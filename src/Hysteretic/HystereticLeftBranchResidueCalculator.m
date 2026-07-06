classdef HystereticLeftBranchResidueCalculator < ResidueCalculator
%HYSTERETICLEFTBRANCHRESIDUECALCULATOR  Residual for JA hysteretic fitting.
%   HystereticLeftBranchResidueCalculator(H, M, Hhat, Mhat) compares the
%   measured hysteretic left branch (H, M) to a simulated JA branch
%   (Hhat, Mhat). get_residue() sorts/dedupes the model by H, interpolates
%   it onto the (finite) data H values, and returns Y - Yint; degenerate
%   inputs (fewer than 2 usable model points) yield an all-zero residual.
    methods (Access = public)
        function obj = HystereticLeftBranchResidueCalculator(H, M, Hhat, Mhat)
            obj.X = H(:).';
            obj.Y = M(:).';
            obj.Xhat = Hhat(:).';
            obj.Yhat = Mhat(:).';
        end

        function residue = get_residue(obj)
            X = obj.X(:);
            Y = obj.Y(:);
            Xhat = obj.Xhat(:);
            Yhat = obj.Yhat(:);

            valid_data = isfinite(X) & isfinite(Y);
            valid_model = isfinite(Xhat) & isfinite(Yhat);
            X = X(valid_data);
            Y = Y(valid_data);
            Xhat = Xhat(valid_model);
            Yhat = Yhat(valid_model);

            if numel(X) < 1 || numel(Xhat) < 2
                residue = zeros(1, numel(Y));
                return;
            end

            [Xhat, idx_sort] = sort(Xhat, 'ascend');
            Yhat = Yhat(idx_sort);
            [Xhat, idx_unique] = unique(Xhat, 'stable');
            Yhat = Yhat(idx_unique);

            if numel(Xhat) < 2
                residue = zeros(1, numel(Y));
                return;
            end

            Yint = interp1(Xhat, Yhat, X, 'linear', 'extrap');
            residue = Y(:).' - Yint(:).';
        end
    end
end
