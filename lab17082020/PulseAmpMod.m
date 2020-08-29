%PULSE AMPLITUDE MODULATION PAM
%Written by Debagnik Kar 1804373
clc
close all
clear all
 
t = 1:0.0001:2
f = input('Enter the value of frequency: ')

x=sawtooth(2*pi*f*t)
ts=0.02
%PULSE GENERATION
for k=1:length(t)
  if mod(t(1,k),ts)==0
      pulse(1,k)=1 %PULSE
  else
      pulse(1,k)=0;
  end 
end 
natural_pam = x.*pulse %Natural Pulse amplitude modulation

subplot(5,1,1)
plot(t,x,'r')
xlabel('Time -->')
ylabel('Amplitude -->')
title('Message')
subplot(5,1,2)
plot(t,pulse,'b')
xlabel('Time -->')
ylabel('Amplitude -->')
title('Pulse Signal')
subplot(5,1,3)
plot(t,natural_pam,'g')
xlabel('Time -->')
ylabel('Amplitude -->')
title('Natural PAM')

%FLATTOP PAM
FlatTop_pam =zeros(1,length(t));
k=1;

while k <length(t)
if natural_pam(1,k)~=0
  FlatTop_pam(1,k:k+49)=natural_pam(1,k)*ones(1,50); % pulse duration is 50*0.001
  k=k+49;
else FlatTop_pam(1,k)=0;
  k=k+1;
 end
end

subplot(5,1,4)
plot(t,FlatTop_pam,'k')
xlabel('Time -->')
ylabel('Amplitude -->')
title('Flat top PAM')

%Demodulation
[b,a]=butter(7,0.004)
demod=filter(b,a,FlatTop_pam)
subplot(5,1,5)
plot(t,demod,'c')
xlabel('Time -->')
ylabel('Amplitude -->')
title('Demodulated PAM')