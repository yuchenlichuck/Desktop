function [OutputImage]=ReduceSAP_11712116(InputImage,nSize)
    img=imread(InputImage);
    n = nSize(1);
    m=nSize(2);
    [ height, width ] = size(img);
    x1 = double(img);
    x2 = x1;
    for i = 1: height-n+1
        for j = 1:width-m+1
            mb = x1( i:(i+n-1),  j:(j+m-1) );
            mb = mb(:);
            mm = median(mb);
            x2( i+(n-1)/2,  j+(m-1)/2 ) = mm;
        end
    end
    img = uint8(x2);
    figure;
    imshow(img);
    imwrite(img,'Q2_4_11712116.tif');
    OutputImage=img;
    

end