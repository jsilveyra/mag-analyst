opengl('software')	%fixes a problem with recent versions of AMD video drivers. Sometimes (when I use yline(), some legend lines don't show up https://se.mathworks.com/matlabcentral/answers/493330-legend-bar-not-visible)
clear;				%clear workspace
clc;				%clear command window

% Parse hysteresis loop data table

%[Xraw, Yraw] = Parser('data/loopData/CAHLtest_H_Am_B_T.csv').get_data_csv;
%[Xraw, Yraw] = Parser('data/loopData/Core 1 DC 800Am Nico B(T)vsH(Am).csv').get_data_csv;   %Error using griddedInterpolant - Sample points must be sorted in ascending order.
%[Xraw, Yraw] = Parser('data/loopData/Core 1 DC 10000Am Nico B(T)vsH(Am).csv').get_data_csv;
[Xraw, Yraw] = Parser('data/loopData/Core 1 DC 15000Am Nico B(T)vsH(Am).csv').get_data_csv;

% Convert horizontal axis field into H [A/m]

disp('1. H [A/m]')
disp('2. H [kA/m]')
disp('3. H [Oe]')
disp('4. H [kOe]')
disp('5. Bext [T]')
disp('6. Bext [Gauss]')
disp('7. Bext [kGauss]')

x = input('Enter the horizontal axis field (1-7): ');

xLabel = 'X';

switch x
	case 1
		xLabel = 'H [A/m]';
		disp(xLabel)
		[H] = Xraw;
	case 2
		xLabel = 'H [kA/m]';
		disp(xLabel)
		[H] = 1000 * Xraw;
	case 3
		xLabel = 'H [Oe]';
		disp(xLabel)
		[H] = 79.5774715459 * Xraw;
	case 4
		xLabel = 'H [kOe]';
		disp(xLabel)
		[H] = 1000 * 79.5774715459 * Xraw;
	case 5
		xLabel = 'Bext [T]';
		disp(xLabel)
		[H] = 1/(4*pi*10^(-7))* Xraw;
	case 6
		xLabel = 'Bext [Gauss]';
		disp(xLabel)
		[H] = 1/(4*pi*10^(-7)) * 1/10000 * Xraw;
	case 7
		xLabel = 'Bext [kGauss]';
		disp(xLabel)
		[H] = 1/(4*pi*10^(-7)) * 1/10000 * 1000 * Xraw;
	otherwise
		disp('The horizontal axis field must be from 1 to 7.')
end

% Convert vertical axis field into M [A/m]

disp('1. M [A/m]')
disp('2. M [kA/m]')
disp('3. M [MA/m]')
disp('4. M [emu/cm^3]')
disp('5. J [T]')
disp('6. B [T]')
disp('7. B [Gauss]')
disp('8. B [kGauss]')

y = input('Enter the vertical axis field (1-8): ');

yLabel = 'Y';

switch y
	case 1
		yLabel = 'M [A/m]';
		disp(yLabel)
		M = Yraw;
	case 2
		yLabel = 'M [kA/m]';
		disp(yLabel)
		M = 1000 * Yraw;
	case 3
		yLabel = 'M [MA/m]';
		disp(yLabel)
		M = 1000000 * Yraw;
	case 4
		yLabel = 'M [emu/cm^3]';
		disp(yLabel)
		M = 1000 * Yraw;
	case 5
		yLabel = 'J [T]';
		disp(yLabel)
		M = 1/(4*pi*10^(-7))* Yraw;
	case 6
		yLabel = 'B [T]';
		disp(yLabel)
		M = 1/(4*pi*10^(-7)) * Yraw - H;
	case 7
		yLabel = 'B [Gauss]';
		disp(yLabel)
		M = 1/(4*pi*10^(-7)) * 1/10000 * 1000 * Yraw - H;
	case 8
		yLabel = 'B [kGauss]';
		disp(yLabel)
		M = 1/(4*pi*10^(-7)) * 1/10000 * 1000 * Yraw - H;
	otherwise
		disp('The vertical axis field must be from 1 to 8.')
end

% Plot raw and converted hysteresis loops

% figure
% subplot(121), plot(Xraw,Yraw,'r.','LineWidth',2)
% axis square, title('Raw hysteresis loop')
% xlabel(xLabel)
% ylabel(yLabel)
% % Use yline() to plot a horizontal line at y=0 (requires r2018b or later)
% % https://www.mathworks.com/help/matlab/ref/yline.html
% % This will automatically adjust if your xlim changes.
% yline(0,'k-','')
% xline(0,'k-','')
% 
% subplot(122), plot(H,M,'r.','LineWidth',2)
% axis square, title('Converted hysteresis loop')
% xlabel('H [A/m]')
% ylabel('M [A/m]')
% xline(0,'k-','')
% yline(0,'k-','')
% 
% message = input('Press a key to continue');
% close

% Sort [H,M] so that it begins at Hmin
	
[Hmin, Imin] = min(H); % Find H minimum (i.e., -Htip) as well as the row index of data in which it appears

Hstart = H(Imin:end);
Hend = H(1:Imin);
Hsorted = [Hstart Hend];

Mstart = M(Imin:end);
Mend = M(1:Imin);
Msorted = [Mstart Mend];

% Split hysteresis loop into ascending and descending branches

% Find M maximum (i.e., +Mtip) as well as the row index of data in which it appears in the already sorted array
% (when finding Imax for Hmax, for some reason I wasn't finding the curve tip. Need to check with future data.)
	
[Mmax, Imax] = max(Msorted);

% Split the hysteresis loop into the ascendent and descendent branches, i.e., right and left branches, respectively

Hright = Hsorted(1:Imax);
Mright = Msorted(1:Imax);

Hleft = Hsorted(Imax:end);
Mleft = Msorted(Imax:end);

% figure
% subplot(121), plot(Hsorted,Msorted,'r.','LineWidth',2)
% axis square, title('Sorted hysteresis loop')
% xlabel('H [A/m]')
% ylabel('M [A/m]')
% xline(0,'k-','')
% yline(0,'k-','')
% 
% subplot(122), plot(Hright,Mright,'r.',Hleft,Mleft,'b.','LineWidth',2)
% axis square, title('Splitted hysteresis loop')
% xlabel('H [A/m]')
% ylabel('M [A/m]')
% xline(0,'k-','')
% yline(0,'k-','')
% 
% message = input('Press a key to continue');
% close

% Transform both branches to the same M domain (so we can then add or substract them)

% Use griddedInterpolant to interpolate [HrightShifted MrightShifted] data set
%griddedInterpolant returns the interpolant F for the given data set.
%It is quicker to evaluate a gridded interpolant object at many different sets of query points than it is
%to compute the interpolations separately using interp1, interp2, interp3, or interpn.

% First, we need to remove duplicates using 'unique' function.
% C = unique(A) returns the same data as in A, but with no repetitions. C is in sorted order.
[MrightUnique, index] = unique(Mright);
HrightUnique = Hright(index);
[MleftUnique, index] = unique(Mleft);
HleftUnique = Hleft(index);

% figure
% plot(Hright, Mright, 'r.',Hleft, Mleft, 'b.')
% hold
% plot(HrightUnique, MrightUnique, 'rx',HleftUnique, MleftUnique, 'bx')
% xline(0,'k-','')
% yline(0,'k-','')
% xlabel('H [A/m]')
% ylabel('M [A/m]')
% legend ({'splitted raw data','', 'splitted unique data'},'Location','northwest')
% 
% message = input('Press a key to continue');
% close

% Second, find the maximum absolute M (it's the same for both branches, within numerical error)
MpostipRight = max(Mright);
MpostipLeft = max(Mleft);
Mpostip = min(MpostipRight,MpostipLeft);    % We need to choose between the smallest value of both. Otherwise, we will obtain a NaN interpolated value afterwards
MnegtipRight = min(Mright);
MnegtipLeft = min(Mleft);
Mnegtip = max(MnegtipRight,MnegtipLeft);    % We need to choose between the smallest absolute value of both. Otherwise, we will obtain a NaN interpolated value afterwards

% Third, find the minimum absolute non zero M (it's the same for both branches)
tmp = Mright;
tmp(tmp==0) = Inf;
Mmin = min(abs(tmp));

% Forth, create a gridded interpolant object for the right and left branches data. By default, griddedInterpolant uses the 'linear' interpolation method
%Interpolation method: linear; Extrapolation method: none (you can specify 'none' if you want queries outside the domain of your grid to return NaN values)
Fright = griddedInterpolant(MrightUnique,HrightUnique,'linear','none');
Fleft = griddedInterpolant(MleftUnique,HleftUnique,'linear','none');

% Fifth, query the interpolant F at Ngrid points between 0 to tip

Ngrid = 100; %number of elements from 0 to tip  % This value might need to be increased or decreased depending on the resolution and ripples of the data curve. 
                                                % Lower N decreases some ripples but increases ripples in the objective error function to minimize.

%Mpos = logspace(log10(Mmin),log10(Mtip),Ngrid);	% logarithmically spaced
Mpos = linspace(Mmin,Mpostip,Ngrid);					% linearly spaced
Mneg = flip(-linspace(Mmin,-Mnegtip,Ngrid));					% linearly spaced       %LEGACY: flip(-Mpos);

Mq = [Mneg 0 Mpos]; % specifies the query points
Hrightq = Fright(Mq);
Hleftq = Fleft(Mq);

% Finally, plot the interpolated results (Hq, Mq) on top of the original data (HrightShifted,MrightShifted)

% figure
% plot (Hright, Mright, 'r.', Hleft, Mleft, 'b.')
% hold on
% plot (Hrightq, Mq, 'ro',Hleftq, Mq, 'bo')
% xline(0,'k-','')
% yline(0,'k-','')
% xlabel('H [A/m]')
% ylabel('M [A/m]')
% legend ('sample points','', 'interpolated values at fixed M values', '','Location','northwest')
% 
% message = input('Press a key to continue');
% close

% Calculate k[M] distribution

k = 1/2*(Hrightq - Hleftq);

% Calculate MSE of k[M] distribution

mse_k = @(Moffset)(msek(k,Mq,Moffset)); % Define a new MSE function only dependent on Moffset so it can be optimized

% Uncomment for debugging: Plot the error functions vs Moffset within the interval [-Mbounds Mbounds]
% Mbounds = 0.5 * Mpostip;
% fplot(mse_k,[-Mbounds Mbounds])
% message = input('Press a key to continue');
% close

% Optimize vertical offset
Moffset0 = 0;   % seed
[Moffset_opt, msek_opt] = fminsearch(mse_k,Moffset0); % Call the function the finds the optimium Moffset so that the MSE of the k[M] distribution is minimum

disp('msek')
disp(msek_opt)
disp('Moffset_opt')
disp(Moffset_opt)

% msekplots(k,Mq, Moffset_opt); % Plot graphs after the optimal Moffset has been applied.

% Calculate anhysteretic curve Hanh[M]

Hanh = 1/2*(Hrightq + Hleftq);

% Calculate MSE of Hanh[M] distribution

mse_hanh = @(Hoffset)(msehanh(Hanh,Mq,Moffset_opt,Hoffset)); % Define a new MSE function only dependent on Hoffset so it can be optimized

% Uncomment for debugging: Plot the error functions vs Hoffset within the interval [-Mbounds Mbounds]
% Hbounds = 0.5 * max(abs(Hleftq));
% fplot(mse_hanh,[-Hbounds Hbounds])
% message = input('Press a key to continue');
% close

% Optimize horizontal offset
Hoffset0 = 0;   % seed
[Hoffset_opt, msehanh_opt] = fminsearch(mse_hanh,Hoffset0); % Call the function the finds the optimium Hoffset so that the MSE of the |Hanh|[|Manh|] distribution is minimum

disp('mseHanh')
disp(msehanh_opt)
disp('Hoffset_opt')
disp(Hoffset_opt)

%msehanhplots(Hanh,Mq,Moffset_opt,Hoffset_opt); % Plot graphs after the optimal Hoffset has been applied.

figure
plot (Hrightq, Mq, 'k-',Hleftq, Mq, 'k-')
hold on
plot (Hrightq+Hoffset_opt, Mq+Moffset_opt, 'r-',Hleftq+Hoffset_opt, Mq+Moffset_opt, 'r-')
hold on
plot (-Hrightq, -Mq, 'k--',-Hleftq, -Mq, 'k--','LineWidth',2)
hold on
plot (-(Hrightq+Hoffset_opt), -(Mq+Moffset_opt), 'r--',-(Hleftq+Hoffset_opt), -(Mq+Moffset_opt), 'r--','LineWidth',2)
xline(0,'k-','')
yline(0,'k-','')
xlabel('H [A/m]')
ylabel('M [A/m]')
legend ('original loop','', 'loop with M & H offsets', '','antisym original loop','', 'antisym loop with M & H offsets', '','Location','northwest')

% The centering feature should be optional and not mandatory

center = input('Center hysteresis loop? (1-Yes/2-No): ');

tmpMoffset_opt = Moffset_opt;
tmpHoffset_opt = Hoffset_opt;

switch center
	case 1
		Moffset_opt = tmpMoffset_opt;
        Hoffset_opt = tmpHoffset_opt;
	case 2
		Moffset_opt = 0;
        Hoffset_opt = 0;
end

%message = input('Press a key to continue');
close

kvsM = kvsmpos(k,Mq, Moffset_opt);
% plot(kvsM(1:end,1),kvsM(1:end,2));    % Plot k vs M (for positive M)

MvsHanh = mvshanhpos(Hanh,Mq,Moffset_opt,Hoffset_opt);
% plot(MvsHanh(1:end,1),MvsHanh(1:end,2));    % Plot Manh vs Hanh (for positive H)

% Plot the hysteresis loop, the anhysteretic magnetization curve and the k(M) distribution.

figure
subplot(121)
plot (Hrightq+Hoffset_opt, Mq+Moffset_opt, 'r-',Hleftq+Hoffset_opt, Mq+Moffset_opt, 'r-')
hold on
plot (MvsHanh(1:end,1),MvsHanh(1:end,2), 'r-',-MvsHanh(1:end,1),-MvsHanh(1:end,2), 'b-','LineWidth',2)
xline(0,'k-','')
yline(0,'k-','')
xlabel('H [A/m]')
ylabel('M [A/m]')
legend ('hysteresis loop','', 'Anhysteretic curve','Location','northwest')

subplot(122)
plot (kvsM(1:end,2), kvsM(1:end,1),'r-',kvsM(1:end,2), -kvsM(1:end,1), 'b-','LineWidth',2)
xline(0,'k-','')
yline(0,'k-','')
xlabel('k [A/m]')
ylabel('M [A/m]')

% Set up figure properties:
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

message = input('Press a key to continue');
close

% Export csv files

% of processed hysteresis loop with headers
HMprocLabel = ["H [A/m]","M [A/m]"];
writematrix(HMprocLabel,'data\processedData\processedLoop.csv','Delimiter',';','FileType','text');
HprocLeft = transpose(-(Hrightq+Hoffset_opt));
MprocLeft = transpose(-(Mq+Moffset_opt));
MHprocLeft = [HprocLeft,MprocLeft];
writematrix(MHprocLeft,'data\processedData\processedLoop.csv','Delimiter',';','FileType','text','WriteMode','append');
HprocRight = transpose(Hrightq+Hoffset_opt);
MprocRight = transpose(Mq+Moffset_opt);
MHprocRight = [HprocRight,MprocRight];
writematrix(MHprocRight,'data\processedData\processedLoop.csv','Delimiter',';','FileType','text','WriteMode','append');

% of k[M] distribution for positive M with headers
Mproc = kvsM(1:end,1);
kproc = kvsM(1:end,2);
kMprocLabel = ["M [A/m]","k [A/m]"];
writematrix(kMprocLabel,'data\processedData\k_vs_M.csv','Delimiter',';', 'FileType', 'text')
kMproc = [Mproc,kproc];
writematrix(kMproc,'data\processedData\k_vs_M.csv','Delimiter',';', 'FileType', 'text','WriteMode','append');

% of M[Hanh] distribution for positive Hanh with headers
Hanhproc = MvsHanh(1:end,1);
Manhproc = MvsHanh(1:end,2);
MHanhprocLabel = ["Hanh [A/m]","Manh [A/m]"];
writematrix(MHanhprocLabel,'data\processedData\Manh_vs_Hanh.csv','Delimiter',';', 'FileType', 'text')
MHanhproc = [Hanhproc,Manhproc];
writematrix(MHanhproc,'data\processedData\Manh_vs_Hanh.csv','Delimiter',';', 'FileType', 'text','WriteMode','append');