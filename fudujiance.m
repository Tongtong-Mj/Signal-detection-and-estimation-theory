clc
close all

a = [1 0 1 0 1 1 0 1 0 0 1 1 0 0 0 1 0 1 0 1];
t = 0:0.001:0.999;
m = a(ceil(20*t+0.001));
subplot(4,1,1);
plot(t,m);
axis([0,1.2,-0.2,1.2]);
title('信源信号');
     
A = round(rand(1,1)*10)-5;
f = 200;
s = cos(2*pi*f*t);
x1 = A*s;
st=m.*x1;
subplot(4,1,2);
plot(t,st);
axis([0,1.2,-6,6]);
title('生成信号');

w = normrnd(0,0.01,1,1000);
x = st+w;
subplot(4,1,3);
plot(t,x);
axis([0,1.2,-6,6]);
title('加上高斯白噪声');

b = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

for i =1:1:20
    Sum = 0;
    for N=1:1:50
        t1 = (i-1)*50+N;
        xiang_guan_qi = s(t1)*x(t1);
        Sum = Sum+xiang_guan_qi;
    end
    
    Sum = Sum^2;
    
    if Sum > 50      %判决门限
        b(i) = 1;
    else
        b(i) = 0;
    end
end

panjue = b(ceil(20*t+0.001));
subplot(4,1,4);
plot(t,panjue);
axis([0,1.2,-0.2,1.2]);
title('判决系统判决幅度未知信号');