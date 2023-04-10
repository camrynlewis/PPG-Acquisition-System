% University of Florida, Herbert Wertheim College of Engineering
% J. Crayton Pruitt Department of Biomedical Engineering
% BME 4503L - Biomedical Instrumentation Lab - Fall2019
% Copyright 2019  Dr. Mansy
% This script reads serial data from the Arduino-Uno board, collects the data
% in the 'Data' variable and plots it. The script also calculates the
% sampling rate at which the data is collected.
clc; clear;
%% Connect to Arduino
% Use the arduino command to connect to an Arduino device.
if(~exist('a')) a = arduino; end
%% Record data for D seconds
D = 20; % duration D = 30 seconds;
ii = 0;
tic % start timer
while toc < D % keep collecting Data until toc = 30 seconds
    ii = ii + 1;
    % Read voltage value from pin analog pin A0
    v = readVoltage(a,'A0');
    Data(ii) = v;
    t(ii) = toc; %Get time. Change to double if using Matlab 2019b
    t = double(t);
end
% Smooth and plot the data
Data = smooth(Data,10);
%% Plot data vs time
figure(1)
plot(t,Data)
xlabel('Time (seconds)')
ylabel('Voltage (Volts)')
title('Voltage vs. Time')
%% Compute sampling rate (samples per second)in Hz
timeBetweenDataPoints = diff(t);
averageTimePerDataPoint = mean(timeBetweenDataPoints);
dataRateHz = 1/averageTimePerDataPoint;
fprintf('Acquired one data point per %.3f seconds (%.f Hz)\n',averageTimePerDataPoint,dataRateHz)
%% Calculate the heart rate (BPM) from your recorded PPG data
[pks,locs] = findpeaks(Data);
beats = length(locs);
BPM = (beats/D)*60;
%BPM = 62; %change this to the value you have calculated
fprintf('The heart rate is %.f BPM \n',BPM)