select
    cast(id as bigint)                                                as listing_id,
    listing_url,
    name                                                              as listing_name,
    room_type,
    cast(minimum_nights as integer)                                   as minimum_nights,
    cast(host_id as bigint)                                           as host_id,
    cast(replace(replace(price, '$', ''), ',', '') as decimal(10, 2)) as price_eur,
    cast(created_at as timestamp)                                     as created_at
from {{ source('raw', 'listings') }}