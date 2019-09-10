% coding by- Abhijeet Bhaskar
% Image Steganography using Modified LSB

function [J] = stegancoder(img,msg,enc_key)
% Calculating Header
    msg_temp = double(msg);     % Converts from ASCII to Integer Values.
    msg_dim = num2str(length(msg_temp));
    msg_length = length(msg_dim);
    z = 0;
    if msg_length < 8
        padtext = 8 - msg_length;
        for z = 1:padtext
            msg_dim = horzcat('0',msg_dim);
        end
        msg_head = msg_dim;
        msg_temp_head = horzcat(msg_head,msg_temp);
    end

% Encrypting Using XOR Key
msg_enc = bitxor(uint8(msg_temp_head),uint8(enc_key));

msg_enc_set = dec2bin(msg_enc, 8);

% Preparing Hiding Canvas
img_prep = im2uint8(img);


% Hiding Data
% RGBBGRRG Order
rm = 1; gm = 1; bm = 1;     % Initializing Counters
rn = 1; gn = 1; bn = 1;

[maxM,maxN] = size(img_prep);
z = 0;

run_time = length(msg_enc_set);

for z = 1:run_time;
    temp_code = msg_enc_set(z,:);
    % Bit 1: Red
    if str2double(temp_code(1)) == 0
        img_prep(rm,rn,1) = bitand(img_prep(rm,rn,1),uint8(254));
    else
        img_prep(rm,rn,1) = bitor(img_prep(rm,rn,1),uint8(1));
    end
    
    rm = rm + 1;
    if rm > maxM
        rn = rn + 1;
        rm = 1;
    end
    % Bit 2: Green
    if str2double(temp_code(2)) == 0
        img_prep(gm,gn,2) = bitand(img_prep(gm,gn,2),uint8(254));
    else
        img_prep(gm,gn,2) = bitor(img_prep(gm,gn,2),uint8(1));
    end
    
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
    end
    % Bit 3: Blue
    if str2double(temp_code(3)) == 0
        img_prep(bm,bn,3) = bitand(img_prep(bm,bn,3),uint8(254));
    else
        img_prep(bm,bn,3) = bitor(img_prep(bm,bn,3),uint8(1));
    end
    
    bm = bm + 1;
    if bm > maxM
        bn = bn + 1;
        bm = 1;
    end
    % Bit 4: Blue
    if str2double(temp_code(4)) == 0
        img_prep(bm,bn,3) = bitand(img_prep(bm,bn,3),uint8(254));
    else
        img_prep(bm,bn,3) = bitor(img_prep(bm,bn,3),uint8(1));
    end
    
    bm = bm + 1;
    if bm > maxM
        bn = bn + 1;
        bm = 1;
    end
    % Bit 5: Green
    if str2double(temp_code(5)) == 0
        img_prep(gm,gn,2) = bitand(img_prep(gm,gn,2),uint8(254));
    else
        img_prep(gm,gn,2) = bitor(img_prep(gm,gn,2),uint8(1));
    end
    
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
    end
    % Bit 6: Red
    if str2double(temp_code(6)) == 0
        img_prep(rm,rn,1) = bitand(img_prep(rm,rn,1),uint8(254));
    else
        img_prep(rm,rn,1) = bitor(img_prep(rm,rn,1),uint8(1));
    end
    rm = rm + 1;
    if rm > maxM
        rn = rn + 1;
        rm = 1;
    end
    % Bit 7: Red
    if str2double(temp_code(7)) == 0
        img_prep(rm,rn,1) = bitand(img_prep(rm,rn,1),uint8(254));
    else
        img_prep(rm,rn,1) = bitor(img_prep(rm,rn,1),uint8(1));
    end
    rm = rm + 1;
    if rm > maxM
        rn = rn + 1;
        rm = 1;
    end
    % Bit 8: Green
    if str2double(temp_code(8)) == 0
        img_prep(gm,gn,2) = bitand(img_prep(gm,gn,2),uint8(254));
    else
        img_prep(gm,gn,2) = bitor(img_prep(gm,gn,2),uint8(1));
    end
    
    gm = gm + 1;
    if gm > maxM
        gn = gn + 1;
        gm = 1;
    end
    
end

% Final Output
J = img_prep;       % Final Encoding Output
end