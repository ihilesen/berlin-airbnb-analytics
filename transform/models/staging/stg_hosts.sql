select
    cast(id as bigint)            as host_id,
    nullif(trim(name), '')        as host_name,
    case is_superhost
        when 't' then true
        when 'f' then false
    end                           as is_superhost,
    cast(created_at as timestamp) as first_listing_at
from {{ source('raw', 'hosts') }}