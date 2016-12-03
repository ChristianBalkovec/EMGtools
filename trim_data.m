%% trim_data
% convert imported data block into desired data matrix for processing
%
% Inputs:
% imported_data_block = cell block of imported data 
% row = user-specified row for start of data range
% data_length = length of data or user-specified row for end of data range
% number_of_channels = number of channels selected to process
% format_string = string the specifies the format of the desired data to be
%                 imported from the data block.
% filename = filename of the data currently being trimmed
%
% Outputs:
% trimmed_data = reduced m by n cell of data based on user-specified range
% message = error message (if error is thrown)
%%
function [trimmed_data, message] = trim_data(imported_data_block, row, data_length, number_of_channels, format_string, filename)

% pre-allocate for speed
trimmed = cell(data_length-row+1, number_of_channels);

for i=1:data_length-row+1
    % divide imported data block using comma delimiter, region to import
    % specified by format string
    trimmed(i,:) = (textscan(imported_data_block{i+row-1}, format_string, 'delimiter', ','));
end

try
    % convert cell array to matrix
    trimmed_data = cell2mat(trimmed);
catch
    message = strcat(['There was an error importing ', filename, '. Please ensure the region you are attempting to import contains only numerical values']);
    trimmed_data = 0;
    return
end

% check for NaN values
if any(isnan(trimmed_data(:)))
   message = strcat(['The region you are trying to import in ', filename, ' contains non-numeric values. Check your import range.']); 
   trimmed_data = 0;
   return
end

% default message (no errors)
message = 0;