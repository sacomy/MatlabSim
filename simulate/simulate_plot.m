% matƒtƒ@ƒCƒ‹‚©‚ç“®‰æ‚ğÄ¶
clear
close all

figure;
load('log/logOK.mat');

w = waitforbuttonpress;

count = 1;
offset_car = 0.10;
max_axis = 0.0;
pendulum_l = 0.1;
while(1)
  %{
  hold off;
  plot_points_x = [state(1,count), state(1,count) - 1*sin(state(3,count))];
  plot_points_y = [offset_car, offset_car+1*cos(state(3,count))];
  car_x = [state(1,count)-offset_car, state(1,count)-offset_car, state(1,count)+offset_car, state(1,count)+offset_car, state(1,count)-offset_car];
  car_y = [0, offset_car, offset_car, 0, 0];
  plot(plot_points_x, plot_points_y, '.-', 'MarkerSize', 20, 'LineWidth', 2);
  hold on;
  plot(car_x, car_y, '-');
  hold on;
  plot([state(1,count)-offset_car/2, state(1,count)+offset_car/2], [0, 0], 'o', 'MarkerSize', 10);
  axis equal; axis([-3+state(1,count) 3+state(1,count) -1 2]);
  title(sprintf('Time: %0.0f sec', count*0.01));
  %}
  
  hold off;
  plot_points_x = [state(1,count), state(1,count) - pendulum_l*sin(state(3,count))];
  plot_points_y = [offset_car/2, offset_car/2+pendulum_l*cos(state(3,count))];
  car_x = [state(1,count)-offset_car, state(1,count)-offset_car, state(1,count)+offset_car, state(1,count)+offset_car, state(1,count)-offset_car];
  car_y = [0, offset_car/2, offset_car/2, 0, 0];
  wheel_theta = linspace(0,2*pi);
  wheel_x = 0.02*cos(wheel_theta);
  wheel_y = 0.02*sin(wheel_theta);
  plot(plot_points_x, plot_points_y, '.-k', 'MarkerSize', 20, 'LineWidth', 2);
  hold on;
  plot(car_x, car_y, '-k');
  hold on;
  plot(wheel_x+state(1,count)-offset_car/2, wheel_y, 'k');
  hold on;
  plot(wheel_x+state(1,count)+offset_car/2, wheel_y, 'k');
  if max_axis<abs(state(1,count))
    max_axis = abs(state(1,count));
  end
  axis equal; axis([-0.2-max_axis 0.2+max_axis -0.1 0.20]);
  drawnow;
  count = count+10;
  if count == length(t)
    break;
  end
  pause(0.1);
end

close all;