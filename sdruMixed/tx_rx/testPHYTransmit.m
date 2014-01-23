function testPHYTransmit



[...
    ObjAGC,...           %Objects
    ObjSDRuReceiver,...
    ObjSDRuTransmitter,...
    ObjDetect,...
    ObjPreambleDemod,...
    ObjDataDemod,...
    estimate,...         %Structs
    tx,...
    timeoutDuration,...  %Values/Vectors
    messageBits...
    ] = CreateTXRX;

message = 'Random Message';


for run = 1 : 1e4
    MACLayerTransmitter(...
        ObjAGC,...           %Objects
        ObjSDRuReceiver,...
        ObjSDRuTransmitter,...
        ObjDetect,...
        ObjPreambleDemod,...
        ObjDataDemod,...
        estimate,...         %Structs
        tx,...
        timeoutDuration,...  %Values/Vectors
        messageBits,...
        message...
        )
    
    %Wait some time
    fprintf('TOP| Waiting some time between actions\n');
    Wait(ObjSDRuReceiver,tx.samplingFreq,1e4);
    
    
end


end