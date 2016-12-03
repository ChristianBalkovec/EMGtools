%% check_filters
% series of checks that ensures the user hasn't entered anything
% incorrectly in the filter option fields.
%
% Inputs:
% filter_entry1 = low cutoff frequency for filter
% filter_entry2 = high cutoff frequency for filter
% filter_entry3 = filter order
% filter_entry4 = linear envelope cutoff frequency
% filter_entry5 = linear envelop filter order
% filter_option = bandpass or butterworth filter options
%
% Output:
% message = error message (if error is thrown)
%%
function [message] = check_filters(filter_entry1, filter_entry2, filter_entry3, filter_entry4, filter_entry5, filter_option)

% ensure the user has selected a filter option
if filter_option == 1                 
    message = 'Please select a filter.';
    return;
end

% ensure only numerical values for filter data fields
% bandpass filter option
if filter_option == 2  
     if isnan(filter_entry1) || isnan(filter_entry2) || isnan(filter_entry3) || isnan(filter_entry4) || isnan(filter_entry5) ||...   
        mod(filter_entry3, 1) ~= 0 || mod(filter_entry5, 1) ~= 0 ||... 
        filter_entry1 <= 0 || filter_entry2 <= 0 || filter_entry3 <= 0 || filter_entry4 <= 0 || filter_entry5 <= 0   
         message = 'One or more of your filter parameters is not entered, or is entered incorrectly.';
         return;
     end

% butterworth filter option
elseif filter_option == 3                             
     if isnan(filter_entry2) || isnan(filter_entry3) || isnan(filter_entry4) || isnan(filter_entry5) ||...   
        mod(filter_entry3, 1) ~= 0 || mod(filter_entry5, 1) ~= 0 ||... 
        filter_entry2 <= 0 || filter_entry3 <= 0 || filter_entry4 <= 0 || filter_entry5 <= 0   
         message = 'One or more of your filter parameters is not entered, or is entered incorrectly.';
         return;
     end
end

% default message code to return (no errors)
message = 0;
