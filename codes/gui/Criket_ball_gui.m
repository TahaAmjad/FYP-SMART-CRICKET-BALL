
function varargout = Criket_ball_gui(varargin)

% CRIKET_BALL_GUI MATLAB code for Criket_ball_gui.fig
%      CRIKET_BALL_GUI, by itself, creates a new CRIKET_BALL_GUI or raises the existing
%      singleton*.
%
%      H = CRIKET_BALL_GUI returns the handle to a new CRIKET_BALL_GUI or the handle to
%      the existing singleton*.
%
%      CRIKET_BALL_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CRIKET_BALL_GUI.M with the given input arguments.
%
%      CRIKET_BALL_GUI('Property','Value',...) creates a new CRIKET_BALL_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Criket_ball_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Criket_ball_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Criket_ball_gui

% Last Modified by GUIDE v2.5 05-Feb-2018 13:26:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Criket_ball_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Criket_ball_gui_OutputFcn, ...
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



% --- Executes just before Criket_ball_gui is made visible.
function Criket_ball_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Criket_ball_gui (see VARARGIN)

% Choose default command line output for Criket_ball_gui
 
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Criket_ball_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Criket_ball_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in selectdata_popup.
function selectdata_popup_Callback(hObject, eventdata, handles)
% hObject    handle to selectdata_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selectdata_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selectdata_popup
global pop;
str = get(hObject, 'String');
val = get(hObject, 'Value');
% aa=str{val}
% s1 = aa;
% s2 = 'GYRO';
% size(aa)
% tf = strcmp(s1,s2)
switch str{val}
    case 'GYRO   '
        pop = 1;
        display('GYRO')
    case 'ACCERO '
        pop = 2;
        display('ACC')
    case 'MAGENTO'
        pop = 3;
        display('MAG')
end
display(pop)

% --- Executes during object creation, after setting all properties.
function selectdata_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectdata_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






% --- Executes on button press in load_data.
function load_data_Callback(hObject, eventdata, handles)
% hObject    handle to load_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input=get(handles.filename_editbox,'String');
input=char(input);
gyro=strcat(input,'_gyro.csv');
accel=strcat(input,'_acc.csv');
mag=strcat(input,'_mag.csv');
set(handles.ErrorBox,'String','Error');
global timeg;global gyroX;global gyroY;global gyroZ;global timea;global accelX;global accelY;global accelZ;global timem;global magX;global magY;global magZ;
[timeg,gyroX,gyroY,gyroZ] = getDataa(gyro);
[timea,accelX,accelY,accelZ] = getDataa(accel);
[timem,magX,magY,magZ] = getDataa(mag);
a='OK';
set(handles.ErrorBox,'String',a);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function text10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
display('dd');


% --- Executes on button press in update_plot.
function update_plot_Callback(hObject, eventdata, handles)
% hObject    handle to update_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global timeg;
global gyroX;
global gyroY;
global gyroZ;
global timea;
global accelX;
global accelY;
global accelZ;
global timem;
global magX;
global magY;
global magZ;
global pop;
global io_impact;global io_release;
res = sqrt(accelX.^2+accelY.^2+accelZ.^2);
dd=diff(res);
[mm,ii]=max(dd);
io_impact = timea(ii);
dior=diff(res(1:ii));
[mv,ior]=min(dior);
io_release=timea(ior);
% subplot(311)
text1  = ' Instance of release : ';
text2 =  ' Instance of impact : ';
text3 =  ' Duration of delivery : ';
unit = 'ms';
tod1=io_release;
tod2=io_impact;
tod3 = io_impact-io_release;
tod1=int2str(tod1);
tod2=int2str(tod2);
tod3=int2str(tod3);
text1=strcat(text1,tod1,unit);
text2=strcat(text2,tod2,unit);
text3=strcat(text3,tod3,unit);
set(handles.text1,'String',text1);
set(handles.text2,'String',text2);
set(handles.text3,'String',text3);

cla reset
if (pop==1)
pplot(timeg,gyroX,gyroY,gyroZ,'gyro');
vline(io_impact,'r','point of impact');
vline(io_release,'black','ior');
end
if (pop==2)

pplot(timea,accelX,accelY,accelZ,'acc');
vline(io_impact,'r','point of impact');
vline(io_release,'black','ior');
end
if (pop==3)

pplot(timem,magX,magY,magZ,'mag');
vline(io_impact,'r','point of impact');
vline(io_release,'black','ior');
end


function filename_editbox_Callback(hObject, eventdata, handles)
% hObject    handle to filename_editbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename_editbox as text
%        str2double(get(hObject,'String')) returns contents of filename_editbox as a double


% --- Executes during object creation, after setting all properties.
function filename_editbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename_editbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
