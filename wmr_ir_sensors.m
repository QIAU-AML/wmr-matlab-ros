function sensor_ir_raw = wmr_ir_sensors()
%WMR_IR_SENSORS Summary of this function goes here
%   Detailed explanation goes here
    try
        ros_master_ip = 'http://192.168.1.20:11311';
        matlab_ip = '192.168.1.22';
        rosinit(ros_master_ip, 'NodeHost', matlab_ip);
        pause(2) % wait a bit the roscore initialization

        r = rosrate(1); % 1 Hz loop rate

        % IR Sensors
        ir_sensor = rossubscriber('/wmr_robot/ir_raw');

        ir_data = receive(ir_sensor,3);
        points = ir_data.Points;
        
        len = size(points);
        %sensor_ir_raw = zeros(16,1);
        sensor_ir_raw = zeros(len(1),1);
        for i=1 : len(1)
            sensor_ir_raw(i)= points(i).X;
        end   
        
        %waitfor(r);
        rosshutdown    

    catch
        warning('Problem using function.  ROs shutdown.');
        rosshutdown;
    end
    
end

