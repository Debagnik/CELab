% Generation of SSB-SC Signal
% Written by Debagnik Kar
clear all
close all
clc

fc = input('Enter the frequency of Carrier: ')
ac = input('Enter the amplitude of Carrier: ')
fm = input('Enter the frequency of Message: ')
am = input('Enter the amplitude of Message: ')

t = linspace(0,1,1000)

m = am*cos(2*pi*fm*t) %Message signal
c = ac*cos(2*pi*fc*t) %carrier Signal

Susb = ((am*ac)/2).*cos(2*pi*(fc+fm)*t) %upper Sideband
Slsb = ((am*ac)/2).*cos(2*pi*(fc-fm)*t) %lower Sideband

subplot(4,1,1)
plot(t,c,'r')
xlabel("Time -->")
ylabel("Amplitude-->")
title("Carrier Wave")

subplot(4,1,2)
plot(t,m,'g')
xlabel("Time -->")
ylabel("Amplitude-->")
title("Message Wave")

subplot(4,1,3)
plot(t,Susb,'b')
xlabel("Time -->")
ylabel("Amplitude-->")
title("Upper Sideband SSB-SC Signal")

subplot(4,1,4)
plot(t,Slsb,'k')
xlabel("Time -->")
ylabel("Amplitude-->")
title("Lower Sideband SSB-SC Signal")