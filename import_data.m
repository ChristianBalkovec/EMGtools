%% import_data
% imports data for the normal and range import options
%
% Inputs:
% pathname = directory the files being imported are in
% filename = list of the filenames that are being imported
%
% Outputs:
% imported_data = data matrix containing the given range the user has
%                 specified to import
% data_length = length of imported data block
%%
function [text, data_length] = import_data(pathname, filename)

file_id = fopen(strcat(pathname, filename));  
all_text = textscan(file_id,'%s','delimiter','\n');   % read each line of file
data_length = size(all_text{1}, 1) - 1;  % determine length of data file
fclose(file_id);

% return cell array of everything contained in data file
text = all_text{1};
