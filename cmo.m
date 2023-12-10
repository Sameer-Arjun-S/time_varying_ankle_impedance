% Example for reading a text-based file with known format
file_path = 'p9.cmo';

try
    % Read data (adjust the format based on your file structure)
    data = importdata(file_path);
    
    % Check if data is a structure (indicating an issue with import)
    if isstruct(data)
        error('Error importing data. Check the file format.');
    end
    
    % Display the size of the data array
    disp(size(data));
    
    % Access the extracted data using linear indexing
    num_columns = size(data, 2);
    x_values = data(1:num_columns:end);
    y_values = data(2:num_columns:end);
    z_values = data(3:num_columns:end);
    
    % Trim or pad vectors to the same length
    min_length = min([length(x_values), length(y_values), length(z_values)]);
    x_values = x_values(1:min_length);
    y_values = y_values(1:min_length);
    z_values = z_values(1:min_length);
    
    % Define the maximum number of rows to save in a single sheet
    max_rows_per_sheet = 100; % Excel maximum number of rows
    
    % Determine the number of rows to save
    rows_to_save = min(min_length, max_rows_per_sheet);
    
    % Create a table from the data
    table_data = table(x_values(1:rows_to_save)', y_values(1:rows_to_save)', z_values(1:rows_to_save)', ...
        'VariableNames', {'X', 'Y', 'Z'});
    
    % Create column headers
    headers = {'X', 'Y', 'Z'};
    
    % Save the table to an Excel file using writetable
    excel_file_path = 'output_data.xlsx';  % Save as XLSX format
    writetable(table_data, excel_file_path, 'Sheet', 'Sheet1', 'WriteMode', 'overwritesheet');
    
    disp(['Data saved to ', excel_file_path]);
    
catch ME
    % Display an error message if an exception occurs
    disp(['Error: ', ME.message]);
end
