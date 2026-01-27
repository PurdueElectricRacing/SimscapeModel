% Select runs for plotting
tau_sum_cond = input_combos(:,1) == 18;
split_FR_cond = input_combos(:,2) == .5;
split_LR_cond = input_combos(:,3) == .5;
CCSA_cond = input_combos(:,4) == 45;

plt_ind = all([tau_sum_cond], 2);

input_combos_plt = input_combos(plt_ind,:);
result_array_plt = result_array(plt_ind);

% select runs for highlighting
hl_ind = [result_array_plt.drho_avg] > .39 & [result_array_plt.drho_avg] < .41;
col = repmat("#268CDD",[length(plt_ind),1]);
col(hl_ind) = "#F57729";
col = hex2rgb(col);

%% plot
figure(1)
scatter3(input_combos_plt(:,3), input_combos_plt(:,4), [result_array_plt.V_avg]', 10, col)
xlabel("Left-Right Split")
ylabel("Steering Angle")
zlabel("Velocity")

figure(2)
scatter3(input_combos_plt(:,3), input_combos_plt(:,4), [result_array_plt.r_avg]', 10, col)
xlabel("Left-Right Split")
ylabel("Steering Angle")
zlabel("Turning Radius avg")
zlim([0,250])

figure(3)
scatter3(input_combos_plt(:,3), input_combos_plt(:,4), [result_array_plt.drho_avg]')
hold on
scatter3(input_combos_plt(:,3), input_combos_plt(:,4), [result_array_plt.V_avg]' ./ [result_array_plt.r_avg]',"x")
hold off
legend("drho","V/r")
xlabel("Left-Right Split")
ylabel("Steering Angle")
zlabel("dRho")


figure(4)
scatter3(input_combos_plt(:,3), input_combos_plt(:,4), [result_array_plt.r_std]')
xlabel("Left-Right Split")
ylabel("Steering Angle")
zlabel("Radius std")
