%Generation of PWM
%Written by Debagnik Kar 1804373

clc
clear all
close all

fc = input('Carrier frequency in Hz: ') %user input prompt
fm = input('Message Freguency in Hz: ') %user input prompt

t = 0:0.001:1 % TIME

carrier = sawtooth(2*pi*fc*t)

subplot 411
plot(t,carrier,'c')
title('Carrier wave')
xlabel('Time -->')
ylabel('Amplitude -->')

% Modulating waveform
message = cos(2*pi*fm*t)
subplot 412
plot(t,message,'g')
title('Message wave')
xlabel('Time -->')
ylabel('Amplitude -->')

% PWM waveform generation
p=find(carrier>=message)
    pwm(p) = -1
q=find(carrier<message)
     pwm(q) = 1
     
subplot 413
plot(t,pwm,'k')
axis([0 1 0 2])
title('PWM waveform')
xlabel('Time -->')
ylabel('Amplitude -->')

[b, a] = butter(7,0.05)
demod = filter(b,a,pwm)
subplot 414
plot(t,demod,'r')
xlabel('Time -->')
ylabel('Amplitude -->')
title('Demodulated Wave')

prompt = input('Do you want to continue to PPM? (1 - yes/0 - no):  ')
if prompt == 1
    PulsePosMod(t,pwm,fm)
elseif prompt == 0
    disp('Okay!')
    exit()
else
    disp('Wrong choice, Exiting')
    goto(46)
end