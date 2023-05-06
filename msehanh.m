function ehanh = msehanh(Hanh,Mq,Moffset,Hoffset)
%MSEHAN Local function that calculates the mean squared error of the |Hanh|[|Manh|] distribution (which, ideally, should be antisymmetric w.r.t. |Manh|).
%The calculated error is actually in |Manh| for constant |Hanh|. Anyway, we denoted it as Hanh error.
    
    % Hanh is the array of Hanh
    % Mq is the array of Manh(Hanh)
    % Moffset and Hoffset are the vertical and horizontal offsets, respectively, to add to the hysteresis loop so that M(H)=-M(-H)
    
    MqShifted = (Mq + Moffset);
    HanhShifted = @(Hoffset)(Hanh + Hoffset);
    
    % First, find where we need to "fold" Manh(H) distribution (ideally, at Hanh=0, but that value may not be present in the Hanh(M) table)
    % We'll do it both for the original Hanh(M) distribution, as for the shifted distribution, just to compare them both in a plot
    % (we actually only need it for the shifted distribution)

    [Hanhzero_shifted, Izero_shifted] = min(abs(HanhShifted(Hoffset)));   % Find |Hanh_shifted| minimum (i.e., where Hanh is zero o changes sign) 
                                                                          % as well as the row index of data in which it appears
    
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
    
    absManhneg_shifted = abs(flip(MqShifted(1:end_Hanhneg_shifted)));       % array of M(Hanh) with Hanhshifted<0
    absManhpos_shifted = abs(MqShifted(start_Hanhpos_shifted:end));         % array of M(Hanh) with Hanhshifted>0
    
    tmpHanhShifted = HanhShifted(Hoffset);   % temporary variable to store the function of shifted Hanh at Hoffset input. 
                                             % Although Octave does handle a syntaxis such as HanhShifted(Hoffset)(1:end_Hanhneg_shifted)
                                             % -having two sets of parentheses immediately following one another-, Matlab doesn't.
    absHanhneg_shifted = flip(abs(tmpHanhShifted(1:end_Hanhneg_shifted)));
    absHanhpos_shifted = tmpHanhShifted(start_Hanhpos_shifted:end);
        
    ehanh = diagonal_error2(absHanhpos_shifted, absManhpos_shifted,absHanhneg_shifted, absManhneg_shifted); %ACÁ LLAMO A UNA COPY-PASTE FUNCTION DE LA QUE ESTÁ DENTRO DE ERROR CALCULATOR. AVERIGUAR CÓMO LLAMARLA PARA NO DUPLICAR.

end