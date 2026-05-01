function import_src()
    src_dir = fileparts(mfilename('fullpath'));

    addpath(src_dir)
    addpath(fullfile(src_dir, 'minimize'))
    addpath(fullfile(src_dir, 'ResidueCalculator'))
    addpath(fullfile(src_dir, 'ErrorCalculator'))
    addpath(fullfile(src_dir, 'AnhystereticCurve'))
    addpath(fullfile(src_dir, 'Parser'))
    addpath(fullfile(src_dir, 'Plotter'))
    addpath(fullfile(src_dir, 'MagneticParameters'))
    addpath(fullfile(src_dir, 'interparc'))
end
