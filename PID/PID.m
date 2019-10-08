% �|���U�q�̃V�~�����[�V����
clear
close all

% �p�����[�^�[��
state_0 = [0.0; 0.0; 0.3; 0.0];
dt = 0.01;
t = 0:dt:10;
k_p = 3.0;
global inverted_pendulum_u motor_u
inverted_pendulum_u = 0;
motor_u = 0;

% �v���b�g�p�̊֐�
state = zeros(4, length(t));
state(:,1) = state_0;
u = zeros(1, length(t));


% ���C�����[�v
state_I = state_0;
for i=1:length(t)-1
  state_i = state_I;
  u_i = 0;
  state_I = runge_kutta(state_i, u_i, dt, @plant);
  state(:, i+1) = state_I;
  u(:, i) = u_i;
end
figure(1)
plot(t,state);
hold on
plot(t,u);
legend('x', 'dx/dt', '��', 'd��/dt', 'u');
title('��ԕϐ�x, dx/dt, ��, d��/dt�Ɠ���u�̎��ԉ���');
xlabel('����t');
ylabel('��ԕϐ�x, dx/dt, ��, d��/dt, ����u');

save('log.mat', 't', 'state', 'u');