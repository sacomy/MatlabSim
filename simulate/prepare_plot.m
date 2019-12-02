function [cart, pole] = prepare_plot(cart_pos, cart_offset, pole_angle, pole_size)

  cart_x = [cart_pos-cart_offset, cart_pos-cart_offset, cart_pos+cart_offset, cart_pos+cart_offset, cart_pos-cart_offset];
  cart_y = [0, cart_offset/2, cart_offset/2, 0, 0];
  pole_x = [cart_pos, cart_pos - pole_size*sin(pole_angle)];
  pole_y = [cart_offset/2, cart_offset/2+pole_size*cos(pole_angle)];
  
  cart = plot(cart_x, cart_y, '-k');
  hold on;
  pole = plot(pole_x, pole_y, '-k', 'LineWidth', 2);
end