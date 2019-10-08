% matƒtƒ@ƒCƒ‹‚©‚ç“®‰æ‚ğÄ¶
clear
close all

figure;
load('log.mat');

w = waitforbuttonpress;

count = 1;
offset_car = 0.5;
while(1)
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
  
  axis equal; axis([-3 3 -3 3]);
  title(sprintf('Time: %0.1f sec', count*0.01));

  drawnow;
  count = count+5;
  if count == length(t)
    break;
  end
  pause(0.05);
end

close all;