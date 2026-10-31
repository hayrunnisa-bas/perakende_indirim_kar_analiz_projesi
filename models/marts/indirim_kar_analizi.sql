{{ config(materialized='table') }}

with sales as (
    select * from {{ ref('stg_sales_data') }}
),

indirim_karsilastirma as (
    select 
        "Product ID",
        "Category",
        "Discount", -- İndirim oranı/tutarı
        "Price",    -- Birim fiyat
        "Units Sold", -- Satılan adet
        -- Toplam ciro (Satış Adedi * Fiyat)
        ("Units Sold" * "Price") as toplam_ciro,
        -- İndirimin ciroya ve kârlılığa etkisini ölçmek için gruplama yapıyoruz
        case 
            when "Discount" = 0 then 'Indirimsiz'
            when "Discount" > 0 and "Discount" <= 10 then 'Dusuk Indirim (%1 - %10)'
            when "Discount" > 10 then 'Yuksek Indirim (%10 Üstü)'
            else 'Diger'
        end as indirim_grubu
    from sales
)

select 
    indirim_grubu,
    "Category",
    count("Product ID") as toplam_islem_sayisi,
    sum("Units Sold") as toplam_satilan_urun_adedi,
    round(avg("Price"), 2) as ortalama_fiyat,
    round(sum(toplam_ciro), 2) as toplam_ciro
from indirim_karsilastirma
group by 1, 2
order by toplam_ciro desc