function [OutputImage,OutputHist,InputHist]=HistMatch_11712116(InputImage,SpecHist)
colormap('gray'); 
x0=imread(InputImage);
x0=double(x0);
L=256;
[m,n]=size(x0);
len=m*n;
x=reshape(x0,len,1);

x_pdf=hist(x,[0:L-1]);

x_pdf=x_pdf/len;
sk=x_pdf*triu(ones(L));
zk=load(SpecHist,'zd_cdf');
zk=zk.zd_cdf;

map=zeros(256);
z0=zeros(m,n);
for i=1:L
    for j=map(i)+1:L
        if (zk(j)-sk(i))>=0
            map(i)=j;
            list=find(x0==i-1);
            a=size(list)
            z0(list)=j;
            break;
        end
    end
end
z=reshape(z0,len,1);
z_pdf=hist(z,[0:L-1])/len;

figure(1),subplot(3,1,1),stem([0:L-1],x_pdf,'.'),title('histogram, original');
subplot(3,1,2),stem([0:L-1],zk,'.'),title('transformation');
subplot(3,1,3),stem([0:L-1],z_pdf,'.'),title('histogram,matched');



colormap('gray'); 
image(z0);
z0=uint8(z0);
imwrite(z0,'Q2_2_11712116.tif')
figure(2),imshow(z0);

OutputImage=z0;
OutputHist=z_pdf;
InputHist=x_pdf;


