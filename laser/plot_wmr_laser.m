
function plot_wmr_laser( )
    global laser_msg;
    
    try
        %ROS_MASTER_URI    ;
        ros_master_ip = 'http://192.168.1.20:11311';
        %ROS_HOSTNAME
        matlab_ip = '192.168.1.22';
        
        %Connect to an external ROS Network, setting ROS_MASTER_URI and
        %ROS_HOSTNAME
        rosinit(ros_master_ip, 'NodeHost', matlab_ip);
        
        pause(2) % wait a bit the roscore initialization
        

        laser_sub = rossubscriber( '/scan', @get_laser );
        r = rosrate(2); % 2 Hz loop rate 
        
        for i=1:50
            plot(laser_msg, 'MaximumRange', 7   ); %Plot laser_msg 
            waitfor(r);
        end
        
        %Shutdown ROS connection
        rosshutdown
        close all 

    catch
        warning('Problem using function.  ROs shutdown.');
        rosshutdown;
        close all
    end
   

end
