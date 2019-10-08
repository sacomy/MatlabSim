% “|—§Uq(‘äÔƒ‚ƒfƒ‹)‚Ìó‘Ô•û’ö®
function dx = plant(x, u)
  M = 0.05;
  m = 0.3;
  l = 0.2;
  g = 9.8;
  
  denominator_ddx = M+m*cos(x(3))*cos(x(3));
  numerator_ddx = -m*l*x(4)*x(4)*sin(x(3))+m*g*sin(x(3))*cos(x(3));
  denominator_ddtheta = M+m*sin(x(3))*sin(x(3));
  numerator_ddtheta = -m*l*x(4)*x(4)*sin(x(3))*cos(x(3))+(M+m)*g*sin(x(3));
  
  A = [x(2); numerator_ddx/denominator_ddx; x(4); numerator_ddtheta/denominator_ddtheta];
  B = [0; 1/denominator_ddx; 0; cos(x(3))/denominator_ddtheta];
  
  dx = A+u.*B;
end