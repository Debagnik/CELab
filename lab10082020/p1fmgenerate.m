clc;
clear all;
close all;
% closing and clearing all the previously stored variables and windows.
fc=input('Enter the carrier signal freq in hz,fc=');
fm=input('Enter the modulating signal freq inhz,fm= ');
m1=input('Modulation index= ');
t=linspace(0,1,1000);
c=cos(2*pi*fc*t);%carrier signal
m=sin(2*pi*fm*t);% modulating signal
subplot(3,1,2);
plot(t,c); % plotting the modulated signal
ylabel('amplitude');
xlabel('time');
title('Carrier signal');
subplot(3,1,1);
plot(t,m); %plotting the message signal
ylabel('amplitude');
xlabel('time');
title('Message signal signal');
y=cos(2*pi*fc*t-(m1*cos(2*pi*fm*t))); % FM Generation
subplot(3,1,3);
plot(t,y); % Plotting the FM Generation wrt time
ylabel('amplitude');
xlabel('time');
title('Frequency Modulated signal');
%Written By Debagnik