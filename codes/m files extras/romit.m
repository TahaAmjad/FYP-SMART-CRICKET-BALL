name1=('gyruMagnoalg_Accel.csv');
name2=('gyruMagnoalg_Gyro.csv');
name3=('gyruMagnoalg_Magn.csv');

[timeA,AX,AY,AZ] = getDataa1(name1);
[timeG,GX,GY,GZ] = getDataa1(name2);
[timeM,MX,MY,MZ] = getDataa1(name3);


res =  sqrt(AX.^2+AY.^2+AZ.^2);                 %Resultant
res2 = abs(AX)+abs(AY)+abs(AZ);%Abs sum resultant

dy = diff(res2);dt = diff(timeA);yu=dy./(dt+0.1);% Calculating derivative yu of Resultant
mul=abs(yu.*res2(2:end));                       %multiplying derivative and resultant = mul
[ioi_value,ioi_ind]=max(mul);                   %Find max of mul ,ioi_value=max value,ioi_ind=index of amx value
ioi=timeA(ioi_ind);                             %Ioi time
scaled_time=ioi-3;                              %Considering time 3s before the Ioi
b=abs(timeA-scaled_time);[scaled_value,scaled_ind]=min(b);%Finding closest value in time array               %
res4=res(scaled_ind:ioi_ind-10);                %Resizing the resultant to 3s before Ioi
[ior_value_r,ior_index_r]=max(res4);            %Finding max in resized res
kior = find(res==ior_value_r);                  %Finding index of max_value in orginal Resultant
ior  = timeA(kior);                             %Calulating Ior time at index of amx_value

xa_preflight=AX(1:kior);ya_preflight=AY(1:kior);za_preflight=AZ(1:kior); %Scaling x,y,z of LA upto delivery time
xa_inflight=AX(kior:ioi_ind);ya_inflight=AY(kior:ioi_ind);za_inflight=AZ(kior:ioi_ind); %Scaling x,y,z of LA upto delivery time
ta_preflight=timeA(1:MagIOR_ind);
ta_inflight=timeA(MagIOR_ind:MagIOI_ind);

xg_preflight=GX(1:kior);yg_preflight=GY(1:kior);zg_preflight=GZ(1:kior); %Scaling x,y,z of LA upto delivery time
xg_inflight=GX(kior:ioi_ind);yg_inflight=GY(kior:ioi_ind);zg_inflight=GZ(kior:ioi_ind); %Scaling x,y,z of LA upto delivery time
tg_preflight=timeG(1:MagIOR_ind);
tg_inflight=timeG(MagIOR_ind:MagIOI_ind);

                           
bB=abs(timeM-ior);[MagIOR_value,MagIOR_ind]=min(bB);
bB2=abs(timeM-ioi);[MagIOI_value,MagIOI_ind]=min(bB2);

xm_preflight=MX(1:MagIOR_ind);ym_preflight=MY(1:MagIOR_ind);zm_preflight=MZ(1:MagIOR_ind); %Scaling x,y,z of LA upto delivery time
xm_inflight=MX(MagIOR_ind:MagIOI_ind);ym_inflight=MY(MagIOR_ind:MagIOI_ind);zm_inflight=MZ(MagIOR_ind:MagIOI_ind); %Scaling x,y,z of LA upto delivery time
tm_preflight=timeM(1:MagIOR_ind);
tm_inflight=timeM(MagIOR_ind:MagIOI_ind);

io_impact = ioi;
io_release= ior;

pplot(timeA,AX,AY,AZ,'Accel');
vline(io_impact,'r','point of impact');
vline(io_release,'black','ior');

figure()
pplot(timeG,GX,GY,GZ,'GYRO');
vline(io_impact,'r','point of impact');
vline(io_release,'black','ior');

figure()
pplot(timeM,MX,MY,MZ,'MAGNETO');
vline(io_impact,'r','point of impact');
vline(io_release,'black','ior');
