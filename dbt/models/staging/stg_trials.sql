with source as (

  select * from {{ ref('raw_trials') }}

)

, final as (

  select
    trial_id
    , sponsor_id
    , trialName as trial_name
    , indication
    , phase
    , status
    , start_date
    , end_date
  from source
  where trial_id <> 'tr_0146'

)

select * from final
