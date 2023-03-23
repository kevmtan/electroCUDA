function varargout = sift(varargin)
% SIFT M-file for sift.fig
%      SIFT, by itself, creates a new SIFT or raises the existing
%      singleton*.
%
%      H = SIFT returns the handle to a new SIFT or the handle to
%      the existing singleton*.
%
%      SIFT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIFT.M with the given input arguments.
%
%      SIFT('Property','Value',...) creates a new SIFT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sift_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sift_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sift

% Last Modified by GUIDE v2.5 16-Jul-2010 15:21:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sift_OpeningFcn, ...
                   'gui_OutputFcn',  @sift_OutputFcn, ...
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


% --- Executes just before sift is made visible.
function sift_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sift (see VARARGIN)

% Choose default command line output for sift
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sift wait for user response (see UIRESUME)
 uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sift_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
global handle1 handle2 matched
handle1 = hObject;
matched = 0;
set(hObject, 'Value', 1)
try
    set(handle2, 'Value', 0)
end
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
global handle1 handle2 matched
handle2 = hObject;
matched = 1;
set(hObject, 'Value', 1)
try
    set(handle1, 'Value', 0)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
% next
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
close(handles.figure1)
%keyboard
%set(handles.figure1, 'Visible', 'off');
%close %all
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function radiobutton1_CreateFcn(hObject, eventdata, handles)
global handle1
handle1 = hObject;
set(hObject, 'Value', 1);
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
