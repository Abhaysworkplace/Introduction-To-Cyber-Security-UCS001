clc;
clear;
input = imread('flowers.jpeg');
input=rgb2gray(input);
input=imresize(input, [512 512]);
len = length(message) * 8;
ascii_value = uint8(message);
bin_message = transpose(dec2bin(ascii_value, 8));
bin_message = bin_message(:);
N = length(bin_message);
bin_num_message=str2num(bin_message);
output = input;
height = size(input, 1);
width = size(input, 2);
embed_counter = 1;
for i = 1 : height
for j = 1 : width
if(embed_counter<= len)
Bit = de2bi(input(i,j),5);
temp = double(xor(Bit(1), bin_num_message(embed_counter)));
if(temp)
if(Bit(4))
Bit(4)=0;
else
Bit(4)=1;
end
end
output(i,j) = bi2de(Bit);
embed_counter = embed_counter+1;
end
end
end
sum = 0;
for i = 1 : height
for j = 1 : width
sum = sum + (double(input(i,j)) - double(output(i,j)))^2;
end
end
MSE = sum / (height * width);
display(MSE);
imwrite(output, 'OUTPUT_1.jpeg');