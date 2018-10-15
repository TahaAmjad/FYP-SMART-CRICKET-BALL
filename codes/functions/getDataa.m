function [time,w,x,y,z]=getDataa(filename)
fid=fopen(filename);
 readData=textscan(fid,'%f %f %f %f %f','Headerlines',1,'Delimiter',',','EmptyValue',-Inf);
 
 time=readData{1,1}(:,1);
 w=readData{1,2}(:,1);
 x=readData{1,3}(:,1);
 y=readData{1,4}(:,1);
 z=readData{1,5}(:,1);
 fclose('all')
end
