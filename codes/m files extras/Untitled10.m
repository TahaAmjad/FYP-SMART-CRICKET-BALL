clc;clear all;close all;  %clearing data and command windows and closing all open figure
[timea,xa,ya,za]=getDataa1('test_LA.csv');      %Load Linear Accelaration Data
[timee,xe,ye,ze]=getDataa1('test_Euler.csv');   %Load Euler Angles Data
res =  sqrt(xa.^2+ya.^2+za.^2);                 %Resultant
res2 = abs(xa)+abs(ya)+abs(za);                 %Abs sum resultant
dy = diff(res2);dt = diff(timea);yu=dy./(dt+0.001);% Calculating derivative yu of Resultant
mul=abs(yu.*res2(2:end));                       %multiplying derivative and resultant = mul
[ioi_value,ioi_ind]=max(mul);                   %Find max of mul ,ioi_value=max value,ioi_ind=index of amx value
ioi=timea(ioi_ind);                             %Ioi time
scaled_time=ioi-3;                              %Considering time 3s before the Ioi
b=abs(timea-scaled_time);[scaled_value,scaled_ind]=min(b);%Finding closest value in time array               %
res4=res(scaled_ind:ioi_ind-10);                %Resizing the resultant to 3s before Ioi
[ior_value_r,ior_index_r]=max(res4);            %Finding max in resized res
kior = find(res==ior_value_r);                  %Finding index of max_value in orginal Resultant
ior  = timea(kior);                             %Calulating Ior time at index of amx_value
% plot(timea,res);
% vline(ioi,'r','point of impact');
% vline(ior,'black','ior');
xa_scaled=xa(kior:ioi_ind);ya_scaled=ya(kior:ioi_ind);za_scaled=za(kior:ioi_ind); %Scaling x,y,z of LA upto delivery time
% figure()
% plot(timea(kior:ioi_ind),xa_scaled);
% hold on
% plot(timea(kior:ioi_ind),ya_scaled);
% hold on
% plot(timea(kior:ioi_ind),za_scaled);
[xa_peaks,xa_locs]=findpeaks(xa_scaled);[ya_peaks,ya_locs]=findpeaks(ya_scaled);[za_peaks,za_locs]=findpeaks(za_scaled); % find peaks in each x,y,z

% figure()
% findpeaks(xa_scaled);
% hold on
% findpeaks(ya_scaled);
% hold on
% findpeaks(za_scaled);

peaka=[size(xa_peaks);size(ya_peaks);size(za_peaks)];           %putting number of peaks in each into an array           
np=min(peaka(:,1));                                             %find minimum numebr of peaks

Tod=ioi-ior;                                                    %Time of delivery (ms)

Tpeaks=np/Tod;                                                  %rps

spin_rate_rpm=Tpeaks*60;                                        %rpm

spin_rate_dps=Tpeaks*360;                                       %dps

% figure()
% pplot(timea,xa,ya,za,'LA');
% vline(ioi,'r','point of impact');
% vline(ior,'black','ior');
% figure()
% pplot(timee,xe,ye,ze,'Euler');
% vline(ioi,'r','point of impact');
% vline(ior,'black','ior');
% 
% display('spin rate rpm :')
% display(spin_rate_rpm)
% display('spin rate dps :')
% display(spin_rate_dps)
