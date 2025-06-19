#This view is used to get the attrition % in the current year
view: attrition {
  derived_table: {
    sql: SELECT
          COUNT(CASE WHEN ((( case when  (DATE(headcount.TerminationDate)) = (DATE(headcount.CalendarDate)) then 'Yes' else 'No' end )) = 'Yes') THEN 1 ELSE NULL END) AS headcount_total_terminations,
              COALESCE(SUM(headcount.headCount), 0) / NULLIF(IFNULL(COUNT(DISTINCT ( DATE(headcount.CalendarDate))), 0), 0) AS headcount_average_daily_headcount
      FROM `{{_user_attributes['project_id']}}.EdwBI.Employee-HeadCountDailyHR` AS headcount
      WHERE (headcount.AssignmentType) = 'Employee' AND ((( headcount.CalendarDate ) >= ((DATETIME_TRUNC(DATETIME_TRUNC(CURRENT_DATETIME('UTC'), DAY), YEAR))) AND ( headcount.CalendarDate ) < ((DATETIME_ADD(DATETIME_TRUNC(DATETIME_TRUNC(CURRENT_DATETIME('UTC'), DAY), YEAR), INTERVAL 1 YEAR))))) AND (CASE WHEN (headcount.ParentClientCode IN ('10110','10030','12430') OR headcount.LocationSubsidiary = 'Percepta')
                     THEN 'yes'
                     ELSE 'no'
                END) = 'yes' ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: headcount_total_terminations {
    type: sum
    sql: ${TABLE}.headcount_total_terminations ;;
  }


  measure: headcount_average_daily_headcount {
    type: sum
    sql: ${TABLE}.headcount_average_daily_headcount ;;
  }
measure: attrition_percent {
  label: "Attrition %"
  type: number
  sql: ${headcount_total_terminations}/nullif(${headcount_average_daily_headcount},0) ;;
  value_format_name: percent_2
}
  set: detail {
    fields: [
      headcount_total_terminations,
      headcount_average_daily_headcount
    ]
  }
}
