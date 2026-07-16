with source as (

  select * from {{ ref('raw_sites') }}

)

, final as (

  select
    site_id
    , siteName as site_name
    , countryCode as country_code
    , replace(country_name, 'country: ', '') as country_name
  from source

)

select * from final
