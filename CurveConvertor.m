classdef CurveConvertor

    properties
    end

    methods
        function obj = CurveConvertor()
        end

        function [H, M] = convert_curve(~, X, Y, curve_type)
            H = X;
            M = Y;
            if(curve_type == "Anhysteretic curve")
                new_index = -1;
                for i = 1:length(H)
                    if( H(i) >= 0 )
                        new_index = i;
                        break;
                    end
                end

                H = H(new_index:end);
                M = M(new_index:end);
                return;
            end
            [~, H_min_index] = min(H); % Find H minimum (i.e., -Htip) as well as the row index of data in which it appears
            
            H_start = H(H_min_index:end);
            H_end = H(1:H_min_index);
            H_sorted = [H_start H_end];
            
            M_start = M(H_min_index:end);
            M_end = M(1:H_min_index);
            M_sorted = [M_start M_end];
            
            [~, M_max_index] = max(M_sorted);
            
            H_right = H_sorted(1:M_max_index);
            M_right = M_sorted(1:M_max_index);
            
            H_left = H_sorted(M_max_index:end);
            M_left = M_sorted(M_max_index:end);
            
            [M_right_unique, M_right_unique_indexes] = unique(M_right);
            H_right_unique = H_right(M_right_unique_indexes);
            [M_left_unique, M_left_unique_indexes] = unique(M_left);
            H_left_unique = H_left(M_left_unique_indexes);
            
            M_positive_tip_right = max(M_right);
            M_positive_tip_left = max(M_left);
            M_positive_tip = min(M_positive_tip_right,M_positive_tip_left);
            
            F_right = griddedInterpolant(M_right_unique,H_right_unique,'linear','none');
            F_left = griddedInterpolant(M_left_unique,H_left_unique,'linear','none');
            
            N_grid = 100; 
            
            M_query = linspace(0,M_positive_tip,N_grid);
           
            H_right_query = F_right(M_query);
            H_left_query = F_left(M_query);
            
            H = 1/2*(H_right_query + H_left_query);
            M = M_query;
            
            new_index = -1;
            for i = 1:length(H)
              if( H(i) >= 0 )
                new_index = i;
                break;
              end
            end

            H = H(new_index:end);
            M = M(new_index:end);
        end
    end
end