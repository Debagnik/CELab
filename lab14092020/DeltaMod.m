%generation of Delta Modulated Signals
%Written by Debagnik Kar 1804373

clc
close all
clear all

am = 5        %Amplitude
fm = 2        %Frequency of the signal
fs = 1000      %No. Of samples
t = 0:0.001:2  %Time
x = am*sawtooth(2*pi*fm*t,0.5) %Message signal (Sawtooth)

subplot(3,1,1)
plot(t,x,'r')
xlabel('time')
ylabel('Amplitude')
title('Message Signal')

d = (2*pi*am*fm)/fs

%Quantization of the signal

for n=1:length(x)
  if n==1
    e(n)=x(n);
    eq(n)=d*sign(e(n));
    xq(n)=eq(n);
  else
    e(n)=x(n)-xq(n-1);
    eq(n)=d*sign(e(n));
    xq(n)=eq(n)+xq(n-1);
  end
end

subplot(3,1,2)
stairs(t,xq,'b')
hold on
plot(t,x,'y')
hold off
xlabel('time')
ylabel('Amplitude')
title('Quantizad signal')

for i=1:length(x)
    if e(i)>0
        dm(i)=1
    else
        dm(i)=0
    end
    
end

subplot(3,1,3);
stairs(t,dm,'g')
axis([0 2 -1 2])
xlabel('time')
ylabel('amplitude')
title('Delta modulated signal')

%Demodulation




