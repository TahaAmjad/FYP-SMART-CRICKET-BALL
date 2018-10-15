clear all
prompt='www'
input = input(prompt,'s')
input=char(input);
    % Euler=strcat(input,'_Euler.csv');
% LA=strcat(input,'_LA.csv');

% [timeE,EX,EY,EZ] = getDataa1(Euler);

    addpath(genpath('C:\Users\MUHAMMAD IBRAHIM\Downloads\MbientLab.43351ABAF8FB0_afn0cdqbtq7je!App'))
    addpath(genpath('E:\UEt\4th year\fyp\demon'))
    cd 'C:\Users\MUHAMMAD IBRAHIM\Downloads\MbientLab.43351ABAF8FB0_afn0cdqbtq7je!App';
    LA1=strcat(input,'*.*');
    listing = dir(LA1);
    LA2 = listing.name;
    LA=strcat(LA2,'_LinearAcceleration_100.000Hz.csv');
