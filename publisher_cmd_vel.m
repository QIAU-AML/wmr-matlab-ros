
function publisher_cmd_vel(Linear_vel , Angular_vel)
%PUBLISHER_CMD_VEL Summary of this function goes here
%   Detailed explanation goes here

try

    ros_master_ip = 'http://192.168.1.20:11311';
    matlab_ip = '192.168.1.22';
    rosinit(ros_master_ip, 'NodeHost', matlab_ip);
    pause(2) % wait a bit the roscore initialization


    vel_pub = rospublisher( '/cmd_vel' , 'geometry_msgs/Twist' );
    %vel_pub = rospublisher( topic , 'geometry_msgs/Twist' );
    %[vel_pub, vel_msg] = rospublisher('/cmd_vel','geometry_msgs/Twist');
    msg = rosmessage(vel_pub);
    msg.Linear.X = Linear_vel ;
    msg.Angular.Z = Angular_vel ;
    %send(vel_pub , msg);

    %vel_publisher = vel_pub;


    r = rosrate(1); % 1 Hz loop rate

    for i = 1:20
        send(vel_pub , msg);
        waitfor(r);
    end

    rosshutdown
    
catch
    %warning('Problem using function.  ROs shutdown.');
    rosshutdown;
end


end

