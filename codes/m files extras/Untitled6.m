% [time,x,y,z]=getDataa1('EL_robo_Grav.csv')
% pplot(time,x,y,z,'Grav')
% figure
clc;
clear all
close all
[timea,xa,ya,za]=getDataa1('log4_kusum_midpace_del1.csv');
 pplot(timea,xa,ya,za,'LA')
res =  sqrt(xa.^2+ya.^2+za.^2);
res2 = abs(xa)+abs(ya)+abs(za);
% hold on
figure();
plot(timea,res/max(abs(res)));
hold on
% plot(timea,res2/max(abs(res2)));
dy = diff(res2);
hold on 
% plot(timea(2:end),dy/max(abs(dy)));
dt = diff(timea);
yu=dy./(dt+0.001);
hold on 
plot(timea(2:end),abs(yu)/max(abs(yu)));
hold on 
plot(timea(2:end),abs(yu.*res2(2:end))/max(abs(yu.*res2(2:end))));
legend('res','der','*')
% legend('res','res2','diff','der','*')