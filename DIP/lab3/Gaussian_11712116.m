function []= Gaussian_11712116(D0)
image_in = imread('Q3_2.tif');
[m, n] = size(image_in);
P = 2 * m;
Q = 2 * n;

fp = zeros(P, Q);
%��ͼ�����0,���ҳ���(-1)^(x+y) ���Ƶ��任����
for i = 1 : m
    for j = 1 : n
        fp(i, j) = double(image_in(i, j)) * (-1)^(i+j);
    end
end
% �������ͼ����и���Ҷ�任
F1 = fft2(fp);

% ����Butterworth�˲�������������(m+1,n+1)
Bw = zeros(P, Q);
for u = 1 : P
    for v = 1 : Q
        temp = sqrt((u-(m+1.0))^2 + (v-(n+1.0))^2);
        if  temp>D0
            Bw(u, v) = 1;
        end
    end
end

C=2*D0*D0;
Bh = zeros(P, Q);
for u = 1 : P
    for v = 1 : Q
        temp = (u-(m+1.0))^2 + (v-(n+1.0))^2;
        Bh(u, v) = exp(-temp/C);
     
    end
end


%�����˲�
G = F1 .* Bw;
G1=F1 .* Bh;
% ������Ҷ�任
gp = ifft2(G);
gh = ifft2(G1);
% ����õ���ͼ��
image_out = zeros(m, n, 'uint8');
image_out_high=zeros(m, n, 'uint8');
gp = real(gp);
gh = real(gh);
g = zeros(m, n);
g1 = zeros(m, n);
for i = 1 : m
    for j = 1 : n
        g(i, j) = gp(i, j) * (-1)^(i+j);
        g1(i, j) = gh(i, j) * (-1)^(i+j);
    end
end
mmax = max(g(:));
mmin = min(g(:));
range = mmax-mmin;
for i = 1 : m
    for j = 1 : n
        image_out(i,j) = uint8(255 * (g(i, j)-mmin) / range);
    end
end


mmax = max(g1(:));
mmin = min(g1(:));
range = mmax-mmin;
for i = 1 : m
    for j = 1 : n
        image_out_high(i,j) = uint8(255 * (g1(i, j)-mmin) / range);
    end
end
figure,imshow(image_out);
name=sprintf("Gaussian_11712116_low_%d.tif",D0);
imwrite(image_out,name)

figure,imshow(image_out_high);
name=sprintf("Gaussian_11712116_high_%d.tif",D0);
imwrite(image_out,name)
end
