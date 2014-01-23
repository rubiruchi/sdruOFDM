function MACLayerTransmitter(...
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

% This function is called when the node wants to transmit something

% % Sense spectrum and wait until it is unoccupied
% for tries = 1:4 % try only so many times
%     occupied = PHY.Sense;
%     if occupied
%         fprintf('MAC| Spectrum occupied, listening...\n');
%         %Recover signal and/or wait
%         lookingForACK = false;
%         MACLayerReceiver(PHY,lookingForACK);
%     else% Yay we can transmit now
%         break;
%     end    
%     if tries >=4
%         fprintf('MAC| Spectrum Busy, try again later\n');
%         return;
%     end
% end


%% Spectrum clear, send message
for tries = 1:4
    % Send message
    PHYTransmit(...
        ObjSDRuTransmitter,...
        ObjSDRuReceiver,...
        message,...
        tx.samplingFreq...
        );
    % Listen for acknowledgement
    fprintf('###########################################\n');
    fprintf('MAC| Transmission finished, waiting for ACK\n');
    
    % Call Receiver
    lookingForACK = true;
    Response = MACLayerReceiver(...
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
        );

    if strcmp(Response,'ACK')
        fprintf('MAC| Got ACK\n');
        break
    else
        fprintf('MAC| Retransmitting message\n');
    end
    if tries >= 4
        fprintf('MAC| No ACK received :(\n');
        return;
    end 
end


end
