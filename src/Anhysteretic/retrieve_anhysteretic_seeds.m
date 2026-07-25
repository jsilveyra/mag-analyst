function [Hcr, mcr, Hx, details] = retrieve_anhysteretic_seeds(data_curve, number_components, select_a)
%RETRIEVE_ANHYSTERETIC_SEEDS Estimate anhysteretic fit seeds from halo peaks.
%
%   Hcr is taken from peaks of H*dM/dH = dM/d(ln H). The dimensionless
%   m(Hcr) seed is retrieved by matching an amplitude-independent halo
%   width, area/peak height, to single-component model templates. After
%   each component seed is found, a temporary modeled component is
%   subtracted from the experimental curve before finding the next peak.

    default_mcr = 0.521657107787896;

    if nargin < 3 || isempty(select_a)
        select_a = repmat({'low'}, number_components, 1);
    end

    number_components = max(1, round(number_components));
    select_a = normalize_select_a(select_a, number_components);

    Hcr = 0.01 * (1:number_components);
    mcr = default_mcr * ones(1, number_components);
    Hx = 0.015 * (1:max(number_components - 1, 0));
    details = struct( ...
        'method', "peak_Hcr_fwhm_m", ...
        'Hcr_unsorted', [], ...
        'mcr_unsorted', [], ...
        'equivalent_log_width', [], ...
        'half_height_log_width', [], ...
        'component_area', [], ...
        'component_Ms_seed', [], ...
        'messages', strings(0, 1));

    [H, M] = sanitize_curve(data_curve);
    if numel(H) < 5
        details.messages(end + 1, 1) = "Not enough positive H points; built-in seeds returned.";
        return;
    end

    x = log(H);
    [~, halo_full_smooth] = halo_from_curve(H, M);
    residual_M = M;
    found = 0;
    found_Hcr = zeros(1, number_components);
    found_mcr = zeros(1, number_components);
    found_area = zeros(1, number_components);
    found_eq_width = zeros(1, number_components);
    found_half_width = nan(1, number_components);
    found_Ms = zeros(1, number_components);

    for component_index = 1:number_components
        [halo, halo_smooth] = halo_from_curve(H, residual_M);
        [peak_height, peak_index] = max(halo_smooth);

        if isempty(peak_height) || ~isfinite(peak_height) || peak_height <= 0
            details.messages(end + 1, 1) = "No positive residual halo remained; remaining built-in seeds kept.";
            break;
        end

        [left_index, right_index] = halo_basin(halo_smooth, peak_index);
        if right_index - left_index < 2
            details.messages(end + 1, 1) = "Residual halo basin was too narrow; remaining built-in seeds kept.";
            break;
        end

        basin = left_index:right_index;
        component_area = log_area(x(basin), max(halo(basin), 0));
        equivalent_width = component_area / peak_height;
        half_width = half_height_width(x, halo_smooth, peak_index);

        if ~isfinite(component_area) || component_area <= 0 || ~isfinite(equivalent_width) || equivalent_width <= 0
            details.messages(end + 1, 1) = "Residual halo area was not usable; remaining built-in seeds kept.";
            break;
        end

        Hcr_i = H(peak_index);
        select_mode = select_a(component_index);
        mcr_i = estimate_mcr_from_width(equivalent_width, half_width, select_mode, default_mcr);

        [m_unit, halo_unit] = modeled_unit_component(H, Hcr_i, mcr_i, select_mode);
        unit_area = log_area(x(basin), max(halo_unit(basin), 0));
        if ~isfinite(unit_area) || unit_area <= 0
            Ms_seed = 0;
        else
            Ms_seed = component_area / unit_area;
        end

        if ~isfinite(Ms_seed) || Ms_seed <= 0
            details.messages(end + 1, 1) = "Could not scale modeled component for subtraction; remaining built-in seeds kept.";
            break;
        end

        found = found + 1;
        found_Hcr(found) = Hcr_i;
        found_mcr(found) = mcr_i;
        found_area(found) = component_area;
        found_eq_width(found) = equivalent_width;
        found_half_width(found) = half_width;
        found_Ms(found) = Ms_seed;

        residual_M = residual_M - Ms_seed * m_unit;
    end

    if found == 0
        return;
    end

    Hcr(1:found) = found_Hcr(1:found);
    mcr(1:found) = found_mcr(1:found);
    details.Hcr_unsorted = found_Hcr(1:found);
    details.mcr_unsorted = found_mcr(1:found);
    details.equivalent_log_width = found_eq_width(1:found);
    details.half_height_log_width = found_half_width(1:found);
    details.component_area = found_area(1:found);
    details.component_Ms_seed = found_Ms(1:found);

    if found > 1
        [sorted_Hcr, order] = sort(Hcr(1:found));
        Hcr(1:found) = sorted_Hcr;
        mcr(1:found) = mcr(order);
    end

    if number_components > 1
        % The peak-and-subtract loop above only resolves components whose
        % halo peaks are far enough apart in log(H) to show up as distinct
        % local maxima. When two components' Hcr are close relative to
        % their width (a shoulder rather than a separate peak -- e.g. the
        % GOSS_67_MPa dataset, where both Hcr collapsed onto the same
        % point), it degenerates instead of separating them. Refine (or,
        % for a degenerate result, rebuild) the seeds by jointly fitting
        % all `number_components` unit halo templates directly against the
        % measured halo curve -- this is the deconvolution step the
        % sequential method skips, and it is what actually resolves
        % overlapping components.
        [Hcr_refined, mcr_refined, refined] = joint_refine_seeds( ...
            H, x, halo_full_smooth, Hcr(1:found), mcr(1:found), select_a, number_components, default_mcr);
        if refined
            Hcr(1:number_components) = Hcr_refined;
            mcr(1:number_components) = mcr_refined;
            details.messages(end + 1, 1) = "Joint halo-template fit applied to separate overlapping components.";
        end
        Hx = estimate_crossovers(H, M, Hcr);
    end
end

function [Hcr_out, mcr_out, refined] = joint_refine_seeds(H, x, halo_target, Hcr_seed, mcr_seed, select_a, number_components, default_mcr)
%JOINT_REFINE_SEEDS Jointly fit N unit halo templates to the measured halo.
%   Starts from the sequential peak-and-subtract seeds when they are
%   usable (as many distinct Hcr as requested components, not collapsed
%   onto each other); otherwise starts from an equal-area quantile split
%   of the halo curve in log(H), which stays sensible even when the
%   components are too close together to appear as separate local maxima.
    refined = false;
    Hcr_out = Hcr_seed;
    mcr_out = mcr_seed;

    total_area = log_area(x, max(halo_target, 0));
    if ~isfinite(total_area) || total_area <= 0
        return;
    end

    % Each objective evaluation solves modeled_unit_component's per-point
    % fzero for every H sample and every component, so it dominates the
    % joint optimizer's runtime; a fit-quality seed does not need every
    % point of a densely resampled curve, so subsample to keep this
    % interactive (a 3-component fit on the full ~100-point grid took over
    % half a minute; 50 points preserves the halo shape at negligible cost).
    max_eval_points = 50;
    if numel(H) > max_eval_points
        eval_idx = round(linspace(1, numel(H), max_eval_points));
        H_eval = H(eval_idx);
        halo_target_eval = halo_target(eval_idx);
    else
        H_eval = H;
        halo_target_eval = halo_target;
    end

    min_log_separation = 0.01;
    degenerate = numel(Hcr_seed) < number_components;
    if ~degenerate
        sorted_log_Hcr = sort(log(Hcr_seed(:).'));
        degenerate = any(diff(sorted_log_Hcr) < min_log_separation);
    end

    if degenerate
        Hcr0 = equal_area_quantiles(x, halo_target, number_components);
        mcr0 = default_mcr * ones(1, number_components);
    else
        Hcr0 = Hcr_seed(:).';
        mcr0 = mcr_seed(:).';
    end

    Ms0 = zeros(1, number_components);
    for i = 1:number_components
        [~, halo_unit] = modeled_unit_component(H, Hcr0(i), mcr0(i), select_a(i));
        unit_area = log_area(x, max(halo_unit, 0));
        if isfinite(unit_area) && unit_area > 0
            Ms0(i) = (total_area / number_components) / unit_area;
        end
    end
    Ms0(~isfinite(Ms0) | Ms0 <= 0) = total_area / number_components;

    H_min = min(H_eval(H_eval > 0));
    H_max = max(H_eval);
    lb = [H_min * ones(1, number_components), 0.45 * ones(1, number_components), zeros(1, number_components)];
    ub = [H_max * ones(1, number_components), 0.95 * ones(1, number_components), 10 * max(Ms0) * ones(1, number_components)];
    x0 = [Hcr0, mcr0, Ms0];

    options = optimset('MaxIter', 200, 'MaxFunEvals', 2000, 'TolX', 1e-4, 'TolFun', 1e-6, 'Display', 'off');
    try
        p = minimize(@joint_objective, x0, [], [], [], [], lb, ub, [], options);
    catch
        return;
    end

    Hcr_p = p(1:number_components);
    mcr_p = p(number_components + 1:2 * number_components);
    if ~all(isfinite(Hcr_p)) || ~all(isfinite(mcr_p))
        return;
    end

    [Hcr_out, order] = sort(Hcr_p);
    mcr_out = mcr_p(order);
    refined = true;

    function err = joint_objective(p)
        Hcr_p = p(1:number_components);
        mcr_p = p(number_components + 1:2 * number_components);
        Ms_p = p(2 * number_components + 1:end);
        predicted = zeros(size(halo_target_eval));
        for k = 1:number_components
            [~, halo_k] = modeled_unit_component(H_eval, Hcr_p(k), mcr_p(k), select_a(k));
            predicted = predicted + Ms_p(k) * halo_k;
        end
        err = sum((predicted(:) - halo_target_eval(:)).^2) / (max(halo_target_eval)^2 * numel(halo_target_eval));
    end
end

function Hcr_q = equal_area_quantiles(x, halo, number_components)
    x = x(:);
    halo = max(halo(:), 0);
    cumulative = cumtrapz(x, halo);
    total = cumulative(end);
    if ~isfinite(total) || total <= 0
        edges = exp(linspace(min(x), max(x), number_components + 2));
        Hcr_q = edges(2:end-1);
        return;
    end
    Hcr_q = zeros(1, number_components);
    for i = 1:number_components
        target = (i - 0.5) / number_components * total;
        Hcr_q(i) = exp(interp1(cumulative, x, target, 'linear', 'extrap'));
    end
end

function select_a = normalize_select_a(select_a, number_components)
    select_a = string(select_a(:));
    if isempty(select_a)
        select_a = "low";
    end
    if numel(select_a) < number_components
        select_a(end + 1:number_components, 1) = select_a(end);
    end
    select_a = lower(select_a(1:number_components));
    select_a(select_a ~= "high" & select_a ~= "low") = "low";
end

function [H, M] = sanitize_curve(data_curve)
    H = data_curve.H(:);
    M = data_curve.M(:);
    valid = isfinite(H) & isfinite(M) & H > 0;
    H = H(valid);
    M = M(valid);
end

function [halo, halo_smooth] = halo_from_curve(H, M)
    dMdH = gradient(M(:)) ./ gradient(H(:));
    halo = H(:) .* dMdH(:);
    halo(~isfinite(halo) | halo < 0) = 0;
    halo_smooth = smooth_vector(halo);
end

function y = smooth_vector(y)
    n = numel(y);
    if n < 7
        return;
    end
    window = max(3, 2 * floor(min(21, max(3, floor(n / 12))) / 2) + 1);
    if exist('movmean', 'file') == 2 || exist('movmean', 'builtin') == 5
        y = movmean(y, window, 'Endpoints', 'shrink');
    else
        kernel = ones(window, 1) / window;
        y = conv(y(:), kernel, 'same');
    end
end

function [left_index, right_index] = halo_basin(halo, peak_index)
    peak_height = halo(peak_index);
    n = numel(halo);
    threshold = 0.05 * peak_height;

    local_minima = find(halo(2:end-1) <= halo(1:end-2) & halo(2:end-1) <= halo(3:end)) + 1;
    left_candidates = local_minima(local_minima < peak_index & halo(local_minima) <= 0.75 * peak_height);
    right_candidates = local_minima(local_minima > peak_index & halo(local_minima) <= 0.75 * peak_height);

    if isempty(left_candidates)
        left_candidates = find(halo(1:peak_index) <= threshold);
    end
    if isempty(right_candidates)
        right_candidates = peak_index - 1 + find(halo(peak_index:end) <= threshold, 1, 'first');
    end

    if isempty(left_candidates)
        left_index = 1;
    else
        left_index = left_candidates(end);
    end

    if isempty(right_candidates)
        right_index = n;
    else
        right_index = right_candidates(1);
    end

    left_index = max(1, min(left_index, peak_index - 1));
    right_index = min(n, max(right_index, peak_index + 1));
end

function width = half_height_width(x, y, peak_index)
    width = NaN;
    half_height = 0.5 * y(peak_index);

    left = find(y(1:peak_index) <= half_height, 1, 'last');
    right_relative = find(y(peak_index:end) <= half_height, 1, 'first');
    if isempty(left) || isempty(right_relative)
        return;
    end
    right = peak_index + right_relative - 1;
    if left >= peak_index || right <= peak_index
        return;
    end

    x_left = interp_crossing(x(left:left+1), y(left:left+1), half_height);
    x_right = interp_crossing(x(right-1:right), y(right-1:right), half_height);
    width = abs(x_right - x_left);
end

function area = log_area(x, y)
    x = x(:);
    y = y(:);
    if numel(x) < 2
        area = 0;
        return;
    end
    area = sum(0.5 * (y(1:end-1) + y(2:end)) .* abs(diff(x)));
end

function x_cross = interp_crossing(x_pair, y_pair, y_cross)
    if diff(y_pair) == 0
        x_cross = mean(x_pair);
    else
        x_cross = interp1(y_pair, x_pair, y_cross, 'linear', 'extrap');
    end
end

function mcr = estimate_mcr_from_width(equivalent_width, half_width, select_mode, default_mcr)
    library = template_library(select_mode);
    if isfinite(half_width) && half_width > 0
        valid_half_width = library.half_width(isfinite(library.half_width) & library.half_width > 0);
        if ~isempty(valid_half_width) && half_width < 0.75 * min(valid_half_width)
            mcr = default_mcr;
            return;
        end
        score = (log(half_width) - log(library.half_width)).^2;
        if isfinite(equivalent_width) && equivalent_width > 0
            score = score + 0.10 * (log(equivalent_width) - log(library.equivalent_width)).^2;
        end
    else
        score = (log(equivalent_width) - log(library.equivalent_width)).^2;
    end
    score(~isfinite(score)) = Inf;
    [~, best_index] = min(score);
    if isempty(best_index) || ~isfinite(score(best_index))
        mcr = default_mcr;
    else
        mcr = library.mcr(best_index);
    end
end

function library = template_library(select_mode)
    persistent low_library high_library

    select_mode = lower(string(select_mode));
    if select_mode == "high"
        if isempty(high_library)
            high_library = build_template_library("high");
        end
        library = high_library;
    else
        if isempty(low_library)
            low_library = build_template_library("low");
        end
        library = low_library;
    end
end

function library = build_template_library(select_mode)
    m_values = 0.45:0.01:0.95;
    x = linspace(-8, 8, 321).';
    H = exp(x);
    equivalent_width = nan(size(m_values));
    half_width = nan(size(m_values));

    for i = 1:numel(m_values)
        [~, halo] = modeled_unit_component(H, 1, m_values(i), select_mode);
        [peak_height, peak_index] = max(halo);
        if isfinite(peak_height) && peak_height > 0
            equivalent_width(i) = log_area(x, max(halo, 0)) / peak_height;
            half_width(i) = half_height_width(x, halo, peak_index);
        end
    end

    library = struct( ...
        'mcr', m_values, ...
        'equivalent_width', equivalent_width, ...
        'half_width', half_width);
end

function [m_values, halo] = modeled_unit_component(H, Hcr, mcr, select_mode)
    [a, alphaMs] = model_shape_parameters(Hcr, mcr, select_mode);
    m_values = zeros(size(H(:)));
    dmdH = zeros(size(H(:)));
    m_guess = 0;

    for i = 1:numel(H)
        m_values(i) = solve_m(H(i), a, alphaMs, m_guess);
        m_guess = m_values(i);
        h = (H(i) + alphaMs * m_values(i)) / a;
        numerator = Langevin(h, 1) / a;
        dmdH(i) = numerator / (1 - alphaMs * numerator);
    end

    halo = H(:) .* dmdH(:);
    halo(~isfinite(halo) | halo < 0) = 0;
end

function [a, alphaMs] = model_shape_parameters(Hcr, mcr, select_mode)
    factor = 1;
    if lower(string(select_mode)) == "low"
        factor = -1;
    end

    p = P_value(mcr);
    q = Q_value(mcr);
    radicand = max(q^2 - 1, 0);
    a = Hcr * p * (q + factor * sqrt(radicand));
    alphaMs = (Langevin(mcr, -1) * a - Hcr) / mcr;
end

function m = solve_m(H, a, alphaMs, m_guess)
    f = @(m_candidate) Langevin((H + alphaMs * m_candidate) / a, 0) - m_candidate;
    try
        m = fzero(f, min(max(m_guess, 0), 0.999999));
    catch
        try
            m = fzero(f, [0, 0.999999]);
        catch
            m = fzero(f, 0.5);
        end
    end
    m = min(max(m, 0), 0.999999);
end

function p = P_value(m)
    inverse_m = Langevin(m, -1);
    numerator = Langevin(inverse_m, 1);
    denominator = m - inverse_m * Langevin(inverse_m, 1);
    p = numerator / denominator;
end

function q = Q_value(m)
    inverse_m = Langevin(m, -1);
    some_a = m / Langevin(inverse_m, 1);
    b = -Langevin(inverse_m, 2);
    c = 2 * (m - inverse_m * Langevin(inverse_m, 1));
    q = ((some_a^2) * b / c) - 1;
end

function Hx = estimate_crossovers(~, ~, Hcr)
    n = numel(Hcr);
    Hx = zeros(1, max(n - 1, 0));
    if isempty(Hx)
        return;
    end

    for i = 1:(n - 1)
        Hx(i) = 0.5 * (Hcr(i) + Hcr(i + 1));
    end
end
