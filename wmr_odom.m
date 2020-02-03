function [odom_pose , theta] = wmr_odom()
%WMR_ODOM Summary of this function goes here
%   Detailed explanation goes here

try
    ros_master_ip = 'http://192.168.1.20:11311';
    matlab_ip = '192.168.1.22';
    rosinit(ros_master_ip, 'NodeHost', matlab_ip);
    pause(2) % wait a bit the roscore initialization

    %setenv('ROS_MASTER_URI' , 'http://192.168.1.20:11311')
    %rosinit
    %setenv('ROS_MASTER_URI' , 'http://192.168.1.20:11311');

    r = rosrate(1); % 1 Hz loop rate


    % Odometry
    odom = rossubscriber('/wmr_robot/odometry');

    odomdata = receive(odom,3);
    pose = odomdata.Pose.Pose;
    x = pose.Position.X;
    y = pose.Position.Y;
    z = pose.Position.Z;

    odom_pose = [x,y,z];

    quat = pose.Orientation;
    angles = quat2eul([quat.W quat.X quat.Y quat.Z]);
    theta = rad2deg(angles(1));

    waitfor(r);
    rosshutdown    
    
catch
    warning('Problem using function.  ROs shutdown.');
    odom_pose = [];
    theta = [];
    
    rosshutdown;
end


% Laser Scaner
% laser = rossubscriber('/scan');
% scan = receive(laser,3)
% 
% figure
% plot(scan);
% 
% tic;
% while toc < 10
%   scan = receive(laser,3);
%   plot(scan);
% end



end

