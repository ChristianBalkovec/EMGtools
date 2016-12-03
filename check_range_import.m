%% check_range_import
% series of checks that ensures no incorrect values entered into range
% import option fields.
%
% Inputs:
% range_import_row1 = row user has selected to start importing data from
% range_import_row2 = row user has selected to stop importing data from
% range_import_column1 = column user has selected to start importing data from
% range_import_column2 = column user has selected to stop importing data from
% channels_in_dropdown = number of channels user has selected to process
%
% Output:
% message = error message (if error is thrown)
%%
function [message] = check_range_import(row1, row2, column1, column2, channels_in_dropdown)

channels_in_dropdown = channels_in_dropdown - 1;

% ensure only positive integer values are entered into range import boxes
if isnan(row1) || mod(row1, 1) ~= 0 || row1 <= 0 ||...
   isnan(row2) || mod(row2, 1) ~= 0 || row2 <= 0 ||...
   isnan(column1) || mod(column1, 1) ~= 0 || column1 <= 0 ||...
   isnan(column2) || mod(column2, 1) ~= 0 || column2 <= 0
    message = 'Please select a range of rows and columns to start importing from and ensure that your entries contain only integers.';
    return
end

% ensure that range of rows specified is a positive numerical range
if row2 - row1 <= 0                                         
    message = 'The row range you have entered is not valid, check to make sure that the values are ascending.';
    return
end
% ensure that range of columns specified is a positive numerical range
if column2 - column1 < 0
    message = 'The column range you have entered is not valid, check to make sure that the values are ascending.';
    return
end

channels_in_range = (column2 - column1) + 1;                          
% ensure channels specified in range corresponds to channels from dropdown 
if channels_in_dropdown - channels_in_range ~= 0                                                   
    message = 'The number of channels that you have selected to import via the range import method does not correspond to the number of channels you have selected with the dropdown menu.';
    return
end

% default message code to return (no errors)
message = 0;
