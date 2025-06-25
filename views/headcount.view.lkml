# access_grant: can_see_hc_sensitive{
#   user_attribute: can_see_hc_sensitive
#   allowed_values: [ "yes" ]
# }


view: headcount {
  sql_table_name:`{{_user_attributes['project_id']}}.EdwBI.Employee-HeadCountDailyHR`;;

#************************************************************ String Dimensions ***************************************#

  # dimension: key {
  #   type: string
  #   sql: ${TABLE}.RowNumber;;
  #   primary_key: yes
  #   hidden: yes
  # }

  dimension: key {
    type: string
    sql: concat(${employee_number},${calendar_date_date}) ;;
    primary_key: yes
    hidden: yes
  }

  dimension: over_time_hours {
    hidden: yes
    type: number
    sql: ${TABLE}.OverTimeHours ;;
  }

  measure: Sum_of_over_time_hours {
    label: "Over Time Hours"
    type: sum
    sql: ${over_time_hours} ;;
  }

  dimension: employment_category {
    view_label: "Employee"
    description: "Category of employee"
    type: string
    sql: ${TABLE}.EmploymentCategory;;
  }

  dimension: gender {
    view_label: "Employee"
    description: "Gender of Employee"
    type: string
    sql: ${TABLE}.Gender;;
   # ##############required_access_grants: [can_see_hc_sensitive]
  }

  dimension: gcalevel {
    label: "GCA Level"
    view_label: "Employee"
    description: "GCA level of Employee"
    type: string
    sql: ${TABLE}.GCALevel;;
  }

  dimension: job_name {
    label: "GCA Band"
    view_label: "Employee"
    description: "Job Name of Employee"
    type: string
    sql: ${TABLE}.JobName;;
  }

  dimension: job_title {
    view_label: "Employee"
    description: "Job title of Employee"
    type: string
    sql: REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(${TABLE}.JobTitle, "Â",""),"?","–"),"©","éc"),"�","ç"),"Ã³","ó"),"Ã§","ç"),"Ã­","í");;
  }

  dimension: technical {
    view_label: "Employee"
    description: "Employee is technical or not"
    type: string
    sql: ${TABLE}.Technical;;
  }

  dimension: voluntary_termination_status {
    view_label: "Attrition"
    label: "Term Category (Voluntary/Involuntary) Flag"
    description: "Voluntary termination or Resignation"
    type: string
    sql: ${TABLE}.VoluntaryTerminationStatus;;
  }

  dimension: term_reason {
    view_label: "Attrition"
    label: "Termination Reason"
    description: "Reason for termination"
    type: string
    sql: ${TABLE}.TermReason;;
  }

  dimension: term_category {
    type: string
    description: "Category of termination"
    sql: ${TABLE}.TermCategory ;;
  }

  dimension: segment {
    view_label: "Account Ownership"
    description: "Segment details"
    type: string
    sql: ${TABLE}.Segment;;
  }

  dimension: job_family {
    view_label: "Employee"
    description: "Agent/G&A"
    type: string
    sql: ${TABLE}.JobFamily;;
  }

  dimension: management_level {
    label: "Manager Level"
    view_label: "Employee"
    description: "Level of Manager"
    type: string
    sql: ${TABLE}.ManagementLevel;;
  }

  dimension: staffing_ratio {
    label: "Job Staff Ratio"
    view_label: "Headcount"
    group_label: "Client Profile"
    description: "Ratio of staffing"
    type: string
    sql: ${TABLE}.StaffingRatio;;
  }

  dimension: cost_hr_location {
    view_label: "Headcount"
    group_label: "Client Profile"
    description: "Location of HR (Costing)"
    type: string
    sql: ${TABLE}.CostingHRLocation;;
  }

  dimension: ethnicity {
    view_label: "Employee"
    description: "Ethnicity of Employee"
    type: string
    sql: ${TABLE}.Ethnicity;;
    ###############required_access_grants: [can_see_hc_sensitive_data]
  }

  dimension: ethnicity_breakdown {
    description: "Breakdown details of Ethinicity"
    type: string
    sql: ${TABLE}.EthnicityBreakdown ;;
  #  ##############required_access_grants: [can_see_hc_sensitive]
  }

  # dimension: country_name {
  #   view_label: "Headcount"
  #   group_label: "Client Profile"
  #   description: "Name of Country"
  #   label: "Country Code"
  #   type: string
  #   sql:CASE WHEN ${dim_country.country_name} = "United States of America" THEN "United States (US)"
  #     ELSE concat(${dim_country.country_name}, " (",  ${TABLE}.LocationCountry, ")") END;;
  #   map_layer_name: countries
  # }

  # dimension: country{
  #   view_label: "Headcount"
  #   group_label: "Client Profile"
  #   description: "Country Name"
  #   type: string
  #   map_layer_name: countries
  #   sql: CASE WHEN UPPER(${dim_country.country_name}) = "United States of America" THEN "United States"
  #     ELSE ${dim_country.country_name} END;;
  # }

  dimension: business_region_description {
    label: "Region"
    view_label: "Headcount"
    group_label: "Client Profile"
    description: "Region of Business"
    type: string
    sql: ${TABLE}.BusinessRegionDescription;;
  }

  dimension: employee_number {
    view_label: "Employee"
    description: "Employee's Number"
    type: string
    sql: ${TABLE}.EmployeeNumber;;
  }

  dimension: first_name {
    view_label: "Employee"
    description: "First Name of Employee"
    type: string
    sql: ${TABLE}.FirstName;;
  }

  dimension: last_name {
    view_label: "Employee"
    description: "Last Name of Employee"
    type: string
    sql: ${TABLE}.LastName;;
  }

  dimension: middle_name {
    view_label: "Employee"
    description: "Middle Name of Employee"
    type: string
    sql: ${TABLE}.MiddleName;;
  }
  dimension: full_name{
    view_label: "Employee"
    description: "Full Name of Employee"
    type: string
    sql:  CONCAT(${TABLE}.FirstName,' ',${TABLE}.MiddleName,' ',${TABLE}.LastName);;
  }

  dimension: original_hire_date {
    type: date
    description: "Original Hire Date of Employee"
    datatype: date
    sql: ${TABLE}.OriginalHireDate ;;
  }

  dimension_group: hire_date {
    label: "Hire"
    type: time
    description: "Hire Date of Employee"
    datatype: datetime
    sql: ${TABLE}.HireDate ;;
  }

  dimension_group: adjusted_service_date {
    label: "Adjusted Service"
    type: time
    description: "Adjusted Hire Date of Employee"
    datatype: datetime
    sql: ${TABLE}.AdjustedServiceDate ;;
  }

  dimension: pay_basis {
    view_label: "Employee"
    description: "Basis of Pay/Salary Basis"
    type: string
    sql: ${TABLE}.PayBasis;;
    ##############required_access_grants: [can_see_hc_sensitive]
  }

  # dimension: org_name {
  #   type: string
  #   sql: CASE WHEN ${employee_costing_history.costing_department_name_with_code} = "CENTER MANAGEMENT (008)" THEN "CENTER MANAGEMENT"
  #       WHEN ${employee_costing_history.costing_department_name_with_code} = "OPS MANAGEMENT (144)" AND ${job_title} IN ("Manager, Operations", "Manager, Service Delivery", "Senior Manager, Sales Service Delivery", "Senior Manager, Service Delivery", "Manager III, Sales Service Delivery", " Manager II, Sales Service Delivery") THEN "OPS MANAGEMENT"
  #       WHEN ${employee_costing_history.costing_department_name_with_code} = "OPS TEAM LEADER (143)" AND ${job_title} IN ("Team Leader", "Team Lead, Service Delivery -TMO", "Team Lead, Service Delivery - Motif", "Team Lead, Service Delivery - FCR", "Team Lead, Service Delivery - Bilingual", "Team Lead, Service Delivery", "Team Lead, Sales Service Delivery - Bilingual", "Team Lead, Sales Service Delivery", "Supervisor, Service Delivery - Faneuil", "Supervisor de Opera�ões Bilingue", "Supervisor de Opera�ões", "Senior Team Lead, Service Delivery - Bilingual", "Senior Team Lead, Service Delivery", "Senior Team Lead, Sales Service Delivery", "Senior Supervisor, Operations", "Temporary Team Lead", "Team Leader - Bilingual") THEN "OPS TEAM LEADER"
  #       WHEN ${employee_costing_history.costing_department_name_with_code} IN ("QUALITY ASSURANCE (065)","QUALITY ASSURANCE - BILLABLE (165)") THEN "QUALITY ASSURANCE"
  #       WHEN ${employee_costing_history.costing_department_name_with_code} = "REPORTING AND ANALYTICS (006)" THEN "REPORTING AND ANALYTICS"
  #       WHEN ${employee_costing_history.costing_department_name_with_code} = "TRAINING OPERATIONS (030)" THEN "TRAINING OPERATIONS"
  #       WHEN ${employee_costing_history.costing_department_name_with_code} IN ("WORKFORCE MANAGEMENT (056)", "WORKFORCE MANAGEMENT - BILLABLE (157)") THEN "WORKFORCE MANAGEMENT"
  #       END;;
  #   html: <h1 id="Sample "style="height:50px; width:100%; font-size:24px;font-weight:500;text-align:center;background-color:#3299ff; color:white;padding:10px 10px;">{{rendered_value}}</h1>  ;;
  # }

  dimension: current_date {
    type: date
    sql: current_date ;;
  }

  dimension_group: today {
    label: "Today Date"
    type: time
    datatype: datetime
    sql: current_date();;
    html: {{ rendered_value | date: "%m/%d/%Y" }};;
  }

  dimension: last_day_month {
    type: yesno
    sql: EXTRACT( DAY FROM DATE_ADD(${calendar_date}, INTERVAL 1 DAY)) = 1 and ${calendar_date} < ${current_date};;
  }

  # dimension: organization_name1 {
  #   label: "Organization"
  #   description: "TTEC Organization Name"
  #   type: string
  #   sql: case when ${TABLE}.SystemId = 2579 then NULL else replace(${TABLE}.OrganizationName,"TTEC-","")
  #     end;;
  # }

  dimension: organization_name {
    description: "Derived Name of Organization"
    label: "Organization Name"
    type: string
    sql: ${TABLE}.OrganizationNameDerived;;
  }

  # dimension: organization_name {
  #   description: "Name of Organization"
  #   type: string
  #   sql:case
  #         when ${organization_name1} = "072 Data & Analytics" then "Data & Analytics-072"
  #                 when ${organization_name1} LIKE "%130 - Cloud Engineering%" then replace(${organization_name1},"130 - Cloud Engineering","Cloud Engineering-130")
  #                 when ${organization_name1} LIKE "%131 - Cloud Support%" then replace(${organization_name1},"131 - Cloud Support","Cloud Support-131")
  #                 when ${organization_name1} = "MEX-089 PRODUCT LINE MANAGEMENT-089" then "PRODUCT LINE MANAGEMENT-089"
  #                 when ${organization_name1} in ("TTECH ENTERPRISE SERVICES LEADERSHIP 039", "TTEC ENTERPRISE SERVICES LEADERSHIP 039") then "ENTERPRISE SERVICES LEADERSHIP 039"
  #                 when ${organization_name1} = "TTEC Companies Group - 022" then "Companies Group - 022"
  #                 when ${organization_name1} = "TTEC International Pty Ltd" then "International Pty Ltd"
  #                   when ${organization_name1} LIKE "%DAC-%" then replace(${organization_name1},"DAC-","")
  #                   when ${organization_name1} LIKE "%CO-%" then replace(${organization_name1},"CO-","")
  #                 when ${organization_name1} LIKE "%PCTA-AUS-%" then replace(${organization_name1},"PCTA-AUS-","")
  #                 when ${organization_name1} LIKE "%PCTA-PH-%" then replace(${organization_name1},"TTEC-PCTA-PH-","")
  #                 when ${organization_name1} LIKE "%PCTA-%" then replace(${organization_name1},"PCTA-","")
  #                 when ${organization_name1} LIKE "%PCTA-UK-%" then replace(${organization_name1},"PCTA-UK-","")
  #                 when ${organization_name1} LIKE "%ARG-ACE - %" then replace(${organization_name1},"TTEC-ARG-ACE - ","")
  #                 when ${organization_name1} LIKE "%PH-ACE - %" then replace(${organization_name1},"TTEC-PH-ACE - ","")
  #                 when ${organization_name1} LIKE "%IN-ACE - %" then replace(${organization_name1},"TTEC-IN-ACE - ","")
  #                 when ${organization_name1} LIKE "%TTEC%" then replace(${organization_name1},"TTEC - ","")
  #                 when ${organization_name1} LIKE "%TTECH%" then replace(Ltrim(${organization_name1}),"TTECH","")
  #                 when ${organization_name1} LIKE "%ARG-%" then replace(${organization_name1},"ARG-","")
  #               when ${organization_name1} LIKE "%AU-%" then replace(${organization_name1},"AU-","")
  #                 when ${organization_name1} LIKE "%BE-%" then replace(${organization_name1},"BE-","")
  #                 when ${organization_name1} LIKE "%BG-%" then replace(${organization_name1},"BG-","")
  #                 when ${organization_name1} LIKE "%BR-%" then replace(${organization_name1},"BR-","")
  #                 when ${organization_name1} LIKE "%BRZ-%" then replace(${organization_name1},"BRZ-","")
  #                 when ${organization_name1} LIKE "%CA-%" then replace(${organization_name1},"CA-","")
  #                 when ${organization_name1} LIKE "%CAN-%" then replace(${organization_name1},"CAN-","")
  #                 when ${organization_name1} LIKE "%CO-CLIENT %" then replace(${organization_name1},"CO-CLIENT ","")
  #                 when ${organization_name1} LIKE "%CLIENT %" then replace(${organization_name1},"TTEC-CO-CLIENT ","")
  #                 when ${organization_name1} LIKE "%COL-%" then replace(${organization_name1},"COL-","")
  #                 when ${organization_name1} LIKE "%CR-%" then replace(${organization_name1},"COL-","")
  #                 when ${organization_name1} LIKE "%EG-%" then replace(${organization_name1},"EG-","")
  #                 when ${organization_name1} LIKE "%ESP-%" then replace(${organization_name1},"ESP-","")
  #                 when ${organization_name1} LIKE "%GH-%" then replace(${organization_name1},"GH-","")
  #                 when ${organization_name1} LIKE "%GR-%" then replace(${organization_name1},"GR-","")
  #                 when ${organization_name1} LIKE "%GRC-%" then replace(${organization_name1},"GRC-","")
  #                 when ${organization_name1} LIKE "%HKG-%" then replace(${organization_name1},"HKG-","")
  #                 when ${organization_name1} LIKE "%HK-%" then replace(${organization_name1},"HK-","")
  #                 when ${organization_name1} LIKE "%HN-%" then replace(${organization_name1},"HN-","")
  #                 when ${organization_name1} LIKE "%IE-%" then replace(${organization_name1},"IE-","")
  #                 when ${organization_name1} LIKE "%IN-%" then replace(${organization_name1},"IN-","")
  #                 when ${organization_name1} LIKE "%IND-%" then replace(${organization_name1},"IND-","")
  #                 when ${organization_name1} LIKE "%MAL-%" then replace(${organization_name1},"MAL-","")
  #                 when ${organization_name1} LIKE "%MEX-%" then replace(${organization_name1},"MEX-","")
  #                 when ${organization_name1} LIKE "%MK-%" then replace(${organization_name1},"MK-","")
  #                 when ${organization_name1} LIKE "%MS %" then replace(${organization_name1},"MS ","")
  #                 when ${organization_name1} LIKE "%MX-%" then replace(${organization_name1},"MX-","")
  #                 when ${organization_name1} LIKE "%MY-%" then replace(${organization_name1},"MY-","")
  #                 when ${organization_name1} LIKE "%NL-%" then replace(${organization_name1},"NL-","")
  #                 when ${organization_name1} LIKE "%NZ-%" then replace(${organization_name1},"NZ-","")
  #                 when ${organization_name1} LIKE "%PH-%" then replace(${organization_name1},"TTEC-PH-","")
  #                 when ${organization_name1} LIKE "%PHL-089 %" then replace(${organization_name1},"PHL-089 ","")
  #                 when ${organization_name1} LIKE "%MEX-089%" then replace(${organization_name1},"MEX-089","")
  #                 when ${organization_name1} LIKE "%PHL-%" then replace(${organization_name1},"PHL-","")
  #                 when ${organization_name1} LIKE "%PL-%" then replace(${organization_name1},"PL-","")
  #                 when ${organization_name1} LIKE "%PRG-%" then replace(${organization_name1},"PRG-","")
  #                 when ${organization_name1} LIKE "%SGP-%" then replace(${organization_name1},"SGP-","")
  #                 when ${organization_name1} LIKE "%UAE-%" then replace(${organization_name1},"TTEC-UAE-","")
  #                 when ${organization_name1} LIKE "%UK-089 %" then replace(${organization_name1},"UK-089 ","")
  #                 when ${organization_name1} LIKE "%UK-%" then replace(${organization_name1},"UK-","")
  #                 when ${organization_name1} LIKE "%US-%" then replace(${organization_name1},"US-","")
  #                 when ${organization_name1} LIKE "%USA-%" then replace(${organization_name1},"USA-","")
  #                 when ${organization_name1} LIKE "%ZA-%" then replace(${organization_name1},"ZA-","")
  #                 when ${organization_name1} LIKE "%Telecommunications Engineering ? SG&A 079%" then replace(${organization_name1},"Telecommunications Engineering ? SG&A 079","Telecommunications Engineering - SG&A 079")

  #     else ${organization_name1}
  #     end;;

  # }

  dimension: organization_code {
    view_label: "Employee"
    description: "Organization's code"
    type: string
    sql: ${TABLE}.OrganizationCode;;
  }

  dimension: location_id {
    view_label: "Headcount"
    group_label: "Client Profile"
    description: "ID of location"
    type: string
    sql: ${TABLE}.LocationId;;
  }

  dimension: location_name {
    label: "Geo Location Name"
    description: "Name of Location"
    type: string
    sql: ${TABLE}.LocationName;;
  }

  dimension: site_hr_location {
    view_label: "Headcount"
    group_label: "Client Profile"
    description: "Location of site"
    type: string
    sql: ${TABLE}.SiteHrLocation;;
  }

  dimension: cost_client_code {
    label: "Cost Client Code"
    view_label: "Employee"
    description: "Code of Cost Client"
    type: string
    sql: ${TABLE}.CostingClientCode;;
  }

  dimension: cost_client_description1 {
    description: "Additional description of cost client"
    hidden: yes
    view_label: "Employee"
    type: string
    sql: ${TABLE}.CostingClientDescription;;
  }

  dimension: cost_client_description {
    description: "Description of cost client"
    view_label: "Employee"
    type: string
    sql: CONCAT(UPPER(${TABLE}.CostClientName),' (',${TABLE}.CostingClientCode,')');;
  }

  dimension: cost_client_name {
    description: "Name of cost client"
    view_label: "Employee"
    type: string
    sql: UPPER(${TABLE}.CostClientName);;
  }

  dimension: program_code {
    description: "Code of Program"
    view_label: "Headcount"
    group_label: "Client Profile"
    type: string
    sql: ${TABLE}.ProgramCode;;
  }

  dimension: program {
    label: "Program (Name Only)"
    description: "Name of program"
    view_label: "Headcount"
    group_label: "Client Profile"
    type: string
    sql: REPLACE(${TABLE}.ProgramName,"?","–");;
  }

  dimension: program_name {
    label: "Program Name with Code"
    description: "Name of program"
    view_label: "Headcount"
    group_label: "Client Profile"
    type: string
    sql: concat(REPLACE(${TABLE}.ProgramName,"?","–"), " (", ${TABLE}.ProgramCode, ")");;
  }

  dimension: project_code {
    description: "Code assigend to the Project"
    view_label: "Headcount"
    group_label: "Client Profile"
    type: string
    sql: ${TABLE}.ProjectCode;;
  }
  dimension: project_name {
    label: "Project Name with Code"
    description: "Name assigned to Project"
    view_label: "Headcount"
    group_label: "Client Profile"
    type: string
    sql: concat(REPLACE(${TABLE}.ProjectName,"?","–"), " (",  ${TABLE}.ProjectCode, ")");;
  }
  dimension: project {
    description: "Name assigned to Project"
    label: "Project (Name Only)"
    view_label: "Headcount"
    group_label: "Client Profile"
    type: string
    sql: REPLACE(${TABLE}.ProjectName,"?","–");;
  }

  dimension: job_code {
    description: "Code of Job"
    view_label: "Employee"
    type: string
    sql: ${TABLE}.JobCode;;
  }

  dimension: assignment_category {
    description: "Category of Assignment"
    view_label: "Employee"
    type: string
    sql: ${TABLE}.AssignmentCategory;;
  }

  dimension: assignment_status {
    description: "Status of Assignment"
    view_label: "Employee"
    type: string
    sql: ${TABLE}.AssignmentStatus;;
  }

  dimension: costing_location_code {
    description: "Code of costing location"
    type: string
    sql: ${TABLE}.CostingLocationCode ;;
  }

  dimension: costing_department_code {
    description: "Code of costing department"
    label: "Department Code Costing"
    type: string
    sql: ${TABLE}.CostDepartmentCode ;;
  }

  dimension: cost_location_code {
    description: "Code of cost location"
    view_label: "Employee"
    type: string
    sql: ${TABLE}.CostingLocationCode;;
  }

  dimension: cost_location_name {
    description: "Name of cost location"
    view_label: "Employee"
    type: string
    sql: UPPER(${TABLE}.CostingLocationName);;
  }

  dimension: cost_department_name {
    description: "Name of cost department/Line of Business"
    label: "Cost Department Name"
    view_label: "Employee"
    type: string
    sql: UPPER(${TABLE}.CostDepartmentName);;
  }

  dimension: cost_department_code {
    description: "Code of cost department"
    view_label: "Employee"
    label: "Cost Department Code"
    type: string
    sql: ${TABLE}.CostingDepartmentCode;;
  }

  dimension: legal_employer {
    description: "Legal Employer or GRE"
    label: "GRE"
    view_label: "Employee"
    type: string
    sql: case when ${TABLE}.LegalEmployer like '%|%'
              then RTRIM(${TABLE}.LegalEmployer, '|||||||No||No|No|Yes||')
              else ${TABLE}.LegalEmployer  end ;;
    # sql: case when  ${country_name} = "India" then REPLACE(${TABLE}.LegalEmployer,"|||||||No||No|No|Yes||" ,"") else ${TABLE}.LegalEmployer end;;
    }

    dimension: legal {
      type: string
      sql: ${TABLE}.LegalEmployer ;;
    }

    dimension: flsa_status {
      description: "FLSA status"
      label: "FLSA"
      view_label: "Employee"
      type: string
      sql: case when ${TABLE}.FlsaStatus = "EX" then "Exempt"
              when ${TABLE}.FlsaStatus = "NEX" then "Non Exempt"
              when ${TABLE}.FlsaStatus = "SNE" then "Salaried Non Exempt" else
              ${TABLE}.FlsaStatus end;;
      ##############required_access_grants: [can_see_hc_sensitive]
    }

    dimension: psaflag {
      view_label: "Employee"
      label: "PSA FLAG"
      description: "The mapped PSA in the employee’s Oracle Profile – Assignment Form"
      type: string
      sql: ${TABLE}.PSAFlag;;
    }

    dimension: ec1_name {
      description: "EC1 Name of Employee"
      view_label: "Employee"
      type: string
      label: "ECM "
      sql: ${TABLE}.EC1Name;;
    }

    dimension: ec2_name {
      description: "EC2 Name of Employee"
      view_label: "Employee"
      type: string
      label: "ECM Direct Report 1"
      sql: ${TABLE}.EC2Name;;
    }

    dimension: ec3_name {
      description: "EC3 Name of Employee"
      view_label: "Employee"
      type: string
      label: "ECM Direct Report 2"
      sql: ${TABLE}.EC3Name;;
    }

    dimension: ec4_name {
      description: "EC4 Name of Employee"
      type: string
      label: "ECM Direct Report 3"
      view_label: "Employee"
      sql: ${TABLE}.EC4Name;;
    }

    dimension: ec5_name {
      description: "EC5 Name of Employee"
      type: string
      label: "ECM Direct Report 4"
      view_label: "Employee"
      # sql: ${TABLE}.EC5Name;;
      sql: REPLACE(${TABLE}.EC5Name,"�","ñ") ;;
    }

    dimension: ec6_name {
      description: "EC5 Name of Employee"
      type: string
      label: "ECM Direct Report 5"
      view_label: "Employee"
      # sql: ${TABLE}.EC6Name;;
      sql: REPLACE(${TABLE}.EC6Name,"�","ñ") ;;
    }

    dimension: state {
      description: "State of Employee"
      view_label: "Employee"
      type: string
      sql: ${TABLE}.State;;
      ##############required_access_grants: [can_see_hc_sensitive]
    }

    dimension: work_arrangement {
      description: "Type of Work Arrangement"
      label: "Work Arrangement Type"
      view_label: "Employee"
      type: string
      sql: ${TABLE}.WorkArrangement;;
    }

    dimension: work_arrangement_reason {
      description: "Reason of Work Arrangement"
      view_label: "Employee"
      type: string
      sql: ${TABLE}.WorkArrangementReason;;
    }

    dimension: parent_client_name {
      description: "Name of the Parent client"
      label: "Parent Client"
      type: string
      sql: concat( ${TABLE}.ParentClientName, " (", ${TABLE}.ParentClientCode , ")") ;;
    }

    dimension: parent_client {
      description: "Parent Client"
      label: "Parent Client (Name Only)"
      type: string
      sql: ${TABLE}.ParentClientName;;
    }

    dimension: costing_client_code{
      description: "Key flexfield segment costing client code"
      label: "Cost Client Code - Billing"
      type: string
      sql: case when ${TABLE}.CostingClientCode is null and ${TABLE}.Proportion =1 then ${TABLE}.ClientCode else
        ${TABLE}.CostingClientCode end;;
    }

    dimension: veteran_status_definition {
      description: "Definition of Veteran status"
      view_label: "Employee"
      label: "Protected Veteran Status"
      type: string
      sql: ${TABLE}.VeteranStatusDefinition;;
      ###############required_access_grants: [can_see_hc_sensitive_data]
    }

    dimension: supervisor1_oracle_id {
      description: "Oracle ID of Supervisor1"
      view_label: "Employee"
      label: "New Supervisor Employee ID"
      type: string
      sql: ${TABLE}.Supervisor1OracleId;;
    }

    dimension: supervisor1_name {
      description: "Name of supervisor1"
      view_label: "Employee"
      label: "New Supervisor Name"
      type: string
      # sql: ${TABLE}.Supervisor1Name;;
      sql: REPLACE(${TABLE}.Supervisor1Name,"�","ñ") ;;
    }

    dimension: new_supervisor_location_code {
      description: "location code of new supervisor"
      view_label: "Employee"
      label: "New Supervisor Location Code"
      type: string
      sql: ${TABLE}.NewSupervisorLocationCode;;
    }

    dimension: previous_supervisor_employee_id {
      description: "Employee ID of Previous supervisor"
      view_label: "Employee"
      label: "Previous Supervisor Employee ID"
      type: string
      sql: ${TABLE}.PreviousSupervisorEmployeeID;;
    }

    dimension: previous_supervisor_name {
      description: "Name of Previous supervisor"
      view_label: "Employee"
      type: string
      sql: ${TABLE}.PreviousSupervisorName;;
    }

    dimension: person_id {
      description: "Peron ID of Employee"
      view_label: "Employee"
      type: string
      sql: ${TABLE}.PersonID;;
    }

    dimension: person_gu_id {
      description: "Person GU ID of Employee"
      view_label: "Employee"
      label: "Person GU ID"
      type: string
      sql: ${TABLE}.PersonGuId;;
    }

    dimension_group: termination_date {
      description: "Termination"
      label: "Termination"
      type: time
      datatype: datetime
      sql: ${TABLE}.TerminationDate ;;
    }

    dimension_group: production_start_date {
      description: "Production Start"
      label: "Production Start"
      view_label: "Headcount"
      type: time
      datatype: datetime
      sql: ${TABLE}.ProductionStartDate ;;
    }

    dimension: manager_turnover_distinct_supervisors {
      description: "Manager turnover or Distinct supervisor"
      label: "Manager Turnover/Distinct Supervisors"
      view_label: "Employee"
      type: string
      sql: ${TABLE}.ManagerTurnoverDistinctSupervisors;;
    }

    dimension: account_ownership_key {
      description: "Key of ownership for the account"
      hidden: yes
      type: string
      sql: ${TABLE}.AccountOwnershipKey;;
    }

    dimension: sub_function {
      description: "Sub function"
      view_label: "Employee"
      type: string
      sql: ${TABLE}.SubFunction;;
    }

    dimension_group: effective_start_date {
      label: "Effective Start"
      type: time
      datatype: datetime
      sql: ${TABLE}.EffectiveStartDate ;;
    }

    dimension_group: effective_end_date {
      label: "Effective End"
      type: time
      datatype: datetime
      sql: ${TABLE}.EffectiveEndDate ;;
    }

    dimension: registered_disabled {
      description: "Registered disabled"
      view_label: "Employee"
      type: string
      sql: ${TABLE}.RegisteredDisabled;;
      ###############required_access_grants: [can_see_hc_sensitive_data]
    }

    dimension: default_department_code {
      description: "default code of department"
      hidden: yes
      view_label: "Employee"
      type: string
      sql: ${TABLE}.DefaultDepartmentCode;;
    }

    dimension: default_client_code {
      description: "default code of client"
      #hidden: yes
      view_label: "Employee"
      type: string
      sql: ${TABLE}.DefaultClientCode;;
    }

    dimension: costing_hrlocation {
      hidden: yes
      description: "location of costing HR"
      type: string
      sql: ${TABLE}.CostingHRLocation ;;
    }

    dimension: costing_department {
      description: "Name of the organization"
      label: "Department Name Costing"
      type: string
      sql:  CASE WHEN ${TABLE}.SystemId = 2579 THEN CONCAT(SUBSTR(${TABLE}.CostingDepartment, 3 - LENGTH(${TABLE}.CostingDepartment)), " (" , ${costing_department_code}, ")")
          ELSE CONCAT(REPLACE(${TABLE}.CostingDepartment, "?", "–") , " (", ${costing_department_code} , ")")
          END ;;
    }
#6
    dimension_group: calendar_date {
      label: "Calendar"
      description: "Date"
      type: time
      datatype: datetime
      sql: ${TABLE}.CalendarDate ;;
    }

    dimension: costing_client_description {
      description: "Costing (Billing) Client Code"
      label: "Cost Client Description - Billing"
      type: string
      sql:  case when ${TABLE}.CostingClientCode is null and ${TABLE}.Proportion =1 then  CONCAT( ${TABLE}.ClientName, ' (',  ${TABLE}.ClientCode, ')')  else  CONCAT( ${TABLE}.CostingClientname, ' (',  ${TABLE}.CostingClientCode, ')')  end ;;
    }

    dimension: assignment_type {
      description: "type of assignment"
      view_label: "Employee"
      type: string
      sql: ${TABLE}.AssignmentType;;
    }

    dimension: business_group_id {
      description: "Business Group"
      view_label: "Employee"
      type: string
      sql: ${TABLE}.BusinessGroupId;;
    }


    #****************************************************** Number Dimensions ***********************************************************#

    dimension: system_id {
      description: "system id"
      view_label: "Account Ownership"
      type: number
      sql: ${TABLE}.SystemID;;
    }

    dimension: head_count {
      description: "Count of headcount"
      hidden: yes
      type: number
      sql: ${TABLE}.headCount;;
    }



    #******************************************* Boolean/Yes-No Dimensions **************************************************#

    dimension: attrition_impacting_ind {
      description: "Attrition impacting ind"
      type: yesno
      hidden: yes
      view_label: "Attrition"
      sql: ${TABLE}.AttritionImpactingInd;;
    }

    dimension: is_weekly {
      description: "Is it weekly or not"
      type: string
      sql: CASE WHEN ${TABLE}.IsWeekly = 1 THEN 'Yes' else 'No' end;;
    }

    dimension: is_monthly {
      description: "Is it monthly or not"
      type: string
      sql: CASE WHEN  ${TABLE}.IsMonthly = 1 THEN 'Yes' else 'No' end;;
    }

    dimension: is_quarterly {
      description: "Is it quarterly or not"
      type: string
      sql: CASE WHEN ${TABLE}.IsQuarterly = 1 THEN 'Yes' else 'No' end;;
    }

    dimension: is_yearly {
      description: "Is it yearly or not"
      type: string
      sql: CASE WHEN ${TABLE}.IsYearly = 1 THEN 'Yes' else 'No' end ;;
    }

    #*************************************** Date/Time Dimensions ******************************************************************#

    dimension_group: original_hire_date {
      description: "Original hire date"
      label: "Original Hire"
      view_label: "Employee"
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      datatype: datetime
      sql: ${TABLE}.OriginalHireDate;;
    }

    dimension_group: hire {
      description: "Current Hire date"
      view_label: "Employee"
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      datatype: datetime
      sql: ${TABLE}.HireDate;;
    }

    dimension_group: adjusted_service {
      description: "Adjusted service"
      view_label: "Employee"
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      datatype: datetime
      sql: ${TABLE}.AdjustedServiceDate;;
    }

    dimension_group: production_start {
      description: "Production Start Date"
      view_label: "Employee"
      hidden: yes
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      datatype: datetime
      sql: ${TABLE}.ProductionStartDate;;
    }

    dimension_group: termination {
      description: "Termination date"
      label: "Actual Termination"
      view_label: "Attrition"
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      datatype: datetime
      sql: ${TABLE}.TerminationDate;;
    }

    dimension_group: effective_start {
      description: "Effective Start Date"
      label: "Effective Start"
      view_label: "Employee"
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      datatype: datetime
      sql: ${TABLE}.EffectiveStartDate;;
    }

    dimension_group: effective_end {
      description: "Effective End date"
      label: "Effective End"
      view_label: "Employee"
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      datatype: datetime
      sql: ${TABLE}.EffectiveEndDate;;
    }

    dimension_group: calendar {
      description: "Calendar date"
      view_label: "Calendar"
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      datatype: datetime
      sql: ${TABLE}.CalendarDate;;
    }

    dimension: year_month {
      type: string
      sql: concat(${calendar_year},"-",${calendar_month}) ;;
    }


    #********************************************************** Custom Dimensions **********************************************************#

    dimension:term_filter {
      hidden: yes
      description: "checks if the calendar date is equal to termination date or not"
      type: string
      sql: case when  ${termination_date} = ${calendar_date} then 'Yes' else 'No' end;;
    }

    dimension:hire_filter {
      hidden: yes
      description: "Checks if calendar date is equal to hire date or not"
      type: string
      sql: case when ${hire_date} = ${calendar_date} then 'Yes' else 'No' end;;
    }

    dimension: prod_flag {
      description: "Flags whether Production or non production"
      type: string
      view_label: "Attrition"
      label: "Production/Pre-Production Flag"
      sql: CASE WHEN ${job_family} = 'G&A' then 'Production' WHEN ${job_family} = 'Agent' THEN
        (CASE WHEN ${hire_date} = ${calendar_date} OR ${calendar_date}  < ${production_start_date} THEN  'Non-Production' ELSE 'Production' END )
         ELSE 'Production' END;;
    }

    dimension: impacting_non_impacting{
      description: "Impacting or not impacting"
      type: string
      hidden: no
      label: "Attrition Category (Impacting\Non impacting)"
      view_label: "Attrition"
      sql:  case when CAST(${attrition_impacting_ind} as string)  = 'true' then 'Impacting' else 'Non-Impacting' end ;;
    }

    dimension: hire_prod_bucket {
      description: "Tier of hire to termination"
      label: "Hire to Termination Tires"
      view_label: "Employee"
      type: string
      hidden: yes
      sql:   CASE WHEN (DATE_DIFF(${termination_date},${hire_date}, day)) <= 30 THEN 'First 30 Days'
          When (DATE_DIFF(${termination_date},${hire_date}, day)) <= 90 THEN 'First 90 Days'
          When ABS(DATE_DIFF(${termination_date},${hire_date}, day)) <= 180 THEN 'First 180 Days'
          When ABS(DATE_DIFF(${termination_date},${hire_date}, day)) = 365 THEN '365 Days' ELSE "More Than 365 Days" END;;
    }

    dimension: age_tires_sort_order {
      description: "Tier of Age based on sort"
      hidden: yes
      view_label: "Employee"
      type: string
      sql:SPLIT(${TABLE}.AgeBracket, '.')[OFFSET(0)] ;;
    }

    dimension: age_tires {
      description: "Tier of Age"
      label: "Age Tiers"
      view_label: "Employee"
      type: string
      sql:case when ${TABLE}.AgeBracket LIKE '%.%' then RIGHT(${TABLE}.AgeBracket, LENGTH(${TABLE}.AgeBracket) - 2) else ${TABLE}.AgeBracket end;;
      order_by_field: age_tires_sort_order
    }

    dimension: tenure_in_days {
      description: "Tenure in days"
      label: "Employee Tenure in days by current date"
      view_label: "Employee"
      type: number
      sql:Date_Diff(COALESCE(LEAST(${termination_date}, current_date), current_date), DATE(${hire_date}), DAY);;
      # sql: Least(date_diff(IFNULL(${termination_date},current_date()),${hire_date},Day)) ;;
      # sql:date_diff(IFNULL(${termination_date},current_date()),${hire_date},Day);;
    }

    dimension: tenure_in_months {
      description: "Tenure in months"
      label: "Employee Tenure in months by current date"
      view_label: "Employee"
      type: number
      sql: ROUND(${tenure_in_days}/30.45,2);;
      # sql:date_diff(IFNULL(${termination_date},current_date()),${hire_date},MONTH);;
    }

    dimension: tenure_in_years {
      description: "Tenure in years"
      label: "Employee Tenure in years by current date"
      view_label: "Employee"
      type: number
      sql:  ROUND(${tenure_in_days}/365.5,2);;
      # sql:date_diff(IFNULL(${termination_date},current_date()),${hire_date},YEAR);;
    }

    dimension: tenure_in_days_by_calendar_date {
      description: "Tenure in days"
      label: "Employee Tenure in days by calendar date"
      view_label: "Employee"
      type: number
      sql:Date_Diff(COALESCE(LEAST(${termination_date}, ${calendar_date_date}), ${calendar_date_date}), DATE(${hire_date}), DAY);;
    }

    dimension: tenure_in_months_by_calendar_date {
      description: "Tenure in months"
      label: "Employee Tenure in months by calendar date"
      view_label: "Employee"
      type: number
      sql: ROUND(${tenure_in_days_by_calendar_date}/30.45,2);;
    }

    dimension: tenure_in_years_by_calendar_date {
      description: "Tenure in years"
      label: "Employee Tenure in years by calendar date"
      view_label: "Employee"
      type: number
      sql:  ROUND(${tenure_in_days_by_calendar_date}/365.5,2);;
    }

    dimension:tenure_group_bucket {
      label: "Employee Tenure Tiers"
      hidden: yes
      view_label: "Employee"
      description: "Tier of Employee tenure"
      case: {
        when: {
          sql: date_diff(IFNULL(${termination_date},current_date()),${hire_date},Day)  >=0 and date_diff(IFNULL(${termination_date},current_date()),${hire_date},Day)  <=30;;
          label: "Between 0 to 30 Days"
        }

        when: {
          sql: date_diff(IFNULL(${termination_date},current_date()),${hire_date},Day)  >=31 and date_diff(IFNULL(${termination_date},current_date()),${hire_date},Day)  <=60;;
          label: "Between 31 to 60 Days"
        }
        when: {
          sql: date_diff(IFNULL(${termination_date},current_date()),${hire_date},MONTH) >=0 and date_diff(IFNULL(${termination_date},current_date()),${hire_date},MONTH) <=3;;
          label: "Between 0 to 3 Months"
        }
        when: {
          sql: date_diff(IFNULL(${termination_date},current_date()),${hire_date},MONTH)  >=4 and date_diff(IFNULL(${termination_date},current_date()),${hire_date},MONTH)  <=6;;
          label: "Between 4 to 6 Months"
        }
        when: {
          sql: date_diff(IFNULL(${termination_date},current_date()),${hire_date},MONTH)  >=7 and date_diff(IFNULL(${termination_date},current_date()),${hire_date},YEAR) <=1;;
          label: "Between 7 to 1 Years"
        }

        when: {
          sql: date_diff(IFNULL(${termination_date},current_date()),${hire_date},YEAR)  >=1 and date_diff(IFNULL(${termination_date},current_date()),${hire_date},YEAR)  <=2;;
          label: "Between 1 to 2 Years"
        }
        when: {
          sql: date_diff(IFNULL(${termination_date},current_date()),${hire_date},YEAR)  > 2;;
          label: "Greater Than 2 Years "
        }
      }
    }

    dimension: boomerangs_rehires {
      description: "rehired employees from terminations"
      hidden: yes
      view_label: "Employee"
      type: string
      sql: CASE WHEN ${termination_date}  is NOT NULL AND (${hire_date} = ${calendar_date}) THEN ${employee_number} ELSE NULL END;;
    }

    dimension: gl_client_code {
      description: "Code of gl client"
      view_label: "Headcount"
      group_label: "Client Profile"
      label: "GL Client Code"
      type: string
      sql: case when ${costing_client_code} <> "" then ${costing_client_code} else ${TABLE}.DefaultClientCode end ;;
    }

    # dimension: gl_client_name {
    #   view_label: "Headcount"
    #   group_label: "Client Profile"
    #   description: "General Ledger Client Name"
    #   label: "GL Client Name"
    #   type: string
    #   sql: CASE WHEN ${gl_client_name_lookup.costing_client_description} is null
    #           THEN ${costing_client_description}
    #           ELSE ${gl_client_name_lookup.costing_client_description}
    #       END ;;
    # }

    #************************************************************** Measures ***************************************************************#

    measure: headcount_daily {
      label: "Headcount Daily"
      type: sum
      view_label: "Headcount"
      sql: ${head_count};;
     # drill_fields: [detail*]
    }

    measure: number_of_days {
      label: "Number of Days"
      type: count_distinct
      view_label: "Headcount"
      sql: ${calendar_date};;
    }

    measure: average_daily_headcount {
      description: "Average of Headcounts by days"
      label: "Average Daily Headcount"
      type: number
      view_label: "Headcount"
      sql: ${headcount_daily}/NULLIF(IFNULL((${number_of_days}),0),0);;
      value_format_name: decimal_2
     # drill_fields: [detail*]
    }

    measure: hired_count {
      description: "Count of hired"
      label: "Total Hired - Count"
      type: count_distinct
      view_label: "Headcount"
      sql: ${employee_number};;
      filters: [hire_filter: "Yes"]
    }

    measure: total_headcount_distinct {
      description: "Distinct count of employees"
      label: "Total Distinct Headcount"
      type: count_distinct
      view_label: "Headcount"
      sql: ${employee_number};;
    }

    measure: terminations {
      description: "Terminations count"
      type: count
      label: "Prod Terminations- Count"
      view_label: "Attrition"
    #  drill_fields: [detail*]
      filters: [prod_flag: "Production",term_filter: "Yes"]
    }

    measure: total_terminations {
      description: "Total Terminations"
      type: count
      label: "Total Terminations - Count "
      view_label: "Attrition"
     # drill_fields: [detail*]
      filters: [term_filter: "Yes"]
    }

    measure: global_attrition_percentage {
      label: "Global Attrition %"
      type: number
      sql: ${total_terminations}/NULLIF(IFNULL((${average_daily_headcount}),0),0);;
      value_format_name: percent_2
    }

    measure: impacting_terminations {
      description: "Impacting terminations"
      type: count
      label: "Prod Terminations(Impacting) - Count"
      view_label: "Attrition"
      filters: [prod_flag: "Production",term_filter: "Yes",impacting_non_impacting: "Impacting"]
   #   drill_fields: [detail*]
    }

    measure: nonimpacting_terminations {
      description: "Non Impacting terminations"
      type: count
      label: "Prod Terminations(Non-Impacting) - Count"
      view_label: "Attrition"
      filters: [prod_flag: "Production",term_filter: "Yes",impacting_non_impacting: "Non-Impacting"]
     # drill_fields: [detail*]
    }

    measure: voluntary_terminations {
      description: "Voluntary terminations"
      type: count
      label: "Prod Terminations(Voluntary) - Count"
      view_label: "Attrition"
      filters: [prod_flag: "Production",term_filter: "Yes",voluntary_termination_status: "Voluntary"]
     # drill_fields: [detail*]
    }

    measure: involuntary_terminations {
      description: "Involuntary terminations"
      type: count
      label: "Prod Terminations(Involuntary) - Count"
      view_label: "Attrition"
      filters: [prod_flag: "Production",term_filter: "Yes",voluntary_termination_status:"Involuntary"]
     # drill_fields: [detail*]
    }

    measure: terminations_first_30_days {
      description: "Termination within 30 days"
      type: count
      label: "Prod Terminations(First 30 Days) - Count"
      view_label: "Attrition"
    #  drill_fields: [detail*]
      filters: [prod_flag: "Production",term_filter: "Yes",hire_prod_bucket: "First 30 Days"]
    }

    measure: terminations_first_90_days {
      description: "Termination within 90days"
      type: count
      label: "Prod Terminations(First 90 Days) - Count"
      view_label: "Attrition"
    #  drill_fields: [detail*]
      filters: [prod_flag: "Production",term_filter: "Yes",hire_prod_bucket: "First 90 Days"]
    }

    measure: terminations_first_180_days {
      description: "Termination within 180 days"
      type: count
      label: "Prod Terminations(First 180 Days) - Count"
      view_label: "Attrition"
   #   drill_fields: [detail*]
      filters: [prod_flag: "Production",term_filter: "Yes",hire_prod_bucket: "First 180 Days"]
    }

    measure: terminations_365_days {
      description: "Termination within 365 days"
      type: count
      label: "Prod Terminations(365 Days) - Count"
      view_label: "Attrition"
    #  drill_fields: [detail*]
      filters: [prod_flag: "Production",term_filter: "Yes",hire_prod_bucket: "365 Days"]
    }

    measure: boomerangs {
      description: "Rehires"
      type: count_distinct
      view_label: "Employee"
      label: "Boomerangs/Rehires"
      sql: CASE WHEN ${assignment_number} LIKE '%-%' THEN ${assignment_number} END ;;
    }

    measure: compliance_completion_percentage {
      description: "Percentage of Compliance courses completed for each Employee"
      label: "Compliance Completion"
      view_label: "Headcount"
     # drill_fields: [detail*]
      type: number
      # sql: SAFE_DIVIDE(COALESCE(${total_compliance_completed},0),COALESCE(${completed_compliance},0)) ;;
      sql: SAFE_DIVIDE(COALESCE(${completed_compliance},0),COALESCE(${total_compliance_completed},0)) ;;
      value_format_name: decimal_1
    }

    measure: terminated_employee_count {
      description: "Represents count of employees who has resigned or terminated"
      type: count_distinct
      sql: ${employee_number};;
      filters: [termination_date: "not null"]
    }

    measure: average_comp_ratio {
      label: "Average Compensation ratio"
      description: "Average of Compensation ratio"
      type: average
      sql: ${comp_ratio} ;;
    }

    ########################### Talent Management Enhancements ###############################

    dimension: client_code {
      description: "Client Code in Oracle"
      label: "Oracle Client Code"
      type: string
      sql: ${TABLE}.ClientCode;;
    }
    dimension: client_name {
      description: "Client Name in Oracle"
      type: string
      sql: concat(${TABLE}.ClientName, ' (', ${TABLE}.ClientCode, ')');;
    }
    dimension: client{
      description: "Client Name in Oracle"
      label: "Client (Name Only) "
      type: string
      sql: ${TABLE}.ClientName;;
    }

    dimension: row_number {
      description: "describes which row"
      type: string
      sql: ${TABLE}.RowNumber ;;
    }

    dimension: costing_location_name {
      description: "Name of costing location"
      hidden: yes
      type: string
      sql: ${TABLE}.CostingLocationName ;;
    }

    dimension: production_flag {
      description: "Flag of Production"
      type: string
      sql: ${TABLE}.ProductionFlag ;;
    }

    dimension: ec1_oracle_id {
      description: "Oracle ID of EC1"
      label: "ECM Oracle ID"
      type: string
      sql: ${TABLE}.EC1OracleId ;;
    }

    dimension: ec2_oracle_id {
      description: "Oracle ID of EC2"
      label: "ECM Direct Report 1 Oracle ID"
      type: string
      sql: ${TABLE}.EC2OracleId ;;
    }

    dimension: ec3_oracle_id {
      description: "Oracle ID of EC3"
      label: "ECM Direct Report 2 Oracle ID"
      type: string
      sql: ${TABLE}.EC3OracleId ;;
    }

    dimension: ec4_oracle_id {
      description: "Oracle ID of EC4"
      label: "ECM Direct Report 3 Oracle ID"
      type: string
      sql: ${TABLE}.EC4OracleId ;;
    }

    dimension: ec5_oracle_id {
      description: "Oracle ID of EC5"
      label: "ECM Direct Report 4 Oracle ID"
      type: string
      sql: ${TABLE}.EC5OracleId ;;
    }

    dimension: ec6_oracle_id {
      description: "Oracle ID of EC5"
      label: "ECM Direct Report 5 Oracle ID"
      type: string
      sql: ${TABLE}.EC6OracleId ;;
    }

    dimension: age_bracket {
      description: "Age bracket"
      type: string
      sql: ${TABLE}.AgeBracket ;;
    }

    dimension: client_owner_region_id {
      description: "Regions ID of client owner"
      type: number
      sql: ${TABLE}.ClientOwnerRegionId ;;
    }

    dimension: location_country {
      description: "Country and location"
      type: string
      sql: ${TABLE}.LocationCountry ;;
    }

    dimension: address {
      description: "Address"
      type: string
      sql: ${TABLE}.Address ;;
      ##############required_access_grants: [can_see_hc_sensitive]
    }

    dimension: town_or_city {
      description: "Information of town or city"
      type: string
      sql: ${TABLE}.TownOrCity ;;
      ##############required_access_grants: [can_see_hc_sensitive]
    }

    dimension: postal_code {
      description: "Postal code"
      type: string
      sql: ${TABLE}.PostalCode ;;
      map_layer_name: us_zipcode_tabulation_areas
      ##############required_access_grants: [can_see_hc_sensitive]
    }

    dimension: marital_status {
      description: "Marital status of Employee"
      type: string
      sql: ${TABLE}.MaritalStatus ;;
      ##############required_access_grants: [can_see_hc_sensitive]
    }

    dimension: nationality {
      description: "Nationality of Employee"
      type: string
      sql: ${TABLE}.Nationality ;;
      ##############required_access_grants: [can_see_hc_sensitive]
    }

    dimension: personal_email_address {
      description: "Personal Email Address"
      type: string
      sql: ${TABLE}.PersonalEmailAddress ;;
      ##############required_access_grants: [can_see_hc_sensitive]
    }

    dimension: education_status {
      description: "Education status"
      type: string
      sql: ${TABLE}.EducationStatus ;;
      ##############required_access_grants: [can_see_hc_sensitive]
    }

    dimension: supervisor2_oracle_id {
      description: "Oracle ID of supervisor2"
      type: string
      sql: ${TABLE}.Supervisor2OracleId ;;
    }

    dimension: supervisor3_oracle_id {
      description: "Oracle ID of supervisor3"
      type: string
      sql: ${TABLE}.Supervisor3OracleId ;;
    }

    dimension: supervisor4_oracle_id {
      description: "Oracle ID of supervisor4"
      type: string
      sql: ${TABLE}.Supervisor4OracleId ;;
    }

    dimension: supervisor5_oracle_id {
      description: "Oracle ID of supervisor5"
      type: string
      sql: ${TABLE}.Supervisor5OracleId ;;
    }

    dimension: supervisor6_oracle_id {
      description: "Oracle ID of supervisor6"
      type: string
      sql: ${TABLE}.Supervisor6OracleId ;;
    }

    dimension: supervisor7_oracle_id {
      description: "Oracle ID of supervisor7"
      type: string
      sql: ${TABLE}.Supervisor7OracleId ;;
    }

    dimension: supervisor8_oracle_id {
      description: "Oracle ID of supervisor8"
      type: string
      sql: ${TABLE}.Supervisor8OracleId ;;
    }

    dimension: supervisor9_oracle_id {
      description: "Oracle ID of supervisor9"
      type: string
      sql: ${TABLE}.Supervisor9OracleId ;;
    }

    dimension: supervisor10_oracle_id {
      description: "Oracle ID of supervisor10"
      type: string
      sql: ${TABLE}.Supervisor10OracleId ;;
    }

    dimension: supervisor11_oracle_id {
      description: "Oracle ID of supervisor11"
      type: string
      sql: ${TABLE}.Supervisor11OracleId ;;
    }

    dimension: supervisor12_oracle_id {
      description: "Oracle ID of supervisor12"
      type: string
      sql: ${TABLE}.Supervisor12OracleId ;;
    }

    dimension: supervisor13_oracle_id {
      description: "Oracle ID of supervisor13"
      type: string
      sql: ${TABLE}.Supervisor13OracleId ;;
    }

    dimension: supervisor14_oracle_id {
      description: "Oracle ID of supervisor14"
      type: string
      sql: ${TABLE}.Supervisor14OracleId ;;
    }

    dimension: supervisor2_name {
      label: "Manager"
      description: "Manager Name"
      type: string
      sql: REPLACE(${TABLE}.Supervisor2Name,"�","ñ") ;;
    }

    dimension: supervisor3_name {
      description: "Name of Supervisor3"
      type: string
      sql: ${TABLE}.Supervisor3Name ;;
    }

    dimension: supervisor4_name {
      description: "Name of Supervisor4"
      type: string
      sql: ${TABLE}.Supervisor4Name ;;
    }

    dimension: supervisor5_name {
      description: "Name of Supervisor5"
      type: string
      sql: ${TABLE}.Supervisor5Name ;;
    }

    dimension: supervisor6_name {
      description: "Name of Supervisor6"
      type: string
      sql: ${TABLE}.Supervisor6Name ;;
    }

    dimension: supervisor7_name {
      description: "Name of Supervisor7"
      type: string
      sql: ${TABLE}.Supervisor7Name ;;
    }

    dimension: supervisor8_name {
      description: "Name of Supervisor8"
      type: string
      sql: ${TABLE}.Supervisor8Name ;;
    }

    dimension: supervisor9_name {
      description: "Name of Supervisor9"
      type: string
      sql: ${TABLE}.Supervisor9Name ;;
    }

    dimension: supervisor10_name {
      description: "Name of Supervisor10"
      type: string
      sql: ${TABLE}.Supervisor10Name ;;
    }

    dimension: supervisor11_name {
      description: "Name of Supervisor11"
      type: string
      sql: ${TABLE}.Supervisor11Name ;;
    }

    dimension: supervisor12_name {
      description: "Name of Supervisor12"
      type: string
      sql: ${TABLE}.Supervisor12Name ;;
    }

    dimension: supervisor13_name {
      description: "Name of Supervisor13"
      type: string
      sql: ${TABLE}.Supervisor13Name ;;
    }

    dimension: supervisor14_name {
      description: "Name of Supervisor14"
      type: string
      sql: ${TABLE}.Supervisor14Name ;;
    }

    dimension: manager_level_supervisor {
      description: "Manager level of supervisor"
      type: string
      sql: ${TABLE}.ManagerLevelSupervisor ;;
    }

    dimension: manager_level_prev_supervisor {
      description: "Manager level of previous supervisor"
      type: string
      sql: ${TABLE}.ManagerLevelPrevSupervisor ;;
    }

    dimension: manager_prev_level_supervisor {
      description: "Manager's previous level of supervisor"
      type: string
      sql: ${TABLE}.ManagerPrevLevelSupervisor  ;;
    }

    dimension: manager_prev_level_prev_supervisor {
      description: "Manager's previous level of prevous supervisor"
      type: string
      sql: ${TABLE}.ManagerPrevLevelPrevSupervisor ;;
    }

    dimension_group: supervisor_transfer_date {
      label: "Supervisor Transfer"
      description: "Transferred date of supervisor"
      type: time
      datatype: datetime
      sql: ${TABLE}.SupervisorTransferDate ;;
    }

    dimension: tenure_tier {
      description: "Tier of Tenure"
      type: string
      sql: ${TABLE}.TenureTier ;;
    }

    dimension: tenure_sort {
      description: "Tenure based on sort"
      type: number
      sql: ${TABLE}.TenureSort ;;
    }

    dimension: job_title_category {
      description: "Category of Job title for the employee"
      type: string
      sql: ${TABLE}.JobTitleCategory ;;
    }

    dimension: tiers {
      description: "Tier value"
      type: string
      sql: ${TABLE}.Tiers ;;
    }

    dimension: shore {
      description: "Checks the shore value of the employee"
      type: string
      sql: ${TABLE}.Shore ;;
    }

    dimension: location_subsidiary {
      description: "Descriptive flexfield Location name"
      label: "Company Subsidiary"
      type: string
      sql: ${TABLE}.LocationSubsidiary ;;
    }

    dimension: parent_client_code {
      description: "Code of Parent Client"
      label: "Parent Client Code"
      type: string
      sql: ${TABLE}.ParentClientCode ;;
    }

    dimension: supervisor_title {
      description: "Title of supervisor"
      type: string
      sql: ${TABLE}.SupervisorTitle ;;
    }

    dimension: prev_supervisor_title {
      description: "Title of previous supervisor"
      type: string
      sql: ${TABLE}.PrevSupervisorTitle ;;
    }

    dimension: percepta_yes_no {
      description: "checks if value is percepta or not"
      label: "Include Percepta"
      type: string
      sql:  CASE WHEN (${parent_client_code} IN ('10110','10030','12430') OR ${location_subsidiary} = 'Percepta')
               THEN 'yes'
               ELSE 'no'
          END;;
    }

    dimension: supervisor_transfer {
      description: "checks if the employee is transferred or not"
      view_label: "Employee"
      type: number
      sql: case when ${supervisor1_oracle_id} <> ${previous_supervisor_employee_id} then 1 else 0 end ;;
    }

    dimension: division_id {
      description: "Gives the Unique Identifier of Division"
      type: string
      sql: ${TABLE}.DivisionId ;;
    }

    dimension: performance {
      description: "Performance process asgined to an employee"
      type: string
      sql: ${TABLE}.PerformanceProcessName ;;
    }

    dimension_group: updated {
      hidden: yes
      type: time
      datatype: datetime
      description: "Reference Week of WBR"
      sql: cast(${TABLE}.UpdateDate as datetime);;
    }

    dimension: nav_bar {
      type: string
      sql: "" ;;
      html:

          <div style=" background-color: #3299ff; width:100%;height: 60px; border-radius: 0px 0px 12px 12px; ">
               <img style="height: 35px; width: 70px; padding-left:5px; margin-bottom:1%;" src="https://raw.githubusercontent.com/Engage-Data-IQ/Looker-Assets/develop/ttec-logo-black-share%203.png" alt="logo" />
          <span style="padding-left: 65%; ">
             <a href="" title='Last Updated Date - {{max_load_date._value}}'  >
              <img style="height: 35px;  padding-right:5px;margin-bottom:1%;" src="https://raw.githubusercontent.com/Engage-Data-IQ/Looker-Assets/771b7f8249726caf0f8106e6f7077e1ebc5eab05/Group%20427320510.png" alt="Refresh" />
             </a>
             <a href="">
              <img style="height: 35px;  padding-right:5px;margin-bottom:1%;" title="Business Owner - {{certified_by._value}}" src="https://raw.githubusercontent.com/Engage-Data-IQ/Looker-Assets/771b7f8249726caf0f8106e6f7077e1ebc5eab05/Group%20427320511.png" alt="Certified by" />
             </a>
            <a target="_blank" title="KPI Workbook" href="/extensions/employee_snapshot::TM-Looker-data-dictionary/">
              <img style="height: 35px;  padding-right:5px;margin-bottom:1%;" src="https://raw.githubusercontent.com/Engage-Data-IQ/Looker-Assets/771b7f8249726caf0f8106e6f7077e1ebc5eab05/Group%20427320507.png" alt="Book" />
            </a>
            <a target="_blank" title="AskNow Service Portal" href="https://asknow.service-now.com/asknow?id=asknow_sc_cat_item&sys_id=bec6a503874e29dc97c8646d8bbb3597&sysparm_category=d866a94b87ca29dc97c8646d8bbb35a1">
              <img style="height: 35px;  padding-ight:5px;margin-bottom:1%;" src="https://raw.githubusercontent.com/Engage-Data-IQ/Looker-Assets/771b7f8249726caf0f8106e6f7077e1ebc5eab05/Group%20427320509.png" alt="ASKNOW" />
            </a>
            <img style="height: 60px;margin-bottom:1%;" src="https://raw.githubusercontent.com/Engage-Data-IQ/Looker-Assets/400b42eb0985dd973a71fc0bd5341c19c6f9ad61/Frame%20427320526%20(1).png"
      alt="Askted" />
         </span>
      </div>

        ;;
    }
    dimension: just_more_nav_bar {
      type: string
      sql: "" ;;
      html:

          <div style=" background-color: #3299ff; width:100%;height: 60px; border-radius: 0px 0px 12px 12px; ">
               <img style="height: 35px; width: 70px; padding-left:5px; margin-bottom:1%;" src="https://raw.githubusercontent.com/Engage-Data-IQ/Looker-Assets/develop/ttec-logo-black-share%203.png" alt="logo" />
          <img style=" padding-left:30%; height: 25px; margin-bottom: 1%;" src="https://raw.githubusercontent.com/Engage-Data-IQ/Looker-Assets/b2b5ba214deb5478cc8122a3bf6a6de344907014/justmore.png"/>
            <span style="padding-left: 20%; ">
             <a href="" title='Last Updated Date - {{max_load_date._value}}'  >
              <img style="height: 35px;  padding-right:5px;margin-bottom:1%;" src="https://raw.githubusercontent.com/Engage-Data-IQ/Looker-Assets/771b7f8249726caf0f8106e6f7077e1ebc5eab05/Group%20427320510.png" alt="Refresh" />
             </a>
             <a href="">
              <img style="height: 35px;  padding-right:5px;margin-bottom:1%;" title="Business Owner - {{certified_by._value}}" src="https://raw.githubusercontent.com/Engage-Data-IQ/Looker-Assets/771b7f8249726caf0f8106e6f7077e1ebc5eab05/Group%20427320511.png" alt="Certified by" />
             </a>
            <a target="_blank" title="KPI Workbook" href="/extensions/employee_snapshot::TM-Looker-data-dictionary/">
              <img style="height: 35px;  padding-right:5px;margin-bottom:1%;" src="https://raw.githubusercontent.com/Engage-Data-IQ/Looker-Assets/771b7f8249726caf0f8106e6f7077e1ebc5eab05/Group%20427320507.png" alt="Book" />
            </a>
            <a target="_blank" title="AskNow Service Portal" href="https://asknow.service-now.com/asknow?id=asknow_sc_cat_item&sys_id=bec6a503874e29dc97c8646d8bbb3597&sysparm_category=d866a94b87ca29dc97c8646d8bbb35a1">
              <img style="height: 35px;  padding-ight:5px;margin-bottom:1%;" src="https://raw.githubusercontent.com/Engage-Data-IQ/Looker-Assets/771b7f8249726caf0f8106e6f7077e1ebc5eab05/Group%20427320509.png" alt="ASKNOW" />
            </a>
            <img style="height: 60px;margin-bottom:1%;" src="https://raw.githubusercontent.com/Engage-Data-IQ/Looker-Assets/400b42eb0985dd973a71fc0bd5341c19c6f9ad61/Frame%20427320526%20(1).png"
          alt="Askted" />
             </span>
          </div>

        ;;
    }
    measure: max_load_date {
      hidden: yes
      type: string
      sql: max( format_date("%Y-%m-%d", ${updated_date} ));;

    }
    dimension:certified_by{
      hidden: yes
      label: "Business Owner"
      type: string
      sql: "Pfeifer, Gretchen" ;;
    }

    dimension: completion_status {
      description: "Status of learning activity assigned to an employee"
      type: number
      sql: ${TABLE}.CompletionStatus ;;
    }

    dimension: total_compliance{
      hidden: yes
      type: number
      sql: ${TABLE}.TotalCompliance ;;
    }

    measure: sum_total_compliance{
      label: "Total Compliance"
      hidden: yes
      type: sum
      sql: ${total_compliance} ;;
    }

    measure: total_compliance_completed{
      label: "Complaince Course - Assigned"
      description: "Total number of Compliance courses assigned to an employee"
      type: number
      sql: SAFE_DIVIDE(SUM(COALESCE(${TABLE}.TotalCompliance,0)),COUNT(DISTINCT ${calendar_date_date}));;
    }

    dimension: last_performance_rating {
      description: "Last performance rating of an employee Current/Last Quarter"
      type: number
      sql: ${TABLE}.LastPerformanceRating ;;
    }

    dimension: performance_rating {
      type: string
      sql: case when ${last_performance_rating} = 0 then 'No Rating'
              when ${last_performance_rating} between 1 and 1.49 then 'Opportunity to Improve'
              when ${last_performance_rating} between 1.5 and 2.49 then 'Fully Satisfactory'
              when ${last_performance_rating} between 2.5 and 3.49 then 'Significant Contributor'
              when ${last_performance_rating} between 3.5 and 4.0 then 'Extraordinary Performer' end ;;
    }

    dimension: total_learning_hours {
      hidden: yes
      type: number
      sql: ${TABLE}.TotalLearningHours ;;
    }

    measure: sum_total_learning_hours {
      label: "Total Learning Hours"
      description: "Sum of Learning hours completed by an employee"
      hidden: yes
      type: sum
      sql: ${total_learning_hours} ;;
      value_format: "0.0"
    }

    measure: total_learning_hours_completed {
      description: "Number of Learning hours completed by an employee"
      label: "Learning Hours"
      type: number
      sql:  SAFE_DIVIDE(SUM(COALESCE(${TABLE}.TotalLearningHours,0)),COUNT(DISTINCT ${calendar_date_date}));;
    }

    dimension: total_completed_compliance{
      hidden: yes
      type: number
      sql: ${TABLE}.CompletedCompliance ;;
    }

    measure: sum_total_completed_compliance{
      label: "Total Completed Compliance"
      hidden: yes
      type: sum
      sql: ${total_completed_compliance} ;;
    }

    measure: completed_compliance {
      label: "Compliance Course Completed"
      description: "Total number of Complaince courses completed"
      type: number
      sql: SAFE_DIVIDE(SUM(COALESCE(${TABLE}.CompletedCompliance,0)), COUNT(DISTINCT ${calendar_date_date}));;
    }

    dimension: internal_placement {
      description: "This attribute indicates the employee in an internal candidate and applied for an open position in TTEC through Taleo"
      type: number
      sql: ${TABLE}.InternalPlacement ;;
    }

    dimension: comp_ratio {
      label: "Compensation Ratio"
      description: "Measurement of pay that compares an employee's salary to the median compensation for similar"
      type: number
      sql: ${TABLE}.CompRatio ;;
    }

    dimension_group: last_increase_date {
      label: "Last Increase"
      description: "Date on which last salary increment was effective for an employee"
      type: time
      datatype: datetime
      sql: ${TABLE}.LastIncreaseDate ;;
    }

    measure: supervisor_transfer_count {
      description: "Count of supervisor with transfer"
      view_label: "Employee"
      type: count_distinct
      sql: ${employee_number} ;;
      filters: [supervisor_transfer: "1"]
    }

    dimension: supervisor_title_change {
      description: "checks if the supervisor title is changed or not"
      view_label: "Employee"
      type: number
      sql: case when ${supervisor_title} <> ${prev_supervisor_title} then 1 else 0 end ;;
    }

    measure: supervisor_title_change_count {
      description: "Count of supervisor with title change"
      view_label: "Employee"
      type: count_distinct
      sql: ${employee_number} ;;
      filters: [supervisor_title_change: "1"]
    }

    dimension: create_by {
      type: string
      sql: ${TABLE}.CreateBy ;;
    }

    dimension_group: create_date {
      label: "Create"
      type: time
      sql: ${TABLE}.CreateDate ;;
    }

    dimension: create_process {
      type: string
      sql: ${TABLE}.CreateProcess ;;
    }

    dimension: update_by {
      type: string
      sql: ${TABLE}.UpdateBy ;;
    }

    dimension_group: update_date {
      label: "Update"
      type: time
      sql: ${TABLE}.UpdateDate ;;
    }

    dimension: update_process {
      type: string
      sql: ${TABLE}.UpdateProcess ;;
    }

    dimension: inactive_ind {
      type: yesno
      sql: ${TABLE}.InactiveInd ;;
    }

    dimension_group: inactive_date {
      label: "Inactive"
      type: time
      sql: ${TABLE}.InactiveDate ;;
    }

    dimension: inactive_reason {
      type: string
      sql: ${TABLE}.InactiveReason ;;
    }

    dimension: load_by {
      type: string
      sql: ${TABLE}.LoadBy ;;
    }

    dimension_group: load_date {
      label: "Load"
      type: time
      sql: ${TABLE}.LoadDate ;;
    }

    dimension: load_process {
      type: string
      sql: ${TABLE}.LoadProcess ;;
    }

    dimension: assignment_id {
      type: string
      sql: ${TABLE}.AssignmentId ;;
    }

    dimension: parent_system_id {
      type: number
      sql: ${TABLE}.ParentSystemId ;;
    }

    dimension: performance_process_name {
      type: string
      sql: ${TABLE}.PerformanceProcessName ;;
    }

    dimension: assignment_number {
      type: string
      sql: ${TABLE}.AssignmentNumber ;;
    }

    dimension: performance_and_goal_eligible {
      type: string
      sql: ${TABLE}.PerformanceAndGoalEligible ;;
    }


    #################### Hansen New Requirements #####################

    #################### Custom Dimensions ###########################

    dimension: cycurrent_date {
      type: date
      datatype: date
      sql: DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY) ;;
    }

    dimension: pycurrent_date {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), INTERVAL 1 YEAR) ;;
    }

    dimension: current_year {
      type: number
      sql: EXTRACT(YEAR FROM DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY)) ;;
    }

    dimension: prior_year {
      type: number
      sql: EXTRACT(YEAR FROM DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY)) - 1;;
    }

    dimension: prior2_year {
      type: number
      sql: EXTRACT(YEAR FROM DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY)) - 2 ;;
    }

    dimension: prior3_year {
      type: number
      sql: EXTRACT(YEAR FROM DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY)) - 3 ;;
    }

    dimension: prior4_year {
      type: number
      sql: EXTRACT(YEAR FROM DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY)) - 4 ;;
    }

    dimension: prior5_year {
      type: number
      sql: EXTRACT(YEAR FROM DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY)) - 5 ;;
    }

    dimension: current_month {
      type: number
      sql: EXTRACT(MONTH FROM DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY)) ;;
    }

    dimension: current_week {
      type: number
      sql: EXTRACT(WEEK FROM DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY)) ;;
    }

    dimension: w0start {
      type: date
      datatype: date
      sql: DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), WEEK) ;;
    }

    dimension: w1start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), WEEK), INTERVAL 1 WEEK) ;;
    }

    dimension: w2start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), WEEK), INTERVAL 2 WEEK) ;;
    }

    dimension: w3start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), WEEK), INTERVAL 3 WEEK) ;;
    }

    dimension: w4start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), WEEK), INTERVAL 4 WEEK) ;;
    }

    dimension: w5start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), WEEK), INTERVAL 5 WEEK) ;;
    }

    dimension: m0start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 0 MONTH) ;;
    }

    dimension: m1start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 1 MONTH) ;;
    }

    dimension: m2start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 2 MONTH) ;;
    }

    dimension: m3start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 3 MONTH) ;;
    }

    dimension: m4start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 4 MONTH) ;;
    }

    dimension: m5start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 5 MONTH) ;;
    }

    dimension: m6start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 6 MONTH) ;;
    }

    dimension: m7start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 7 MONTH) ;;
    }

    dimension: m8start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 8 MONTH) ;;
    }

    dimension: m9start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 9 MONTH) ;;
    }

    dimension: m10start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 10 MONTH) ;;
    }

    dimension: m11start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 11 MONTH) ;;
    }

    dimension: m12start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 12 MONTH) ;;
    }

    dimension: m13start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 13 MONTH) ;;
    }

    dimension: m14start {
      type: date
      datatype: date
      sql: DATE_SUB(DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL (CAST(FORMAT_DATE('%w', CURRENT_DATE()+1) AS INT64) ) DAY), MONTH), INTERVAL 14 MONTH) ;;
    }

    #################### Custom Measures #############################

    ########### AVERAGE DAILY HC PREVIOUS WEEK, MONTH AND YEAR BREAKDOWN #############

    measure: current_week_headcount_daily {
      label: "Current Week Headcount Daily"
      hidden: yes
      type: sum
      view_label: "Headcount"
      sql: Case When Extract(YEAR FROM ${calendar_date}) =${current_year} and EXTRACT(WEEK FROM ${calendar_date}) =${current_week} and CalendarDate<=${cycurrent_date} THEN ${head_count} end ;;
      #drill_fields: [detail*]
    }

    measure: current_week_number_of_days {
      label: "Current Week Number of Days"
      hidden: yes
      type: count_distinct
      view_label: "Headcount"
      sql: Case When Extract(YEAR FROM ${calendar_date}) =${current_year} and EXTRACT(WEEK FROM ${calendar_date}) =${current_week} and CalendarDate<=${cycurrent_date} THEN ${calendar_date} end ;;
      #drill_fields: [detail*]
    }

    measure: current_week_average_daily_headcount {
      description: "Average of Headcounts by Current Week"
      label: "Current Week Average Daily Headcount"
      type: number
      view_label: "Headcount"
      sql: ${current_week_headcount_daily}/NULLIF(IFNULL((${current_week_number_of_days}),0),0);;
      value_format_name: decimal_2
     # drill_fields: [detail*]
    }

    measure: previous_week1_headcount_daily {
      label: "previous 1 Week Headcount Daily"
      hidden: yes
      type: sum
      view_label: "Headcount"
      sql: case when ${calendar_date} >= ${w1start} and ${calendar_date} < ${w0start} then ${head_count} end ;;
      #drill_fields: [detail*]
    }

    measure: previous_week1_number_of_days {
      label: "Previous 1 Week Number of Days"
      hidden: yes
      type: count_distinct
      view_label: "Headcount"
      sql: case when ${calendar_date} >= ${w1start} and ${calendar_date} < ${w0start} then ${calendar_date} end;;
    }


#2
    measure: current_month_headcount_daily {
      label: "Current Month Headcount Daily"
      hidden: yes
      type: sum
      view_label: "Headcount"
      sql: Case When Extract(YEAR FROM ${calendar_date}) =${current_year} and EXTRACT(MONTH FROM ${calendar_date}) =${current_month} and CalendarDate<=${cycurrent_date} THEN ${head_count} end ;;
      #drill_fields: [detail*]
    }
#3
    measure: current_month_number_of_days {
      label: "Current Month Number of Days"
      hidden: yes
      type: count_distinct
      view_label: "Headcount"
      sql: Case When Extract(YEAR FROM ${calendar_date}) =${current_year} and EXTRACT(MONTH FROM ${calendar_date}) =${current_month} and CalendarDate<=${cycurrent_date} THEN ${calendar_date} end ;;
      #drill_fields: [detail*]
    }
#1
    measure: current_month_average_daily_headcount {
      description: "Average of Headcounts by Current Month"
      label: "Current Month Average Daily Headcount"
      type: number
      view_label: "Headcount"
      sql: ${current_month_headcount_daily}/NULLIF(IFNULL((${current_month_number_of_days}),0),0);;
      value_format_name: decimal_2
     # drill_fields: [detail*]
    }

    measure: previous_month1_headcount_daily {
      label: "previous 1 Month Headcount Daily"
      hidden: yes
      type: sum
      view_label: "Headcount"
      sql: case when ${calendar_date} >= ${m1start} and ${calendar_date} < ${m0start} then ${head_count} end ;;
     # drill_fields: [detail*]
    }

    measure: previous_month1_number_of_days {
      label: "Previous 1 Month Number of Days"
      hidden: yes
      type: count_distinct
      view_label: "Headcount"
      sql: case when ${calendar_date} >= ${m1start} and ${calendar_date} < ${m0start} then ${calendar_date} end;;
    }
#5
    measure: previous_month1_average_daily_headcount {
      description: "Average of Headcounts by Previous 1 Month"
      label: "Previous 1 Month Average Daily Headcount"
      type: number
      view_label: "Headcount"
      sql: ${previous_month1_headcount_daily}/NULLIF(IFNULL((${previous_month1_number_of_days}),0),0);;
      value_format_name: decimal_2
      #drill_fields: [detail*]
    }
#4
    measure:month_on_month_average_daily_headcount_percent_change {
      type: number
      view_label: "Headcount"
      sql: (${current_month_average_daily_headcount}-${previous_month1_average_daily_headcount})/ NULLIF(IFNULL((${previous_month1_average_daily_headcount}),0),0);;
      value_format_name: percent_2
    }

    measure: current_year_headcount_daily {
      label: "Current Year Headcount Daily"
      hidden: yes
      type: sum
      view_label: "Headcount"
      sql: Case When Extract(YEAR FROM ${calendar_date}) =${current_year} and CalendarDate<=${cycurrent_date} THEN ${head_count} end ;;
      #drill_fields: [detail*]
    }

    measure: current_year_number_of_days {
      label: "Current Year Number of Days"
      hidden: yes
      type: count_distinct
      view_label: "Headcount"
      sql: Case When Extract(YEAR FROM ${calendar_date}) =${current_year} and CalendarDate<=${cycurrent_date} THEN ${calendar_date} end ;;
     # drill_fields: [detail*]
    }

    measure: current_year_average_daily_headcount {
      hidden: yes
      description: "Average of Headcounts by Current Year"
      label: "Current Year Average Daily Headcount"
      type: number
      view_label: "Headcount"
      sql: ${current_year_headcount_daily}/NULLIF(IFNULL((${current_year_number_of_days}),0),0);;
      value_format_name: decimal_2
      #drill_fields: [detail*]
    }

    measure: previous_ytd_headcount_daily {
      label: "previous YTD Headcount Daily"
      hidden: yes
      type: sum
      view_label: "Headcount"
      sql: case when Extract(YEAR FROM ${calendar_date}) = ${prior_year} and ${calendar_date}<=${pycurrent_date} THEN ${head_count} end;;
      #drill_fields: [detail*]
    }

    measure: previous_year_number_of_days {
      label: "Previous Year Number of Days"
      hidden: yes
      type: count_distinct
      view_label: "Headcount"
      sql: case when Extract(YEAR FROM ${calendar_date}) = ${prior_year} and ${calendar_date}<=${pycurrent_date} THEN ${calendar_date} end;;
    }

    measure: previous_year_average_daily_headcount {
      description: "Average of Headcounts by Previous Year"
      label: "Previous YTD Average Daily Headcount"
      type: number
      view_label: "Headcount"
      sql: ${previous_ytd_headcount_daily}/NULLIF(IFNULL((${previous_year_number_of_days}),0),0);;
      value_format_name: decimal_2
     # drill_fields: [detail*]
    }

    measure: year_on_year_average_daily_headcount_percent_change {
      type: number
      view_label: "Headcount"
      sql: (${current_year_average_daily_headcount}-${previous_year_average_daily_headcount})/ NULLIF(IFNULL((${previous_year_average_daily_headcount}),0),0);;
      value_format_name: percent_2
    }




  }
