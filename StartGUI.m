function varargout = StartGUI(varargin)
% STARTGUI MATLAB code for StartGUI.fig
%      STARTGUI, by itself, creates a new STARTGUI or raises the existing
%      singleton*.
%
%      H = STARTGUI returns the handle to a new STARTGUI or the handle to
%      the existing singleton*.
%
%      STARTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STARTGUI.M with the given input arguments.
%
%      STARTGUI('Property','Value',...) creates a new STARTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before StartGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to StartGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help StartGUI

% Last Modified by GUIDE v2.5 30-May-2013 12:46:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @StartGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @StartGUI_OutputFcn, ...
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


% --- Executes just before StartGUI is made visible.
function StartGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to StartGUI (see VARARGIN)

% Choose default command line output for StartGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes StartGUI wait for user response (see UIRESUME)
% uiwait(handles.fig_start);

global NewPosition;
first_run=isempty(NewPosition);
 
if first_run
  x_value = 90;
  y_value = 25;
 set(handles.fig_start,'Position', [x_value,y_value,120,30]);
else
 x_value = NewPosition(1);
 y_value = NewPosition(2);
 set(handles.fig_start,'Position',[x_value,y_value,120,30]); 
end
% Five components within the main window
set(handles.radiogrp_panel,'Position', [10,6,100,20]);
set(handles.btn_next,'Position', [95,3,15,2]);
set(handles.btn_back,'Position', [80,3,15,2]);
set(handles.btn_exit,'Position', [65,3,15,2]);
set(handles.btn_about,'Position', [10,3,15,2]);
%%%%

% --- Outputs from this function are returned to the command line.
function varargout = StartGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_next.
function btn_next_Callback(hObject, eventdata, handles)
% hObject    handle to btn_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global NewPosition;
NewPosition=get(handles.fig_start,'Position');
 
val = get(handles.radiogrp_panel,'SelectedObject');
switch val
    case handles.radio_hide
      close(StartGUI); 
      run('HideGUI');       
    case handles.radio_extract
      close(StartGUI);
      run('ExtractGUI');      
end

% --- Executes on button press in btn_back.
function btn_back_Callback(hObject, eventdata, handles)
% hObject    handle to btn_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_exit.
function btn_exit_Callback(hObject, eventdata, handles)
% hObject    handle to btn_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(StartGUI); 

% --- Executes on button press in btn_about.
function btn_about_Callback(hObject, eventdata, handles)
% hObject    handle to btn_about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

run('About');
