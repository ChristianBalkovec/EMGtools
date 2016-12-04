% EMG Tools: Process EMG Data Quickly
%
% Copyright: 2016 Christian Balkovec
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
% Version: 1.0
% - date 
% - initial release
%
%
function varargout = EMG_process(varargin)
% EMG_PROCESS MATLAB code for EMG_process.fig
%      EMG_PROCESS, by itself, creates a new EMG_PROCESS or raises the existing
%      singleton*.
%
%      H = EMG_PROCESS returns the handle to a new EMG_PROCESS or the handle to
%      the existing singleton*.
%
%      EMG_PROCESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EMG_PROCESS.M with the given input arguments.
%
%      EMG_PROCESS('Property','Value',...) creates a new EMG_PROCESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EMG_process_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EMG_process_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EMG_process

% Last Modified by GUIDE v2.5 20-Nov-2016 09:43:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EMG_process_OpeningFcn, ...
                   'gui_OutputFcn',  @EMG_process_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before EMG_process is made visible.
function EMG_process_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EMG_process (see VARARGIN)

% Choose default command line output for EMG_process
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EMG_process wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%Set the title of the window to the program name and current version
set(gcf, 'Name', 'EMG Tools: Version 1.0') 

% put these elements into an array for convenient access in other functions
channel_list = [handles.channel_1,...
                handles.channel_2,...
                handles.channel_3,...
                handles.channel_4,...
                handles.channel_5,...
                handles.channel_6,...
                handles.channel_7,...
                handles.channel_8,...
                handles.channel_9,...
                handles.channel_10,...
                handles.channel_11,...
                handles.channel_12,...
                handles.channel_13,...
                handles.channel_14,...
                handles.channel_15,...
                handles.channel_16];
            
channel_list_MVC = [handles.channel_1_MVC,...
                handles.channel_2_MVC,...
                handles.channel_3_MVC,...
                handles.channel_4_MVC,...
                handles.channel_5_MVC,...
                handles.channel_6_MVC,...
                handles.channel_7_MVC,...
                handles.channel_8_MVC,...
                handles.channel_9_MVC,...
                handles.channel_10_MVC,...
                handles.channel_11_MVC,...
                handles.channel_12_MVC,...
                handles.channel_13_MVC,...
                handles.channel_14_MVC,...
                handles.channel_15_MVC,...
                handles.channel_16_MVC];
            
channel_list_QL = [handles.channel_1_QL,...
                handles.channel_2_QL,...
                handles.channel_3_QL,...
                handles.channel_4_QL,...
                handles.channel_5_QL,...
                handles.channel_6_QL,...
                handles.channel_7_QL,...
                handles.channel_8_QL,...
                handles.channel_9_QL,...
                handles.channel_10_QL,...
                handles.channel_11_QL,...
                handles.channel_12_QL,...
                handles.channel_13_QL,...
                handles.channel_14_QL,...
                handles.channel_15_QL,...
                handles.channel_16_QL];

% put above arrays in the handles structure for use in other callbacks
handles.channel_list = channel_list;
handles.channel_list_MVC = channel_list_MVC;
handles.channel_list_QL = channel_list_QL;
guidata(hObject, handles)            

% set font sizes and remove visibility of feedback panel elements
for i=1:16
    set(channel_list_MVC(1,i), 'FontSize', 8)
    set(channel_list_QL(1,i), 'FontSize', 8)
    set(channel_list(1,i), 'Visible', 'off')
    set(channel_list_MVC(1,i), 'Visible', 'off')
    set(channel_list_QL(1,i), 'Visible', 'off')
end

% default quiet lying boxes disabled on startup
set(handles.import_QL, 'Enable', 'off');
set(handles.file_selector_QL, 'Enable', 'off');
set(handles.channel_numerical_values_list_QL, 'Enable', 'off');

% --- Outputs from this function are returned to the command line.
function varargout = EMG_process_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in channel_selector.
function channel_selector_Callback(~, ~, handles) %#ok<DEFNU>
% hObject    handle to channel_selector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

number_of_channels = get(handles.channel_selector, 'Value') - 1;
listbox_string = {'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16'};

% set the highlighted channel in the listboxes back to 1 (prevents a bug 
% that causes them to disappear). 
set(handles.channel_numerical_values_list_MVC, 'Value', 1);
set(handles.channel_numerical_values_list_QL, 'Value', 1);


% reset channel listboxes and elements in the feedback window when number
% of channels has been set to 0
if number_of_channels == 0
    set(handles.channel_numerical_values_list_MVC, 'String', '')
    set(handles.channel_numerical_values_list_QL, 'String', '')
    for i=1:16
        set(handles.channel_list(1,i), 'Visible', 'off')
        set(handles.channel_list_MVC(1,i), 'Visible', 'off')
        set(handles.channel_list_QL(1,i), 'Visible', 'off')
    end
end

% populate listboxes and make elements in the feedback window visible for
% the number of channels that have been selected by the user
for i=1:number_of_channels
    set(handles.channel_numerical_values_list_MVC, 'String', listbox_string(1:i))
    set(handles.channel_list(1,i), 'Visible', 'on');
    set(handles.channel_list_MVC(1,i), 'Visible', 'on');
    set(handles.channel_list(1, i+1:end), 'Visible','off');
    set(handles.channel_list_MVC(1, i+1:end), 'Visible','off');
    if get(handles.remove_QL,'Value')
        set(handles.channel_numerical_values_list_QL, 'String', listbox_string(1:i))
        set(handles.channel_list_QL(1,i), 'Visible', 'on');
        set(handles.channel_list_QL(1, i+1:end), 'Visible', 'off');
    end
end


% --- Executes on button press in remove_QL.
function remove_QL_Callback(~, ~, handles) %#ok<DEFNU>
% hObject    handle to remove_QL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

number_of_channels = get(handles.channel_selector,'Value') - 1;
listbox_string = {'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16'};
remove_QL_option = get(handles.remove_QL,'Value');

% populate quiet lying listbox with channel numbers and make feedback
% window elements visible 
if remove_QL_option
    for i=1:number_of_channels
        set(handles.channel_numerical_values_list_QL, 'String', listbox_string(1:i))
        set(handles.channel_list_QL(1,i), 'Visible', 'on');
        set(handles.channel_list_QL(1, i+1:end), 'Visible', 'off');
    end
    set(handles.import_QL, 'Enable', 'on');
    set(handles.file_selector_QL, 'Enable', 'on');
    set(handles.channel_numerical_values_list_QL, 'Enable', 'on');
    
% hide quiet lying listbox and feedback window elements if the option to
% remove quiet lying has been de-selected
elseif ~ remove_QL_option
    set(handles.channel_numerical_values_list_QL, 'String', '');
    set(handles.import_QL, 'Enable', 'off');
    set(handles.file_selector_QL, 'Enable', 'off');
    set(handles.channel_numerical_values_list_QL, 'Enable', 'off');
	set(handles.channel_list_QL(1, 1:end), 'Visible', 'off');
end


% --- Executes on selection change in file_selector_MVC.
function file_selector_MVC_Callback(~, ~, handles) %#ok<DEFNU>
% hObject    handle to file_selector_MVC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% get color value assigned to this directory on MVC file import
random_colour = handles.ran_colour;

MVC_file_names = get(handles.file_selector_MVC, 'String');  
MVC_file_values = get(handles.file_selector_MVC, 'Value');  
highlighted_channels = get(handles.channel_numerical_values_list_MVC, 'Value');    

% standardize file name variable into cell array if only one file imported
if ischar(MVC_file_names)
	MVC_file_names = {MVC_file_names};
end

% Set channels selected by the user in the MVC channel listbox to the 
% corresponding channel in the MVC feedback window. Add background color
% that corresponds with the current active directory for MVC files.
for i=1:size(highlighted_channels,2)
    set(handles.channel_list_MVC(1, highlighted_channels(1,i)), 'String', MVC_file_names{MVC_file_values})
    set(handles.channel_list_MVC(1, highlighted_channels(1,i)), 'BackgroundColor', random_colour);
end


% --- Executes on selection change in file_selector_QL.
function file_selector_QL_Callback(~, ~, handles) %#ok<DEFNU>
% hObject    handle to file_selector_QL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% get color value assigned to this directory on QL file import
random_colour = handles.QLran_colour;

QL_file_names = get(handles.file_selector_QL, 'String');
QL_file_values = get(handles.file_selector_QL, 'Value');
highlighted_channels = get(handles.channel_numerical_values_list_QL, 'Value');

% standardize file name variable into cell array if only one file imported
if ischar(QL_file_names)
	QL_file_names = {QL_file_names};
end

% Set channels selected by the user in the QL channel listbox to the 
% corresponding channel in the QL feedback window. Add background color
% that corresponds with the current active directory for QL files.
for i=1:size(highlighted_channels,2)
    set(handles.channel_list_QL(1, highlighted_channels(1,i)), 'String', QL_file_names{QL_file_values})
    set(handles.channel_list_QL(1, highlighted_channels(1,i)), 'BackgroundColor', random_colour);
end


% --- Executes on button press in import_MVC.
function import_MVC_Callback(hObject, ~, handles) %#ok<DEFNU>
% hObject    handle to import_MVC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile({'*.csv','CSV-files'}, 'Select the files', 'MultiSelect', 'on');    

% handle if the user has pressed the cancel button
path_check = char([filename pathname]);   
if path_check == 0
    return
end

% standardize the filename output if only one file was selected
if ischar(filename) 
    filename = {filename}; 
end
number_of_files = size(filename, 2); 

% return the highlighted dropdown value to the first one to prevent menu
% from disappearing
MVCFileValue = get(handles.file_selector_MVC, 'Value');
if number_of_files < MVCFileValue
    set(handles.file_selector_MVC, 'Value', 1);
end

% display selected path and populated the MVC file selection dropdown menu
set(handles.Directory_Label_MVC, 'String', pathname);
set(handles.file_selector_MVC, 'String', filename);

% create a random color to associate with the selected directory, set the 
% background of the directory display to that color, and store the value
% as a global variable to be used by other functions
ran_colour = rand(1,3); 
set(handles.Directory_Label_MVC, 'BackgroundColor', ran_colour);   
handles.ran_colour = ran_colour;

% set number of MVC files as a global variable for use in 'run' function
handles.number_MVC_files = number_of_files;
guidata(hObject, handles);


% --- Executes on button press in import_QL.
function import_QL_Callback(hObject, ~, handles) %#ok<DEFNU>
% hObject    handle to import_QL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile({'*.csv','CSV-files'}, 'Select the files', 'MultiSelect', 'on');    

% handle if the user has pressed the cancel button
path_check = char([filename pathname]);   
if path_check == 0
    return
end

% standardize the filename output if only one file was selected
if ischar(filename) 
    filename = {filename}; 
end
number_of_files = size(filename, 2); 

% return the highlighted dropdown value to the first one to prevent menu
% from disappearing
QLFileValue = get(handles.file_selector_QL, 'Value');
if number_of_files < QLFileValue
    set(handles.file_selector_QL, 'Value', 1);
end

% display selected path and populated the MVC file selection dropdown menu
set(handles.Directory_Label_QL, 'String', pathname);  
set(handles.file_selector_QL, 'String', filename);

% create a random color to associate with the selected directory, set the 
% background of the directory display to that color, and store the value
% as a global variable to be used by other functions
QLran_colour = rand(1,3);
set(handles.Directory_Label_QL, 'BackgroundColor', QLran_colour);  
handles.QLran_colour = QLran_colour; 

% set number of QL files as a global variable for use in 'run' function
handles.number_QL_files = number_of_files;
guidata(hObject, handles);




% --- Executes on button press in run.
function run_Callback(~, ~, handles) %#ok<DEFNU>
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Main processing function after the 'run' button is pressed
%% Declare variables

% declare variables:
normal_import_option = get(handles.normal_import, 'Value');
range_import_option = get(handles.range_import, 'Value');
column_import_option = get(handles.column_import, 'Value');

export_files_option = get(handles.file_export, 'Value');                     
export_downsampled_files_option = get(handles.downsample_export, 'Value');                         
plot_data_option = get(handles.plotter, 'Value');  
downsample_frequency = str2double(get(handles.downsample_freq, 'String'));   
sample_frequency = str2double(get(handles.sample_rate, 'String'));  

cutoff_low = str2double(get(handles.low_cutoff, 'String'));   
cutoff_high = str2double(get(handles.high_cutoff, 'String'));    
order = str2double(get(handles.order, 'String'));   
cutoff_LE = str2double(get(handles.linear_envelope, 'String'));  
filter_order_LE = str2double(get(handles.LE_order, 'String')); 
filter_option = get(handles.filter_selector, 'Value');

number_of_channels = get(handles.channel_selector, 'Value');
reference_color_MVC = get(handles.Directory_Label_MVC, 'BackgroundColor');
reference_color_QL = get(handles.Directory_Label_QL, 'BackgroundColor');

color_values_MVC = {get(handles.channel_1_MVC, 'BackgroundColor'),...
             get(handles.channel_2_MVC, 'BackgroundColor'),...
             get(handles.channel_3_MVC, 'BackgroundColor'),...
             get(handles.channel_4_MVC, 'BackgroundColor'),...
             get(handles.channel_5_MVC, 'BackgroundColor'),...
             get(handles.channel_6_MVC, 'BackgroundColor'),...
             get(handles.channel_7_MVC, 'BackgroundColor'),...
             get(handles.channel_8_MVC, 'BackgroundColor'),...
             get(handles.channel_9_MVC, 'BackgroundColor'),...
             get(handles.channel_10_MVC, 'BackgroundColor'),...
             get(handles.channel_11_MVC, 'BackgroundColor'),...
             get(handles.channel_12_MVC, 'BackgroundColor'),...
             get(handles.channel_13_MVC, 'BackgroundColor'),...
             get(handles.channel_14_MVC, 'BackgroundColor'),...
             get(handles.channel_15_MVC, 'BackgroundColor'),...
             get(handles.channel_16_MVC, 'BackgroundColor')...
             };

color_values_QL = {get(handles.channel_1_QL, 'BackgroundColor'),...
             get(handles.channel_2_QL, 'BackgroundColor'),...
             get(handles.channel_3_QL, 'BackgroundColor'),...
             get(handles.channel_4_QL, 'BackgroundColor'),...
             get(handles.channel_5_QL, 'BackgroundColor'),...
             get(handles.channel_6_QL, 'BackgroundColor'),...
             get(handles.channel_7_QL, 'BackgroundColor'),...
             get(handles.channel_8_QL, 'BackgroundColor'),...
             get(handles.channel_9_QL, 'BackgroundColor'),...
             get(handles.channel_10_QL, 'BackgroundColor'),...
             get(handles.channel_11_QL, 'BackgroundColor'),...
             get(handles.channel_12_QL, 'BackgroundColor'),...
             get(handles.channel_13_QL, 'BackgroundColor'),...
             get(handles.channel_14_QL, 'BackgroundColor'),...
             get(handles.channel_15_QL, 'BackgroundColor'),...
             get(handles.channel_16_QL, 'BackgroundColor')...
             };

filenames_MVC_trials = get(handles.file_selector_MVC,'String');
filenames_QL_trials = get(handles.file_selector_QL,'String');
remove_QL_option = get(handles.remove_QL,'Value');
         

%% Run checks on GUI field entries

% general import parameters checks
message = check_gen_import(number_of_channels, sample_frequency);
if message ~= 0
   h = errordlg(message, 'General Import Parameters Error');
   uiwait(h)
   return
end

% import option checks
if normal_import_option

    row = str2double(get(handles.row,'String'));
    column = str2double(get(handles.column,'String'));
    
    message = check_normal_import(row, column);
    if message ~= 0
       h = errordlg(message, 'Standard Import Option Error');
       uiwait(h)
       return
    end
    
elseif range_import_option
    
    row = str2double(get(handles.range_row1,'String'));
    row2 = str2double(get(handles.range_row2,'String'));
    column = str2double(get(handles.range_column1,'String'));
    final_column = str2double(get(handles.range_column2,'String'));
    
    message = check_range_import(row, row2, column, final_column, number_of_channels);                                
    if message ~= 0
       h = errordlg(message, 'Range Import Option Error');
       uiwait(h)
       return
    end
    
elseif column_import_option
    
   	row = str2double(get(handles.sep_row,'String'));   

    column_list = [str2double(get(handles.sep_column1,'String')),...
                   str2double(get(handles.sep_column2,'String')),...
                   str2double(get(handles.sep_column3,'String')),...
                   str2double(get(handles.sep_column4,'String')),...
                   str2double(get(handles.sep_column5,'String'))];
               
    message = check_column_import(row, column_list, number_of_channels);
    if message ~= 0
       h = errordlg(message, 'Column Import Option Error');
       uiwait(h)
       return
    end
    
else
    
    h = errordlg('Please select an import option before trying to import files.', 'No Import Option Selected');
    uiwait(h)
    return
    
end

% MVC and quiet lying data import checks
message = check_MVC_QL_import_status(filenames_MVC_trials, filenames_QL_trials, remove_QL_option);
if message ~= 0
   h = errordlg(message, 'MVC/QL Import Error');
   uiwait(h)
   return
end

% filter option checks
message = check_filters(cutoff_low, cutoff_high, order, cutoff_LE, filter_order_LE, filter_option);
if message ~= 0
   h = errordlg(message, 'Filter Parameter Error');
   uiwait(h)
   return
end

% export option checks
message = check_export(export_files_option, export_downsampled_files_option, plot_data_option, downsample_frequency, sample_frequency);
if message ~= 0
   h = errordlg(message, 'Export Option Error');
   uiwait(h)
   return
end

% normalization entry checks
message = check_normalization_entries(color_values_MVC, color_values_QL, number_of_channels, reference_color_MVC, reference_color_QL, remove_QL_option);
if message ~= 0
   h = errordlg(message, 'Normalization Entry Error');
   uiwait(h)
   return
end

%% Bring in file and directory names for data files

[filename, pathname] = uigetfile({'*.csv','CSV-files'}, 'Select the files', 'MultiSelect', 'on');    

% handle if the user has pressed the cancel button
path_check = char([filename pathname]);   
if path_check == 0
    return
end

% standardize the filename output if only one file was selected
if ischar(filename) 
    filename = {filename}; 
end

% prep variables after checks for use in processing steps and bring in
% additional variables
number_of_channels = number_of_channels - 1; 
number_of_files = size(filename, 2); 

number_of_MVC_files = handles.number_MVC_files;  
folder_path_MVC_files = get(handles.Directory_Label_MVC,'String');   

if remove_QL_option 
    folder_path_QL_files = get(handles.Directory_Label_QL,'String');  
    number_of_QL_files = handles.number_QL_files;
end

%% Pre-allocate processing variables 

imported_data_block = cell(number_of_files, 1);
data = cell(number_of_files, 1);

imported_data_block_MVC = cell(number_of_MVC_files, 1);
MVC_data = cell(number_of_MVC_files, 1);

data_length = cell(number_of_files, 1);
data_length_MVC = cell(number_of_MVC_files, 1);

MVC_data_filt = cell(number_of_MVC_files, 1);
data_filt = cell(number_of_files, 1);

reversed_data = cell(number_of_files, 1);
first_half_data = cell(number_of_files, 1);
last_half_data = cell(number_of_files, 1);
front_padding_points = cell(number_of_files, 1);
end_padding_points = cell(number_of_files, 1);
padding = cell(number_of_files, 1);
data_padded = cell(number_of_files, 1);

data_LE = cell(number_of_files, 1);
MVC_LE = cell(number_of_MVC_files, 1);

MVC_max = cell(number_of_MVC_files, 1);
data_normalized = cell(number_of_files, 1);

data_downsampled = cell(number_of_files,1);    

if remove_QL_option
    imported_data_block_QL = cell(number_of_QL_files, 1);
    QL_data = cell(number_of_QL_files, 1);
    data_length_QL = cell(number_of_QL_files, 1);
    
    QL_data_filt = cell(number_of_QL_files, 1);

    QL_data_avg = cell(number_of_QL_files, 1);

    data_bias_removed = cell(number_of_files, 1);
    MVC_bias_removed = cell(number_of_MVC_files, 1);    
end

%% Data Import

% Import entire contents of csv files first
for i=1:number_of_files
    
    % bring in entire csv file the user has chosen
    [imported_data_block{i}, data_length{i}] = import_data(pathname, filename{i});
end

for i=1:number_of_MVC_files
    
    % bring in entire csv file the user has chosen for MVCs
    [imported_data_block_MVC{i}, data_length_MVC{i}] = import_data(folder_path_MVC_files, filenames_MVC_trials{i});
end

if remove_QL_option
    for i=1:number_of_QL_files
   
        % bring in entire csv file the user has chosen for quiet lying
        [imported_data_block_QL{i}, data_length_QL{i}] = import_data(folder_path_QL_files, filenames_QL_trials{i});
    end
end


% Create format strings for data import
% Normal & Range import
if normal_import_option || range_import_option
    
    format_string = create_format_string(column, number_of_channels);

% Column import 
elseif column_import_option

    format_string = create_format_string_column_import(column_list, number_of_channels);
end


% Trim data to regions for processing
if range_import_option
	for i=1:number_of_files
        if data_length{i} < row2
            h = errordlg('The data range you have specified is larger than the actual data file.', 'File Import Error');
            uiwait(h)
            return
        end
        
        [data{i}, message] = trim_data(imported_data_block{i}, row, row2, number_of_channels, format_string, filename{i});
        if message ~= 0
            h = errordlg(message, 'File Import Error');
            uiwait(h)
            return
        end 
	end
    
else
    for i=1:number_of_files
        [data{i}, message] = trim_data(imported_data_block{i}, row, data_length{i}, number_of_channels, format_string, filename{i});
        if message ~= 0
            h = errordlg(message, 'File Import Error');
            uiwait(h)
            return
        end 
    end
end
    
for i=1:number_of_MVC_files
        
    [MVC_data{i}, message] = trim_data(imported_data_block_MVC{i}, row, data_length_MVC{i}, number_of_channels, format_string, filenames_MVC_trials{i});
    if message ~= 0
        h = errordlg(message, 'MVC File Import Error');
        uiwait(h)
        return
    end 

end

if remove_QL_option
    for i=1:number_of_QL_files
        [QL_data{i}, message] = trim_data(imported_data_block_QL{i}, row, data_length_QL{i}, number_of_channels, format_string, filenames_QL_trials{i});
        if message ~= 0
            h = errordlg(message, 'Quiet Lying File Import Error');
            uiwait(h)
            return
        end 
    end
end


%% MVC & Quiet Lying Data Filtering

% set up filter parameters
if filter_option == 2
    [B, A] = butter(order, [cutoff_low,cutoff_high]/(sample_frequency/2), 'bandpass'); 
elseif filter_option == 3
    [B, A] = butter(order, cutoff_high/(sample_frequency/2), 'low');    
end

% filter MVC data
for i=1:number_of_MVC_files
    MVC_data_filt{i} = filtfilt(B, A, MVC_data{i});
end

% filter quiet lying data
if remove_QL_option  
    for i=1:number_of_QL_files           
        QL_data_filt{i} = filtfilt(B, A, QL_data{i});    
    end     
end
%% Data Padding and Filtering

% pad data using invert method and filter it
% reverses the data array, divides it in two, then inverts it
for i=1:number_of_files
    
    % find length of half the data array, use 'round' to ensure that
    % value obtained is an integer
    padding{i} = round(length(data{i}) / 2); 
         
    % reverse the data array (front to end, end to front)
	reversed_data{i}  = flip(data{i}, 1);  
        
	% divide reversed array into halves
	first_half_data{i} = reversed_data{i}(padding{i}:end,:); 
	last_half_data{i} = reversed_data{i}(1:padding{i},:);
        
	% subtract value that will border start and end of data array from
	% all of the front and end padding points respectively. Inverts
	% each padding array and ensures no artificial noise is generated
	% when padding points are added to the front and end of the data
    for r=1:number_of_channels
        front_padding_points{i}(:,r) = first_half_data{i}(end,r) - first_half_data{i}(:,r);
        end_padding_points{i}(:,r) = last_half_data{i}(1,r) - last_half_data{i}(:,r);
    end
        
	% add padding points to the front and end of the data array
	data_padded{i}  = [front_padding_points{i}; data{i}; end_padding_points{i}];  

	% filter data array
	data_filt{i} = filtfilt(B, A, data_padded{i}); 
end

%% Full Wave Rectify
    
if remove_QL_option

    % calculate average of every channel of every quiet lying file
    % to determine DC bias to remove
	for i=1:number_of_QL_files      
        QL_data_avg{i} = mean(QL_data_filt{i});
	end

    % remove quiet lying DC bias from data files
    for i=1:number_of_QL_files       
        for r=1:number_of_channels 
            
            % compare strings in QL dropdown menu to those in channel
            % feedback window to find a match
            if strcmp(char(filenames_QL_trials(i,:)), get(handles.channel_list_QL(1,r), 'String'))
               
                % remove the zero bias from the given channel of the data files (eg. channel 1 from quiet lying file is subtracted from channel 1 of all data files)
                for p=1:number_of_files
                    data_bias_removed{p}(:,r) = (data_filt{p}(:,r)) - QL_data_avg{i}(:,r);   
                end
                % remove the zero bias from the given channel of the MVC files (eg. channel 1 from quiet lying file is subtracted from channel 1 of all MVC files)
                for j=1:number_of_MVC_files
                    MVC_bias_removed{j}(:,r) = (MVC_data_filt{j}(:,r) - QL_data_avg{i}(:,r));
                end
            end
        end
    end

	[data_FWR] = full_wave_rectify(data_bias_removed, number_of_files);
    [MVC_FWR] = full_wave_rectify(MVC_bias_removed, number_of_MVC_files);
     
else    
    [data_FWR] = full_wave_rectify(data_filt, number_of_files);
    [MVC_FWR] = full_wave_rectify(MVC_data_filt, number_of_MVC_files);
end

%% Linear Envelope

% set up filter for linear envelope   
[D, E] = butter(filter_order_LE, cutoff_LE/(sample_frequency/2), 'low');   % get filter coefficients

% linear envelope the data using single pass 'filter' function
for i=1:number_of_files
	data_LE{i} = filter(D, E, data_FWR{i}); 
	data_LE{i} = data_LE{i}(padding{i}:end-padding{i},:);  %remove padding points 
end
% linear envelope MVC data
for i=1:number_of_MVC_files
	MVC_LE{i} = filter(D, E, MVC_FWR{i});   
end

% find the max value in the linear enveloped MVC data to be used for data
% normalization
for i=1:number_of_MVC_files    
	MVC_max{i} = max(MVC_LE{i});  
end

%% Data Normalization

for i=1:number_of_MVC_files  
    for r=1:number_of_channels
        for p=1:number_of_files
            % compare strings in MVC dropdown menu to those in channel
            % feedback window to find a match
            if strcmp(char(filenames_MVC_trials (i,:)), get(handles.channel_list_MVC(1,r), 'String')) 
                % normalize the channel in each data file to the channel from the corresponding MVC file that was selected
                data_normalized{p}(:,r) = ((data_LE{p}(:,r)) / (MVC_max{i}(:,r))) * 100;   
            end
        end
    end
end

%% File Export

% handle writing data/downsampled data to csv files
if export_files_option || export_downsampled_files_option
    directory = uigetdir(pathname,'Please select a directory to save the files to');
    
    % write data to csv files
    if export_files_option
        write_files(directory, number_of_files, '\Processed_', filename, data_normalized)
    end
    
    % handle downsampling of data and writing to csv files
    if export_downsampled_files_option

        rows_to_skip = sample_frequency/downsample_frequency;   %determine how many rows to skip when downsampling
        for i=1:number_of_files 
            % downsample_export the data
            data_downsampled{i} = downsample(data_normalized{i}, rows_to_skip);
        end
        
        % write downsampled data to csv files
        write_files(directory, number_of_files, '\DS_Processed_', filename, data_downsampled)
    end
    
end

% generate plots of processed data
if plot_data_option
    
    % pre-allocating for speed
    fig = zeros(number_of_files,1);    
    time = cell(number_of_files,1);
    
    for i=1:number_of_files    
        fig(i) = figure();
        set(fig(i), 'Tag', 'graphs');   
        set(fig(i), 'Color', [1 1 1]); 
        time{i} = (0:length(data_normalized{i})-1) / sample_frequency;  
        plot(time{i}, data_normalized{i});
        xlabel('Time (s)')   
        ylabel('Muscle Activation (%MVC)')  
        legend toggle  
    end
end

msgbox('Done!')


% --- Executes on button press in normal_import.
function normal_import_Callback(~, ~, handles) %#ok<DEFNU>
% hObject    handle to normal_import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% enables or disables elements of the GUI if the normal import option has
% been selected/de-selected
if get(handles.normal_import, 'Value')
    set(handles.range_import, 'Enable', 'off');
    set(handles.range_row1, 'Enable', 'off');
    set(handles.range_row2, 'Enable', 'off');
    set(handles.range_column1, 'Enable', 'off');
    set(handles.range_column2, 'Enable', 'off');
    set(handles.column_import, 'Enable', 'off');
    set(handles.sep_row, 'Enable', 'off');
    set(handles.sep_column1, 'Enable', 'off');
    set(handles.sep_column2, 'Enable', 'off');
    set(handles.sep_column3, 'Enable', 'off');
    set(handles.sep_column4, 'Enable', 'off');
    set(handles.sep_column5, 'Enable', 'off');
elseif ~ get(handles.normal_import, 'Value')
    set(handles.range_import, 'Enable', 'on');
    set(handles.range_row1, 'Enable', 'on');
    set(handles.range_row2, 'Enable', 'on');
    set(handles.range_column1, 'Enable', 'on');
    set(handles.range_column2, 'Enable', 'on');
    set(handles.column_import, 'Enable', 'on');
    set(handles.sep_row, 'Enable', 'on');
    set(handles.sep_column1, 'Enable', 'on');
    set(handles.sep_column2, 'Enable', 'on');
    set(handles.sep_column3, 'Enable', 'on');
    set(handles.sep_column4, 'Enable', 'on');
    set(handles.sep_column5, 'Enable', 'on');
end


% --- Executes on button press in range_import.
function range_import_Callback(~, ~, handles) %#ok<DEFNU>
% hObject    handle to range_import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% enables or disables elements of the GUI if the range import option has
% been selected/de-selected
if get(handles.range_import, 'Value')
    msgbox('Are you sure that you want to use this import method? Read the manual on this subject and ensure that you are aware of common mistakes made before using this.')
    set(handles.normal_import, 'Enable', 'off');
    set(handles.row, 'Enable', 'off');
    set(handles.column, 'Enable', 'off');
    set(handles.column_import, 'Enable', 'off');
    set(handles.sep_row, 'Enable', 'off');
    set(handles.sep_column1, 'Enable', 'off');
    set(handles.sep_column2, 'Enable', 'off');
    set(handles.sep_column3, 'Enable', 'off');
    set(handles.sep_column4, 'Enable', 'off');
    set(handles.sep_column5, 'Enable', 'off');
elseif ~ get(handles.range_import,'Value')
    set(handles.normal_import, 'Enable', 'on');
    set(handles.row, 'Enable', 'on');
    set(handles.column, 'Enable', 'on');
    set(handles.column_import, 'Enable', 'on');
    set(handles.sep_row, 'Enable', 'on');
    set(handles.sep_column1, 'Enable', 'on');
    set(handles.sep_column2, 'Enable', 'on');
    set(handles.sep_column3, 'Enable', 'on');
    set(handles.sep_column4, 'Enable', 'on');
    set(handles.sep_column5, 'Enable', 'on');
end


% --- Executes on button press in column_import.
function column_import_Callback(~, ~, handles) %#ok<DEFNU>
% hObject    handle to column_import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% enables or disables elements of the GUI if the separate column import 
% option has been selected/de-selected
if get(handles.column_import, 'Value')
    set(handles.normal_import, 'Enable', 'off');
    set(handles.row, 'Enable', 'off');
    set(handles.column, 'Enable', 'off');
    set(handles.range_import, 'Enable', 'off');
    set(handles.range_row1, 'Enable', 'off');
    set(handles.range_row2, 'Enable', 'off');
    set(handles.range_column1, 'Enable', 'off');
    set(handles.range_column2, 'Enable', 'off');
elseif ~ get(handles.column_import, 'Value')
    set(handles.normal_import, 'Enable', 'on');
    set(handles.row, 'Enable', 'on');
    set(handles.column, 'Enable', 'on');
    set(handles.range_import, 'Enable','on');
    set(handles.range_row1, 'Enable', 'on');
    set(handles.range_row2, 'Enable', 'on');
    set(handles.range_column1, 'Enable', 'on');
    set(handles.range_column2, 'Enable', 'on');
end


% --- Executes on selection change in filter_selector.
function filter_selector_Callback(~, ~, handles) %#ok<DEFNU>
% hObject    handle to filter_selector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if get(handles.filter_selector, 'Value') == 3
    set(handles.low_cutoff, 'Enable', 'off');
elseif get(handles.filter_selector, 'Value') ~=3
    set(handles.low_cutoff, 'Enable', 'on');
end


% --- Executes on button press in reset_all.
function reset_all_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to reset_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%closes program and re-opens it if reset button is hit
close(EMG_process);
EMG_process;


% --- Executes on button press in clr_figs.
function clr_figs_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to clr_figs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% delete figures generated by the application
to_close = findobj(get(0, 'Children'), 'flat', 'Tag', 'graphs');   % finds all objects with the tag 'graphs'
delete(to_close)  % deletes those objects


% --- Executes on selection change in channel_numerical_values_list_MVC.
function channel_numerical_values_list_MVC_Callback(~, ~, handles) %#ok<DEFNU>
% hObject    handle to channel_numerical_values_list_MVC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% allow for multiple channel selection in channel selection listbox
set(handles.channel_numerical_values_list_MVC, 'Max', 2); 


% --- Executes on selection change in channel_numerical_values_list_QL.
function channel_numerical_values_list_QL_Callback(~, ~, handles) %#ok<DEFNU>
% hObject    handle to channel_numerical_values_list_QL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% allow for multiple channel selection in channel selection listbox
set(handles.channel_numerical_values_list_QL, 'Max', 2); 







%% Empty Functions Below
function range_column1_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to range_column1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function range_column1_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to range_column1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function range_row1_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to range_row1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function range_row1_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to range_row1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function range_column2_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to range_column2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function range_column2_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to range_column2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function range_row2_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to range_row2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function range_row2_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to range_row2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sep_row_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to sep_row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function sep_row_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to sep_row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sep_column1_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to sep_column1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function sep_column1_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to sep_column1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sep_column2_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to sep_column2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function sep_column2_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to sep_column2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sep_column3_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to sep_column3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function sep_column3_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to sep_column3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sep_column4_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to sep_column4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function sep_column4_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to sep_column4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sep_column5_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to sep_column5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function sep_column5_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to sep_column5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function MVC_column_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to MVC_column (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function MVC_column_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to MVC_column (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function MVC_row_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to MVC_row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function MVC_row_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to MVC_row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function row_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function row_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to row (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function column_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to column (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function column_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to column (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function file_selector_MVC_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to file_selector_MVC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function channel_numerical_values_list_MVC_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to channel_numerical_values_list_MVC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function channel_selector_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to channel_selector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function filter_selector_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to filter_selector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function low_cutoff_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to low_cutoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function low_cutoff_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to low_cutoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function high_cutoff_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to high_cutoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function high_cutoff_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to high_cutoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function channel_numerical_values_list_QL_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to channel_numerical_values_list_QL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function file_selector_QL_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to file_selector_QL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in downsample_export.
function downsample_export_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to downsample_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in plotter.
function plotter_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to plotter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in file_export.
function file_export_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to file_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function sample_rate_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function sample_rate_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function linear_envelope_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to linear_envelope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function linear_envelope_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to linear_envelope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function order_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function order_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function LE_order_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to LE_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function LE_order_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to LE_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function downsample_freq_Callback(~, ~, ~) %#ok<DEFNU>
% hObject    handle to downsample_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function downsample_freq_CreateFcn(hObject, ~, ~) %#ok<DEFNU>
% hObject    handle to downsample_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
