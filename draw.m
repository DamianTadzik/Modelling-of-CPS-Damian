clear draw_robot
clear draw

%% Run the model without the regulator in the equilibrium point
BOUNDARY_CHOICE = "BOUNDED"; % BOUNDED or UNBOUNDED
MODEL_CHOICE = "LINEARIZED_SCHED"; % LINEARIZED_SL LINEARIZED_MY LINEARIZED_SCHED or NONLINEAR
REGULATOR_CHOICE = "ZERO_INPUT"; % ZERO_INPUT STABLE_INPUT SIMPLE_P_REG
set_param('model_robot', 'SolverType', 'Fixed-step');
set_param('model_robot', 'Solver', 'ode45');
set_param('model_robot', 'FixedStep', '0.01');
set_param('model_robot', 'StartTime', '0'); % should be 0
set_param('model_robot', 'StopTime', '.5');
set_param('model_robot', 'SimulationCommand', 'update');
simOut = sim('model_robot');

x1_sim = simOut.Scope.signals(1).values; % theta
x2_sim = simOut.Scope.signals(2).values; % theta dot
x3_sim = simOut.Scope.signals(3).values; % r
x4_sim = simOut.Scope.signals(4).values; % r dot
f_sim = simOut.Scope.signals(5).values;
gamma_sim = simOut.Scope.signals(6).values;
time_sim = simOut.Scope.time;
samples_sim = length(time_sim)

%% Draw
for i=1:samples_sim
    draw_robot(x3_sim(i), x1_sim(i), x4_sim(i), x2_sim(i), f_sim(i), gamma_sim(i), time_sim(i), time_sim(end), r_min, r_max, theta_min, theta_max)
    pause(0.001);
end

%% TODO / NOTES
% TODO: Fix the linearized model -- DONE
% NOTE: Another thing is that running a model with different solver gives
% different results, ode45 is better than ode4 for example
% NOTE: The LINEARIZED_SL model is not working yet.
% NOTE: SIMPLE_P_REG is just a placeholder