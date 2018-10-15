function [time,x,y,z]=getDataa1(filename)
fid=fopen(filename);
 readData=textscan(fid,'%f %s %f %f %f %f %f','Headerlines',1,'Delimiter',',','EmptyValue',0);
 time=readData{1,3}(:,1);
 x=readData{1,4}(:,1);
 y=readData{1,5}(:,1);
 z=readData{1,6}(:,1);
 fclose('all')
end
