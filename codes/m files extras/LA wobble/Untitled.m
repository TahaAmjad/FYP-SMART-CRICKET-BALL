close all
clc
clear all
% filePath = 
addpath(genpath('C:\Users\MUHAMMAD IBRAHIM\Downloads\MbientLab.43351ABAF8FB0_afn0cdqbtq7je!App'))
addpath(genpath('E:\UEt\4th year\fyp\demon'))
    
LA=('MetaWear_2018-05-07T09.44.23.909_E4B36609F00C_LinearAcceleration.csv')
[timeL,LX,LY,LZ] = getDataa1(LA);

pplot(timeL,LX,LY,LZ,'LA');
a = min(LZ)
LZ1 = LZ
figure()
findpeaks(LZ1)
[pks,locspos]=findpeaks(LZ1)
hold on
findpeaks(-1*LZ1)
[pksneg,locsneg]=findpeaks(-1*LZ1)
positivepeaks = LZ1(locspos)
negativepeak = LZ1(locsneg)

difference = abs(pks+pksneg(1:end-1))
b=size(difference)
arr=1:b(1)
strechedarr=((arr-1)./b(1)).*90;
hold on
plot(strechedarr,difference)
legend('org','','-ve','','diff')