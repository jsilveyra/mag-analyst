% By Davide Fenucci
% https://se.mathworks.com/matlabcentral/profile/authors/7494770

function align_yyaxis_zero(ax)
    % align zero for left and right
    yyaxis left;  yliml = get(ax,'Ylim');
    yyaxis right; ylimr = get(ax,'Ylim');
    
    % Remove potential zeros from the limits
    yliml = yliml - 0.05 * (yliml == 0) .* yliml([2 1]);
    ylimr = ylimr - 0.05 * (ylimr == 0) .* ylimr([2 1]);
    
    if yliml(1) > 0 && ylimr(1) > 0
        yliml = [0 yliml(2)];
        ylimr = [0 ylimr(2)];
    elseif yliml(2) < 0 && ylimr(2) < 0
        yliml = [yliml(1), 0];
        ylimr = [ylimr(1), 0];
    elseif yliml(1) > 0 && ylimr(2) < 0
        ratio = diff(yliml)/diff(ylimr);
        yliml = [ylimr(1)*ratio, yliml(2)];
        ylimr = [ylimr(1), yliml(2)/ratio];

    elseif yliml(2) < 0 && ylimr(1) > 0
        ratio = diff(yliml)/diff(ylimr);
        yliml = [yliml(1), ylimr(2)*ratio];
        ylimr = [yliml(1)/ratio, ylimr(2)];
    elseif yliml(1) > 0
        yliml(1) = yliml(2) * ylimr(1) / ylimr(2);
    elseif yliml(2) < 0
        yliml(2) = yliml(1) * ylimr(2) / ylimr(1);
    elseif ylimr(1) > 0
        ylimr(1) = ylimr(2) * yliml(1) / yliml(2);
    elseif ylimr(2) < 0
        ylimr(2) = ylimr(1) * yliml(2) / yliml(1);
    else
        dl = diff(yliml);
        dr = diff(ylimr);
        if yliml(2)/dl > ylimr(2)/dr
            ylimr(2) = yliml(2)*dr/dl;
            yliml(1) = ylimr(1)*dl/dr;
        else
            yliml(2) = ylimr(2)*dl/dr;
            ylimr(1) = yliml(1)*dr/dl;
        end
    end

    yyaxis left;  set(ax, 'YLim', yliml);
    yyaxis right; set(ax, 'Ylim', ylimr);
end