% üŒ`‹ß—‚µ‚½“|—§Uq(‘äÔƒ‚ƒfƒ‹)‚Ìó‘Ô•û’ö®
function dx = inverted_pendulum_func(t,x)
  global inverted_pendulum_u
  M = 0.5;
  m = 0.2;
  l = 0.1;
  g = 9.8;
  
  A = [x(2); m*g/M*x(3); x(4); (M+m)*g/(M*l)*x(3)];
  B = [0; 1/M*inverted_pendulum_u; 0; 1/(M*l)*inverted_pendulum_u];
  
  dx = A+B;
end