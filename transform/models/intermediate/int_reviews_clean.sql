with numbered as (
    select
        *,
        row_number() over (
            partition by listing_id, review_date, reviewer_name, review_text
            order by listing_id
        ) as copy_number
    from {{ ref('stg_reviews') }}
)

select
    md5(concat_ws('|', listing_id, review_date, reviewer_name, coalesce(review_text, ''))) as review_id,
    listing_id,
    review_date,
    reviewer_name,
    trim(regexp_replace(review_text, '\bbr\b', ' ', 'g'))   as review_text,
    coalesce(review_text ilike '%automated posting%', false) as is_automated,
    coalesce(trim(review_text), '') = ''                     as is_empty,
    vendor_sentiment
from numbered
where copy_number = 1