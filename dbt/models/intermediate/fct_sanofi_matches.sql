with matches as (

  select * from {{ ref('stg_patient_trial_matches') }}

)

, trials as (

  select * from {{ ref('stg_trials') }}
  where sponsor_id = '{{ var("sponsor_id", "sp_001") }}'

)

, sites as (

  select * from {{ ref('stg_sites') }}

)

, final as (

  select
    matches.patient_id
    , matches.trial_id
    , trials.sponsor_id
    , matches.site_id
    , trials.trial_name
    , trials.indication
    , trials.phase
    , trials.status
    , sites.country_code
    , sites.country_name
    , matches.processed_at
    , matches.reviewed_at
    , matches.enrolled_at
    , true as is_processed
    , matches.reviewed_at is not null as is_reviewed
    , matches.enrolled_at is not null as is_enrolled
  from matches
  inner join trials on matches.trial_id = trials.trial_id
  left join sites on matches.site_id = sites.site_id

)

select * from final
