close all
clc
clear all
% filePath = 
LA=('test_LA.csv');
[timeL,LX,LY,LZ] = getDataa1(LA);

res =  sqrt(LX.^2+LY.^2+LZ.^2);                 %Resultant
res2 = abs(LX)+abs(LY)+abs(LZ);                 %Abs sum resultant

dy = diff(res2);dt = diff(timeL);yu=dy./(dt+0.1);% Calculating derivative yu of Resultant

mul=abs(yu.*res2(2:end));                       %multiplying derivative and resultant = mul

[ioi_value,ioi_ind]=max(mul);                   %Find max of mul ,ioi_value=max value,ioi_ind=index of amx value
ioi=timeL(ioi_ind);                             %Ioi time

scaled_time=ioi-3;                              %Considering time 3s before the Ioi
b=abs(timeL-scaled_time);[scaled_value,scaled_ind]=min(b);%Finding closest value in time array               %
res4=res(scaled_ind:ioi_ind-10);                %Resizing the resultant to 3s before Ioi
[ior_value_r,ior_index_r]=max(res4);            %Finding max in resized res
kior = find(res==ior_value_r);                  %Finding index of max_value in orginal Resultant
ior  = timeL(kior);                             %Calulating Ior time at index of amx_value
xa_scaled=LX(kior:ioi_ind);ya_scaled=LY(kior:ioi_ind);za_scaled=LZ(kior:ioi_ind); %Scaling x,y,z of LA upto delivery time
xa_peaks=findpeaks(xa_scaled);ya_peaks=findpeaks(ya_scaled);za_peaks=findpeaks(za_scaled); % find peaks in each x,y,z
xa_npeaks=findpeaks(-1*xa_scaled);ya_npeaks=findpeaks(-1*ya_scaled);za_npeaks=findpeaks(-1*za_scaled); % find peaks in each x,y,z

peaka = [size(xa_peaks);size(ya_peaks);size(za_peaks)];           %putting number of peaks in each into an array           
npeaka= [size(xa_npeaks);size(ya_npeaks);size(za_npeaks)];

np=max(peaka(:,1));                                             %find minimum numebr of peaks

Tod=ioi-ior;                                                    %Time of delivery (ms)

Tpeaks=np/Tod;                                                  %rps

spin_rate_rpm=Tpeaks*60                                        %rpm

spin_rate_dps=Tpeaks*360;                                       %dps
io_impact = ioi;
io_release= ior;



pplot(timeL,LX,LY,LZ,'LA');
vline(io_impact,'r','point of impact');
vline(io_release,'black','ior');

zpositive = peaka(3,1);
znegative = npeaka(3,1);

difff = abs(zpositive-znegative);

if (zpositive>znegative)
    wscaledzp=za_peaks(1:end-difff);
    wscaledzn=za_npeaks;
elseif (znegative>zpositive)
    wscaledzn=za_npeaks(1:end-difff);
    wscaledzp=za_peaks;
else
    wscaledzn=za_npeaks;
    wscaledzp=za_peaks;
end
    
    
LZ1 = za_scaled
figure()
findpeaks(za_scaled)
hold on
findpeaks(-1*LZ1)
difference = abs(za_peaks+za_npeaks)
b=size(difference)
arr=1:b(1)
strechedarr=(((arr-1)./b(1)).*size(za_scaled,1))+5;
hold on
stem(strechedarr,difference)
legend('org','','-ve','','diff')