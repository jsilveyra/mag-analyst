function kM = kvsmpos(k,Mq,Moffset)
%KVSMPOS Local function that calculates the k[M] distribution for positive M.
%The function assumes the loop is centered, so it only consideres the positive M interval.
    
    % k is the array of k(M)
    % M is the array of k(M)
    % Moffset is the vertical offset to add to the hysteresis loop so that k(M)=k(-M)
    
    MqShifted = @(Moffset)(Mq + Moffset);
    
    % First, find where we need to "fold" k(M) distribution (ideally, at M=0, but that value may not be present in the k(M) table)

    [Mzero_shifted, Izero_shifted] = min(abs(MqShifted(Moffset)));   % Find |M_shifted| minimum (i.e., where M is zero o changes sign) as well as the row index of data in which it appears
    
    if Izero_shifted == 0
        end_kMneg_shifted = Izero_shifted;
	    start_kMpos_shifted = Izero_shifted;
    elseif Izero_shifted > 0
        end_kMneg_shifted = Izero_shifted - 1;
	    start_kMpos_shifted = Izero_shifted;
    else Izero_shifted < 0
        end_kMneg_shifted = Izero_shifted;
	    start_kMpos_shifted = Izero_shifted + 1;
    end
    
    kMpos_shifted = k(start_kMpos_shifted:end);         % array of k(M) with Mshifted>0
    
    tmpMqShifted = MqShifted(Moffset);   % temporary variable to store the function of shifted Mq at Moffset input. Although Octave does handle a syntaxis such as MqShifted(Moffset)(1:end_kMneg_shifted) -having two sets of parentheses immediately following one another-, Matlab doesn't.
    absMpos_shifted = tmpMqShifted(start_kMpos_shifted:end);
    
    Fpos = griddedInterpolant(absMpos_shifted,kMpos_shifted,'linear','none'); % Create griddedInterpolant object
    
    max_absMpos_shifted = max(absMpos_shifted);
    max_absM = max_absMpos_shifted;

    min_absM = min(absMpos_shifted); % Define minimum absolute M from both branches
    
    Ngrid_absM = 100; % number of elements from min_absM to max_absM
    absMq = linspace(min_absM,max_absM,Ngrid_absM); % linearly spaced query points
    
    kMpos_shiftedq = Fpos(absMq); % query the interpolant Fpos at absMq points

    kM = [transpose(absMq),transpose(kMpos_shiftedq)];

    end