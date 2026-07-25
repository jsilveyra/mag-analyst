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

        function eq = get_lw_model_eq(app)
            % Anhysteretic tab's Langevin-Weiss model formulation (LWModel_eq).
            if app.M_is_mass_based
                eq = '$\sigma(H) = \sum_{i}^{n} \sigma_i(H) = \sum_{i}^{n} \sigma_{S,i} \mathcal{L}\left[(H + \rho\alpha_i \sigma_i) / a_i\right]$';
            else
                eq = '$M(H) = \sum_{i}^{n} M_i(H) = \sum_{i}^{n} M_{S,i} \mathcal{L}\left[(H + \alpha_i M_i) / a_i\right]$';
            end
        end

        function eq = get_ja_anh_eq(app)
            % Classical J-A model formulation, line 1 (JAmodel_eq1 / _2).
            if app.M_is_mass_based
                eq = '$\quad \sigma_{anh} = \sigma_S \mathcal{L}\left[(H + \rho\alpha \sigma) / a\right]$';
            else
                eq = '$\quad M_{anh} = M_S \mathcal{L}\left[(H + \alpha M) / a\right]$';
            end
        end

        function eq = get_ja_m_eq(app)
            % Classical J-A model formulation, line 2 (JAmodel_eq2 / _2).
            if app.M_is_mass_based
                eq = '$\quad \sigma = c \sigma_{anh} + (1 - c) \sigma_{irr}$';
            else
                eq = '$\quad M = c M_{anh} + (1 - c) M_{irr}$';
            end
        end

        function eq = get_ja_irr_eq(app)
            % Classical J-A model formulation, line 3 (JAmodel_eq3 / _2).
            if app.M_is_mass_based
                eq = '$\quad \sigma_{irr} = \sigma_{anh} - \delta k \, d \sigma_{irr} / d H_{eff}$';
            else
                eq = '$\quad M_{irr} = M_{anh} - \delta k \, d M_{irr} / d H_{eff}$';
            end
        end

        function apply_ja_model_eqs(app, eq1_ctrl, eq2_ctrl, eq3_ctrl)
            % Shared by the Hysteretic (JAmodel_eq1/2/3) and Playground
            % (JAmodel_eq1_2/2_2/3_2) tabs' "Classical J-A model formulation"
            % LaTeX labels.
            eq1_ctrl.Text = DisplayUnits.get_ja_anh_eq(app);
            eq2_ctrl.Text = DisplayUnits.get_ja_m_eq(app);
            eq3_ctrl.Text = DisplayUnits.get_ja_irr_eq(app);
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
