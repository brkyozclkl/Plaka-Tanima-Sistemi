clc; clear all; close all;

%%dizini matlab ortamına import ettik(dahil ettik)
dizin = dir("EgitimGoruntuleri");

%%dosyanın adlarını alalım
dosyaAdlari = {dizin.name};

%%görüntüleri alıyoruz fakat artık 3ten başlıyoruz
dosyaAdlari = dosyaAdlari(3:end);

%%2 satır 32 sütunlu(kaç tane dosya varsa) bir cell veri tipi oluşturcak
goruntuler = cell(2,length(dosyaAdlari));

for i=1:length(dosyaAdlari)
    
    %%otomatik olarak her seferinde i değeri artacağı için bir sonrakinin
    %%ismi gelecek ve görüntüler cell değerine aktarılacak
    goruntuler(1,i)={imread(['EgitimGoruntuleri','\',cell2mat(dosyaAdlari(i))])};


    gecici = cell2mat(dosyaAdlari(i));

    goruntuler(2,i)= {gecici(1)};



end

save('imgfildata.mat','goruntuler')
clear;


