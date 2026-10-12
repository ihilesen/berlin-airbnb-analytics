select r.review_id
from {{ ref('fct_reviews') }} r
join {{ ref('dim_listings') }} l using (listing_id)
where r.review_date < cast(l.created_at as date)