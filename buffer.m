% 回転トルク入力の倒立振子
close all
clear

% パラメータ
p = [1.0,1.0];
global a b;
a = 1.0;
b = [0; 1.0];
alpha = 1.0;
k = 10.0;

% 初期状態(倒立振子に入力を全く入れていない状態を想定)
th0 = [pi;0];

dt = 0.01;
t = 0:dt:10-dt;

% プロット用の関数
th = zeros(2, length(t));
th(:,1) = th0;
u = zeros(1, length(t));
inv_pb = 1 / (p*b);
fx = zeros(2,1);

