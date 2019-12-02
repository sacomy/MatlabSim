% motor�̐���e�X�g
clear
close all

% �p�����[�^
plant_dt = 0.01;
t = 0:plant_dt:1;
motor_dt = 0.01;
m_k_p = 1.0;
m_k_i = 0.0;
m_k_d = 0.0;

% plot�̂���
out_tau = zeros(1, length(t));

% ���C�����[�v
state_I = state_0;
for i=1:length(t)-1
  state_i = state_I;
  out_tau(:, i) = motor_feedback(2.0, motor_dt, m_k_p, m_k_i, m_k_d);
end
figure(1)
plot(t,u);
legend('u');
title('����u�̎��ԉ���');
xlabel('����t');
ylabel('����u');