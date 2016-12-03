%% check_normal_import
% series of checks that ensures no incorrect values entered into normal
% import option fields.
%
% Inputs:
% row = row user has entered to start importing data from                         
% column = column user has entered to start importing data from
%
% Output:
% message = error message (if error is thrown)
%%
function [message] = check_normal_import(row, column)

if isnan(row) || mod(row, 1) ~= 0 || row <= 0                              
    message = 'Please select a row to start importing from and ensure that your entry is an integer value.';
    return
end
if isnan(column) || mod(column, 1) ~= 0 || column <= 0   
   message = 'Please select a column to start importing from and ensure that your entry is an integer value.';
   return
end

% default message code to return (no errors)
message = 0;
