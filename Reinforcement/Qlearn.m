% PIDによる倒立振子の制御(位置と速度と角度と角速度を利用)
clear
close all

% パラメータ
state_0 = [0.0, 0.0, 0.1, 0.0];
plant_dt = 0.01;
t = 0:plant_dt:5;
learn_step = 100000;
success_count = 0;

% Q-table
Q = rand(10000, 9);
% load('log/logQ.mat');

% digital param
p_dig = linspace(-0.5, 0.5, 10);
v_dig = linspace(-0.5, 0.5, 10);
t_dig = linspace(-0.5, 0.5, 10);
w_dig = linspace(-0.5, 0.5, 10);

% 報酬のプロットなど
plot_reward = [0.0];
plot_reward_ave = [0.0];
sum_reward = 0;

% 試行のループ
for i=1:learn_step
  % plot用
  plot_state = [0,0,0,0];
  plot_state(1,:) = state_0;
  plot_u = [0];

  % メインループ
  reward = 0;
  state_J = state_0;
  [~, u_j_index] = max(Q(State2Index(state_0, p_dig, v_dig, t_dig, w_dig), :));
  for j=1:length(t)-1
    state_j = state_J;
    state_J = runge_kutta(state_j, Index2U(u_j_index), plant_dt, @plantQ);
    if abs(state_J(1)) > 0.5
      reward = -150+reward;
      break
    elseif abs(state_J(3)) > 0.5
      reward = -100+reward;
      break
    else
      reward = 1+reward;
    end
    Q = UpdateQTable(Q, State2Index(state_j, p_dig, v_dig, t_dig, w_dig), u_j_index, reward, State2Index(state_J, p_dig, v_dig, t_dig, w_dig));
    u_j_index = GetU(Q(State2Index(state_J, p_dig, v_dig, t_dig, w_dig), :), j);
    plot_state(j+1, :) = state_J;
    plot_u(j, :) = u_j_index;
  end
  
  if reward >= 400
    success_count = success_count+1;
    disp('count');
    logname = strcat('log/log_success', num2str(success_count/50), '.mat');
    save(logname, 't', 'plot_state', 'plot_u', 'Q');
  else
  end
  if success_count > 500
    break;
  end
  
  sum_reward = sum_reward + reward;
  plot_reward(:, i) = reward;
  
  % 途中結果のグラフ表示
  plot_span = 1000;
  if rem(i, plot_span) == 0
    close all
    figure(1)
    plot(plot_reward(i-plot_span+1:i));
    figure(2)
    plot(plot_state);
    hold on
    plot(plot_u);
    legend('x', 'dx/dt', 'θ', 'dθ/dt', 'u');
    title('状態変数x, dx/dt, θ, dθ/dtの時間応答');
    xlabel('時間t');
    ylabel('状態変数x, dx/dt, θ, dθ/dt, 入力u');
    figure(3)
    plot(plot_reward_ave);
    logname = strcat('log/log', num2str(i), '.mat');
    save(logname, 't', 'plot_state', 'plot_u', 'Q');
    drawnow;
  end
  
  if rem(i, 100) == 0
    disp(i);
    disp(success_count);
    disp(sum_reward/100);
    plot_reward_ave(:,i/100) = sum_reward/100;
    sum_reward = 0;
  end
  
end

% plot
figure(1)
plot(plot_reward);
save('log/logQ', 'Q', 'plot_reward');


% 離散値の入力をindexから算出
function u = Index2U(index)
  switch index
    case 1
      u = -10;
    case 2
      u = -6;
    case 3
      u = -3;
    case 4
      u = -1;
    case 5
      u = 0;
    case 6
      u = 1;
    case 7
      u = 3;
    case 8
      u = 6;
    case 9
      u = 10;
  end
end

% 現在の状態からQtableのindexを求める
function index = State2Index(state, p_dig, v_dig, t_dig, w_dig)
  [N, ~] = histcounts(state(1), p_dig);
  [~, p] = max(N);
  [N, ~] = histcounts(state(2), v_dig);
  [~, v] = max(N);
  [N, ~] = histcounts(state(3), t_dig);
  [~, t] = max(N);
  [N, ~] = histcounts(state(4), w_dig);
  [~, w] = max(N);
  index = p + (v-1)*10 + (t-1)*100 + (w-1)*1000;
end

% ある状態における入力uを決定する
function u_index = GetU(LineQ, step)  
  epsilon = 0.5 * (1 / (step + 1));
  if rand()<epsilon
    u_index = fix(randi(9));
  else
    [~, u_index] = max(LineQ);
  end
end

% Q-tableを更新する
function q = UpdateQTable(Q, state_index, u_index, reward, next_state_index)
  gamma = 0.99;
  alpha = 0.5;
  next_max_q = max(Q(next_state_index, :));
  q = Q;
  q(state_index, u_index) = (1 - alpha) * Q(state_index, u_index) + alpha * (reward + gamma * next_max_q);
end