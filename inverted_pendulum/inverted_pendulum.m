% üŒ`‹ß—‚µ‚½“|—§Uq(‘äÔƒ‚ƒfƒ‹)‚Ìó‘Ô•û’ö®
function x_N = inverted_pendulum(x_n, dt)
  global inverted_pendulum_u
  M = 0.5;
  m = 1.0;
  l = 0.1;
  g = 9.8;
  
  A = [x_n(2); x_n(3)*m*g/M; x_n(4); x_n(3)*(M+m)*g/(M*l)];
  B = [0; inverted_pendulum_u/M; 0; inverted_pendulum_u/(M*l)];
  
  x_N = A*dt+eye(4)*x_n+B*dt;
end