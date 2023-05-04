function MH = mvshanhpos(Hanh,Mq,Moffset,Hoffset)
%MVSHANPOS Local function that calculates the Manh[Hanh] distribution for positive Hanh and Manh (i.e., 1st quadrant).
%The function assumes the loop is centered, so it only consideres the positive H interval.
    
    % Hanh is the array of Hanh
    % Mq is the array of Manh(Hanh)
    % Moffset and Hoffset are the vertical and horizontal offsets, respectively, to add to the hysteresis loop so that M(H)=-M(-H)
    
    MqShifted = (Mq + Moffset);
    HanhShifted = @(Hoffset)(Hanh + Hoffset);
    
    % First, find where we need to "fold" Manh(H) distribution (ideally, at Hanh=0, but that value may not be present in the Hanh(M) table)
    % We'll do it both for the original Hanh(M) distribution, as for the shifted distribution, just to compare them both in a plot
    % (we actually only need it for the shifted distribution)

    [Hanhzero_shifted, Izero_shifted] = min(abs(HanhShifted(Hoffset)));   % Find |Hanh_shifted| minimum (i.e., where Hanh is zero o changes sign) as well as the row index of data in which it appears
    
    if Izero_shifted == 0
        end_Hanhneg_shifted = Izero_shifted;
	    start_Hanhpos_shifted = Izero_shifted;
    elseif Izero_shifted > 0
        end_Hanhneg_shifted = Izero_shifted - 1;
	    start_Hanhpos_shifted = Izero_shifted;
    else Izero_shifted < 0
        end_Hanhneg_shifted = Izero_shifted;
	    start_Hanhpos_shifted = Izero_shifted + 1;
    end
    
    absMHanhpos_shifted = abs(MqShifted(start_Hanhpos_shifted:end));         % array of M(Hanh) with Hanhshifted>0
    
    tmpHanhShifted = HanhShifted(Hoffset);   % temporary variable to store the function of shifted Hanh at Hoffset input. 
                                             % Although Octave does handle a syntaxis such as HanhShifted(Hoffset)(1:end_Hanhneg_shifted)
                                             % -having two sets of parentheses immediately following one another-, Matlab doesn't.
    absHanhpos_shifted = tmpHanhShifted(start_Hanhpos_shifted:end);
    
    Fpos = griddedInterpolant(absHanhpos_shifted,absMHanhpos_shifted,'linear','none'); % Create griddedInterpolant object
    
    max_absHanhpos_shifted = max(absHanhpos_shifted);
    max_absHanh = max_absHanhpos_shifted;

    min_absHanh = min(absHanhpos_shifted); % Define minimum absolute Hanh from both parts of the curve (positive and negative)
    
    Ngrid_absHanh = 100; % number of elements from min_absHanh to max_absHanh
    absHanhq = linspace(min_absHanh,max_absHanh,Ngrid_absHanh); % linearly spaced query points
    
    MHanhpos_shiftedq = Fpos(absHanhq); % query the interpolant Fpos at absHanhq points
    
    MH = [transpose(absHanhq),transpose(MHanhpos_shiftedq)];
    MH = [[0,0]; MH];
end