with source_data as (
    select
        "Date",
        "Close",
        "simbolo"
    from {{ source('datadw', 'commodities') }}
),

renamed as (
    select
        cast("Date" as date) as data,
        "Close" as valor_fechamento,
        "simbolo"
    from source_data
)

select * from renamed