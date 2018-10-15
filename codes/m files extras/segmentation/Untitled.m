% SEGMENTATION
name1=('log4_kusum_midpace_del1.csv')
[timeL,LX,LY,LZ] = getDataa1(name1);
pplot(timeL,LX,LY,LZ,'LA');
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

xa_scaled1=LX(kior:round((kior+ioi_ind)/2));ya_scaled1=LY(kior:round((kior+ioi_ind)/2));za_scaled1=LZ(kior:round((kior+ioi_ind)/2)); %Scaling x,y,z of LA upto delivery time
xa_scaled2=LX(round((kior+ioi_ind)/2):ioi_ind);ya_scaled2=LY(round((kior+ioi_ind)/2):ioi_ind);za_scaled2=LZ(round((kior+ioi_ind)/2):ioi_ind); %Scaling x,y,z of LA upto delivery time


xa_peaks=findpeaks(xa_scaled);ya_peaks=findpeaks(ya_scaled);za_peaks=findpeaks(za_scaled); % find peaks in each x,y,z

xa_peaks1=findpeaks(xa_scaled1);ya_peaks1=findpeaks(ya_scaled1);za_peaks1=findpeaks(za_scaled1); % find peaks in each x,y,z
xa_peaks2=findpeaks(xa_scaled2);ya_peaks2=findpeaks(ya_scaled2);za_peaks2=findpeaks(za_scaled2); % find peaks in each x,y,z

peaka=[size(xa_peaks);size(ya_peaks);size(za_peaks)];           %putting number of peaks in each into an array           

peaka1=[size(xa_peaks1);size(ya_peaks1);size(za_peaks1)];           %putting number of peaks in each into an array           
peaka2=[size(xa_peaks2);size(ya_peaks2);size(za_peaks2)];           %putting number of peaks in each into an array           


np=min(peaka(:,1));                                             %find minimum numebr of peaks

np1=min(peaka1(:,1));                                             %find minimum numebr of peaks
np2=min(peaka2(:,1));                                             %find minimum numebr of peaks

mid=timeL(round((kior+ioi_ind)/2))

Tod=ioi-ior;
Tod1=mid-ior;                                                    %Time of delivery (ms)
Tod2=ioi-mid;

Tpeak=np/Tod;
Tpeaks1=np1/Tod1;                                                  %rps
Tpeaks2=np2/Tod2;                                                  %rps

spin_rate_rpm1=Tpeaks1*60;                                        %rpm
spin_rate_rpm2=Tpeaks2*60;                                        %rpm
spin_rate_rpm=Tpeaks*60;                                        %rpm


spin_rate_dps1=Tpeaks1*360;                                       %dps
spin_rate_dps2=Tpeaks2*360;                                       %dps


io_impact = ioi;
io_release= ior;

delta_T = diff(timeL(kior:ioi_ind));
Vx = xa_scaled(1:end-1).*delta_T*9.81; 
Vy = ya_scaled(1:end-1).*delta_T*9.81;
Vz = za_scaled(1:end-1).*delta_T*9.81;
% Vx = trapz(xa_scaled(1:end))*9.81;
% Vy = trapz(ya_scaled(1:end))*9.81;
% Vz = trapz(za_scaled(1:end))*9.81;
Vx=sum(Vx);
Vy=sum(Vy);
Vz=sum(Vz);
Vr2=res(kior:ioi_ind-1).*delta_T*9.81;

Vres =  sqrt(Vx.^2+Vy.^2+Vz.^2);
Vres*3600/1000
sum(Vr2)*3600/1000
vline(io_impact,'r','point of impact');
vline(io_release,'black','ior');
spin_rate_rpm1
spin_rate_rpm2
spin_rate_rpm