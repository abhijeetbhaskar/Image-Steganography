% coding by- Abhijeet Bhaskar
% Image Steganography using Modified LSB

function [msg] = stegandecoder(img,enc_key)

    rm = 1; gm = 1; bm = 1;     % Initializing Counters
    rn = 1; gn = 1; bn = 1;

    header = [];
    [maxM, maxN] = size(img);

    for z = 1:8;
        temp = zeros(1,8);
        % Red    
        temp(1,1) = mod(img(rm,rn,1),2);    
        rm = rm + 1;
   
        if rm > maxM
            rn = rn + 1;
            rm = 1;
            if rn > maxN
                break
            end
        end
        % Green
        temp(1,2) = mod(img(gm,gn,2),2);
        gm = gm + 1;
        if gm > maxM
            gn = gn + 1;
            gm = 1;
            if gn > maxN
                break
            end
        end
        % Blue
        temp(1,3) = mod(img(bm,bn,3),2);
        bm = bm + 1;
        if bm > maxM
            bn = bn + 1;
            bm = 1;
        end
        % Blue
        temp(1,4) = mod(img(bm,bn,3),2);
        bm = bm + 1;
        if bm > maxM
            bn = bn + 1;
            bm = 1;
        end
        % Green
        temp(1,5) = mod(img(gm,gn,2),2);
        gm = gm + 1;
        if gm > maxM
            gn = gn + 1;
            gm = 1;
            if gn > maxN
                break
            end
        end
        % Red    
        temp(1,6) = mod(img(rm,rn,1),2);    
        rm = rm + 1;
        if rm > maxM
            rn = rn + 1;
            rm = 1;
            if rn > maxN
                break
            end
        end
        % Red    
        temp(1,7) = mod(img(rm,rn,1),2);    
        rm = rm + 1;
        if rm > maxM
            rn = rn + 1;
            rm = 1;
            if rn > maxN
                break
            end
        end
        % Green
        temp(1,8) = mod(img(gm,gn,2),2);
        gm = gm + 1;
        if gm > maxM
            gn = gn + 1;
            gm = 1;
            if gn > maxN
                break
            end
        end      
        tempstr = num2str(temp);
        header = vertcat(header,tempstr);
    end

    % Header Analysis - Decrypt and Determine Message Dimensions
   
    msg_head_set = bin2dec(header);
    temp_head = bitxor(uint8(msg_head_set),uint8(enc_key));


        dim1 = char(temp_head(1:8));
        m = str2double(dim1);
        n = 1;    
   
   


% Retrieve Secret Message
z = 0;

enc_msg = [];
stopmax = (m * n);

for z = 1:stopmax
    temp = zeros(1,8);
    % Red    
    temp(1,1) = mod(img(rm,rn,1),2);    
    rm = rm + 1;
    if rm > maxM
        rn = rn + 1;
        rm = 1;
        if rn > maxN
            break
        end
    end
    % Green
    temp(1,2) = mod(img(gm,gn,2),2);
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
        if gn > maxN
            break
        end
    end
    % Blue
    temp(1,3) = mod(img(bm,bn,3),2);
    bm = bm + 1;
    if bm > maxM
        bn = bn + 1;
        bm = 1;
    end
    % Blue
    temp(1,4) = mod(img(bm,bn,3),2);
    bm = bm + 1;
    if bm > maxM
        bn = bn + 1;
        bm = 1;
    end
    % Green
    temp(1,5) = mod(img(gm,gn,2),2);
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
        if gn > maxN
            break
        end
    end
    % Red    
    temp(1,6) = mod(img(rm,rn,1),2);    
    rm = rm + 1;
    if rm > maxM
        rn = rn + 1;
        rm = 1;
        if rn > maxN
            break
        end
    end
    % Red    
    temp(1,7) = mod(img(rm,rn,1),2);    
    rm = rm + 1;
    if rm > maxM
        rn = rn + 1;
        rm = 1;
        if rn > maxN
            break
        end
    end
    % Green
    temp(1,8) = mod(img(gm,gn,2),2);
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
        if gn > maxN
            break
        end
    end      
    tempstr = num2str(temp);
    enc_msg = vertcat(enc_msg,tempstr);
end

% Decryption Step
msg_dec_set = bin2dec(enc_msg);
msg_dec = bitxor(uint8(msg_dec_set),uint8(enc_key));


% Message Prep

    msg_set = msg_dec;
    msg_out = char(msg_set');


% Final Output
msg = msg_out;
end
