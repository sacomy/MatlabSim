% モーターシステム(トルク入力の電圧フィードバックシステム)
function tau_out = motor_feedback(tau_ref, dt, k_p, k_i, k_d)
 % params
  K_tau=4.0; 
 
 % persistent params
  persistent sum_err pre_err i omega
  if isempty(sum_err)
    sum_err = 0;
  end
  if isempty(pre_err)
    pre_err = 0;
  end
  if isempty(i)
    i = 0;
  end
  if isempty(omega)
    omega = 0;
  end
  
 % main_process
  err = tau_ref - i*K_tau;
  sum_err = sum_err + err*dt;
  d_err = (err - pre_err) / dt;
  pre_err = err;
  v = err*k_p + sum_err*k_i + d_err*k_d;
  i_omega = runge_kutta([i omega], v, dt, @motor_func);
  i = i_omega(1);
  omega = i_omega(2);
  tau_out = i*K_tau;
end