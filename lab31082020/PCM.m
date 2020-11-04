%Generation of PCM Signals and Demodulating it
%written by Denagnik 1804373
clc
close all
clear all

n=input('Enter n values for n-bit Pcm system: ')
n1=input('Enter number of samples in a period : ')

%Sampling Operation

x=0:2*pi/n1:4*pi

s=8*sin(x)
subplot 411
plot(s,'r')
axis([0 50 -10 10])
grid on
title('Analog Signal');
ylabel('Amplitude')
xlabel('Time')

subplot 412
stem(s,'y') 
axis([0 50 -10 10])
grid on
title('Sampled Signal')
ylabel('Amplitude')
xlabel('Time')

%Quantization Process
vmax=8
vmin=-vmax
del=(vmax-vmin)/(2^n)
part=vmin:del:vmax
code=vmin-(del/2):del:vmax+(del/2)
[ind,q]=quantiz(s,part,code)

l1=length(ind)
l2=length(q)

for i=1:l1
    if(ind(i)~=0)
        ind(i)=ind(i)-1;
    end
    i=i+1
end 
for i=1:12
    if(q(i)==vmin-(del/2))
        q(i)=vmin+(del/2);
    end
end

subplot 413
stem(q,'b')
grid on
title('Quantized Signal')
ylabel('Amplitude')
xlabel('Time')
axis([0 50 -10 10])
%Encoding process

code=de2bi(ind)

k=1
for i=1:11 
  for j=1:n
    coded(k)=code(i,j);
    j=j+1;
    k=k+1;
  end
  i=i+1;
end


subplot 414
grid on
stairs(coded,'g')
axis([0 180 -0.5 1.5])
grid on
title('Encoded Signal');
ylabel('Amplitude')
xlabel('Time')

%Demodulation of pcm signals

index=bi2de(code)
q=del*index+vmin+(del/2);
figure(2)
subplot 311
plot(s,'k')
axis([0 50 -10 10])
grid on
title('Analog Signal');
ylabel('Amplitude')
xlabel('Time')

subplot 312
grid on
stairs(coded,'c')
axis([0 180 -0.5 1.5])
grid on
title('Encoded Signal');
ylabel('Amplitude')
xlabel('Time')

subplot 313
plot(q,'m')
axis([0 50 -10 10])
grid on
title('Demodulated Signal')
ylabel('Amplitude')
xlabel('Time')
