function varargout = romitgui(varargin)
% ROMITGUI MATLAB code for romitgui.fig
%      ROMITGUI, by itself, creates a new ROMITGUI or raises the existing
%      singleton*.
%
%      H = ROMITGUI returns the handle to a new ROMITGUI or the handle to
%      the existing singleton*.
%
%      ROMITGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROMITGUI.M with the given input arguments.
%
%      ROMITGUI('Property','Value',...) creates a new ROMITGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before romitgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to romitgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help romitgui

% Last Modified by GUIDE v2.5 13-May-2018 15:31:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @romitgui_OpeningFcn, ...
                   'gui_OutputFcn',  @romitgui_OutputFcn, ...
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


% --- Executes just before romitgui is made visible.
function romitgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to romitgui (see VARARGIN)

% Choose default command line output for romitgui
handles.output = hObject;
global pop
addpath(genpath('E:\UEt\4th year\fyp'))
%     
% pop  = 1;
cla reset
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes romitgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = romitgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in parameter_dropdown1.
function parameter_dropdown1_Callback(hObject, eventdata, handles)
% hObject    handle to parameter_dropdown1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pop;
contents = cellstr(get(hObject,'String'));
val = contents{get(hObject,'Value')};
val
switch val
    case 'Spin Axis'
        pop = 1
    case 'Accelorometer'
        pop = 5
    case 'Gyroscope'
        pop = 6
    case 'Magnetometer'
        pop = 7
end
pop

% Hints: contents = cellstr(get(hObject,'String')) returns parameter_dropdown1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from parameter_dropdown1


% --- Executes during object creation, after setting all properties.
function parameter_dropdown1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to parameter_dropdown1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function input_name_Callback(hObject, eventdata, handles)
% hObject    handle to input_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_name as text
%        str2double(get(hObject,'String')) returns contents of input_name as a double


% --- Executes during object creation, after setting all properties.
function input_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Update_plot.
function Update_plot_Callback(hObject, eventdata, handles)
% hObject    handle to Update_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global timeA;global AX;global AY;global AZ;global timeG;global GX;global GY;global GZ;global timeM;global MX;global MY;global MZ;
global pop;global io_impact;global io_release;
global R_L;global R_L1;global R_L1res;global result;
global spin;global spin1;global spin2;global Gxx;global Gyy;global Gzz;global aresG;

% ------------
% addpath(genpath('C:\Users\MUHAMMAD IBRAHIM\Downloads\MbientLab.43351ABAF8FB0_afn0cdqbtq7je!App'))
% addpath(genpath('E:\UEt\4th year\fyp\demon'))

% figure()
 % popup selection and result display
if (pop==1)
 cla reset
    % Plotting a 3D ball
     r = 200 * ones(50, 50); % radius is 5
[th, phi] = meshgrid(linspace(0, 2*pi, 50), linspace(-pi, pi, 50));
[x,y,z] = sph2cart(th, phi, r);
plot3(x,y,z,'r','LineWidth',10)
axis equal
xlabel('x')
ylabel('y')
zlabel('z')
grid on
hold on
th = 0:pi/50:2*pi;
x = 210* cos(th);
y = 210* sin(th);
z = zeros(length(th));
plot3(x,y,z,'r','LineWidth',15)
hold on
th1 = 0:pi/100:2*pi;

x1 = 210* cos(th1);
y1 = 210* sin(th1);
z1 = zeros(length(th1));
plot3(x1,y1,z1+10,'w--','LineWidth',4)
hold on
plot3(x1,y1,z1-10,'w--','LineWidth',4)
hold on
x2 = 204* cos(th1);
y2 = 204* sin(th1);
z2 = zeros(length(th1));
plot3(x2,y2,z2+30,'w--','LineWidth',5)
hold on
plot3(x2,y2,z2-30,'w--','LineWidth',5)

title('Spin Axis','FontSize',12)

%% Plotting location of spinaxes
 pause(1)
for i=3:length(R_L)-3
 hold on

 GXN(i) = abs(R_L1(i,1)/norm(R_L1res(i)));
 GYN(i) = abs(R_L1(i,2)/norm(R_L1res(i)));
 GZN(i) = abs(R_L1(i,3)/norm(R_L1res(i)));
 plot3 ([0 300*GXN(i)],[0 300*GYN(i)],[0 300*GZN(i)],'LineWidth',2)
axis equal
hold on
xlabel('x-axis')
ylabel('y-axis')
zlabel('z-axis')

% plot3 ([0 0],[0 1],[0 0])
% hold on
% plot3 ([0 0],[0 0],[0 1])
% hold on
% plot3 ([0 1],[0 1],[0 1])
grid on
pause(0.3)
end
end
    if (pop==2)

    end
    if (pop==3)

    end
    if (pop==4)
%   Spin Decay

    end
if (pop==5)
    cla reset
pplot(timeA,AX,AY,AZ,'Accel');
vline(io_impact,'r','point of impact');
vline(io_release,'black','ior');
end
if (pop==6)
    cla reset
pplot(timeG,GX,GY,GZ,'GYRO');
vline(io_impact,'r','point of impact');
vline(io_release,'black','ior');
end

if (pop==7)
    cla reset
pplot(timeM,MX,MY,MZ,'MAGNETO');
vline(io_impact,'r','point of impact');
vline(io_release,'black','ior');
end



% --- Executes on button press in load_data.
function load_data_Callback(hObject, eventdata, handles)
% hObject    handle to load_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input=get(handles.input_name,'String');
input=char(input);
 Accel=strcat(input,'_Accel.csv');
 Gyro=strcat(input,'_Gyro.csv');
 Mag=strcat(input,'_Mag.csv');
    set(handles.error_box,'String','Error');
    global timeA;global AX;global AY;global AZ;global timeG;global GX;global GY;global GZ;global timeM;global MX;global MY;global MZ;
global R_L;global R_L1;global R_L1res;global result;
global io_impact;global io_release;
global spin;global spin1;global spin2;global Gxx;global Gyy;global Gzz; 
    
%     addpath(genpath('C:\Users\MUHAMMAD IBRAHIM\Downloads\MbientLab.43351ABAF8FB0_afn0cdqbtq7je!App'))
%     addpath(genpath('E:\UEt\4th year\fyp\demon'))
%     cd 'C:\Users\MUHAMMAD IBRAHIM\Downloads\MbientLab.43351ABAF8FB0_afn0cdqbtq7je!App\Devices\E4B36609F00C';
%     
%     LA1=strcat(input,'*.csv');
%     listing = dir(LA1);
%     LA2 = listing.name;
% %     LA=strcat(LA2,'_LinearAcceleration_100.000Hz.csv');
    
    [timeA,AX,AY,AZ] = getDataa1(Accel);
    [timeG,GX,GY,GZ] = getDataa1(Gyro);
    [timeM,MX,MY,MZ] = getDataa1(Mag);

    a='OK';
set(handles.error_box,'String',a);
R_initial=[ 1 0 0;
    0 1 0;
    0 0 1];
res =  sqrt(AX.^2+AY.^2+AZ.^2);                 %Resultant
res2 = abs(AX)+abs(AY)+abs(AZ);%Abs sum resultant

dy = diff(res2);dt = diff(timeA);yu=dy./(dt+0.1);% Calculating derivative yu of Resultant
mul=abs(yu.*res2(2:end));                       %multiplying derivative and resultant = mul
[ioi_value,ioi_ind]=max(mul);                   %Find max of mul ,ioi_value=max value,ioi_ind=index of amx value
ioi=timeA(ioi_ind);                             %Ioi time
scaled_time=ioi-3;                              %Considering time 3s before the Ioi
b=abs(timeA-scaled_time);[scaled_value,scaled_ind]=min(b);%Finding closest value in time array               %
res4=res(scaled_ind:ioi_ind-10);                %Resizing the resultant to 3s before Ioi
[ior_value_r,ior_index_r]=max(res4);            %Finding max in resized res
kior = find(res==ior_value_r);                  %Finding index of max_value in orginal Resultant
ior  = timeA(kior);                             %Calulating Ior time at index of amx_value

xa_preflight=AX(1:kior);ya_preflight=AY(1:kior);za_preflight=AZ(1:kior); %Scaling x,y,z of LA upto delivery time
xa_inflight=AX(kior:ioi_ind);ya_inflight=AY(kior:ioi_ind);za_inflight=AZ(kior:ioi_ind); %Scaling x,y,z of LA upto delivery time
ta_preflight=timeA(1:kior);
ta_inflight=timeA(kior:ioi_ind)  ;

xg_preflight=GX(1:kior);yg_preflight=GY(1:kior);zg_preflight=GZ(1:kior); %Scaling x,y,z of LA upto delivery time
xg_inflight=GX(kior:ioi_ind);yg_inflight=GY(kior:ioi_ind);zg_inflight=GZ(kior:ioi_ind); %Scaling x,y,z of LA upto delivery time
tg_preflight=timeG(1:kior);
tg_inflight=timeG(kior:ioi_ind);

                           
bB=abs(timeM-ior);[MagIOR_value,MagIOR_ind]=min(bB);
bB2=abs(timeM-ioi);[MagIOI_value,MagIOI_ind]=min(bB2);

xm_preflight=MX(1:MagIOR_ind);ym_preflight=MY(1:MagIOR_ind);zm_preflight=MZ(1:MagIOR_ind); %Scaling x,y,z of LA upto delivery time
xm_inflight=MX(MagIOR_ind:MagIOI_ind);ym_inflight=MY(MagIOR_ind:MagIOI_ind);zm_inflight=MZ(MagIOR_ind:MagIOI_ind); %Scaling x,y,z of LA upto delivery time
tm_preflight=timeM(1:MagIOR_ind);
tm_inflight=timeM(MagIOR_ind:MagIOI_ind);

io_impact = ioi;
io_release= ior;
Tod=ioi-ior;


for i=1:length(xm_inflight)-2
    v1=[xm_inflight(i) ym_inflight(i) zm_inflight(i)];
    v2=[xm_inflight(i+1) ym_inflight(i+1) zm_inflight(i+1)];
    v3=[xm_inflight(i+2) ym_inflight(i+2) zm_inflight(i+2)];
    [normal,d]=plot_line(v1, v2, v3);
    R_L(i,:)=normal;
    coneangles(i)=acos(dot(v1,R_L(i,:))/(norm(v1)*norm(R_L(i,:))));
    %hold on
% plot3([0 10^10.5*normal(1)],[0 10^10.5*normal(2)],[0 10^10.5*normal(3)])
cla reset
end
coneangle=mean(coneangles);
varience=var(coneangles);
rot=R_initial;
for i=1:length(xg_preflight)-1
    Ix(i)=trapz(xg_preflight(i:i+1),tg_preflight(i:i+1));
    Iy(i)=trapz(yg_preflight(i:i+1),tg_preflight(i:i+1));
    Iz(i)=trapz(zg_preflight(i:i+1),tg_preflight(i:i+1));
    R_O=rotz(Iz(i))*roty(Iy(i))*rotx(Ix(i));
    rot=rot*R_O;
end
R_G=rot*R_L(end,:)';
N_G=[xm_preflight(1) ym_preflight(1) zm_preflight(1)];
R1=[R_G N_G' cross(R_G,N_G')];
for i=1:length(xm_inflight)-2
    N_L=[xm_inflight(i) ym_inflight(i) zm_inflight(i)];
    R2=[R_L(i,:)' N_L' cross(R_L(i,:)',N_L')];
    R3=inv(R2);
    Rot_f(:,:,i)=R1*R3;
    THEETHA_EU(i)=asin(-Rot_f(3,1,i));
    PHI_EU(i)=asin(Rot_f(3,2,i)/cos(THEETHA_EU(i)));
    GAMMA_EU(i)=acos(Rot_f(1,1,i)/cos(THEETHA_EU(i)));
end
theeha_NR=acos(dot(R_G,N_G')/(norm(R_G)*norm(N_G')));
timeee=diff(tm_inflight)+0.1;
Gxx=(abs(THEETHA_EU)./timeee(1:end-1)')*(180/pi);
Gyy=(abs(PHI_EU)./timeee(1:end-1)')*(180/pi);
Gzz=(abs(GAMMA_EU)./timeee(1:end-1)')*(180/pi);
Gxx = Gxx/6;
Gyy = Gyy/6;
Gzz = Gzz/6;

resG =  sqrt(Gxx.^2+Gyy.^2+Gzz.^2);
aresG = Gxx+Gyy+Gzz;
text1 = 'Spin Rate =  ';
spinrate_rpm=mean(abs(aresG))
aresG1=aresG(1:round(length(aresG)/2));
aresG2=aresG((round(length(aresG)/2)):end);
spin=mean(aresG)
spin1=mean(aresG1)
spin2=mean(aresG2)
text2 = ' rpm ' ;
tod4=num2str(spinrate_rpm);
result=strcat(text1,tod4,text2);
display(result)
%% 

R_L1=R_L*10^10;
for l=1:length(R_L1)
    R_L1res(l) = sqrt(R_L1(l,1)^2+R_L1(l,2)^2+R_L1(l,3)^2);
end
text1  = ' Instance of release : ';
text2 =  ' Instance of impact : ';
text3 =  ' Duration of delivery : ';
text4 =  ' Average Spin rate : ';
% text5 =  ' Average Spin 1st half : ';
% text1 =  ' Average Spin 2nd half : ';
text5 = 'Spin Decay : '; 
units =  'rpm';
unit = 's';
tod1 = io_release;
tod2 = io_impact;
tod3 = io_impact-io_release;
tod4 = spinrate_rpm;
tod5 = abs(spin1-spin2);
tod1=num2str(tod1);
tod2=num2str(tod2);
tod3=num2str(tod3);
tod4=num2str(tod4);
tod5=num2str(tod5);

text1=strcat(text1,tod1,unit);
text2=strcat(text2,tod2,unit);
text3=strcat(text3,tod3,unit);
text4=strcat(text4,tod4,units);
text5=strcat(text5,tod5,units);

set(handles.text1,'String',text1);
set(handles.text2,'String',text2);
set(handles.text3,'String',text3);
set(handles.text4,'String',text4);
set(handles.text5,'String',text5);
