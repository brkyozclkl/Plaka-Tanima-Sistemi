close all; clear all; clc;

load imgfildata

%% kullan�c�ya dosya se�tirme i�lemi

[dosya,dosyaYolu] = uigetfile({'*.jpg; *.bmp; *.png; *.tif'},'Bir g�r�nt� se�in');

%%dosya ad� tam haliyle olu�turuldu
dosya = [dosyaYolu,dosya];

goruntu = imread(dosya);


[~,boyut] = size(goruntu)

goruntu = imresize(goruntu, [300 500]);
%e�er g�r�nt� renkli g�r�nt�yse gri yap
if size(goruntu,3) == 3

    goruntu = rgb2gray(goruntu)
end


%grilik seviyesini tespit ettik

%%Gabor filtresiyle �ok daha sa�l�kl� sonu�lar alabilirseniz.
threshold = graythresh(goruntu);
%% g�r�nt�y� siyah beyaz yapt�k
goruntu = imbinarize(goruntu,threshold);

goruntuTersi = ~goruntu;
figure,imshow(goruntu),title('Orjinal G�r�nt�');
figure,imshow(goruntuTersi),title('G�r�nt�n�n Tersi');


%% g�r�lt�leri temizle
if boyut > 2000
    %%nesenin boyutu 3500 den b�y�kse kals�n de�ilse silsin
    goruntu1 = bwareaopen(goruntuTersi,3500)
else
    goruntu1 = bwareaopen(goruntuTersi , 3000)
end
figure,imshow(goruntu1),title('Temizlenmi� G�r�nt�');
goruntu2= goruntuTersi- goruntu1;

goruntu2 = bwareaopen(goruntu2,250);
figure,imshow(goruntu2),title('��kar�lm�� G�r�nt�');

[etiketler ,Nesneler] = bwlabel(goruntu2);
nesneOzellikler = regionprops(etiketler,'BoundingBox');



hold on 

pause(1)

for n =1 : size(nesneOzellikler,1)
    
   
   rectangle('Position',nesneOzellikler(n).BoundingBox, 'EdgeColor','g','LineWidth',2);
   
end
hold off

figure 

% t�m plaka karakterlerini finalCikis de�i�keninde saklayaca��m
finalCikis = []
%her nesnenin max korelasyon de�erini tutar.
t = []


for n=1 : Nesneler
    %% etiketlenmi� g�r�nt� de karakter ara
    
    [r,c] = find(etiketler == n)
    karakter = goruntuTersi(min(r) : max(r),min(c):max(c) );
    karakter = imresize(karakter,[42,24]);
    figure,imshow(karakter),title('KARAKTEr');
    
    pause(0.2);
    x=[];
    %%karakter say�s�n� bulduk
    karakterSayisi = size(goruntuler,2)
    
    %%�uan elde etti�imiz nesnenin veritaban�ndaki t�m karakterlerle
    %%k�yaslamas�n� yap�yoruz ve korelasyon de�erini elde ediyoruz
    for k=1: karakterSayisi
        y=corr2(goruntuler{1,k},karakter)
        x=[x y]
    end
    
    t = [t max(x)];
        %% korelasyon de�erleri 0.4 �n alt�nda kalanlar� karakterlikten sil
    if max(x) > 0.4
    enBuyukIndis = find(x==max(x))
    %% hangi karakterle e�le�tiyse max indis de�erine bakar o karakter oalcakt�r
    
    cikisKarakter = cell2mat(goruntuler(2,enBuyukIndis))
    finalCikis = [finalCikis cikisKarakter]    
    end

end
dosyaAdi = 'plakaKarakterleri.txt';
dosya=fopen(dosyaAdi,'wt');
fprintf(dosya,'%s\n',finalCikis);
fclose(dosya);
winopen('plakaKarakterleri.txt');


















