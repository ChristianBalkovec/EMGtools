%% check_column_import
% series of checks that ensures no incorrect values entered into column
% import option fields.
% 
% Inputs:
% row_entry = row the user has selected to start importing data from
% col_entries = 1x5 array containing the columns the user has selected to
%               import data from
% channels_in_dropdown = number of channels user has selected to process
%
% Output:
% message = error message (if error is thrown)
%%
function [message] = check_column_import(row_entry, col_entries, channels_in_dropdown)

% ensure user has not selected more channels to process than there are
% column entries to make
if channels_in_dropdown > 6
    message = 'Incorrect or not enough column import entries made.';
    return
end

% ensure a valid number has been written in the row section of the 
if isnan(row_entry) || mod(row_entry, 1) ~= 0 || row_entry <= 0
   message = 'Please enter a row to start importing from and ensure that your entry is an integer value.';
   return
end

% ensure that only numerical values are entered in the column boxes for
% the number of channels selected
for i=1:channels_in_dropdown-1
   if isnan(col_entries(1, i)) || mod(col_entries(1, i), 1) ~= 0 || col_entries(1, i) < 0
       message = 'Incorrect or not enough column import entries made.';
       return
   end
end

% ensure that channel import values have been entered sequentially
for i=1:channels_in_dropdown-2
   if col_entries(1,i+1) - col_entries(1, i) < 0
       message = 'Please enter the columns you want to import in ascending order.';
       return
   end
end


% default message code to return (no errors)
message = 0;