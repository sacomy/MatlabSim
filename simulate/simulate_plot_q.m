% matファイルから動画を再生
clear
close all

h = figure(1);
filename = 'testAnimated.gif'; % 保存する名前
load('log/log1000.mat');

w = waitforbuttonpress;

count = 2; % 1列目はprepare_plotで使用するので2列目から
offset_car = 0.10;
max_axis = 0.0;
pendulum_l = 0.1;
step_skip = 4;
step_time = 0.01 * step_skip;
sizen= 512; % rgb2ind()の関数でRGBイメージをインデックス付きイメージに変換する…らしい(よくわからん)。
            % ただ、gifにアニメーションとして保存するサイズに対してこのsizeが小さいと"権限がない"
            % とかのエラーがでる。そうなったらこのsizeを大きくしてみよう。    
delaytime = step_time; % 画像を送る（更新する）間隔。単位は秒。つまり今回は0.5秒で切り替わる

[car, plot_point] = prepare_plot(plot_state(count,1), offset_car, plot_state(count,1), pendulum_l);
axis([-0.5 0.5 -0.10 0.20]);
drawnow;

tic; % ストップウォッチの開始
start_toc = toc;
while(1)
  car_x = [plot_state(count,1)-offset_car, plot_state(count,1)-offset_car, plot_state(count,1)+offset_car, plot_state(count,1)+offset_car, plot_state(count,1)-offset_car];
  car_y = [0, offset_car/2, offset_car/2, 0, 0];
  plot_point_x = [plot_state(count,1), plot_state(count,1) - pendulum_l*sin(plot_state(count,1))];
  plot_point_y = [offset_car/2, offset_car/2+pendulum_l*cos(plot_state(count,1))];
  
  set(car, 'Xdata', car_x); set(car, 'Ydata', car_y);
  set(plot_point, 'Xdata', plot_point_x); set(plot_point, 'Ydata', plot_point_y);
  
  count = count + step_skip;
  if count >= length(plot_state(:,1))-step_skip
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