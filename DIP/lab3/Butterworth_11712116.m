function [image_out] = Butterworth_11712116(image, D0, N)
% Butterworth�˲�������Ƶ��������˲�
% ����Ϊ��Ҫ�����˲��ĻҶ�ͼ��Butterworth�˲����Ľ�ֹƵ��D0������N
% ���Ϊ�˲�֮��ĻҶ�ͼ��
image_in=imread(image);
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
a = D0^(2 * N);
for u = 1 : P
    for v = 1 : Q
        temp = (u-(m+1.0))^2 + (v-(n+1.0))^2;
        Bw(u, v) = 1 / (1 + (temp^N) / a);
    end
end

%�����˲�
G = F1 .* Bw;

% ������Ҷ�任
gp = ifft2(G);

% ����õ���ͼ��
image_out = zeros(m, n, 'uint8');
gp = real(gp);
g = zeros(m, n);
for i = 1 : m
    for j = 1 : n
        g(i, j) = gp(i, j) * (-1)^(i+j);
        
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

figure,imshow(image_out);
name="Butterworth_11712116.tif";
imwrite(image_out,name)

end