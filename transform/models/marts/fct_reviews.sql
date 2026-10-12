select
    r.review_id,
    r.listing_id,
    l.host_id,
    r.review_date,
    date_trunc('month', r.review_date)     as review_month,
    lang.review_language,
    r.vendor_sentiment,
    r.is_automated,
    r.is_empty,
    not r.is_automated
        and not r.is_empty
        and r.vendor_sentiment is not null as is_kpi_eligible,
    h.is_superhost
from {{ ref('int_reviews_clean') }} r
left join {{ ref('int_review_language') }} lang using (review_id)
left join {{ ref('stg_listings') }} l using (listing_id)
left join {{ ref('stg_hosts') }} h on l.host_id = h.host_id