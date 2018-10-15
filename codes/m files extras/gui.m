
function varargout = Euler_gui(varargin)

% EULER_GUI MATLAB code for Euler_gui.fig
%      EULER_GUI, by itself, creates a new EULER_GUI or raises the existing
%      singleton*.
%
%      H = EULER_GUI returns the handle to a new EULER_GUI or the handle to
%      the existing singleton*.
%
%      EULER_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EULER_GUI.M with the given input arguments.
%
%      EULER_GUI('Property','Value',...) creates a new EULER_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Euler_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Euler_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Euler_gui

% Last Modified by GUIDE v2.5 02-Apr-2018 15:43:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Euler_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Euler_gui_OutputFcn, ...
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



% --- Executes just before Euler_gui is made visible.
function Euler_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Euler_gui (see VARARGIN)

% Choose default command line output for Euler_gui
 global pop;
 pop=1;
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Euler_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Euler_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function display_results_Callback(hObject, eventdata, handles)
% hObject    handle to display_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of display_results as text
%        str2double(get(hObject,'String')) returns contents of display_results as a double


% --- Executes during object creation, after setting all properties.
function display_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to display_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
Euler=strcat(input,'_Euler.csv');
LA=strcat(input,'_LA.csv');
set(handles.ErrorBox,'String','Error');
global timeE;global EX;global EY;global EZ;global timeL;global LX;global LY;global LZ;
[timeE,EX,EY,EZ] = getDataa1(Euler);
[timeL,LX,LY,LZ] = getDataa1(LA);
a='OK';
set(handles.ErrorBox,'String',a);




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

global timeE;global EX;global EY;global EZ;global timeL;global LX;global LY;global LZ;
global pop;global io_impact;global io_release;

% =============================-------=============================================

res =  sqrt(LX.^2+LY.^2+LZ.^2);                 %Resultant
res2 = abs(LX)+abs(LY)+abs(LZ);                 %Abs sum resultant
[b,a]= butter(2,2000*2/11025);
res = filter(a,b,res);
% res2 = filter(a,b,res2);

dy = diff(res2);dt = diff(timeL);yu=dy./(dt+0.001);% Calculating derivative yu of Resultant
mul=abs(yu.*res2(2:end));                       %multiplying derivative and resultant = mul
[ioi_value,ioi_ind]=max(mul);                   %Find max of mul ,ioi_value=max value,ioi_ind=index of amx value
ioi=timeL(ioi_ind);                             %Ioi time
scaled_time=ioi-3;                              %Considering time 3s before the Ioi
b=abs(timeL-scaled_time);[scaled_value,scaled_ind]=min(b);%Finding closest value in time array               %
res4=res(scaled_ind:ioi_ind-10);                %Resizing the resultant to 3s before Ioi
[ior_value_r,ior_index_r]=max(res4);            %Finding max in resized res
kior = find(res==ior_value_r);                  %Finding index of max_value in orginal Resultant
ior  = timeL(kior);                             %Calulating Ior time at index of amx_value
xa_scaled=LX(kior:ioi_ind);ya_scaled=LY(kior:ioi_ind);za_scaled=LZ(kior:ioi_ind); %Scaling x,y,z of LA upto delivery time
xa_peaks=findpeaks(xa_scaled);ya_peaks=findpeaks(ya_scaled);za_peaks=findpeaks(za_scaled); % find peaks in each x,y,z

peaka=[size(xa_peaks);size(ya_peaks);size(za_peaks)];           %putting number of peaks in each into an array           
np=min(peaka(:,1));                                             %find minimum numebr of peaks

Tod=ioi-ior;                                                    %Time of delivery (ms)

Tpeaks=np/Tod;                                                  %rps

spin_rate_rpm=Tpeaks*60;                                        %rpm

spin_rate_dps=Tpeaks*360;                                       %dps
io_impact = ioi;
io_release= ior;

%  ================================88888==============================
text1  = ' Instance of release :  ';
text2 =  ' Instance of impact :  ';
text3 =  ' Duration of delivery :  ';
text4 =  ' Spin rate : ';
units =  'rpm';
unit = 's';
tod1 = io_release;
tod2 = io_impact;
tod3 = io_impact-io_release;
tod4 = spin_rate_rpm;
tod1=num2str(tod1);
tod2=num2str(tod2);
tod3=num2str(tod3);
tod4=num2str(tod4);
text1=strcat(text1,tod1,unit);
text2=strcat(text2,tod2,unit);
text3=strcat(text3,tod3,unit);
text4=strcat(text4,tod4,units);
set(handles.text1,'String',text1);
set(handles.text2,'String',text2);
set(handles.text3,'String',text3);
set(handles.text4,'String',text4);

cla reset
if (pop==2)
pplot(timeE,EX,EY,EZ,'Euler');
vline(io_impact,'r','point of impact');
vline(io_release,'black','ior');
end
if (pop==1)

pplot(timeL,LX,LY,LZ,'LA');
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


% --- Executes on selection change in ELA_popup.
function ELA_popup_Callback(hObject, eventdata, handles)
% hObject    handle to ELA_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ELA_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ELA_popup
global pop;
contents = cellstr(get(hObject,'String'));
val = contents{get(hObject,'Value')};
pop=1;

switch val
    case 'EULER'
        pop = 2;
        display('GYRO')
    case 'LA'
        pop = 1;
        display('ACC')
end
display(pop)


% --- Executes during object creation, after setting all properties.
function ELA_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ELA_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
