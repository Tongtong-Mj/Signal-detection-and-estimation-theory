clc
clear all
close all

a=[1 0 1 0 1 1 0 1 0 0 1 1 0 0 0 1 0 1 0 1];
t=0:0.001:0.999;
m=a(ceil(20*t+0.001));
subplot(5,1,1);
plot(t,m);
axis([0,1.2,-0.2,1.2]);
title('��Դ�ź�');

disp('�ز�����Ϊ')         
f=150;
A = 5
carry=cos(2*pi*f*t);
s = A*carry;
st=m.*s;
subplot(5,1,2);
plot(t,st);
axis([0,1.2,-6,6]);
title('�����ź�');

nst=awgn(st,70);

nst=nst.*carry;
subplot(5,1,3);
plot(t,nst);
axis([0,1.2,-1,6]);
title('��������ز�����ź�');

wp=2*pi*2*f*0.5;
ws=2*pi*2*f*0.9;
Rp=2;
As=45;
[N,wc]=buttord(wp,ws,Rp,As,'s');
[B,A]=butter(N,wc,'s');

h=tf(B,A);
dst=lsim(h,nst,t);
subplot(5,1,4);
plot(t,dst);
axis([0,1.2,-1,6]);
title('������ͨ�˲�������ź�');

i = 0;
Num=0;
for k =1:length(dst)
    if dst(k) > 2.0
        Num = Num+dst(k);
        i = i+1;
    end
end
disp('�õ��ز����ȵĹ���Ϊ')
A1 = 2*Num/i

k=0.25;
pdst=A1*(dst>1.25);
subplot(5,1,5);
plot(t,pdst);
axis([0,1.2,-1,6]);
title('���������о�����ź�');