function [hs_i, vaf_irf, vaf_output] = reliability_analysis(h, h_model, z, r)

% This function calculates the smoothed hidden state, IRF goodness-of-fit,
% and output prediction reliability, with user inputs.

% Get user inputs
N = input('Enter the number of time steps: ');
M = input('Enter the number of hidden units: ');
w = input('Enter the window size for smoothing: ');
r = input('Enter the realization index: ');

% Validate user inputs
if N <= 0 || M <= 0 || w <= 0
  error('Invalid input values. Please enter positive integers.');
end

% Get hidden state and model output from user
h = input('Enter the hidden state vector (NxM): ');
h_model = input('Enter the model output (NxM): ');
z = input('Enter the measured output (NxR): ');

% Ensure proper size of inputs
if size(h, 1) ~= N || size(h, 2) ~= M
  error('Hidden state vector size mismatch.');
end
if size(h_model, 1) ~= N || size(h_model, 2) ~= M
  error('Model output size mismatch.');
end
if size(z, 1) ~= N
  error('Measured output size mismatch.');
end

% Calculate smoothed hidden state and reliability values
hs = smooth_hidden_state(h, 2*w + 1);
hs_i = hs(i, :);
var_diff_irf = var(hs_i - h_model(i, :));
var_hs = var(hs_i);
vaf_irf = 100 * (1 - var_diff_irf / var_hs);
z_r = z(i, r);
z_hat_r = h_model(i, :) * w;
var_diff_output = var(z_r - z_hat_r);
var_z = var(z_r);
vaf_output = 100 * (1 - var_diff_output / var_z);

% Display results
disp(['Smoothed hidden state at time step ', num2str(i), ': ', num2str(hs_i)]);
disp(['IRF goodness-of-fit for realization ', num2str(r), ': ', num2str(vaf_irf), '%']);
disp(['Output prediction reliability for realization ', num2str(r), ': ', num2str(vaf_output), '%']);

end
