clear draw_robot
clear draw
%% Run the model without the regulator in the equilibrium point
BOUNDARY_CHOICE = "BOUNDED"; % BOUNDED or UNBOUNDED
MODEL_CHOICE = "NONLINEAR"; % LINEARIZED or NONLINEAR
set_param('model_nonlinear', 'SolverType', 'Fixed-step');
set_param('model_nonlinear', 'Solver', 'ode4');
set_param('model_nonlinear', 'FixedStep', '0.01');
set_param('model_nonlinear', 'StartTime', '0'); % should be 0
set_param('model_nonlinear', 'StopTime', '1.1');
set_param('model_nonlinear', 'SimulationCommand', 'update');
simOut = sim('model_nonlinear');

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

%% TODO fix the linearized model