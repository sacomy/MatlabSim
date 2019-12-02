% PIDによる倒立振子の制御
clear
close all

% パラメータ
state_0 = [0.0; 0.0; 0.1; 0.0];
plant_dt = 0.01;
t = 0:plant_dt:10;
k_p = 10.0;
k_i = 0.0;
k_d = 2.0;
motor_dt = 0.01;
m_k_p = 1.0;
m_k_i = 0.0;
m_k_d = 0.0;

% plotのため
state = zeros(4, length(t));
state(:,1) = state_0;
u = zeros(1, length(t));


% メインループ
state_I = state_0;
err = 0.0;
pre_err = 0.0;
sum_err = 0.0;
d_err = 0.0;
for i=1:length(t)-1
  state_i = state_I;
  err = state_i(3);
  sum_err = sum_err + err*plant_dt;
  d_err = (err - pre_err) / plant_dt;
  pre_err = err;
  % u_i = motor_feedback(-(err*k_p + sum_err*k_i + d_err*k_d), motor_dt, m_k_p, m_k_i, m_k_d);
  u_i = -(err*k_p + sum_err*k_i + d_err*k_d);
  state_I = runge_kutta(state_i, u_i, plant_dt, @plant);
  state(:, i+1) = state_I;
  u(:, i) = u_i;
end
figure(1)
plot(t,state);
hold on
plot(t,u);
legend('x', 'dx/dt', 'θ', 'dθ/dt', 'u');
title('状態変数x, dx/dt, θ, dθ/dtの時間応答');
xlabel('時間t');
ylabel('状態変数x, dx/dt, θ, dθ/dt, 入力u');

save('log/log.mat', 't', 'state', 'u');