%Generate a sine wave of f=2Hz for 2secs time stepsize is 0.01
clc;
 clear all;
 close all;

t = 0:0.01:2
x = sin(100*pi*t);

plot(t,x);
hold on
stem(t,x);

