function []=GenHis()
L=256;
zd_pdf(1:L)=1;
ext=sin(0:pi/255:pi);
zd_pdf=zd_pdf+ext;
zd_pdf=zd_pdf/sum(zd_pdf);
zd_cdf=zd_pdf*triu(ones(L));
save SpecHist_pdf zd_pdf;
save SpecHist_cdf zd_cdf;

figure(),stem([0:L-1],zd_cdf,'.'),title('SpecHist cdf');
figure(),stem([0:L-1],zd_pdf,'.'),title('SpecHist pdf');