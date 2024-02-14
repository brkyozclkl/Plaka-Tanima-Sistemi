clc; clear; close all;
%% dizini matlab ortamýna import ettik (dahil ettik)
dizin = dir('EgitimGoruntuleri');

%%dosyanýn adlarýný alalým
dosyaAdlari = {dizin.name};

%%görüntüleri alýyoruz fakat 3'ten baslamamýz gerekiyor
dosyaAdlari = dosyaAdlari (3:end);


%2 satýr 62 sütunlu (kaç tane dosya varsa) bir cell veri tipi olusturacak
goruntuler = cell(2,length(dosyaAdlari));

for i=1:length(dosyaAdlari)
    
    %%otomatik olarak her seferinde i degeri artacagi icin bir sonrakinin
    %%ismi gelecek ve goruntuler cell degerine aktarýlacak
    goruntuler(1,i) = {imread(['EgitimGoruntuleri','\',cell2mat(dosyaAdlari(i))])};
    
    
    
    gecici = cell2mat(dosyaAdlari(i));
    
    goruntuler(2,i) = {gecici(1)};
    
    
end

save('imgfildata.mat','goruntuler')
clear;


