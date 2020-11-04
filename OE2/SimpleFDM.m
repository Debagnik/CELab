%Experiment 10: Open ended 2:
%Application of FDM Multiplexing and Demultiplexing
%Collaboration of Debagnik Kar (1804373) and Sayani Ghoroi (1804406)

clear all
clc
close all

%PARAMETERS

    bandwidth = 4000; % bandwidth for each frequency band in Hz
    media_guard = 300; %
    signal_to_noise_ratio = 20;
    modudation_ssb = 1;% 1 for Single SSB modulation, 0 for AM


%The first signal will be placed in the third channel, the second in the
%fourth and the third in the fifth.

frec_carrier1 = bandwidth*3;% Carrier frequency in Hz
frec_carrier2 = bandwidth*4;
frec_carrier3 = bandwidth*5;

Fs = frec_carrier3*2+5000;


cutoff_freq_passfilter = 2500;


% 1 show graphics, 0 don't
graphics = 1;
% 1 play sounds, 0 don't
sounds = 1;


%Define filters

[B,A] = butter(4,cutoff_freq_passfilter/(Fs/2));
low_pass = @(S) filter(B,A,S); %function handeling filter() in low_pass variable to know more about it go to https://www.mathworks.com/help/matlab/matlab_prog/creating-a-function-handle.html?searchHighlight=function%20handle

[C1,D1] = butter(2,[bandwidth*2+media_guard bandwidth*3-media_guard]/(Fs/2));
band_filter3 = @(S) filter(C1,D1,S);

[C2,D2] = butter(2,[bandwidth*3+media_guard bandwidth*4-media_guard]/(Fs/2));
band_filter4 = @(S) filter(C2,D2,S);

[C3,D3] = butter(2,[bandwidth*4+media_guard bandwidth*5-media_guard]/(Fs/2));
band_filter5 = @(S) filter(C3,D3,S);


%upload the files

[s1, g1] = audioread('1.wav');
len1 = length(s1);

[s2, g2]= audioread('2.wav');
len2 = length(s2);

[s3, g3]= audioread('3.wav'); % you got rick rolled lol in 2020
len3 = length(s3);

[beep, g4]= audioread('beep-8.wav');
playerbeep = audioplayer(beep,44100);


%are truncated to the length of the minor

min_len = min([len1 len2]);

t = linspace(0,5, min_len);

s1 = s1(1:min_len);
s2 = s2(1:min_len);
s3 = s3(1:min_len);


FLAG = input('STEP 1, the signals are reproduced as they arrive');

%playing sounds
 
if (sounds > 0)
    
    player = audioplayer(s1,g1);
    playblocking(player);
    playblocking(playerbeep);

    player2 = audioplayer(s2,g2);
    playblocking(player2);
    playblocking(playerbeep);

    player3 = audioplayer(s3,g3);
    playblocking(player3);

end

FLAG = input('STEP 2, plot the spectra of the signals as they arrive');


if (graphics > 0)
    figure

    esps1=abs(fft(s1));
    subplot(3,1,1),plot(esps1),grid on,zoom,title('Signal Spectrum 1');

    esps2=abs(fft(s2));
    subplot(3,1,2),plot(esps2),grid on,zoom,title('Signal Spectrum 2');

    esps3=abs(fft(s3));
    subplot(3,1,3),plot(esps3),grid on,zoom,title('Signal Spectrum 3');
end;



FLAG = input('STEP 3, Signals are passed through a low pass filter and plotted');

%they go through the low pass filter

s1 = low_pass(s1); %function handling by a variable
s2 = low_pass(s2);
s3 = low_pass(s3);

%Plot

if (graphics > 0)
    figure

    esps1=abs(fft(s1));
    subplot(3,1,1),plot(esps1),grid on,zoom,title('Signal spectrum 1 filtered');

    esps2=abs(fft(s2));
    subplot(3,1,2),plot(esps2),grid on,zoom,title('Signal spectrum 2 filtered');

    esps3=abs(fft(s3));
    subplot(3,1,3),plot(esps3),grid on,zoom,title('Signal spectrum 3 filtered');
end

FLAG = input('STEP 4, reproduce the signals after passing them through the filter');

%Played again

if (sounds > 0)

    playerbeep = audioplayer(beep,44100);

    player = audioplayer(s1,g1);
    playblocking(player);
    playblocking(playerbeep);

    player2 = audioplayer(s2,g2);
    playblocking(player2);
    playblocking(playerbeep);

    player3 = audioplayer(s3,g3);
    playblocking(player3);
    playblocking(playerbeep);

end

FLAG = input('STEP 5, Signals are modulated to different carriers');

%Modulate


if ( modudation_ssb  > 0)
    s1mod = ssbmod(s1,frec_carrier1,Fs);%modulates
    s2mod = ssbmod(s2,frec_carrier2,Fs);%modulates
    s3mod = ssbmod(s3,frec_carrier3,Fs);%modulates
else
    s1mod = ammod(s1,frec_carrier1,Fs);%modulates
    s2mod = ammod(s2,frec_carrier2,Fs);%modulates
    s3mod = ammod(s3,frec_carrier3,Fs);%modulates
end

%plotted

if (graphics > 0)
    
    figure

    esps1=abs(fft(s1mod));
    subplot(3,1,1),plot(esps1),grid on,zoom,title('Signal spectrum1 modulated');

    esps2=abs(fft(s2mod));
    subplot(3,1,2),plot(esps2),grid on,zoom,title('Signal spectrum2 modulated');

    esps3=abs(fft(s3mod));
    subplot(3,1,3),plot(esps3),grid on,zoom,title('Signal spectrum2 modulated');

end
FLAG = input('STEP 6, The modulated signals are filtered in the determined band and summed');

fs1 = s1mod;
fs2 = s2mod;
fs3 = s3mod;

%added
x = fs1+fs2+fs3;

%plotted again

if (graphics > 0)
    
    figure

    esps1=abs(fft(fs1));
    subplot(4,1,1),plot(esps1),grid on,zoom,title('Signal spectrum1 modulated and filtered');

    esps2=abs(fft(fs2));
    subplot(4,1,2),plot(esps2),grid on,zoom,title('Signal spectrum2 modulated and filtered');

    esps3=abs(fft(fs3));
    subplot(4,1,3),plot(esps3),grid on,zoom,title('Signal spectrum3 modulated and filtered');

    espf=abs(fft(x));
    subplot(4,1,4),plot(espf),grid on,zoom,title('Summed Spectrum')

end


FLAG = input('STEP 7, add some noise to the transmitted signal');

if (graphics > 0)
    
    figure

    esps1=abs(fft(x));
    subplot(2,1,1),plot(esps1),grid on,zoom,title('Full signal spectrum');
    
end 


x = awgn(x, signal_to_noise_ratio );

if (graphics > 0)
   
    esps1=abs(fft(x));
    subplot(2,1,2),plot(esps1),grid on,zoom,title('Full signal spectrum plus some noise'); 
   
end 

FLAG = input('STEP 8, upon arrival each band is filtered');

%signals are received and filtered

demuxs1 = band_filter3(x);

demuxs2 = band_filter4(x);

demuxs3 = band_filter5(x);


%Plotted again

if (graphics > 0)
    
    figure

    esps1=abs(fft(demuxs1));
    subplot(3,1,1),plot(esps1),grid on,zoom,title('Signal spectrum1 filtered');

    esps2=abs(fft(demuxs2));
    subplot(3,1,2),plot(esps2),grid on,zoom,title('Signal spectrum2 filtered');

    esps3=abs(fft(demuxs3));
    subplot(3,1,3),plot(esps3),grid on,zoom,title('Signal spectrum3 filtered');
end

FLAG = input('STEP 9, each recovered band is demodulated to return the signal to the indicated frequency');

%Demodulate
if ( modudation_ssb  > 0)
    demods1 = ssbdemod(demuxs1, frec_carrier1,Fs);
    demods2 = ssbdemod(demuxs2, frec_carrier2,Fs);
    demods3 = ssbdemod(demuxs3, frec_carrier3,Fs);
else
    demods1 = amdemod(demuxs1, frec_carrier1,Fs);
    demods2 = amdemod(demuxs2, frec_carrier2,Fs);
    demods3 = amdemod(demuxs3, frec_carrier3,Fs);
end;

%Plotting

if (graphics > 0)

    figure

    esps1=abs(fft(demods1));
    subplot(3,1,1),plot(esps1),grid on,zoom,title('Demodulated signal1 spectrum');

    esps2=abs(fft(demods2));
    subplot(3,1,2),plot(esps2),grid on,zoom,title('Demodulated signal2 spectrum');

    esps3=abs(fft(demods3));
    subplot(3,1,3),plot(esps3),grid on,zoom,title('Demodulated signal3 spectrum');

end

FLAG = input('STEP 10, the recovered signal is passed through a low pass filter');


%played

demods1 = low_pass(demods1);
demods2 = low_pass(demods2);
demods3 = low_pass(demods3);


if (graphics > 0)
    
    figure

    esps1=abs(fft(demods1));
    subplot(3,1,1),plot(esps1),grid on,zoom,title('Demodulated signal1 spectrum');

    esps2=abs(fft(demods2));
    subplot(3,1,2),plot(esps2),grid on,zoom,title('Demodulated signal2 spectrum');

    esps3=abs(fft(demods3));
    subplot(3,1,3),plot(esps3),grid on,zoom,title('Demodulated signal3 spectrum');

end 

FLAG = input('STEP 11, Signal reproduce the signal after transmission');


player4 = audioplayer(demods1,g2);
playblocking(player4);
playblocking(playerbeep);

player5 = audioplayer(demods2,g2);
playblocking(player5);
playblocking(playerbeep);

player6 = audioplayer(demods3,g3);
playblocking(player6);



