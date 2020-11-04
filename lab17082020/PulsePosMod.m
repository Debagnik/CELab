%PPM Extension Funtion to PWM
%Written By Debagnik Kar

function PulsePosMod(t,pwm,f)
clc
figure(2)
dip=diff(pwm)
dip = [0,dip]
ppm=zeros(1,length(dip))
k=1
%Positive edge 
while k<length(dip)
    if dip(1,k) == 2 % take -2 for negative edge triggering
        ppm(1,k:k+9)=ones(1,10) % I took to block
        k=k+10
    else
        k=k+1
    end
end
subplot 311
plot(t,cos(2*pi*f*t),'r')
xlabel('Time -->')
ylabel('Amplitude -->')
title('Message signal')
subplot 312
plot(t,pwm,'c')
axis([0 1 0 2])
xlabel('Time -->')
ylabel('Amplitude -->')
title('PWM Signal')
subplot 313
plot(t,ppm,'g')
axis([0 1 0 2])
xlabel('Time -->')
ylabel('Amplitude -->')
title('PPM Signal')
end