% coding by- Abhijeet Bhaskar
% Image Steganography using Modified LSB

function [output] = steganography()


% Determine Whether User is Encoding or Decoding a Message
enc_dec = input('Welcome to the Steganography Program \nEnter 1 for Encoding, 2 for Decoding:\n');

if enc_dec == 1
    % ENCODING VERSION
   
    % First Get "Canvas" Image.
    [FileName,PathName] = uigetfile({'*.jpg';'*.png';'*.gif';'*.bmp'},'Select "Canvas Image" to Hide Message.');
    img = imread( strcat(PathName,FileName) );
    
    % get Message File
  
    [FileName,PathName] = uigetfile('*.txt','Select TEXT MESSAGE.');
    testmsg = fopen( strcat(PathName,FileName) );
    [msg] = fscanf(testmsg,'%c');
  
    
    % Ask User for Encryption Key
    enc_key = input('Please Enter an Encryption Key Between 0 - 255:\n');
    if enc_key < 0 || enc_key > 255
        error('Invalid Key Selection');
    end
    
    enc_key = uint8(enc_key);
    
   
   output = stegancoder(img,msg,enc_key);
    
    
    % Write Canvas Image to .BMP File
    
    secfn = input('Enter File Name for Image + Message:\n','s');
    nametest = ischar(secfn);
    if nametest == 1
        imwrite(output,strcat(secfn,'.bmp'));
    else
        error('Invalid File Name');
    end
    
elseif enc_dec == 2
    % DECODING VERSION
    % Import "Canvas Image" With Hidden Message.
    [FileName,PathName] = uigetfile('*.bmp','Select "Canvas Image" With Hidden Message.');
    img = imread( strcat(PathName,FileName) );
    
    % Ask User for Encryption Key
    enc_key = input('Please Enter an Encryption Key Between 0 - 255:\n');
    if enc_key < 0 || enc_key > 255
        error('Invalid Key Selection');
    end
    
    enc_key = uint8(enc_key);
    
   
    output = stegandecoder(img,enc_key);
    

    % Writing Message to .TXT File
    secfn = input('Enter File Name for Image + Message:\n','s')
           
    fid = fopen(strcat(secfn,'.txt'),'w');
    fwrite(fid,output,'char');
    fclose(fid);
       
   
    
else
    error('Invalid Selection');
end






