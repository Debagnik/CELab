%DSBCS Generation
%Written by Debagnik Kar 1804373

clc; 
clear all; 
close all;
t = linspace(0,4,1000);

fc = input('Enter the carrier frequency: ')
ac = input('Enter the carrier amplitude: ')
fm = input('Enter the message frequency: ')
am = input('Enter the message amplitude: ')

y = am*cos(2*pi*fm*t) %message signal
z = ac*cos(2*pi*fc*t) %carrier signal

w = ((am*ac)/2).*(cos(2*pi*(fc+fm)*t)+cos(2*pi*(fc-fm)*t)) %DSBSC Modulation

subplot(3,1,1)
plot(t,z)
xlabel("time -->")
ylabel("magnitude -->")
title("Carrier Signal")
subplot(3,1,2)
plot(t,y)
xlabel("time -->")
ylabel("magnitude -->")
title("Message Signal")
subplot(3,1,3)
plot(t,w)
xlabel("time -->")
ylabel("magnitude -->")
title("DSBSC Signal")