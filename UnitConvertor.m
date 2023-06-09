classdef UnitConvertor
    properties
        UnitConversions
    end

    methods
        function obj = UnitConvertor()
            units = ["H [A/m]" "H [kA/m]" "H [Oe]" "H [kOe]" "Bext [T]" "Bext [Gauss]" "Bext [kGauss]"];
            oe_conversion = 79.5774715459;
            tesla_conversion = 1/(4*pi*10^-7);
            gauss_conversion = 1/(10000 * tesla_conversion);
            conversion = [1 1000 oe_conversion oe_conversion*1000 tesla_conversion gauss_conversion gauss_conversion*1000];
            obj.UnitConversions = dictionary(units, conversion);
        end

        function X = convert(obj, X_raw, unit)
            X = X_raw .* obj.UnitConversions(unit);
        end
    end
end