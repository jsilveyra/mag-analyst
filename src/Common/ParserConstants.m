classdef ParserConstants
%PARSERCONSTANTS  Supported curve types and H/M field-unit labels.
%   Enumerates the two curve_type strings (anhysteretic curve / hysteresis
%   loop) and the H-field (A/m, kA/m, Oe, kOe, Bext in T/G/kG) and M-field
%   (A/m, kA/m, MA/m, emu/cm^3, sigma in emu/g = Am^2/kg, J/B in T/G/kG)
%   unit labels used by the Input-data tab dropdowns and consumed by
%   Parser/UnitConvertor.

    properties
        ANHYSTERETIC_CURVE_TYPE
        HYSTERESIS_LOOP_TYPE

        % X-axis supported fields and units
        H_AMPERE_PER_METER
        H_KILO_AMPERE_PER_METER
        H_OERSTED
        H_KILO_OERSTED
        BEXT_TESLA
        BEXT_GAUSS
        BEXT_KILO_GAUSS

        % Y-axis supported fields and units
        M_AMPERE_PER_METER
        M_KILO_AMPERE_PER_METER
        M_MEGA_AMPERE_PER_METER
        M_ELECTROMAGNETIC_UNIT_PER_CUBE_CENTIMETER
        SIGMA_ELECTROMAGNETIC_UNIT_PER_GRAM
        J_TESLA
        B_TESLA
        B_GAUSS
        B_KILO_GAUSS
    end

    methods
        function obj = ParserConstants()
            obj.ANHYSTERETIC_CURVE_TYPE = "Anhysteretic curve";
            obj.HYSTERESIS_LOOP_TYPE = "Hysteresis loop";

            obj.H_AMPERE_PER_METER = "H [A/m]";
            obj.H_KILO_AMPERE_PER_METER = "H [kA/m]";
            obj.H_OERSTED = "H [Oe]";
            obj.H_KILO_OERSTED = "H [kOe]";
            obj.BEXT_TESLA = "Bext [T]";
            obj.BEXT_GAUSS = "Bext [G]";
            obj.BEXT_KILO_GAUSS = "Bext [kG]";

            obj.M_AMPERE_PER_METER = "M [A/m]";
            obj.M_KILO_AMPERE_PER_METER = "M [kA/m]";
            obj.M_MEGA_AMPERE_PER_METER = "M [MA/m]";
            obj.M_ELECTROMAGNETIC_UNIT_PER_CUBE_CENTIMETER = "M [emu/cm^3]";
            obj.SIGMA_ELECTROMAGNETIC_UNIT_PER_GRAM = string([char(963) ' [emu/g=Am^2/kg]']);
            obj.J_TESLA = "J [T]";
            obj.B_TESLA = "B [T]";
            obj.B_GAUSS = "B [G]";
            obj.B_KILO_GAUSS = "B [kG]";

        end
    end
end
