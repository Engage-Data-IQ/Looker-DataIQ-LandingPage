
view: headcount {
  derived_table: {
    sql: SELECT
          COALESCE(SUM(Case When Extract(YEAR FROM ( DATE(headcount.CalendarDate) )) =( EXTRACT(YEAR FROM DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY))  ) and EXTRACT(MONTH FROM ( DATE(headcount.CalendarDate) )) =( EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY))  ) and CalendarDate<=( DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY)  ) THEN  headcount.headCount  end ), 0) / NULLIF(IFNULL(COUNT(DISTINCT Case When Extract(YEAR FROM ( DATE(headcount.CalendarDate) )) =( EXTRACT(YEAR FROM DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY))  ) and EXTRACT(MONTH FROM ( DATE(headcount.CalendarDate) )) =( EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY))  ) and CalendarDate<=( DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY)  ) THEN ( DATE(headcount.CalendarDate) ) end ), 0), 0) AS headcount_current_month_average_daily_headcount,
                  (COALESCE(SUM(Case When Extract(YEAR FROM ( DATE(headcount.CalendarDate) )) =( EXTRACT(YEAR FROM DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY))  ) and EXTRACT(MONTH FROM ( DATE(headcount.CalendarDate) )) =( EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY))  ) and CalendarDate<=( DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY)  ) THEN  headcount.headCount  end ), 0) / NULLIF(IFNULL(COUNT(DISTINCT Case When Extract(YEAR FROM ( DATE(headcount.CalendarDate) )) =( EXTRACT(YEAR FROM DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY))  ) and EXTRACT(MONTH FROM ( DATE(headcount.CalendarDate) )) =( EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY))  ) and CalendarDate<=( DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY)  ) THEN ( DATE(headcount.CalendarDate) ) end ), 0), 0) - COALESCE(SUM(case when ( DATE(headcount.CalendarDate) ) >= ( DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 1 MONTH)  ) and ( DATE(headcount.CalendarDate) ) < ( DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 0 MONTH)  ) then  headcount.headCount  end ), 0) / NULLIF(IFNULL(COUNT(DISTINCT case when ( DATE(headcount.CalendarDate) ) >= ( DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 1 MONTH)  ) and ( DATE(headcount.CalendarDate) ) < ( DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 0 MONTH)  ) then ( DATE(headcount.CalendarDate) ) end), 0), 0)) / NULLIF(IFNULL(COALESCE(SUM(case when ( DATE(headcount.CalendarDate) ) >= ( DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 1 MONTH)  ) and ( DATE(headcount.CalendarDate) ) < ( DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 0 MONTH)  ) then  headcount.headCount  end ), 0) / NULLIF(IFNULL(COUNT(DISTINCT case when ( DATE(headcount.CalendarDate) ) >= ( DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 1 MONTH)  ) and ( DATE(headcount.CalendarDate) ) < ( DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 0 MONTH)  ) then ( DATE(headcount.CalendarDate) ) end), 0), 0), 0), 0) AS headcount_month_on_month_average_daily_headcount_percent_change
      FROM `{{_user_attributes['project_id']}}.EdwBI.Employee-HeadCountDailyHR` AS headcount
      WHERE (headcount.AssignmentType) = 'Employee' AND (CASE WHEN (headcount.ParentClientCode IN ('10110','10030','12430') OR headcount.LocationSubsidiary = 'Percepta')
                     THEN 'yes'
                     ELSE 'no'
                END) = 'yes'
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: headcount_current_month_average_daily_headcount {
    type: sum
    sql: ${TABLE}.headcount_current_month_average_daily_headcount ;;
    value_format_name: decimal_2
  }

  measure: headcount_month_on_month_average_daily_headcount_percent_change {
    type: sum
    sql: ${TABLE}.headcount_month_on_month_average_daily_headcount_percent_change ;;
    value_format_name: percent_2
  }

  set: detail {
    fields: [
      headcount_current_month_average_daily_headcount,
      headcount_month_on_month_average_daily_headcount_percent_change
    ]
  }
}
