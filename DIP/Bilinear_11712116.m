function []=Bilinear_11712116(input_file,dim)
img=imread(input_file);% read image
[x0,y0]=size(img);% find the size of image and storage to x0,y0 respectively

figure;
imshow(img);% show original image

x=x0/dim(1);
y=y0/dim(2);% computing the ratio of origin size to target image
re_img=zeros(round(dim(1)),round(dim(2)));% new image

for i=1:round(dim(1))
    x1=abs(i*x-floor(i*x));
    x2=floor(i*x);
    if x2>=x0
        x2=x0-1;
    end
    if x2<1
        x2=1;
    end
    % first do linear interpolation in the x-direction
    for j=1:round(dim(2))
        y1=abs(j*y-floor(j*y));
        y2=floor(j*y);
        if y2>=y0
            y2=y0-1;
        end
        if y2<1
            y2=1;
        end
       % interpolating in the y direction
    re_img(i,j)=(1-x1)*(1-y1)*img(x2,y2)+x1*(1-y1)*img(x2+1,y2)+(1-x1)*y1*img(x2,y2+1)+x1*y1*img(x2+1,y2+1);
    % interpolation
    end
end

figure;
re_img=uint8(re_img);%storage gray image to 8 bit matrix
imshow(re_img);

imwrite(re_img,'Shrinked_Bilinear_11712116.tif');%output