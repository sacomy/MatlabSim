% ��]�g���N���͂̓|���U�q
close all
clear

% �p�����[�^
p = [1.0,1.0];
global a b;
a = 1.0;
b = [0; 1.0];
alpha = 1.0;
k = 10.0;

% �������(�|���U�q�ɓ��͂�S������Ă��Ȃ���Ԃ�z��)
th0 = [pi;0];

dt = 0.01;
t = 0:dt:10-dt;

% �v���b�g�p�̊֐�
th = zeros(2, length(t));
th(:,1) = th0;
u = zeros(1, length(t));
inv_pb = 1 / (p*b);
fx = zeros(2,1);

