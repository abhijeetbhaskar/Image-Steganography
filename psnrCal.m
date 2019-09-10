% coding by- Abhijeet Bhaskar
% Image Steganography using Modified LSB

clc;
[filename1,pathname]=uigetfile('*.*','Select the original image'); 
image1=imread(num2str(filename1));
[filename2,pathname]=uigetfile('*.*','Select the stegano image'); 
image2=imread(num2str(filename2));
figure(1);
imshow(image1); title('Original image'); 
figure(2);
imshow(image2); title('Stegano image');    
[row,col] = size(image1)
size_host = row*col;
o_double = double(image1);
w_double = double(image2);
s=0;
for j = 1:size_host; % the size of the original image
s = s+(w_double(j) - o_double(j))^2 ; 
end
mse=s/size_host
psnr =10*log10((255)^2/mse);
display 'Value of',psnr