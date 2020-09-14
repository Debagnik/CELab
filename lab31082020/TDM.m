%Generation of Time domain Multiplexing(TDM)
%Written by Debagnik Kar 1804373

clc
clear all
close all

f1=700
f2=50
s=0.005 %sampling rate

x=pulstran(0:1/f1:1,0:1/f2:1,'rectpuls',s)
y=(1/2)*pulstran(0:1/f1:1,0.01:1/f2:1,'rectpuls',s)
t=0:1/f1:1

subplot 411
plot(t,x)
title('Train of pulse [1]')
ylabel('Amplitude')
xlabel('Time')
subplot 412
plot (t,y,'r')
title('Train of pulse [2]')
ylabel('Amplitude')
xlabel('Time')

%message signal 
y1=20*sin(2*pi*2*t)
y2=20*sin(2*pi*4*t)
subplot 413
plot(t,y1,'g')
hold on
plot(t,y2,'r')
ylabel('Amplitude')
xlabel('Time')
title('message signal')

Pam1=x.*y1
Pam2=y.*y2
y3=Pam1+Pam2

subplot(4,1,4)
plot(t,y3,'k')
title('Tdm signals')
ylabel('Amplitude')
xlabel('Time')

figure(2)
demux=y3.*x
[b,a]=butter(7,0.02)
s1=filter(b,a,demux)
subplot 313
plot(t,s1,'g')
hold on
title('Demuxed and demodulated signal')
demux2=y3.*y
[b,a]=butter(7,0.02);
s2=filter(b,a,demux2)
plot(t,s2,'r');
hold off
ylabel('Amplitude')
xlabel('Time')

subplot 311
plot(t,y1,'g')
hold on
plot(t,y2,'r')
ylabel('Amplitude')
xlabel('Time')
title('message signal')

subplot 312
plot(t,y3)
ylabel('Amplitude')
xlabel('Time')
title('TDM signal')