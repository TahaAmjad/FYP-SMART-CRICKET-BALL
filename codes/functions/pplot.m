function [y,res] = pplot(time,x,y,z,value)
plot(time,x)
hold on
plot(time,y)
hold on
plot(time,z)
hold on
res = sqrt(x.^2+y.^2+z.^2);
plot(time,res)
grid on

legend(union('x - ',value,'stable'),union('y -',value,'stable'),union('z - ',value,'stable'),union('res -',value,'stable'))
end