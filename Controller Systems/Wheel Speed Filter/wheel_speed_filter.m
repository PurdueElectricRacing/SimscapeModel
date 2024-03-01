function y_filt = wheel_speed_filter(y_vec,y_n,A_mat,k)
    % update observation vector
    y_vec = [y_vec(2:end); y_n];

    % find the psuedo-mean
    mu = median(y_vec);

    % filter data matrix and observation vector
    e = abs(mu - y_vec) < delta_lim;
    y_vec = y_vec(e);
    A_mat = A_mat(e,:);

    % find LSR
    beta = ((A_mat')*A_mat)\((A_mat')*y_vec);

    % find filtered number 
    % FIX: use legendre Polynomial instead!!
    % FIX: use k [-1 1] instead!!
    y_filt = beta(1)*k^2 + beta(2)*k + beta(3);

end