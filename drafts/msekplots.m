function ek = msekplots(k,Mq,Moffset)
%MSEKPLOTS Local function that calculates the mean squared error of the k[M] distribution (which, ideally, should be symmetric w.r.t. |M|) and creates plots
    
    % k is the array of k(M)
    % M is the array of k(M)
    % Moffset is the vertical offset to add to the hysteresis loop so that k(M)=k(-M)
    
    MqShifted = @(Moffset)(Mq + Moffset);

    tmpMqShifted = MqShifted(Moffset);
    
    % Plot shifted k[M] distribution

    figure
    plot (k,Mq,'k-',k,MqShifted(Moffset),'r--','LineWidth',2)
    axis tight, title('k[M] distribution')
    yline(0,'k-','')
    xline(0,'k-','')
    xlabel('k [A/m]')
    ylabel('M [A/m]')
    legend ('original', 'shifted with Moffset','Location','west')
    
    message = input('Press a key to continue');
    
    close

    % First, find where we need to "fold" k(M) distribution (ideally, at M=0, but that value may not be present in the k(M) table)
    % We'll do it both for the original k(M) distribution, as for the shifted distribution, just to compare them both in a plot
    % (we actually only need it for the shifted distribution)

    [Mzero, Izero] = min(abs(Mq));   % Find |M| minimum (i.e., where M is zero o changes sign) as well as the row index of data in which it appears
    
    if Mq(Izero) == 0;
        end_kMneg = Izero;
	    start_kMpos = Izero;
    elseif Mq(Izero) > 0;
        end_kMneg = Izero-1;
	    start_kMpos = Izero;
    else Mq(Izero) < 0;
        end_kMneg = Izero;
	    start_kMpos = Izero+1;
    end
    
    kMneg = k(1:end_kMneg);                             % array of k(M) with M<0
    kMpos = k(start_kMpos:end);                         % array of k(M) with M>0
    
    [Mzero_shifted, Izero_shifted] = min(abs(MqShifted(Moffset)));   % Find |M_shifted| minimum (i.e., where M is zero o changes sign) as well as the row index of data in which it appears
    
    if tmpMqShifted(Izero_shifted) == 0;
        end_kMneg_shifted = Izero_shifted;
	    start_kMpos_shifted = Izero_shifted;
    elseif tmpMqShifted(Izero_shifted) > 0;
        end_kMneg_shifted = Izero_shifted - 1;
	    start_kMpos_shifted = Izero_shifted;
    else tmpMqShifted(Izero_shifted) < 0;
        end_kMneg_shifted = Izero_shifted;
	    start_kMpos_shifted = Izero_shifted + 1;
    end
    
    kMneg_shifted = flip(k(1:end_kMneg_shifted));       % array of k(M) with Mshifted<0
    kMpos_shifted = k(start_kMpos_shifted:end);         % array of k(M) with Mshifted>0
    
    tmpMqShifted = MqShifted(Moffset);   % temporary variable to store the function of shifted Mq at Moffset input. Although Octave does handle a syntaxis such as MqShifted(Moffset)(1:end_kMneg_shifted) -having two sets of parentheses immediately following one another-, Matlab doesn't.
    absMneg_shifted = flip(abs(tmpMqShifted(1:end_kMneg_shifted)));
    absMpos_shifted = tmpMqShifted(start_kMpos_shifted:end);
    
    figure
    plot(abs(Mq(1:end_kMneg)),kMneg,'k-',Mq(start_kMpos:end),kMpos,'k-','LineWidth',2)
    hold
    plot(absMneg_shifted,kMneg_shifted,'r--',absMpos_shifted,kMpos_shifted,'b--','LineWidth',2)
    ylabel('k [A/m]')
    xlabel('|M| [A/m]')
    legend ('original (M<0)','original (M>0)','shifted (M<0)','shifted (M>0)','Location','southwest')
    
    message = input('Press a key to continue');
    close

    Fneg = griddedInterpolant(absMneg_shifted,kMneg_shifted,'linear','none'); % Create griddedInterpolant object
    Fpos = griddedInterpolant(absMpos_shifted,kMpos_shifted,'linear','none'); % Create griddedInterpolant object
    
    max_absMneg_shifted = max(absMneg_shifted);
    max_absMpos_shifted = max(absMpos_shifted);
    max_absM = min(max_absMneg_shifted,max_absMpos_shifted); % Find maximum absolute M from both branches (i.e. the minimum of those two maxima)
    
    min_absM = 0; % Define minimum absolute M from both branches
    
    Ngrid_absM = 100; % number of elements from min_absM to max_absM
    absMq = linspace(min_absM,max_absM,Ngrid_absM); % linearly spaced query points
    
    kMneg_shiftedq = Fneg(absMq); % query the interpolant Fneg at absMq points
    kMpos_shiftedq = Fpos(absMq); % query the interpolant Fpos at absMq points
    
    figure % plot original and interpolated shifted data
    plot(absMq,kMneg_shiftedq,'rx',absMq,kMpos_shiftedq,'bx')
    hold
    plot(absMneg_shifted,kMneg_shifted,'r-',absMpos_shifted,kMpos_shifted,'b-')
    ylabel('k [A/m]')
    xlabel('|M| [A/m]')
    legend ('shifted original data (M<0)','shifted original data (M>0)','shifted interpolated data (M<0)','shifted interpolated data (M>0)','Location','southwest')
    
    message = input('Press a key to continue');
    close
    
    kError = residue2(absMpos_shifted, kMpos_shifted,absMneg_shifted, kMneg_shifted);   % at constant |Hanh|
    %ACÁ LLAMO A UNA COPY-PASTE FUNCTION DE LA QUE ESTÁ DENTRO DE ERROR CALCULATOR. AVERIGUAR CÓMO LLAMARLA PARA NO DUPLICAR.
    
    figure
    plot(absMpos_shifted(3:end),kError,'.')
    xlabel('|M| [A/m]')
    ylabel('kError [A/m]')
    yline(0,'k-','')
    
    message = input('Press a key to continue');
    close
    
    ek = diagonal_error2(absMpos_shifted, kMpos_shifted,absMneg_shifted, kMneg_shifted); %ACÁ LLAMO A UNA COPY-PASTE FUNCTION DE LA QUE ESTÁ DENTRO DE ERROR CALCULATOR. AVERIGUAR CÓMO LLAMARLA PARA NO DUPLICAR.
end