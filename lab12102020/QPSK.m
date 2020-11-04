%Generate and demodulate QPSK Signals
%Written by Debagnik Kar 1804373

clc
clear all
close all

%Generating a psuedo-random number as message signal

n = input('Enter the length of data in bits:    ')
f = input('Enter the frequency of carrier:    ')
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

s1 = 0
s2 = 0
for i = 1:length(data)
    if mod(i,2) == 0
        s1(i) = Data(i)
    elseif mod(i,2) ~= 0
        s2(i) = Data(i)
    end
end

r=1
for j = 1:length(t)
    if t(j) <=r
        Even(j) = s1(r)
    else
        Even(j) = s1(r)
        r = r+1
    end
end

s2 = [s2 0]
r=1

for j = 1:length(t)
    if t(j) <=r
        Odd(j) = s2(r)
    else
        Odd(j) = s2(r)
        r = r+1
    end
end


c1 = Odd.*sin(2*pi*f*t)
c2 = Even.*cos(2*pi*f*t)

subplot 511
plot(t,y)
grid on
title('Message signal')
xlabel('Time')
ylabel('Amplitude')
axis([0 n -1.5 1.5])

subplot 512
plot(t,cos(2*pi*f*t),'k')
grid on
title('Carrier signal')
xlabel('Time')
ylabel('Amplitude')

subplot 513
plot(t,c1,'b')
grid on
title('Odd Phase shift signal')
xlabel('Time')
ylabel('Amplitude')

subplot 514
plot(t,c2,'r')
grid on
title('Even phase shift')
xlabel('Time')
ylabel('Amplitude')

c = c1+c2

subplot 515
plot(t,c,'m')
grid on
title('QPSK Modulated signal')
xlabel('Time')
ylabel('Amplitude')
