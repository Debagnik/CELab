%Generating a FM Signal and Demodulating it
%Written by Debagnik Kar 1804373

clc;
clear all;
close all;

fc=input('Enter the carrier signal: ');
fm=input('Enter the message signal: ');
mu=input('Modulation index ');

t=linspace(0,1,1000);

c=cos(2*pi*fc*t);%carrier signal
m=sin(2*pi*fm*t);%message signal

subplot(4,1,1);
plot(t,c,'r'); %plotting the carrier signal
ylabel('amplitude');
xlabel('time');
title('Carrier signal');

subplot(4,1,2);
plot(t,m,'g'); %plotting the message signal
ylabel('amplitude');
xlabel('time');
title('Message signal');

y=cos(2*pi*fc*t-(mu*sin(2*pi*fm*t))); % FM Generation

subplot(4,1,3);
plot(t,y,'b'); % Plotting the FM Generation
ylabel('amplitude');
xlabel('time');
title('Frequency Modulated signal');

%FM Demodulation

dem = diff(y);
dem = [0,dem];
rect_dem = abs(dem)

[b,a]=butter(10,0.06);
rec = filter(b,a,rect_dem);

subplot(4,1,4)
plot(t,rec,'k')
xlabel('Time')
ylabel('Amplitude')
title('Demodulated Signal')