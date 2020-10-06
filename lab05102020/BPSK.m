%Generate and demodulate BPSK Signals
%Written by Debagnik Kar 1804373

clc
clear all
close all

%Generating a psudo-random number as message signal

n = input('Enter the length of data in bits:    ')
data = randi([0 1], 1, n)

for i=1:length(data)
    if data(i) == 1
        Data(i)=1
    else
        Data(i)= -1
    end
end

r=1
t = 0:0.01:length(data)
for j = 1:length(t)
    if t(j) <=r
        y(j) = Data(r)
    else
        y(j) = Data(r)
        r = r+1
    end
end

subplot 411
plot(t,y,'g')
title('Message Signal')
axis([0 n -1.5 1.5])
grid on
xlabel('Time')
ylabel('Amplitude')

%carrier Signal
fc =20
carrier = cos(2*pi*pi*t)
subplot 412
plot(t, carrier, 'r')
title('Carrier Signal')
axis([0 n -1.5 1.5])
grid on
xlabel('Time')
ylabel('Amplitude')

%Modulation
psk = y.*carrier
subplot 413
plot(t, psk, 'm')
title('Modulated Signal')
axis([0 n -1.5 1.5])
grid on
xlabel('Time')
ylabel('Amplitude')

%Demodulation
for j=1:length(t)
    if psk(j) == carrier(j)
        demod(j) = 1
    else
        demod(j) = 0
    end
end

subplot 414
plot(t,demod)
title('Demodulation Signal')
axis([0 n -0.5 1.5])
grid on
xlabel('Time')
ylabel('Amplitude')