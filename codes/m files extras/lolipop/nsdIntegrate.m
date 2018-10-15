clear all;
clc;
gyrofile=fopen('gyruMagnoalg_Gyro.csv');
 readgyrodata=textscan(gyrofile,'%f %f %f %f','Headerlines',1,'Delimiter',',');
 timeg=readgyrodata{1,1}(:,1);
 gyroX=readgyrodata{1,2}(:,1);
 gyroY=readgyrodata{1,3}(:,1);
 gyroZ=readgyrodata{1,4}(:,1);
 gyro_res=sqrt(gyroX.^2+gyroY.^2+gyroZ.^2);
 v=[1;1;1]
 for i=1600:1688
    Ix(i)=trapz(gyroX(i:i+1),timeg(i:i+1));
    Iy(i)=trapz(gyroY(i:i+1),timeg(i:i+1));
    Iz(i)=trapz(gyroZ(i:i+1),timeg(i:i+1));
    R=rotz(Iz(i))*roty(Iy(i))*rotx(Ix(i));
    v=R*v;
    vr=[v(1)/norm(v) v(2)/norm(v) v(3)/norm(v)]
    plot3([i-1 vr(1)+(i-1)],[i-1 vr(2)+(i-1)],[i-1 i-1])
    hold on
    plot3([i-1 vr(1)+(i-1)],[i-1 i-1],[i-1 vr(3)+(i-1)])
    hold on
    plot3([i-1 i-1],[i-1 vr(2)+(i-1)],[i-1 vr(3)+(i-1)])
    grid on
 end
% 
% plot(timeg,gyroZ,'g')
% hold on
% plot(timeg(1:1688),Iz,'r')
% grid on
% title('graph of gyroscopeZ')
% figure
% plot(timeg,gyroX,'g')
% hold on
% plot(timeg(1:1688),Ix,'r')
% grid on
% title('graph of gyroscopeX')
% figure
% plot(timeg,gyroY,'g')
% hold on
% plot(timeg(1:1688),Iy,'r')
% grid on
% title('graph of gyroscopeY')