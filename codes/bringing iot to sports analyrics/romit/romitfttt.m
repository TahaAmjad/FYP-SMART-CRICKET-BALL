clc
clear all
close all
name1=('log5_umer_Accel_del2.csv')
name2=('log5_umer_Gyro_del2.csv')
name3=('log5_umer_Mag_del2.csv')
addpath(genpath('C:\Users\MUHAMMAD IBRAHIM\Downloads\MbientLab.43351ABAF8FB0_afn0cdqbtq7je!App'))
addpath(genpath('E:\UEt\4th year\fyp\demon'))

R_initial=[ 1 0 0;
    0 1 0;
    0 0 1]
[timeA,AX,AY,AZ] = getDataa1(name1);
[timeM,MX,MY,MZ] = getDataa1(name3);
[timeG,GX,GY,GZ] = getDataa1(name2);
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

pplot(timeA,AX,AY,AZ,'Accel');
vline(io_impact,'r','point of impact');
vline(io_release,'black','ior');

figure()
pplot(timeG,GX,GY,GZ,'GYRO');
vline(io_impact,'r','point of impact');
vline(io_release,'black','ior');

figure()
pplot(timeM,MX,MY,MZ,'MAGNETO');
vline(io_impact,'r','point of impact');
vline(io_release,'black','ior');
figure
for i=1:length(xm_inflight)-2
    v1=[xm_inflight(i) ym_inflight(i) zm_inflight(i)];
    v2=[xm_inflight(i+1) ym_inflight(i+1) zm_inflight(i+1)];
    v3=[xm_inflight(i+2) ym_inflight(i+2) zm_inflight(i+2)];
    [normal,d]=plot_line(v1, v2, v3);
    R_L(i,:)=normal;
    coneangles(i)=acos(dot(v1,R_L(i,:))/(norm(v1)*norm(R_L(i,:))));
    %hold on
% plot3([0 10^10.5*normal(1)],[0 10^10.5*normal(2)],[0 10^10.5*normal(3)])
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

Tod=ioi-ior;
resG =  sqrt(Gxx.^2+Gyy.^2+Gzz.^2);
text1 = 'Spin Rate =  ';
spinrate_rpm=mean(resG)/Tod;
text2 = ' rpm ' ;
tod4=num2str(spinrate_rpm);
result=strcat(text1,tod4,text2);
display(result)
%% Plotting a 3D ball
r = 200 * ones(50, 50); % radius is 5
[th, phi] = meshgrid(linspace(0, 2*pi, 50), linspace(-pi, pi, 50));
[x,y,z] = sph2cart(th, phi, r);
plot3(x,y,z,'r','LineWidth',3)
axis equal
xlabel('x')
ylabel('y')
zlabel('z')
grid on
hold on
th = 0:pi/50:2*pi;
x = 200* cos(th);
y = 200* sin(th);
z = zeros(length(th));
plot3(x,y,z,'y','LineWidth',30)
%% Plotting location of spinaxes
 pause(1)
for i=1:length(Gxx)
 hold on

 GXN(i) = Gxx(i)/norm(resG(i));
 GYN(i) = Gyy(i)/norm(resG(i));
 GZN(i) = Gzz(i)/norm(resG(i));
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

