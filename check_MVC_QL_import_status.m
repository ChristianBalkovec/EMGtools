%% check_MVC_QL_import_status
% series of checks that ensures the user has imported their MVC and
% quiet lying files before moving on.
%
% Inputs:
% MVC_file_dropdown_menu = files in the MVC file dropdown menu of GUI
% QL_file_dropdown_menu = files in the quiet lying dropdown menu of GUI
% remove_QL_option = checkbox value for selecting to remove quiet lying
% 
% Output:
% message = error message (if error is thrown)
%%
function [message] = check_MVC_QL_import_status(MVC_file_dropdown_menu, QL_file_dropdown_menu, remove_QL_option)

% ensure user has imported MVC files
if isempty(MVC_file_dropdown_menu) 
    message = 'Please import MVC files.';
    return
end

% ensure user has imported quiet lying files (if checkbox selected)
if remove_QL_option                                     
	if isempty(QL_file_dropdown_menu)       
        message = 'Please import quiet lying trials or de-select the option to remove quiet lying from your data.';
        return
	end   
end

% default message code to return (no errors)
message = 0;
