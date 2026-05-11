[raw, header] = load_data("C:\Users\TAK\Downloads\data2\out_002.csv", [1 66:69 199 208 217 226]);
t = raw(:,1); % time
RL_req_raw = raw(:, 3); % req
RL_inv_raw = raw(:, 8); % inv

RL_req_t = raw(~isnan(RL_req_raw), 1); % req time
RL_req = RL_req_raw(~isnan(RL_req_raw)); % req not nan

RL_inv_t = RL_req_raw(~isnan(RL_inv_raw), 1); % inv time
RL_inv = RL_inv_raw(~isnan(RL_inv_raw)); % inv not nan

figure(1)
hold off
scatter(t, RL_req_raw,".")
hold on
scatter(t, RL_inv_raw,".")
legend("req", "inv")

% figure(2)
% plot(RL_inv ./ RL_req)

