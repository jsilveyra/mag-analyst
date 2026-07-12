classdef DisplayUnits
%DISPLAYUNITS Native-mode label lookups for mass- vs volume-magnetization
%   display. Governed entirely by app.M_is_mass_based (set at import time
%   from whether the vertical-axis unit was sigma [emu/g=Am^2/kg]).
%
%   No value conversion is performed here: MagneticParameters/ja_ode are
%   already unit-agnostic, so the numbers the app computes are already
%   correct in whichever domain (mass or volume) the data was imported in.
%   This class only decides what to call them.

    methods (Static)
        function label = get_H_label(~)
            label = "H [A/m]";
        end

        function label = get_M_label(app)
            % IMPORTANT: this exact string is also used as a UnitConvertor
            % dictionary key and as VerticalaxisfieldDropDown_2's item text
            % (see PlaygroundUtils.convert_playground_curve_units /
            % sync_playground_mass_ui) -- it must match a real dictionary
            % entry (caret "^2", not a unicode superscript) exactly, or the
            % unit lookup throws "Key not found". "emu/g=" is spelled out
            % only on the Input tab's own dropdown item (which doubles as
            % the Parser/UnitConvertor unit key at import time); everywhere
            % else uses this shorter "Am^2/kg"-only form (also a valid
            % dictionary entry, same factor).
            if app.M_is_mass_based
                label = "σ [Am^2/kg]";
            else
                label = "M [A/m]";
            end
        end

        function label = get_Mtip_label(app)
            if app.M_is_mass_based
                label = "σtip [Am²/kg]";
            else
                label = "Mtip [A/m]";
            end
        end

        function label = get_Mstart_label(app)
            if app.M_is_mass_based
                label = "σstart [Am²/kg]";
            else
                label = "Mstart [A/m]";
            end
        end

        function label = get_dMdH_label(app)
            % dsigma/dH is NOT dimensionless the way dM/dH is: M and H
            % share A/m so dM/dH cancels to unitless, but sigma [Am^2/kg]
            % over H [A/m] leaves m^3/kg.
            if app.M_is_mass_based
                label = "dσ/dH [m³/kg]";
            else
                label = "dM/dH";
            end
        end

        function label = get_HdMdH_label(app)
            if app.M_is_mass_based
                label = "∂σ/∂(lnH) [Am²/kg]";
            else
                label = "∂M/∂(lnH) [A/m]";
            end
        end

        function label = get_Ms_label(app)
            % Mirrors "Msᵢ" exactly: plain "s" (not subscripted, same as
            % volume mode's "M" + "s"), unicode subscript "ᵢ" for the
            % component index -- no underscore pseudo-subscripts.
            if app.M_is_mass_based
                label = "σsᵢ [Am²/kg]";
            else
                label = "Msᵢ [A/m]";
            end
        end

        function label = get_alpha_label(app)
            if app.M_is_mass_based
                label = "ρ·αᵢ [kg/m³]";
            else
                label = "αᵢ";
            end
        end

        function label = get_chi_label(app)
            % Mirrors "χᵢₙ ᵢ" (subscript "in" for init, space, subscript
            % component index): mass mode prefixes a subscript "m" for
            % "mass" before "in" -- "χₘᵢₙ ᵢ" -- all unicode subscripts, no
            % underscore.
            if app.M_is_mass_based
                label = "χₘᵢₙ ᵢ [m³/kg]";
            else
                label = "χᵢₙ ᵢ";
            end
        end

        function label = get_chi_total_label(app)
            if app.M_is_mass_based
                label = "χₘᵢₙ [m³/kg]";
            else
                label = "χᵢₙ";
            end
        end

        function label = get_density_product_label(app)
            if app.M_is_mass_based
                label = "NᵢkвT/ρ [J/kg]";
            else
                label = "NᵢkвT [J/m³]";
            end
        end

        function label = get_dimensionless_alphaMs_label(app)
            if app.M_is_mass_based
                label = "ρ·αᵢ⏐σsᵢ⏐/(3aᵢ)";
            else
                label = "αᵢ⏐Msᵢ⏐/(3aᵢ)";
            end
        end

        function label = get_Ms_scalar_label(app)
            % Same as get_Ms_label but without the per-component "i"
            % subscript, for single-value JA fields (Hysteretic/Playground)
            % -- mirrors "Ms [A/m]" (plain "s", no subscript at all here).
            if app.M_is_mass_based
                label = "σs [Am²/kg]";
            else
                label = "Ms [A/m]";
            end
        end

        function label = get_alpha_scalar_label(app)
            if app.M_is_mass_based
                label = "ρ·α [kg/m³]";
            else
                label = "α";
            end
        end

        function label = get_Js_slot_label(app)
            % Js [T] (saturation polarization) needs the true volume Ms,
            % not computable from a mass-native fit without a known density
            % (deferred, see docs/ideas/mass-density-cross-view.md) -- its
            % display slot is replaced by the total sigma_S instead (same
            % label as get_Ms_scalar_label, since it's the same quantity).
            if app.M_is_mass_based
                label = "σs [Am²/kg]";
            else
                label = "Js [T]";
            end
        end

        function apply_ja_labels(app, Ms_label_ctrl, alpha_label_ctrl)
            % Shared by the Hysteretic and Playground tabs' JA parameter
            % panels: Ms_label_ctrl/alpha_label_ctrl are the uilabel
            % components next to the Ms/alpha numeric fields. a and k are
            % always H-side (A/m), unaffected by M_is_mass_based, so their
            % labels are not touched here.
            Ms_label_ctrl.Text = char(DisplayUnits.get_Ms_scalar_label(app));
            alpha_label_ctrl.Text = char(DisplayUnits.get_alpha_scalar_label(app));
        end
    end
end
