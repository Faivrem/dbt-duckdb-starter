with matches as (

  select * from {{ ref('raw_patient_trial_matches') }}

)

, final as (

  select
    patient_id
    , trial_id
    , site_id
    , processedAt as processed_at
    , reviewedAt as reviewed_at
    , enrolledAt as enrolled_at
  from matches

)

select * from final
