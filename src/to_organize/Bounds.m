classdef Bounds
    %BOUNDS Parameter bounds container for JA optimization.
    %   Empty values ([]) mean unbounded.

    properties
        Ms
        a
        alpha
        c
        k
    end

    methods
        function obj = Bounds(varargin)
            % Defaults: all unbounded
            obj.Ms = [];
            obj.a = [];
            obj.alpha = [];
            obj.c = [];
            obj.k = [];

            if nargin == 0
                return;
            end

            if nargin == 1 && isstruct(varargin{1})
                s = varargin{1};
                if isfield(s, 'Ms'), obj.Ms = s.Ms; end
                if isfield(s, 'a'), obj.a = s.a; end
                if isfield(s, 'alpha'), obj.alpha = s.alpha; end
                if isfield(s, 'c'), obj.c = s.c; end
                if isfield(s, 'k'), obj.k = s.k; end
                return;
            end

            error('Bounds:InvalidInput', ...
                'Use Bounds() or Bounds(struct(''Ms'',...)).');
        end

        function s = to_struct(obj)
            s = struct( ...
                'Ms', obj.Ms, ...
                'a', obj.a, ...
                'alpha', obj.alpha, ...
                'c', obj.c, ...
                'k', obj.k);
        end
    end
end

