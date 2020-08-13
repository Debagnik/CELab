%generating user defined AM Signals
%Written By Debagnik Kar 1804373

clc;
clear all;
close all;

t = linspace(0,1,1000) %Time of 1 secs divided by 1000 times

%Carrier wave
fc = input('Enter fc = ')
ac = input('Enter ac = ')
xc= cos(2*pi*fc*t)

%Message signal
fm = input('Enter fm = ');
am = input('enter am = ');

xm = cos(2*pi*fm*t);

%AMplitude modulation

y = [ac + am*xm].*xc;

%plot AM
subplot(4,1,1)
plot(t,xc);
xlabel("Time -->")
ylabel("Amplitude -->")
title("Carrier Wave")
subplot(4,1,2)
plot(t,xm)
xlabel("Time -->")
ylabel("Amplitude -->")
title("Message Wave")
subplot(4,1,3)
plot(t,y)
xlabel("Time -->")
ylabel("Amplitude -->")
title("Modulated Wave")

%if else statement

mu = am/ac;

if mu==1
    disp('Critical modulation');
elseif mu>1
   disp('Over modulated signal');
elseif mu<1
   disp('under modulated signal');
end

%Demodutating The wave
dm = y.^2;
[b,a] = butter(10,0.1);
xd = filter(b,a,dm);

subplot(4,1,4)
plot(t,xd);
xlabel("Time -->")
ylabel("amplitude")
title("Demodulated Wave")
