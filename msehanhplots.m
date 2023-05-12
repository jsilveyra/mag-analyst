function ehanh = msehanhplots(Hanh,Mq,Moffset,Hoffset)
%MSEHAN Local function that calculates the mean squared error of the |Hanh|[|Manh|] distribution (which, ideally, should be antisymmetric w.r.t. |Manh|) and creates plots.
%The calculated error is actually in |Manh| for constant |Hanh|. Anyway, we denoted it as Hanh error.
    
    % Hanh is the array of Hanh
    % Mq is the array of Manh(Hanh)
    % Moffset and Hoffset are the vertical and horizontal offsets, respectively, to add to the hysteresis loop so that M(H)=-M(-H)
    
    MqShifted = (Mq + Moffset);
    HanhShifted = @(Hoffset)(Hanh + Hoffset);
    
    tmpHanhShifted = HanhShifted(Hoffset);   % temporary variable to store the function of shifted Hanh at Hoffset input. 
                                             % Although Octave does handle a syntaxis such as HanhShifted(Hoffset)(1:end_Hanhneg_shifted)
                                             % -having two sets of parentheses immediately following one another-, Matlab doesn't.

    % Plot shifted M[Hanh] distribution

    figure
    plot (Hanh, MqShifted,'k-',HanhShifted(Hoffset),MqShifted,'r--','LineWidth',2)
    axis tight, title('Manh[H] distribution')
    yline(0,'k-','')
    xline(0,'k-','')
    xlabel('Hanh [A/m]')
    ylabel('Manh [A/m]')
    legend ('shifted with Moffset', 'shifted with Moffset and Hoffset','Location','northwest')
    
    message = input('Press a key to continue');
    
    close

    % First, find where we need to "fold" Manh(H) distribution (ideally, at Hanh=0, but that value may not be present in the Hanh(M) table)
    % We'll do it both for the original Hanh(M) distribution, as for the shifted distribution, just to compare them both in a plot
    % (we actually only need it for the shifted distribution)

    [Hzero, Izero] = min(abs(Hanh));   % Find |Hanh| minimum (i.e., where Hanh is zero o changes sign) as well as the row index of data in which it appears
    
    if Hanh(Izero) == 0;
        end_Hanhneg = Izero;
	    start_Hanhpos = Izero;
    elseif Hanh(Izero) > 0;
        end_Hanhneg = Izero-1;
	    start_Hanhpos = Izero;
    else Hanh(Izero) < 0;
        end_Hanhneg = Izero;
	    start_Hanhpos = Izero+1;
    end
    
    Manhneg = MqShifted(1:end_Hanhneg);                             % array of M(Hanh) with Hanh<0
    Manhpos = MqShifted(start_Hanhpos:end);                         % array of M(Hanh) with Hanh>0
    
    [Hanhzero_shifted, Izero_shifted] = min(abs(tmpHanhShifted));   % Find |Hanh_shifted| minimum (i.e., where Hanh is zero o changes sign) as well as the row index of data in which it appears
    
    if tmpHanhShifted(Izero_shifted) == 0;
        end_Hanhneg_shifted = Izero_shifted;
	    start_Hanhpos_shifted = Izero_shifted;
    elseif tmpHanhShifted(Izero_shifted) > 0;
        end_Hanhneg_shifted = Izero_shifted - 1;
	    start_Hanhpos_shifted = Izero_shifted;
    else tmpHanhShifted(Izero_shifted) < 0;
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
    
    figure
    plot(abs(Hanh(1:end_Hanhneg)),abs(Manhneg),'k-',abs(Hanh(start_Hanhpos:end)),abs(Manhpos),'k-','LineWidth',2)
    hold
    plot(absHanhneg_shifted,absManhneg_shifted,'r--',absHanhpos_shifted,absManhpos_shifted,'b--','LineWidth',2)
    yline(0,'k-','')
    xline(0,'k-','')
    ylabel('|Manh| [A/m]')
    xlabel('|Hanh| [A/m]')
    legend ('original (Hanh<0)','original (Hanh>0)','shifted (Hanh<0)','shifted (Hanh>0)','','','Location','southeast')

    message = input('Press a key to continue');
    close    

    absManhError = residue2(absHanhpos_shifted, absManhpos_shifted,absHanhneg_shifted, absManhneg_shifted);   % at constant |Hanh|
    %ACÁ LLAMO A UNA COPY-PASTE FUNCTION DE LA QUE ESTÁ DENTRO DE ERROR CALCULATOR. AVERIGUAR CÓMO LLAMARLA PARA NO DUPLICAR.
  
    figure
    plot(absHanhpos_shifted(3:end),absManhError,'.')
    xlabel('|Hanh| [A/m]')
    ylabel('|Manh| error [A/m]')
    yline(0,'k-','')
    
    message = input('Press a key to continue');
    close
    
    ehanh = diagonal_error2(absHanhpos_shifted, absManhpos_shifted,absHanhneg_shifted, absManhneg_shifted); %ACÁ LLAMO A UNA COPY-PASTE FUNCTION DE LA QUE ESTÁ DENTRO DE ERROR CALCULATOR. AVERIGUAR CÓMO LLAMARLA PARA NO DUPLICAR.

end