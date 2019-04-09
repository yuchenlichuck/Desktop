function [OutputImage,OutputHist,InputHist]=HistEqu_11712116(InputImage)
img=imread(InputImage);
imshow(img);
[m,n]=size(img);
gp=zeros(1,256);
for k=0:255
    gp(k+1)=length(find(img==k))/(m*n);
end

figure,bar(0:255,gp,'g');
title('inputhist');
xlabel('gray value')
ylabel('possiblity')

s=zeros(1,256);
for i=1:256
    for j=1:i
    s(i)=gp(j)+s(i);
    end
end
s1=round((s*256)+0.5);
for i=1:256
    eq=sum(gp(s1==i));
end

figure,bar(0:255,eq,'b')
title('outputhist')
xlabel('gray value')
ylabel('probability')
pa=img;
for i=0:255
    pa(img==i)=s1(i+1);
end
figure,imshow(pa)
title('outputImage')
imwrite(pa,'Q2_3_2_11712116.tif')
OutputImage=pa;
OutputHist=eq;
InputHist=gp;
        