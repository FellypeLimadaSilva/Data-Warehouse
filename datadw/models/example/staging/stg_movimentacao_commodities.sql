with source_data as (

    select *
    from {{ source('datadw', 'movimentacao_commodities') }}

),

renamed as (

    select
        data,
        simbolo,
        acao,
        quantidade
    from source_data

)

select * from renamed