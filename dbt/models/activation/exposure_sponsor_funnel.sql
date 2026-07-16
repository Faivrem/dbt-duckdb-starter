with matches as (

  select * from {{ ref('fct_sanofi_matches') }}

)

, aggregated as (

  select
    trial_id
    , trial_name
    , country_code
    , country_name
    , count(*) as processed_count
    , sum(is_reviewed::int) as reviewed_count
    , sum(is_enrolled::int) as enrolled_count
  from matches
  group by
    trial_id
    , trial_name
    , country_code
    , country_name

)

, final as (

  select
    *
    , reviewed_count / nullif(processed_count, 0) as review_rate
    , enrolled_count / nullif(processed_count, 0) as enrollment_rate
  from aggregated

)

select * from final
