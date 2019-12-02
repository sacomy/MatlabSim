% ƒ‚[ƒ^[Œn‚Ìó‘Ô•û’ö®
function dx = motor_func(x, u)
  J=0.5;
  D=0.2;
  L=0.00034;
  R=0.41;
  K_tau=4.0;
  K_e=6.0;

  A = [- R/L*x(1) - K_e/L*x(2); K_tau/J*x(1) - D/J*x(2)];
  B = [u; 0];

  dx = A+B;
end