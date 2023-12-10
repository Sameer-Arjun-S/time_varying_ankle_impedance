%% Impulse response function - Equation 6
% Inputs
window_size = 40;
input_signal = 90;

% Perform moving average
N = length(input_signal);
output_signal = zeros(1, N);

for i = 1:N
    lower_limit = max(1, i - window_size / 2);
    upper_limit = min(N, i + window_size / 2);

    % Sum elements within the window
    window_sum = sum(input_signal(lower_limit:upper_limit));

    % Calculate the moving average
    output_signal(i) = window_sum / window_size;
end

% Plot the results
figure;
plot(input_signal, 'b-', 'DisplayName', 'Original Signal');
hold on;
plot(output_signal, 'r-', 'DisplayName', 'Moving Average');
legend('Original Signal', 'Moving Average');
title('Moving Average of the Signal');
xlabel('Index');
ylabel('Signal Value');
grid on;

%% Equation 8
% z_r and z_r_hat are vectors representing signals

% Calculate the variance of z_r
var_z_r = var(z_r);

% Calculate the variance of the difference between z_r and z_r_hat
var_diff = var(z_r - z_r_hat);

% Calculate the VAF (Variance Accounted For)
VAF_output = 100 * (1 - var_diff / var_z_r);

% Display the result
disp(['VAF_output: ', num2str(VAF_output)]);


%% Equation 9
% hat_h_s and h_model_star are vectors representing signals

% Calculate the variance of hat_h_s
var_hat_h_s = var(hat_h_s);

% Calculate the variance of the difference between hat_h_s and h_model_star
var_diff = var(hat_h_s - h_model_star);

% Calculate the VAF_IRF (Variance Accounted For for Impulse Response Function)
VAF_IRF = 100 * (1 - var_diff / var_hat_h_s);

% Display the result
disp(['VAF_IRF: ', num2str(VAF_IRF)]);

%% Equation 10
% z_r and hat_z_model_r are vectors representing signals

% Calculate the variance of z_r
var_z_r = var(z_r);

% Calculate the variance of the difference between z_r and hat_z_model_r
var_diff = var(z_r - hat_z_model_r);

% Calculate the VAF_output_model (Variance Accounted For for Output Model)
VAF_output_model = 100 * (1 - var_diff / var_z_r);

% Display the result
disp(['VAF_output_model: ', num2str(VAF_output_model)]);

