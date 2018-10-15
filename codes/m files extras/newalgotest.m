clear all
clc
close all
addpath(genpath('C:\Users\MUHAMMAD IBRAHIM\Downloads\MbientLab.43351ABAF8FB0_afn0cdqbtq7je!App'))
addpath(genpath('E:\UEt\4th year\fyp\demon'))
    
LA=('gyruMagnoalg_Accel.csv');

[timeL,LX,LY,LZ] = getDataa1(LA);
res =  sqrt(LX.^2+LY.^2+LZ.^2);                 %Resultant
res2 = abs(LX)+abs(LY)+abs(LZ);%Abs sum resultant
% [b,a]= butter(2,2000*2/11025);
% % res = filter(a,b,res);
% % res2 = filter(a,b,res2);

dy = diff(res2);dt = diff(timeL);yu=dy./(dt+0.1);% Calculating derivative yu of Resultant
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
tscaled=timeL(kior:ioi_ind);
xa_peaks=findpeaks(xa_scaled);ya_peaks=findpeaks(ya_scaled);za_peaks=findpeaks(za_scaled); % find peaks in each x,y,z

peaka=[size(xa_peaks);size(ya_peaks);size(za_peaks)];           %putting number of peaks in each into an array           
np=max(peaka(:,1));                                             %find minimum numebr of peaks

Tod=ioi-ior;                                                    %Time of delivery (ms)

Tpeaks=np/Tod;                                                  %rps

spin_rate_rpm=Tpeaks*60                                        %rpm

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
pplot(timeL,LX,LY,LZ,'LA');
vline(io_impact,'r','point of impact');
vline(io_release,'black','ior');