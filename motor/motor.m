% モーター系のステップ応答
J=0.5;
D=0.2;
L=0.00034;
R=0.41;
K_tau=4.0;
K_e=6.0;
v2omega_tf = tf(K_tau,[J*L,J*R+L*D, K_tau*K_e+R*D]);
v2tau_tf = tf([K_tau*J, K_tau*D], [J*L,J*R+L*D, K_tau*K_e+R*D]);
v2i_tf = tf([J, D], [J*L,J*R+L*D, K_tau*K_e+R*D]);
subplot(1,3,1);
step(v2omega_tf);
title('電圧に対する角速度のステップ応答');
subplot(1,3,2);
step(v2tau_tf);
title('電圧に対するトルクのステップ応答');
subplot(1,3,3);
step(v2i_tf);
title('電圧に対する電流のステップ応答');