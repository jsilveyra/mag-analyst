classdef Langevin


    methods(Access = public)
        function obj = Langevin()
        end

        function ret = inverse(~, h)
            ret = h;
        end

        function ret = first_derivative(~, h)
            ret = h;
        end

        function ret = second_derivative(~, h)
            ret = h;
        end

   end
end