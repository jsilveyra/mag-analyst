classdef UnitConvertor
    properties
        UnitConversions
    end

    methods
        function obj = UnitConvertor()
            units = ["H [A/m]" "H [kA/m]" "H [Oe]"];
            oe_conversion = 79.5774715459;
            conversion = [1 1000 oe_conversion];
            obj.UnitConversions = dictionary(units, conversion);
        end

        function X = convert(obj, X_raw, unit)
            X = X_raw .* obj.UnitConversions(unit);
        end
    end
end