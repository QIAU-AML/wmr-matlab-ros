function wmr_plot_laser()
%WMR_PLOT_LASER Summary of this function goes here
%   Detailed explanation goes here

    try
        ros_master_ip = 'http://192.168.1.20:11311';
        matlab_ip = '192.168.1.22';
        rosinit(ros_master_ip, 'NodeHost', matlab_ip);
        pause(2) % wait a bit the roscore initialization

        r = rosrate(1); % 1 Hz loop rate
        
        % Laser Scaner
        laser = rossubscriber('/scan');
        scan = receive(laser,3)
        
        figure
        plot(scan);
        
%         tic;
%         while toc < 10
%           scan = receive(laser,3);
%           plot(scan);
%         end

        %waitfor(r);
        rosshutdown;
        close all

    catch
        warning('Problem using function.  ROs shutdown.');    
        rosshutdown;
        close all
    end
end