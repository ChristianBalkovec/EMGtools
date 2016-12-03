%% full_wave_rectify
% returns the absolute value of input data
%
% Inputs:
% data = data to be rectified
% number_of_files = number of data files there are
%
% Output:
% rectified_data = absolute value of data (full wave rectified)
%%
function [rectified_data] = full_wave_rectify(data, number_of_files)

% pre-allocating for speed
rectified_data = cell(number_of_files, 1);

% take absolute value of all matrix elements for every file
for i=1:number_of_files
	rectified_data{i}= abs(data{i}); 
end