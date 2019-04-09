function []=Sobel_11712116()
img=imread('Q3_1.tif');
f=fft2(img);
s=fftshift(log(1+abs(f)));
