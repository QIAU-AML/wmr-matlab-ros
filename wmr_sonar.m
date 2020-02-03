
% function [sonar_data , points] = wmr_sonar()
%function  [sonar_raw , points] = wmr_sonar()
function  sonar_raw  = wmr_sonar()
%WMR_SONAR Summary of this function goes here
%   Detailed explanation goes here

    try
        ros_master_ip = 'http://192.168.1.20:11311';
        matlab_ip = '192.168.1.22';
        rosinit(ros_master_ip, 'NodeHost', matlab_ip);
        pause(2) % wait a bit the roscore initialization

        r = rosrate(1); % 1 Hz loop rate

        % Sonar Sensors
        sonar = rossubscriber('/wmr_robot/sonar_raw');

        sonar_data = receive(sonar,3);
        points = sonar_data.Points;
        
        len = size(points);
        %sonar_raw = zeros(16,1);
        sonar_raw = zeros(len(1),1);
        for i=1 : len(1)
            sonar_raw(i)= points(i).X;
        end   
        
        %waitfor(r);
        rosshutdown    

    catch
        warning('Problem using function.  ROs shutdown.');
        rosshutdown;
    end

end

