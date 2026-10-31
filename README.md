Perakende - İndirim, Kâr ve Stok Analizi Projesi 

Bu proje, **YBS305 İş Zekâsı ve Veri Madenciliği** dersi (Bölüm 1) kapsamında; perakende satış verileri üzerinden veri kalitesi süreçlerini yürütmek, dbt ile katmanlı veri dönüşümleri gerçekleştirmek ve işletme kârlılığını artıran karar destek panoları (Power BI) sunmak amacıyla geliştirilmiştir.

---
Projenin Amacı ve İş Sorusu

**Temel İş Sorusu:**  
> *"Farklı indirim oranları ürün kategorileri bazında toplam ciro ve satış hacmini nasıl etkilemektedir? Yüksek indirimler satış miktarını artırırken kâr marjını eritiyor mu?"*

Bu soruya yanıt vermek adına mağaza satış verileri işlenmiş; indirim oranları gruplandırılarak kategorik ciro ve satış adedi analizleri gerçekleştirilmiştir.

---

Teknoloji Yığını (Tech Stack)

* **Veri Deposu (Data Warehouse):** DuckDB (`nova.duckdb`)
* **ETL & Veri Dönüşümü:** dbt Core + `dbt-duckdb` adaptörü
* **Görselleştirme & İş Zekâsı:** Power BI Desktop (`.pbix`)
* **Veri İşleme Scriptleri:** Python (Pandas, DuckDB)
* **Versiyon Kontrol:** Git & GitHub

---
 Proje Klasör Yapısı

```text
perakende_analiz_projesi/
├── data/                       # Ham veriler (sales_data.csv vb.)
├── models/
│   ├── staging/                # Staging katmanı (stg_*.sql)
│   └── marts/                  # Marts katmanı (indirim_kar_analizi.sql)
│       └── schema.yml          # dbt veri kalitesi testleri ve sütun açıklamaları
├── target/                     # dbt derleme çıktısı ve dokümantasyonu
├── indirim_kar_analizi.csv     # Power BI için aktarılan analiz çıktısı
├── NovaPerakende_Dashboard.pbix # Power BI Dashboard dosyası
├── dbt_project.yml             # dbt konfigürasyon dosyası
└── README.md                   # Proje dokümantasyonu

------------------------------------------------------------------------------------

dbt ETL Katmanları ve Dönüşümler
Projede modern veri mimarisine uygun olarak 2 temel katman inşa edilmiştir:

Staging Katmanı (stg_sales): Ham satış verilerinin temizlendiği, veri tiplerinin düzenlendiği ilk dönüşüm adımıdır.

Marts Katmanı (indirim_kar_analizi): İndirim oranları 4 ana gruba ayrılarak (%0 İndirimsiz, %1-%10 Düşük, %11-%20 Orta, %20+ Yüksek) kategori bazında ciro, toplam satış adedi ve ortalama fiyat metrikleri özetlenmiştir.
 Veri Kalitesi ve dbt Testleri
Veri hattının güvenilirliğini sağlamak için models/marts/schema.yml dosyası üzerinde aşağıdaki veri kalitesi testleri tanımlanmış ve başarıyla doğrulanmıştır (dbt test):

category sütununda not_null testi.

toplam_ciro sütununda not_null testi.

toplam_satilan_urun_adedi sütununda not_null testi.

Power BI Dashboard (Görselleştirme)
Hazırlanan .pbix panosu aşağıdaki görsel ve metrik yapılarını içerir:

KPI Kartları: Toplam Ciro, Toplam Satılan Ürün Adedi ve Ortalama Fiyat.

Sütun Grafiği: İndirim Gruplarına Göre Kategori Bazlı Toplam Ciro Dağılımı.

Çubuk Grafiği: Kategori Bazında Toplam Satış Adetleri.

Dilimleyici (Slicer): İnteraktif Category (Kategori) filtresi.

Analizden Elde Edilen Temel Bulgular:
Düşük İndirim Teşviği (%1 - %10): En yüksek ciro ve satış hacmi düşük indirim grubunda elde edilmektedir.

Kâr Marjı Riski (%20+): Yüksek indirim gruplarında satış adedi artsa dahi birim fiyat düşüşü sebebiyle toplam ciro önemli ölçüde azalmaktadır.