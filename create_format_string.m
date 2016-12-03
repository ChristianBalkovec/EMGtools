%% create_format_string
% produces a string that indicates the format desired data to import is in
% for the data file.
%
% Inputs:
% column = user-specified column for start of data range
% number_of_channels = number of channels selected to process
%
% Output:
% format_string = desired string that will allow data to be imported from
%                 file properly
%%
function [format_string] = create_format_string(column, number_of_channels)

% number of columns to skip at the start of each row
skip_cols = repmat('%*s ', 1, column-1);

% range of columns for each row of the data file that desired data is in
data_cols = repmat('%f', 1, number_of_channels);

% put skipped columns and desired columns together, ignore everything after
format_string = strcat([skip_cols, data_cols, '%*[^\n]']);