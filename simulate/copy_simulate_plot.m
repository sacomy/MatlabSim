% matファイルから動画を再生
clear
close all

figure;
load('log/log.mat');

w = waitforbuttonpress;

count = 2; % 1列目はprepare_plotで使用するので2列目から
offset_car = 0.10;
max_axis = 0.0;
pendulum_l = 0.1;
step_skip = 1;
step_time = 0.01 * step_skip;

[car, plot_point] = prepare_plot(state(1,count), offset_car, state(3,count), pendulum_l);
axis([-0.5 0.5 -0.10 0.20]);
drawnow;

tic; % ストップウォッチの開始
start_toc = toc;
while(1)
  car_x = [state(1,count)-offset_car, state(1,count)-offset_car, state(1,count)+offset_car, state(1,count)+offset_car, state(1,count)-offset_car];
  car_y = [0, offset_car/2, offset_car/2, 0, 0];
  plot_point_x = [state(1,count), state(1,count) - pendulum_l*sin(state(3,count))];
  plot_point_y = [offset_car/2, offset_car/2+pendulum_l*cos(state(3,count))];
  
  set(car, 'Xdata', car_x); set(car, 'Ydata', car_y);
  set(plot_point, 'Xdata', plot_point_x); set(plot_point, 'Ydata', plot_point_y);
  
  if max_axis<abs(state(1,count))
    max_axis = abs(state(1,count));
  end
  count = count + step_skip;
  if count >= length(t)-step_skip
    break;
  end
  end_toc = toc;
  process_time = end_toc - start_toc;
  if process_time > step_time
    disp('step_skip too small. process_time is');
    disp(process_time);
    break;
  end
  pause(step_time - (end_toc - start_toc));
  start_toc = toc;
end
toc

close all;