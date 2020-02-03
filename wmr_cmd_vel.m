%function [outputArg1,outputArg2] = wmr_cmd_vel(Linear_vel , Angular_vel )
%function wmr_cmd_vel(Linear_vel , Angular_vel , topic)
function wmr_cmd_vel(Linear_vel , Angular_vel )
%function [vel_publisher ] = wmr_cmd_vel(Linear_vel , Angular_vel )
%UNTITLED2 Summary of this function goes here
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

    vel_pub = rospublisher( '/cmd_vel' , 'geometry_msgs/Twist' );
    %vel_pub = rospublisher( topic , 'geometry_msgs/Twist' );
    msg = rosmessage(vel_pub);
    msg.Linear.X = Linear_vel ;
    msg.Angular.Z = Angular_vel ;

    send(vel_pub , msg);
    waitfor(r);    
    
    %vel_publisher = vel_pub;
    %msg_pub = msg ;

    rosshutdown;
    
catch
    %warning('Problem using function.  ROs shutdown.');
    rosshutdown;
end


end

