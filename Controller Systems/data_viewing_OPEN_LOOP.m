r_TVS_data = squeeze(r_TVS.data)';
k_TVS_data = squeeze(k_TVS.data)';


plot(r_TVS_data(:,1)-r_TVS_data(:,2))
plot(k_TVS_data(:,1)-k_TVS_data(:,2))