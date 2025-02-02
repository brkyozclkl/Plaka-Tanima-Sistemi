# 🚗 MATLAB Plaka Tanıma Sistemi

<div align="center">

![MATLAB](https://img.shields.io/badge/MATLAB-R2021b+-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![Image Processing](https://img.shields.io/badge/Image%20Processing-Toolbox-orange.svg)
![Status](https://img.shields.io/badge/Status-Stable-success.svg)

<h3>🔍 Görüntü İşleme Tabanlı Otomatik Plaka Tanıma Sistemi</h3>

[Özellikler](#özellikler) •
[Gereksinimler](#gereksinimler) •
[Algoritma](#algoritma-açıklaması) •
[Kullanım](#kullanım) •
[Sonuçlar](#sonuçlar)

<img src="docs/plaka_demo.gif" alt="Plaka Tanıma Demo" width="600"/>

</div>

## ✨ Özellikler

<div align="center">

| 🎯 Özellik | 📝 Açıklama |
|------------|-------------|
| 📸 **Çoklu Format Desteği** | JPG, BMP, PNG, TIF formatlarında görüntü işleme |
| 🔄 **Otomatik Ön İşleme** | Gri seviye dönüşümü ve gürültü temizleme |
| 🎯 **Karakter Segmentasyonu** | Plaka karakterlerinin otomatik ayrıştırılması |
| 🔍 **Karakter Tanıma** | Korelasyon tabanlı OCR işlemi |
| 📝 **Metin Çıktısı** | Tanınan karakterlerin TXT dosyasına kaydı |
| 🖼️ **Görsel Debugger** | Adım adım görsel sonuç gösterimi |

</div>

## 🛠️ Gereksinimler

- MATLAB R2021b veya üzeri
- Image Processing Toolbox
- Yeterli RAM (min. 8GB önerilir)
- Test görüntüleri için yüksek çözünürlüklü kamera

## 🔍 Algoritma Açıklaması

### 1. Ön İşleme Adımları
```matlab
% Görüntü boyutlandırma
goruntu = imresize(goruntu,[300,500]);

% Gri seviyeye dönüştürme
if size(goruntu,3)==3
    goruntu = rgb2gray(goruntu);
end

% Morfolojik işlemler
se = strel('rectangle',[3,3]);
goruntu = imopen(goruntu,se);
```

### 2. Segmentasyon
- Otsu metodu ile eşikleme
- İkili görüntü oluşturma
- Gürültü temizleme
- Karakter bölgelerinin tespiti

### 3. Karakter Tanıma
- Template matching yaklaşımı
- Korelasyon bazlı eşleştirme
- Karakter veritabanı ile karşılaştırma

## 💻 Kullanım

1. MATLAB'i başlatın
2. Kodu çalıştırın
3. Görüntü seçim penceresinden plaka görüntüsünü seçin
4. İşlem adımlarını takip edin
5. Sonuçları `plakaKarakterleri.txt` dosyasında bulun

```matlab
% Örnek kullanım
[dosya,dosyaYolu] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Bir Görüntü Seçin');
goruntu = imread([dosyaYolu,dosya]);
```


## 👨‍💻 Geliştirici

<div align="center">
  
**Berkay Özçelikel**

[![Mail](https://img.shields.io/badge/Mail-D14836?logo=gmail&logoColor=white)](mailto:berkayozcelikel0@gmail.com)

</div>



---

<div align="center">
⭐️ Bu projeyi beğendiyseniz yıldız vermeyi unutmayın!

<i>Bu proje akademik çalışmalar ve araştırma amaçları için geliştirilmiştir.</i>
</div>
