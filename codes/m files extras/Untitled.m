input=('MetaR')
Euler=strcat(input,'_Euler.csv');
LA=strcat(input,'_LA.csv');

[timeE,EX,EY,EZ] = getDataa1(Euler);
[timeL,LX,LY,LZ] = getDataa1(LA);
pplot(timeL,LX,LY,LZ,'LA');
vline(io_impact,'r','point of impact');
vline(io_release,'black','ior');
