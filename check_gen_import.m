%% check_gen_import
% series of checks that ensures the user hasn't entered anything
% incorrectly into the sample rate field, and has selected a value for
% channels to import.
% 
% Inputs:
% channels_in_dropdown = number of channels user has selected to process
% sample_rate = sample rate of the EMG data the user has entered
%
% Output:
% message = error message (if error is thrown)
%%
function [message] = check_gen_import(channels_in_dropdown, sample_rate)

% ensure user has specified number of channels to process
if channels_in_dropdown == 1    
    message = 'Please select the number of channels you want to process.';
    return
end

% ensure user has entered a valid integer value for the sample rate
if isnan(sample_rate) || mod(sample_rate, 1) ~=0 || sample_rate <= 0                                                 
    message = 'Please enter a valid sample rate for the data being imported.';
    return
end

% default message code to return (no errors)
message = 0;
