with source as (

  select * from {{ ref('raw_patient_trial_matches') }}

)

, renamed as (

  select
    patient_id
    , trial_id
    , replace(site_id, 'SITE-', '') as site_id
    , cast(processedAt as timestamp) as processed_at
    , cast(reviewedAt as timestamp) as reviewed_at
    , cast(enrolledAt as timestamp) as enrolled_at
  from source
  where patient_id like 'pat\_%' escape '\'

)

, final as (

  select *
  from renamed
  qualify row_number() over (
    partition by patient_id, trial_id
    order by enrolled_at desc nulls last,
             reviewed_at desc nulls last,
             processed_at desc
  ) = 1

)

select * from final
