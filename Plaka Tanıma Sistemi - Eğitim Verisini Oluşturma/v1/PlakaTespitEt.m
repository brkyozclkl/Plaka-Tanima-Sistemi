close all; clear all; clc;

load imgfildata

%% kullanýcýya dosya seçtirme iþlemi

[dosya,dosyaYolu] = uigetfile({'*.jpg; *.bmp; *.png; *.tif'},'Bir görüntü seçin');

%%dosya adý tam haliyle oluþturuldu
dosya = [dosyaYolu,dosya];

goruntu = imread(dosya);


[~,boyut] = size(goruntu)

goruntu = imresize(goruntu, [300 500]);
%eðer görüntü renkli görüntüyse gri yap
if size(goruntu,3) == 3

    goruntu = rgb2gray(goruntu)
end


%grilik seviyesini tespit ettik

%%Gabor filtresiyle çok daha saðlýklý sonuçlar alabilirseniz.
threshold = graythresh(goruntu);
%% görüntüyü siyah beyaz yaptýk
goruntu = imbinarize(goruntu,threshold);

goruntuTersi = ~goruntu;
figure,imshow(goruntu),title('Orjinal Görüntü');
figure,imshow(goruntuTersi),title('Görüntünün Tersi');


%% gürültüleri temizle
if boyut > 2000
    %%nesenin boyutu 3500 den büyükse kalsýn deðilse silsin
    goruntu1 = bwareaopen(goruntuTersi,3500)
else
    goruntu1 = bwareaopen(goruntuTersi , 3000)
end
figure,imshow(goruntu1),title('Temizlenmiþ Görüntü');
goruntu2= goruntuTersi- goruntu1;

goruntu2 = bwareaopen(goruntu2,250);
figure,imshow(goruntu2),title('Çýkarýlmýþ Görüntü');

[etiketler ,Nesneler] = bwlabel(goruntu2);
nesneOzellikler = regionprops(etiketler,'BoundingBox');



hold on 

pause(1)

for n =1 : size(nesneOzellikler,1)
    
   
   rectangle('Position',nesneOzellikler(n).BoundingBox, 'EdgeColor','g','LineWidth',2);
   
end
hold off

figure 

% tüm plaka karakterlerini finalCikis deðiþkeninde saklayacaðým
finalCikis = []
%her nesnenin max korelasyon deðerini tutar.
t = []


for n=1 : Nesneler
    %% etiketlenmiþ görüntü de karakter ara
    
    [r,c] = find(etiketler == n)
    karakter = goruntuTersi(min(r) : max(r),min(c):max(c) );
    karakter = imresize(karakter,[42,24]);
    figure,imshow(karakter),title('KARAKTEr');
    
    pause(0.2);
    x=[];
    %%karakter sayýsýný bulduk
    karakterSayisi = size(goruntuler,2)
    
    %%þuan elde ettiðimiz nesnenin veritabanýndaki tüm karakterlerle
    %%kýyaslamasýný yapýyoruz ve korelasyon deðerini elde ediyoruz
    for k=1: karakterSayisi
        y=corr2(goruntuler{1,k},karakter)
        x=[x y]
    end
    
    t = [t max(x)];
        %% korelasyon deðerleri 0.4 ün altýnda kalanlarý karakterlikten sil
    if max(x) > 0.4
    enBuyukIndis = find(x==max(x))
    %% hangi karakterle eþleþtiyse max indis deðerine bakar o karakter oalcaktýr
    
    cikisKarakter = cell2mat(goruntuler(2,enBuyukIndis))
    finalCikis = [finalCikis cikisKarakter]    
    end

end
dosyaAdi = 'plakaKarakterleri.txt';
dosya=fopen(dosyaAdi,'wt');
fprintf(dosya,'%s\n',finalCikis);
fclose(dosya);
winopen('plakaKarakterleri.txt');


















