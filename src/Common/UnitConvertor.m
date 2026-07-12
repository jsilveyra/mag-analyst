% Constants:
% mu0 = 4*pi*1e-7
% 1 Oe = 1000/(4*pi) A/m = 79.5774715459 A/m
% 1 emu/cm^3 = 1000 A/m
% 1 T = 10000 G
% 1 kG = 1000 G = 0.1 T
% "sigma [emu/g=Am^2/kg]" is mass magnetization (emu/g and Am^2/kg are
% numerically identical), not volume magnetization -- it is its own base
% unit (factor 1), never rescaled to A/m. Downstream code interprets
% data_curve.M as mass-based via app.M_is_mass_based rather than converting
% it here. "sigma [Am^2/kg]" is the same unit under the shorter display
% name used everywhere except the Input tab's own dropdown (which spells
% out the emu/g equivalence for a user picking a unit for the first time).

classdef UnitConvertor
    properties
        UnitConversions
    end

    methods
        function obj = UnitConvertor()
            units = ["H [A/m]" "H [kA/m]" "H [Oe]" "H [kOe]" "Bext [T]" "Bext [G]" "Bext [kG]" "M [A/m]" "M [kA/m]" "M [MA/m]" "M [emu/cm^3]" "J [T]" "B [T]" "B [G]" "B [kG]" "σ [emu/g=Am^2/kg]" "σ [Am^2/kg]"];
            oe_conversion = 1000/(4*pi); % exact calculation of 1000/(4*pi)
            mu0 = 4*pi*1e-7;
            tesla_conversion = 1/mu0; % multiply T by this to get A/m
            gauss_conversion = tesla_conversion * 1e-4; % 1 G = 1e-4 T
            conversion = [1 1000 oe_conversion oe_conversion*1000 tesla_conversion gauss_conversion gauss_conversion*1000 1 1000 1000000 1000 tesla_conversion tesla_conversion gauss_conversion gauss_conversion*1000 1 1];
            obj.UnitConversions = dictionary(units, conversion);
        end

        function X = convert(obj, X_raw, unit)
            X = X_raw .* obj.UnitConversions(unit);
        end

        function [H, M] = convert_H_M(obj, H_raw, H_unit, M_raw, M_unit)
            H = convert(obj, H_raw, H_unit);
            M = convert(obj, M_raw, M_unit);
            if(M_unit == "B [T]" || M_unit == "B [G]" || M_unit == "B [kG]")
                M = M - H;
            end
        end
    end
end