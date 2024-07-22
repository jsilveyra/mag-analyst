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

            % [~, max_index] = max(M_sorted);    % find tip for Mmax 
            % [~, max_index] = max(H_sorted);    % find tip for Hmax           
            H2M2 = sign(H_sorted).*(H_sorted).^2./max(H_sorted.^2) + sign(M_sorted).*(M_sorted).^2./max(M_sorted.^2);
            [~, max_index] = max(H2M2);          % find tip for normalized H2M2max    
            
            H_right = H_sorted(1:max_index);
            M_right = M_sorted(1:max_index);
            
            H_left = H_sorted(max_index:end);
            M_left = M_sorted(max_index:end);

            [M_right_unique, M_right_unique_indexes] = unique(M_right);
            H_right_unique = H_right(M_right_unique_indexes);
            [M_left_unique, M_left_unique_indexes] = unique(M_left);
            H_left_unique = H_left(M_left_unique_indexes);
            
            M_positive_tip_right = max(M_right);
            M_positive_tip_left = max(M_left);
            M_positive_tip = min(M_positive_tip_right,M_positive_tip_left);
            
            F_right = griddedInterpolant(M_right_unique,H_right_unique,'linear','none');
            F_left = griddedInterpolant(M_left_unique,H_left_unique,'linear','none');
            
            N_grid = 50; % number of points of the positive anhysteretic curve calculated from a symmetric hysteresis loop
            
            M_query = linspace(0,M_positive_tip,N_grid);

            H_right_query = F_right(M_query);
            H_left_query = F_left(M_query);
            
            H = 1/2*(H_right_query + H_left_query);
            M = M_query;
            
            save 'Mq1.mat' M_query

            new_index = -1;

            if (H(1)<10^-6 || M(1)<10^-6) % this is because sometimes we obtained, for example (H;M)=(1.77635683940025e-14;0) as the first point
                H(1)=0;
            end

            for i = 1:length(H)
              if( H(i) >= 0 )
                new_index = i;
                break;
              end
            end

            H = H(new_index:end);
            M = M(new_index:end);

            % resample the unevenly spaced curve
           
            logH_n = transpose(log(H(H>0))/max(log(H(H>0))));
            M_n = transpose(M(H>0)/M_positive_tip);

            logH_M_n_interparc = interparc(N_grid,logH_n,M_n,'linear'); % this function calculates N_grid spaced points of the original curve in a normalized semi-log M vs H plane
            
            M_query = M_positive_tip * transpose(logH_M_n_interparc(:,2)); % use the recently found M values to recompute the mean average curve from the two branches of the symmetric hysteresis loop
            
            M_query(M_query==max(M_query)) = M_positive_tip; % this is because there is a minor difference between max(M_query) and M_positive_tip (e.g., 3.6380e-12, when they should be exactly the same), that makes that then H can't be interpolated.
            
            M_query = [0 M_query]; % add the origin to the array

            save 'Mq2.mat' M_query

            H_right_query = F_right(M_query);
            H_left_query = F_left(M_query);
            
            H = 1/2*(H_right_query + H_left_query);
            M = M_query;
            
            new_index = -1;

            if (H(1)<10^-6 || M(1)<10^-6) % this is because sometimes we obtained, for example (H;M)=(1.77635683940025e-14;0) as the first point
                H(1)=0;
            end

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