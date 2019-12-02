% matファイルから動画を保存
clear
close all

v = VideoWriter('movie/log', 'MPEG-4');
h = figure();
load('log/log.mat');

count = 2; % 1列目はprepare_plotで使用するので2列目から
offset_car = 0.10;
max_axis = 0.0;
pendulum_l = 0.1;
step_skip = 5;
step_time = 0.01 * step_skip;
delaytime = step_time;

[car, plot_point] = prepare_plot(plot_state(count,1), offset_car, plot_state(count,1), pendulum_l);
axis equal
axis([-0.3 0.3 -0.1 0.2]);
drawnow

open(v)
A = getframe(h);
writeVideo(v,A)

tic;
start_toc = toc;
while(1)
  car_x = [plot_state(count,1)-offset_car, plot_state(count,1)-offset_car, plot_state(count,1)+offset_car, plot_state(count,1)+offset_car, plot_state(count,1)-offset_car];
  car_y = [0, offset_car/2, offset_car/2, 0, 0];
  plot_point_x = [plot_state(count,1), plot_state(count,1) - pendulum_l*sin(plot_state(count,1))];
  plot_point_y = [offset_car/2, offset_car/2+pendulum_l*cos(plot_state(count,1))];
  
  set(car, 'Xdata', car_x); set(car, 'Ydata', car_y);
  set(plot_point, 'Xdata', plot_point_x); set(plot_point, 'Ydata', plot_point_y);
  
  A = getframe(h);
  writeVideo(v,A);
  count = count + step_skip;
  if count >= length(plot_state(:,1))-step_skip
    break;
  end
  end_toc = toc;
  process_time = end_toc - start_toc;
  if process_time > step_time
    disp('step_skip too small. now process_time is');
    disp(process_time);
    break;
  end
  pause(step_time - (end_toc - start_toc));
  start_toc = toc;
end
toc

close(v)
close all;