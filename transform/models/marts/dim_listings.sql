with review_stats as (
    select
        listing_id,
        count(*)         as review_count,
        min(review_date) as first_review_date,
        max(review_date) as last_review_date
    from {{ ref('int_reviews_clean') }}
    where not is_automated and not is_empty
    group by listing_id
),

data_end as (
    select max(review_date) as last_date from {{ ref('int_reviews_clean') }}
)

select
    l.listing_id,
    l.listing_name,
    l.room_type,
    l.host_id,
    l.price_eur,
    l.minimum_nights,
    l.created_at,
    coalesce(r.review_count, 0) as review_count,
    r.first_review_date,
    r.last_review_date,
    coalesce(r.last_review_date > d.last_date - interval 365 day, false) as is_active_12m,
    case
        when l.price_eur = 0 then 'zero price'
        when l.price_eur > 1000 then 'over 1000'
        else 'ok'
    end as price_flag,
    case
        when l.minimum_nights = 0 then 'zero nights'
        when l.minimum_nights > 365 then 'over a year'
        when l.minimum_nights >= 30 then 'long stay'
        else 'short stay'
    end as stay_type
from {{ ref('stg_listings') }} l
left join review_stats r using (listing_id)
cross join data_end d