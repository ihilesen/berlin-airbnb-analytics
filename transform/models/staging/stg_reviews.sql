select
    cast(listing_id as bigint)              as listing_id,
    cast(cast("DATE" as timestamp) as date) as review_date,
    reviewer_name,
    comments                                as review_text,
    sentiment                               as vendor_sentiment
from {{ source('raw', 'reviews') }}