%作业：幅度检测
%作者：Tongtong-Mj
%时间：2019-12-15

clc
clear all
close all

a=(sign(randn(1,15))+1)/2;  
t=0:0.001:0.999;
m=a(ceil(15*t+0.01));

disp('载波的幅度')
A=1                         %载波幅度，可自调
f=150;

carry=cos(2*pi*f*t);
s=A*carry;
st=m.*s;
nst=awgn(st,70);
nst=nst.*carry;

wp=2*pi*2*f*0.5;
ws=2*pi*2*f*0.9;
Rp=2;
As=45;
[N,wc]=buttord(wp,ws,Rp,As,'s');
[B,A]=butter(N,wc,'s');
h=tf(B,A);
dst=lsim(h,nst,t);

i = 0;
Num = 0;
for k =1:length(dst)
    if dst(k) > 0.4   
        Num = Num+dst(k);
        i = i+1;
    end
end

disp('可以得到对波形幅度的估计')
A1 = 2*Num/i