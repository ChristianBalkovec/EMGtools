%% create_format_string_column_import
% produces a string for the column import option that indicates the format 
% desired data to import is in for the data file.
%
% Inputs:
% column = user-specified column for start of data range
% number_of_channels = number of channels selected to process
%
% Output:
% format_string = desired string that will allow data to be imported from
%                 file properly
%%
function [format_string] = create_format_string_column_import(column_list, number_of_channels)

% pre-allocate for speed
skip_cols = cell(number_of_channels,1);

% initial number of columns to skip at start of row
skip_cols{1} = repmat('%*s ', 1, column_list(1,1)-1);

% initial format string including first column to actually import
format_string = strcat([skip_cols{1}, '%f']);

% iteratively determine how many columns to skip for each row based on 
% which columns are being imported for processing
for i = 1:number_of_channels-1
    skip_cols{i+1} = repmat('%*s ', 1, (column_list(1,i+1) - column_list(1,i) - 1));
end

% iteratively add to skipped columns and desired columns to format string
for i = 1:number_of_channels - 1
    format_string = strcat([format_string, skip_cols{i+1}, '%f']);
end

% finally ignore all other fields after last column imported
format_string = strcat([format_string, '%*[^\n]']);
