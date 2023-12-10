% True parameter values
true_m = 2.0;
true_b = 0.5;
true_k = 3.0;
K = 1.0;

% Generate synthetic experimental data
time_steps = linspace(0, 5, 100);
force_input = sin(time_steps);  % Example force input
true_response = K ./ (true_m * time_steps.^2 + true_b * time_steps + true_k);

% Add some random noise to simulate measurement errors
noise = 0.1 * randn(size(true_response));
observed_data = true_response + noise;

% Define the objective function (mean squared error)
objective = @(params) mean((observed_data - K ./ (params(1) * time_steps.^2 + params(2) * time_steps + params(3))).^2);

% Initial guess for parameters
initial_guess = [1.0, 0.2, 2.0];

% Use fminsearch for parameter estimation
estimated_params = fminsearch(objective, initial_guess);

% Display results
disp('True Parameters:');
disp(['Inertia (m): ', num2str(true_m)]);
disp(['Viscosity (b): ', num2str(true_b)]);
disp(['Stiffness (k): ', num2str(true_k)]);
disp(' ');
disp('Estimated Parameters:');
disp(['Inertia (m): ', num2str(estimated_params(1))]);
disp(['Viscosity (b): ', num2str(estimated_params(2))]);
disp(['Stiffness (k): ', num2str(estimated_params(3))]);