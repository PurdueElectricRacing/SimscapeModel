TO_lin = linspace(0,21,10);
TO_in = table2array(combinations(TO_lin,TO_lin,TO_lin,TO_lin));

parfor i = 1:size(TO_in,1)
    for j = 1:size(TO_in,1)
        TO_test = rescale_torque(TO_in(j,:), TO_in(i,:));
        test = any([any(isnan(TO_test)) any(isinf(TO_test)) any(TO_test > TO_in(i,:))]);
        if test
            fprintf('Invalid test at indices (%d, %d)\n', i, j);
        end
    end
    % fprintf("%d\n", i)
end