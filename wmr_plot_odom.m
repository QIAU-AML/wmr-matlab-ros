function wmr_plot_odom()
%WMR_PLOT_ODOM Summary of this function goes here
%   Detailed explanation goes here

    try
        ros_master_ip = 'http://192.168.1.20:11311';
        matlab_ip = '192.168.1.22';
        rosinit(ros_master_ip, 'NodeHost', matlab_ip);
        pause(2) % wait a bit the roscore initialization

        r = rosrate(1); % 1 Hz loop rate

        % Odometry
        odom = rossubscriber('/wmr_robot/odometry');

        tic;
        while toc < 10
            odomdata = receive(odom,3);
            pose = odomdata.Pose.Pose;
            x = pose.Position.X;
            y = pose.Position.Y;
            %z = pose.Position.Z;

            odom_pose = [x,y];        
            plot(odom_pose);

        end

        %waitfor(r);
        rosshutdown;
        close all

    catch
        warning('Problem using function.  ROs shutdown.');    
        rosshutdown;
        close all
    end
end

