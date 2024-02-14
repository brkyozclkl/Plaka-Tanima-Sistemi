clc; clear all; close all;

load imgfildata

%%kullanıcaya dosya seçtirme işlemi

[dosya,dosyaYolu] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Bir Görüntü Seçin');

%%dosya adı tam haliyle oluşturuldu
dosya=[dosyaYolu,dosya]

goruntu=imread(dosya);

[~,boyut]=size(goruntu)

goruntu=imresize(goruntu,[300,500]);

%%görüntğ renkli görüntüyse gri yap
if size(goruntu,3)==3
    goruntu=rgb2gray(goruntu)
end  

se=strel('rectangle',[3,3]);
goruntu=imopen(goruntu,se);
figure,imshow(goruntu);
%%grilik seviyesini tespit ettik
threshold=graythresh(goruntu); 
%%görüntüyü siyah beyaz yaptık
goruntu=imbinarize(goruntu,threshold);

goruntuTersi=~goruntu;
figure,imshow(goruntu),title('Orijinal Görüntü');
figure,imshow(goruntuTersi),title('Gorüntünün Tersi ');


%%gürültüleri temizle
if boyut>2000
    %%nesnelerin boyutu 3500den büyükse kalsın değilse silsin
    goruntu1=bwareaopen(goruntuTersi,3500)
else
    goruntu1=bwareaopen(goruntuTersi,3000)
end    
figure,imshow(goruntu1),title('Temizlenmiş Görüntü');
goruntu2=goruntuTersi-goruntu1;

goruntu2=bwareaopen(goruntu2,250);
figure,imshow(goruntu2),title('Çıkarılmış Görüntü');

[etiketler,Nesneler]=bwlabel(goruntu2);
nesneOzellikler=regionprops(etiketler,'BoundingBox');

hold on

pause(1)

for n=1 : size(nesneOzellikler,1)

    rectangle('Position',nesneOzellikler(n).BoundingBox,'EdgeColor','g','LineWidth',2);
end
hold off

figure
%%tüm plaka karakterlerini finalCikis değişkeninde saklayacağım
finalCikis=[]
%%her nesnenin max kolerasyon değerini tutar
t=[]

for n=1:Nesneler
%%etiketlenmiş görüntüde karakter ara

[r,c]=find(etiketler==n);
karakter=goruntuTersi(min(r):max(r),min(c):max(c));
karakter=imresize(karakter,[42,24]);
figure,imshow(karakter),title('KARAKTER');

pause(0.2);
x=[];
%%karakter sayısını bulduk
karakterSayisi=size(goruntuler,2)

%%şu an elde ettiğimiz nesnenin veri tabanındaki tüm karakterlerle
%%kıyaslamasını yapıyoruz ve kolerasyon değerini elde ediyoruz
for k=1:karakterSayisi
    y=corr2(goruntuler{1,k},karakter)
    x=[x y]
end

t=[t max(x)];

if max(x)>0.4
enBuyukIndis=find(x==max(x))
%%hangi karakterle eşleştiyse max indis değerine bakar o karakter
%%olacaktır
cikisKarakter=cell2mat(goruntuler(2,enBuyukIndis))
finalCikis=[finalCikis cikisKarakter]
end

end
dosyaAdi='plakaKarakterleri.txt';
dosya=fopen(dosyaAdi,'wt');
fprintf(dosya,'%s\n',finalCikis);
fclose(dosya);







