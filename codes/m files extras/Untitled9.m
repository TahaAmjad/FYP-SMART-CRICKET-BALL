clc;
clear all
close all
[timea,xa,ya,za]=getDataa1('EL_robo_LA.csv');
 pplot(timea,xa,ya,za,'LA')
res =  sqrt(xa.^2+ya.^2+za.^2);
res2 = abs(xa)+abs(ya)+abs(za);
dy = diff(res2);
dt = diff(timea);
yu=dy./(dt+0.001);
mul=abs(yu.*res2(2:end));
[ioi_value,ioi_ind]=max(mul);
ioi=timea(ioi_ind);
scaled_time=ioi-3;
b=abs(timea-scaled_time);
[scaled_value,scaled_ind]=min(b);
scaled_time=timea(scaled_ind);
k = find(timea==scaled_time)
res4=res(scaled_ind:ioi_ind-10);
[ior_value_r,ior_index_r]=max(res4);
kior = find(res==ior_value_r)
ior=timea(kior)
plot(timea,res)
vline(ioi,'r','point of impact');
vline(ior,'black','ior');


