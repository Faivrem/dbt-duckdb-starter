with source as (

  select * from {{ ref('raw_sponsors') }}

)

, final as (

  select
    sponsor_id
    , sponsor_name
    , createdAt as created_at
  from source
  where sponsor_id <> 'sp_099'

)

select * from final
