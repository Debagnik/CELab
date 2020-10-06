% Generation and demodulation of BFSK signal
% Written by Debagnik Kar 1804373

clc
clear all
close all

%Psuedo-random Message generation in binary

n =input('Enter the no. of bits:    ')
data = randi([0 1], 1, n)

for i=1:n
    if data(i) ==1
        Data(i)=1
    else
        Data(i)=0
    end
end

s = 100
r = 1
t = 0:1/s:n

for j=1:length(t)
    if t(j)<=r
        y(j) = Data(r)
    else
        y(j) = Data(r)
        r = r+1
    end
end

subplot 411
plot(t, y,'b')
axis([0 n -0.5 1.5])
title('Message signal')
ylabel('Amplitude')
xlabel('Time')

%Generation of 2 Carrier signal

f1 = 5
f2 = 10

c1 = cos(2*pi*f1*t)
c2 = cos(2*pi*f2*t)

subplot 412
plot(t, c1, 'g')
axis([0 n -1.5 1.5])
title('Low frequency carrier signal')
ylabel('amplitude')
xlabel('Time')

subplot 413
plot(t, c2, 'm')
axis([0 n -1.5 1.5])
title('High frequency carrier signal')
ylabel('Amplitude')
xlabel('Time')

%Modulation of the message signal to BFSK

for j=1:length(t)
    if y(j)==1
        x(j)=c1(j)
    else
        x(j)=c2(j)
    end
end

subplot 414
plot(t, x, 'k')
axis([0 n -1.5 1.5])
title('Modulated signal')
ylabel('amplitude')
xlabel('Time')

% Demodulation of the BFSK signal

l = x
l1 = l.*c1

Int1 = []
for I=0:s:length(l1)-s
    Int = (1/s)*trapz(l1(I+1:I+s))
    Int1 = [Int1 Int]
end

l2 = l.*c2

Int2 = []
for I=0:s:length(l2)-s
    INT = (1/s)*trapz(l2(I+1:I+s))
    Int2 = [Int2 INT]
end

demod = Int1 - Int2
disp('Detected Bits') 
det = (demod>0) %Recieved bits

figure(2)

subplot 311
plot(t, y, 'r')
title('Message signal')
axis ([0 n -0.5 1.5])
ylabel('Amplitude')
xlabel('Time')

subplot 312
plot(t, x, 'g')
axis([0 n -1.5 1.5])
title('Modulated signal')
ylabel('Amplitude')
xlabel('Time')

subplot 313
stairs(0:n, [det data(n)])
axis ([0 n -0.5 1.5])
title('Demodulated signal')
ylabel('Amplitude')
xlabel('Time')
