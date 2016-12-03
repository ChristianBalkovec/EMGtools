%% write_files
% writes files to csv
%
% Inputs:
% directory = user-selected directory
% number_of_files = number of files to write
% prefix = prefix that will be used for each filename
% filenames = list of original non-processed filenames (prefix attached to these)
%%
function write_files(directory, number_of_files, prefix, filenames, data)

% create a filename and write a csv file to the chosen directory
for i=1:number_of_files  
    filename_to_write = strcat(prefix, filenames{i});   
    csvwrite([directory filename_to_write], data{i});   
end