%% check_normalization_entries
% series of checks that ensures the user hasn't made any errors with
% assigning MVC or quiet lying trials to the wrong channels/using the wrong
% files.
%
% Inputs:
% color_values_MVC = 1x16 array containing the rgb color values for the
%                    backgrounds of each of the channels in the MVC 
%                    feedback window
% color_values_QL = 1x16 array containing the rgb color values for the
%                    backgrounds of each of the channels in the QL 
%                    feedback window
% number_of_channels = number of channels user has selected to process
% reference_color_MVC = rgb color value for the background of the current
%                       active MVC file directory
% reference_color_QL = rgb color value for the background of the current
%                      active QL file directory
% remove_QL_option = checkbox value indicating if the user has selected to
%                    remove quiet lying trials from data
%
% Output:
% message = error message (if error is thrown)
%%
function [message] = check_normalization_entries(color_values_MVC, color_values_QL, number_of_channels, reference_color_MVC, reference_color_QL, remove_QL_option)
        
% compare the associated color in the currently active directory to those
% that are in the channel selection window for QL and MVC files.
for i=1:number_of_channels-1
    test = reference_color_MVC - color_values_MVC{i};
    if test(1,1) ~= 0 || test(1,2) ~= 0 || test(1,3) ~= 0
        message = 'There is a mismatch between the directory you are getting your MVC files from and what you are using to normalize, check the channel selection feedback window.';
        return
    end
end
    
if remove_QL_option
    for i=1:number_of_channels-1
        test = reference_color_QL - color_values_QL{i};
        if test(1,1) ~= 0 || test(1,2) ~= 0 || test(1,3) ~= 0
            message = 'There is a mismatch between the directory you are getting your quiet lying files from and what you are using on your data files, check the channel selection feedback window.';
            return
        end
    end
end  
    
% default message code to return (no errors)
message = 0;    