# Power BI Reporting

This directory contains the Power BI reporting layer of the **Pharmacy Business Intelligence & Data Warehouse** project.

The Power BI report provides an interactive analytical interface built on top of the data warehouse and data-mart layer.

## Report

### Project Reports PUBLIC.pbix

The public Power BI report contains four analytical pages:

1. **Executive Overview**
   - Total Revenue
   - Total Requests
   - Revenue Evolution Over Time
   - Request Volume Over Time
   - Top 5 Examinations by Revenue
   - Year filtering

2. **Examination Performance**
   - Top 10 Examinations by Revenue
   - Top 10 Examinations by Request Volume
   - Revenue vs. Request Volume by Examination

3. **Organization Analysis**
   - Revenue by Organization
   - Request Volume by Organization
   - Revenue vs. Request Volume by Organization
   - Year filtering

4. **Patient Demographics**
   - Request Volume by Age Group
   - Revenue by Age Group
   - Request Volume by Gender
   - Revenue by Gender
   - Year filtering

## Data

The public version of the report is intended for portfolio and demonstration purposes.

The original academic project used real laboratory/healthcare data. These records are **not included in the public repository**.

The public Power BI report uses **synthetic/anonymized data** to demonstrate the report structure and analytical functionality without exposing confidential information.

## Technology

- Microsoft Power BI
- SQL Server
- SSAS Multidimensional
- SSIS
- Data Warehouse / Data Marts
