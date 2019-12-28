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
A=1                         %载波幅度A，可自调
f=150;                      %载波频率

carry=cos(2*pi*f*t);        %设置载波，从要求中知道，这个是已知的，可用来做相关解调
s=A*carry;                  
st=m.*s;
nst=awgn(st,70);            %加性高斯白噪声
nst=nst.*carry;

wp=2*pi*2*f*0.5;                                    
ws=2*pi*2*f*0.9;
Rp=2;
As=45;
[N,wc]=buttord(wp,ws,Rp,As,'s');
[B,A]=butter(N,wc,'s');
h=tf(B,A);                                      %傅里叶变换，乘上两次载波，相当于在频域上对信号进行频谱搬移
dst=lsim(h,nst,t);                              %低通滤波器，信号强度变为原信号的一半

i = 0;
Num = 0;
for k =1:length(dst)
    if dst(k) > 0.4                             %此处的判决门限设置为0.4A（A为前面设置好的载波幅度）
        Num = Num+dst(k);
        i = i+1;
    end
end

disp('可以得到对波形幅度的估计')
A1 = 2*Num/i                                    %对信号中H1部分，进行采样求均值，采样次数为（H1次数乘以分配给的次数）
