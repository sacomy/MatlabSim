function dx = motor_func(t,x)
global motor_u
J=0.5;
D=0.2;
L=0.00034;
R=0.41;
K_tau=4.0;
K_e=6.0;
u = motor_u;

A = - R/L*x(1) - K_e/L*x(2) + u;
B = K_tau/J*x(1) - D/J*x(2);

dx = A+B;
end