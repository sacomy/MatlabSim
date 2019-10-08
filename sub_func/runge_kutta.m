% 古典的ルンゲ＝クッタ法
function next_x = runge_kutta(x, u, dt, func)
  k1 = func(x,u);
  k2 = func(x+k1*dt/2,u);
  k3 = func(x+k2*dt/2,u);
  k4 = func(x+k3*dt,u);

  next_x = x + dt/6*(k1+2*k2+2*k3+k4);
end