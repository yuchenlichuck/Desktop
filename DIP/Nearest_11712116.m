function []=Nearest_11712116(input_file,dim)
img=imread(input_file); % read image
[x0,y0]=size(img);% find the size of image and storage to x0,y0 respectively

figure;
imshow(img);% show original image

x=x0/dim(1);
y=y0/dim(2);% computing the ratio of origin size to target image
re_img=zeros(round(dim(1)),round(dim(2)));% new image

for i=1:round(dim(1))
    for j=1:round(dim(2))

    tx=round(i*x);
    ty=round(j*y);
    if(tx<1)
        tx=1;
    end
    if(tx>x0)
        tx=x0;
    end
    if(ty<1)
        ty=1;
    end
    if(ty>y0)
        ty=y0;
    end
    % avoid tx,ty out of bound
    re_img(i,j)=img(tx,ty);
    % interpolation
    end
end

figure;
re_img=uint8(re_img);
imshow(re_img);%storage gray image to 8 bit matrix

imwrite(re_img,'Shrinked_Nearest_11712116.tif'); %output