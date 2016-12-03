%% check_export
% series of checks that ensures the user has selected at least one option
% from the export menu and that values entered for downsample frequency are
% valid.
%
% Inputs:
% export_option1 = export file option checkbox
% export_option2 = export downsampled files option checkbox
% export_option3 = plot graphs of processed data option checkbox
% downsample_frequency = desired frequency of downsampled data
% sample_rate = sample rate of the EMG data the user has entered
%
% Output:
% message = error message (if error is thrown)
%%
function [message] = check_export(export_option1, export_option2, export_option3, downsample_frequency, sample_rate)

% ensure at least one export option has been selected
if export_option1 + export_option2 + export_option3 == 0   
    message = 'Please select at least one output option under STEP 4.';
    return
end

% ensure numerical value entered into downsample frequency field and
% downsample frequency not greater than original sample rate.
if export_option2
    if isnan(downsample_frequency) || mod(downsample_frequency, 1) ~= 0 || downsample_frequency <= 0 || downsample_frequency >= sample_rate
        message = 'You have chosen to downsample data but have not specified an appropriate downsampling frequency.';
        return
    end
end

% default message code to return (no errors)
message = 0;
