%作业：基于卡尔曼滤波的线性时不变信道的估计
%作者：Tongtong-Mj
%时间：2019-12-15

clc
clear all
close all

Ak = exp(-0.02);              
Ck = 1;    
Qk = 1-2*exp(-1)*exp(-0.02) + exp(-0.04);
Rk = 1;  
p(2) = 1; 
p1(2) = Ak*p(2)*Ak'+Qk;             
H(2) = p1(2) * Ck' * inv(Ck*p1(2)*Ck'+Rk);   %初始参数和矩阵

x(1) = 0;    
x(2) = 0;
h = rand(1,3);
v = round(rand(1,25)*10)-5;

N = length(v);                      
 for k = 3 : N 
     y(k) = h(1)*v(k)+h(2)*v(k-1)+h(3)*v(k-2);  %阶数为3（p=3）的观测方程
     y1(k) = awgn(y(k),70);
     p1(k) = Ak*p(k-1)*Ak' + Qk;       
     H(k) = p1(k)*Ck'*inv(Ck*p1(k)*Ck'+Rk);  
     I = eye(size(H(k)));                   
     p(k)=(I-H(k)*Ck)*(p1(k));              
     x(k)=Ak*x(k-1)+H(k)*(y1(k)-Ck*Ak*x(k-1));  
 end 
 
 m = 1:N;   
 plot(m,y1,'-r*',m,x,'-bo');              
 xlabel(' t/s '),ylabel(' y1(t),x(t) ');
 title('x(t)的估计波形与观测值y1(t)波形比较');
 legend(' 观测数据y1(t) ',' 信号估计值x(t) ','Location','northwest');
 grid on;