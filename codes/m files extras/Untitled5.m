clear all;
clc;
close all;

[timeg,x,y,z] = getDataa1('frizby_Grav.csv');
[timel,lX,lY,lZ] = getDataa1('frizby_LA.csv');

res = sqrt(lX.^2+lY.^2+lZ.^2);
dd=diff(res);
% [mm,ii]=max(dd);
% value = timel(ii);
% dior=diff(res(1:ii));
% [mv,ior]=min(dior);
% ior_value=timel(ior);

figure()
pplot(timeg,x,y,z,'grav');
% vline(value,'r','point of impact');
% vline(ior_value,'black','ior');

figure()
pplot(timel,lX,lY,lZ,'LA');
% vline(value,'r','point of impact');
% vline(ior_value,'black','ior');
