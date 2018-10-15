clc
clear all
close  all

r = 200 * ones(50, 50); % radius is 5
[th, phi] = meshgrid(linspace(0, 2*pi, 50), linspace(-pi, pi, 50));
[x,y,z] = sph2cart(th, phi, r);
plot3(x,y,z,'r','LineWidth',5)
axis equal
xlabel('x')
ylabel('y')
zlabel('z')
grid on
hold on
th = 0:pi/50:2*pi;
x = 200* cos(th);
y = 200* sin(th);
z = zeros(length(th))
plot3(x,y,z,'y','LineWidth',30)
 fid=fopen('rampgyro1.csv');
 readData=textscan(fid,'%f %f %f %f','Headerlines',1,'Delimiter',',');
 time=readData{1,1}(:,1);
 gyroX=readData{1,2}(:,1);
 gyroY=readData{1,3}(:,1);
 gyroZ=readData{1,4}(:,1);
%  accelX=readData{1,5}(:,1);
%  accelY=readData{1,6}(:,1);
%  accelZ=readData{1,7}(:,1);
%  
gyro=sqrt(gyroX.^2+gyroY.^2+gyroZ.^2)
 f1=figure(1);
% subplot(2,3,1)
% plot(time,accelX,'k-')
% grid on
% title('graph of accelerometerX')
% subplot(2,3,2)
% grid on
% plot(time,accelY,'r-')
% grid on
% title('graph of accelerometerY')
% subplot(2,3,3)
% grid on
% plot(time,accelZ,'g-')
% grid on
% title('graph of accelerometerZ')
% subplot(1,3,1)
% grid on
% plot(time,gyroX,'k-')
% grid on
% title('graph of gyroscopeX')
% subplot(1,3,2)
% grid on
% plot(time,gyroY,'r-')
% grid on
% title('graph of gyroscopeY')
% subplot(1,3,3)
% grid on
%  plot(time,gyroZ,'g-')
% title('graph of gyroscopeZ')
% grid on
% figure
% grid on
%  plot(time,gyro,'b-')
% title('graph of gyro')
% grid on
% xlabel('time')
%  f2=figure(2);
% plot(time,accelX,'k-')
% figure
% findpeaks(accelX)
% [pks,locs] = findpeaks(accelX)
% tt=time(locs)
% timett=fix(time)
% ttx=fix(tt)
% clc
% B = unique(ttx) % which will give you the unique elements of A in array B
% Ncount = histc(ttx, B) 
% [B Ncount*360]
% figure
% stem(B,Ncount*360)
% figure
% plot(time,gyroX)
% [timett gyroX]
% figure
% plot(time,gyroY)
% figure
% plot(time,gy
for i=1:length(gyroX)
 hold on   
plot3 ([0 gyroX(i)],[0 gyroY(i)],[0 gyroZ(i)])
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
pause(0.2)
end
