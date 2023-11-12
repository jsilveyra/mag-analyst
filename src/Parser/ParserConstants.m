classdef ParserConstants

    properties
        ANHYSTERETIC_CURVE_TYPE
        HYSTERESIS_LOOP_TYPE

        % H supported units
        H_AMPERE_PER_METER
        H_KILO_AMPERE_PER_METER
        H_OERSTED
        H_KILO_OERSTED
        BEXT_TESLA
        BEXT_GAUSS
        BEXT_KILO_GAUSS

        % M supported units
        M_AMPERE_PER_METER
        M_KILO_AMPERE_PER_METER
        M_MEGA_AMPERE_PER_METER
        M_ELECTROMAGNETIC_UNIT_PER_CUBE_CENTIMETER
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
            obj.J_TESLA = "J [T]";
            obj.B_TESLA = "B [T]";
            obj.B_GAUSS = "B [G]";
            obj.B_KILO_GAUSS = "B [kG]";

        end
    end
end