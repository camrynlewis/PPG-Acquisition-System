% University of Florida, Herbert Wertheim College of Engineering
% J. Crayton Pruitt Department of Biomedical Engineering
% BME 4503L - Biomedical Instrumentation Lab - Fall2019
% Copyright 2019  Dr. Mansy
% This script continuously reads serial data from the Arduino-Uno board and
% plots it (like an oscilloscope) using a while loop. To quit the loop
% (stop viewing) press ctrl+c
clc; clear;
%% Connect to Arduino
% Use the arduino command to connect to an Arduino device.
if(~exist('a')) a = arduino; end
%% Acquire and display live data
figure
h = animatedline;
ax = gca; ax.YGrid = 'on'; ax.YLim = [0 5];
stop = false; startTime = datetime('now');
while ~stop
    % Read voltage value from pin analog pin A0
    v = readVoltage(a,'A0');
    % Get current time
    t =  datetime('now') - startTime;
    % Add points to animation
    addpoints(h,datenum(t),v)
    % Update axes
    ax.XLim = datenum([t-seconds(15) t]);
    datetick('x','keeplimits')
    drawnow
    % Check stop condition
    % stop = readDigitalPin(a,'D12');
    %% Detect a heartbeat and light an LED using digital pin 13
%     using the writeDigitalPin function.
    if v> 2.66 %find threshold value using serial monitor
        writeDigitalPin(a, 'D13', 1); %turn led on
    else
        writeDigitalPin(a, 'D13', 0); %turn led off
    end
end