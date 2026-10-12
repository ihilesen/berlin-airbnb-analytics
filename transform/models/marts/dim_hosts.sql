with listing_counts as (
    select host_id, count(*) as listing_count
    from {{ ref('stg_listings') }}
    group by host_id
)

select
    h.host_id,
    h.host_name,
    h.is_superhost,
    h.first_listing_at,
    coalesce(c.listing_count, 0)     as listing_count,
    coalesce(c.listing_count, 0) > 1 as is_multi_listing_host
from {{ ref('stg_hosts') }} h
left join listing_counts c using (host_id)