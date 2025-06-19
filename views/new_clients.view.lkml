
view: new_clients {
  derived_table: {
    sql: SELECT distinct
          coalesce(sv.AccountName,sv.OpportunityName)  AS OpportunityName,ClientCode,
              (DATE(sv.CloseDate )) AS CloseDate,
      FROM `{{_user_attributes['project_id']}}.CltTtecSalesMart.Sales_ReportingSalesVolume` AS sv
      WHERE sv.CloseDate >=Date_Trunc(DATE_ADD(CURRENT_DATE(), INTERVAL -45 Day), Year)
       AND (sv.ReportingSegment ) = 'Engage' AND (coalesce(sv.StageName,"NA") ) = '00-Closed - Won'
       and sv.OpportunityType='New Logo Signing'
        AND (coalesce(sv.AccountName,'NA')) not in ('Avtex Solutions LLC')
        and (coalesce(sv.OwnerUsername,'NA')) not in ('Lisa Michael')
        and (coalesce(sv.OpportunityName,'NA')) not in ('Pitney Bowes – Genesys','Avtex Summary*','RFP 22-68650 Contact Center as a Service')
        and (coalesce(sv.BillingType,'NA')) not in ('Renewal', 'Migration','Maintenance')
        Order by CloseDate desc
        Limit 3 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: opportunity_name {
    type: string
    sql: ${TABLE}.OpportunityName ;;
  }

  dimension: client_code {
    type: string
    sql: ${TABLE}.ClientCode ;;
  }

  dimension: close_date {
    type: date
    datatype: date
    sql: ${TABLE}.CloseDate ;;
  }
 measure: new_clients {
hidden: yes
  label: "New Clients"
  type: count_distinct
  sql: ${opportunity_name} ;;
  drill_fields: [opportunity_name]
  html:<span style="font-size:12px;">{{rendered_value}} New Clients 🏆</span> ;;
}
measure: final_new_clients {
  label: "New Clients"
  type: string
  sql:concat(${new_clients}," ","New Clients") ;;
  drill_fields: [opportunity_name]
}


  set: detail {
    fields: [
      opportunity_name,
      client_code,
      close_date
    ]
  }
}
