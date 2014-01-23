function Response = MACLayerReceiver(...
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
    lookingForACK...
    )

% This function is called when the node is just listening to the spectrum
% waiting for a message to be transmitted to them

%% Listen to the spectrum
Response = DLLayer(...
    ObjAGC,...           %Objects
    ObjSDRuReceiver,...
    ObjDetect,...
    ObjPreambleDemod,...
    ObjDataDemod,...
    estimate,...         %Structs
    tx,...
    timeoutDuration,...  %Values/Vectors
    messageBits...
    );

%% Possible response messages
% 1.) Timeout
% 2.) Some message
if ~strcmp(Response,'Timeout')
    fprintf('###########################################\n');
    fprintf('MAC| Got message: %s\n',Response);
    if ~lookingForACK
        fprintf('MAC| Transmitting ACK\n');
        % Send ACK
        PHYTransmit(...
            ObjSDRuTransmitter,...
            ObjSDRuReceiver,...
            'ACK',...
            tx.samplingFreq...
            );
        
    end
end


end
