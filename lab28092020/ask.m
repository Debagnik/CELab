%generating ASK signal
%Written By Debagnik Kar 1804373

clc
clear all
close all

time = linspace(0,2,5000)

am = input('Enter amplitude of message signal:    ')
fm = input('Enter frequency of message signal:    ')
ac = input('Enter amplitude of carrier signal (more than message):    ')
fc = input('Enter frequency of carrier signal (more than message):    ')

data = am*(square(2*pi*fm*time)+1)

carrier = ac*cos(2*pi*fc*time)

signal = data.*carrier

subplot 311
plot(time, data)
title('message signal')
xlabel('Time')
ylabel('Magnitude')

subplot 312
plot(time, carrier)
title('carrier signal')
xlabel('Time')
ylabel('Magnitude')

subplot 313
plot(time, signal)
title('Modulated signal')
xlabel('Time')
ylabel('Magnitude')

x = abs(signal)

for n = 0:length(signal)
    if x>0
        d(n) = 1
    else
        d(n) = 0
    end
end

figure(2)

subplot 211
plot(time, data)
subplot 212
plot(time,d)



