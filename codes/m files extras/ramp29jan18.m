clear all;
clc;
close all;

[timee,pitch,roll,yaw] = getDataa1('test2_Euler.csv');
 [timel,lX,lY,lZ] = getDataa1('test2_LA.csv');
% [timeG,GX,GY,GZ] = getDataa('sh4eg_Grav.csv');

res = sqrt(lX.^2+lY.^2+lZ.^2);
dd=diff(res);
[mm,ii]=max(dd);
value = timel(ii);
dior=diff(res(1:ii));
[mv,ior]=min(dior);
ior_value=timel(ior);

figure()
pplot(timee,pitch,roll,yaw,'euler');
vline(value,'r','point of impact');
vline(ior_value,'black','ior');
hold on
findpeaks(roll)

figure()
pplot(timel,lX,lY,lZ,'LA');
vline(value,'r','point of impact');
vline(ior_value,'black','ior');

% figure()
% pplot(timeG,GX,GY,GZ,'LA');
% % vline(value,'r','point of impact');
% % vline(ior_value,'black','ior');
