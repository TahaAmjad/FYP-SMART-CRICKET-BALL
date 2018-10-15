name1=('log5_umer_Accel_del1.csv')
name2=('log5_umer_Gyro_del1.csv')
name3=('log5_umer_Mag_del1.csv')
addpath(genpath('C:\Users\MUHAMMAD IBRAHIM\Downloads\MbientLab.43351ABAF8FB0_afn0cdqbtq7je!App'))
addpath(genpath('E:\UEt\4th year\fyp\demon'))
cd('E:\UEt\4th year\fyp\Lums trial sensor')
R_initial=[ 1 0 0;
    0 1 0;
    0 0 1]
[timeA,AX,AY,AZ] = getDataa1(name1);
[timeM,MX,MY,MZ] = getDataa1(name3);
[timeG,GX,GY,GZ] = getDataa1(name2);
pplot(timeA,AX,AY,AZ,'Accel');

figure()
pplot(timeG,GX,GY,GZ,'GYRO');

figure()
pplot(timeM,MX,MY,MZ,'MAGNETO');
