# Pharmacy Business Intelligence & Data Warehouse

Academic Business Intelligence project focused on the design and implementation of a data warehouse and analytical reporting solution for a pharmacy / healthcare-oriented context.

The project integrates a relational database, ETL processes, a multidimensional SSAS cube, and Power BI dashboards to transform operational data into analytical information for monitoring activity, revenue, examinations, organizations, and patient demographics.

---

## 📌 Project Overview

The objective of this project is to build an end-to-end Business Intelligence solution capable of transforming operational data into structured analytical information.

The solution follows a traditional BI architecture:

**Source Data → Staging → Data Warehouse / Data Marts → SSIS ETL → SSAS Cube → Power BI**

The implementation covers:

- Relational database design
- Staging area
- Data marts
- ETL processes
- Multidimensional OLAP cube
- Analytical dimensions and measures
- Interactive Power BI dashboards

---

## 🏗️ Architecture

```text
┌──────────────────────────┐
│      Source Systems      │
│                          │
│  Operational / MySQL DB  │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│       Staging Area       │
│                          │
│      SQL Server          │
└────────────┬─────────────┘
             │
             │ SSIS ETL
             ▼
┌──────────────────────────┐
│       Data Marts         │
│                          │
│      SQL Server          │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│       SSAS Cube          │
│                          │
│ Multidimensional Model   │
└────────────┬─────────────┘
             │
             ▼
┌──────────────────────────┐
│       Power BI           │
│                          │
│ Dashboards & Analytics   │
└──────────────────────────┘
```

---

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| **MySQL / MariaDB** | Source database |
| **Microsoft SQL Server** | Staging and data marts |
| **SQL** | Database and analytical structures |
| **SSIS** | ETL and data integration |
| **SSAS** | Multidimensional OLAP cube |
| **Power BI** | Data visualization and reporting |
| **Visual Studio / SSDT** | BI project development |
| **Git / GitHub** | Version control and portfolio publication |

---

# 🗄️ Data Model

The operational model contains entities related to patients, examinations, requests, medical practitioners, organizations, billing, and payments.

Main entities include:

- `PATIENT`
- `MEDECIN`
- `EXAMEN`
- `DEMANDE`
- `DEMANDE_EXAMEN`
- `FACTURE`
- `REGLEMENT`
- `ORGANISME`
- `TYPE_ORGANISME`
- `MODE_PAIEMENT`
- `COMPTE`

The analytical layer reorganizes operational information into structures suitable for reporting and multidimensional analysis.

---

# 🔄 ETL — SSIS

The ETL layer is implemented using **SQL Server Integration Services (SSIS)**.

The main ETL package is:

```text
Fill_DataMarts.dtsx
```

The process is responsible for transferring and transforming data between the source/staging environment and the analytical data marts.

The public version of the SSIS project contains sanitized configuration values so that local server names, accounts, and sensitive connection information are not exposed.

### Main databases

```text
Source:
bi_db

Staging:
bi_db_staging

Data Marts:
bi_db_datamarts
```

For a local installation, connection settings must be configured according to the user's environment.

---

# 📊 SSAS Multidimensional Cube

The analytical layer is implemented using **SQL Server Analysis Services (SSAS)**.

The cube project is:

```text
BI_Pharmacie_CUBE
```

The cube is built on top of the `bi_db_datamarts` database.

### Main components

- Data Source
- Data Source View
- Multidimensional Cube
- Dimensions
- Partitions

### Dimensions

The cube contains the following analytical dimensions:

- **Date**
- **Patient**
- **Examination**
- **Organization**
- **Payment**
- **Account**

These dimensions provide different perspectives for analyzing business activity.

---

## Power BI Reporting

The reporting layer is implemented in Microsoft Power BI and provides four
analytical pages:

- Executive Overview
- Examination Performance
- Organization Analysis
- Patient Demographics

## 1. Executive Overview

Provides a high-level overview of business activity.

Main indicators and visualizations:

- Total Revenue
- Total Requests
- Revenue Evolution Over Time
- Request Volume Over Time
- Top 5 Examinations by Revenue
- Year filter

The objective is to provide a concise executive view of revenue and operational activity.

---

## 2. Examination Performance

Focuses on examination-level performance.

Visualizations include:

- Top 10 Examinations by Revenue
- Top 10 Examinations by Request Volume
- Revenue vs. Request Volume by Examination

This page helps identify examinations that contribute most to revenue and activity.

---

## 3. Organization Analysis

Analyzes activity according to organizations.

Visualizations include:

- Revenue by Organization
- Request Volume by Organization
- Revenue vs. Request Volume by Organization
- Year filter

This provides a comparative view of activity and revenue across organizations.

---

## 4. Patient Demographics

Provides demographic analysis of requests and revenue.

Visualizations include:

- Request Volume by Age Group
- Revenue by Age Group
- Request Volume by Gender
- Revenue by Gender
- Year filter

Age groups used in the report are:

```text
0–17
18–29
30–39
40–49
50–59
60–69
70–79
80+
```

**The public PBIX report is available here:**

[Open the public Power BI report](powerbi/Project%20Reports%20PUBLIC.pbix)

**The report uses synthetic data prepared specifically for this public repository.**
**The original laboratory/healthcare records are not distributed.**

---

# 📂 Repository Structure

```text
pharmacy-business-intelligence-data-warehouse/
│
├── README.md
├── .gitignore
├── LICENSE
│
├── docs/
│   ├── architecture/
│   ├── data-model/
│   └── screenshots/
│
├── sql/
│   ├── database/
│   ├── staging/
│   └── data-marts/
│
├── ssis/
│   └── BI_Pharmacie_ETL/
│
├── ssas/
│   └── BI_Pharmacie_CUBE/
│
├── powerbi/
│   └── README.md
│
└── data/
    └── README.md
```

---

# 🔐 Data Privacy & Public Repository

The original academic project used real laboratory/healthcare data.
For privacy and confidentiality reasons, the original records are not included
in this public repository.

The public version uses synthetic data for demonstration and reproducibility.

**Synthetic datasets are available in the `data/` directory.**

---

# ⚙️ Reproducing the Project

The project can be reproduced using a local SQL Server / SSAS / SSIS environment.

A simplified setup sequence is:

### 1. Prepare the source database

Create the required source tables using the SQL scripts provided in:

```text
sql/database/
```

Use synthetic or anonymized records for testing.

### 2. Prepare the staging environment

Create the staging structures from:

```text
sql/staging/
```

### 3. Create the data marts

Create the analytical data mart structures from:

```text
sql/data-marts/
```

### 4. Configure the SSIS project

Open:

```text
ssis/BI_Pharmacie_ETL/
```

Configure the database connections for the local environment.

The public project uses placeholders such as:

```text
YOUR_SQL_SERVER_INSTANCE
YOUR_MYSQL_HOST
```

These must be replaced with the appropriate local configuration.

### 5. Execute the ETL

Run:

```text
Fill_DataMarts.dtsx
```

to populate the analytical data marts.

### 6. Configure the SSAS project

Open:

```text
ssas/BI_Pharmacie_CUBE/
```

Configure the data source to point to the local:

```text
bi_db_datamarts
```

database.

### 7. Deploy and process the cube

Deploy the SSAS project and process the cube so that the dimensions and measures become available for analysis.

### 8. Connect Power BI

Use Power BI to connect to the analytical layer and recreate or open the reporting solution using the appropriate local data source.

---

# 📷 Screenshots

Selected Power BI dashboard screenshots are available under:

```text
docs/screenshots/
```

Planned screenshots include:

```text
powerbi-executive-overview.png
powerbi-examination-performance.png
powerbi-organization-analysis.png
powerbi-patient-demographics.png
```

These screenshots provide a quick visual overview of the final reporting layer without exposing the original dataset.

---

# 🎯 Analytical Objectives

The solution supports analysis of questions such as:

- What is the overall revenue?
- How does revenue evolve over time?
- How does request volume evolve over time?
- Which examinations generate the most revenue?
- Which examinations have the highest request volume?
- Which organizations generate the highest revenue?
- How does activity vary between organizations?
- How is activity distributed across patient age groups?
- How does activity vary by gender?

---

# 🧠 Skills Demonstrated

This project demonstrates practical experience with:

### Data Engineering

- Relational database structures
- SQL
- Staging architecture
- Data integration
- ETL development
- Data marts

### Business Intelligence

- Dimensional modeling
- Multidimensional OLAP
- SSAS cubes
- Dimensions and measures
- Data aggregation
- Analytical reporting

### Data Visualization

- Power BI
- KPI design
- Interactive dashboards
- Slicers and filtering
- Comparative analysis
- Time-series analysis

### Development & Tools

- Microsoft SQL Server
- SSIS
- SSAS
- Power BI
- Visual Studio / SSDT
- Git
- GitHub

---

# 🎓 Academic Context

This repository is based on an academic Business Intelligence project developed in a pharmacy / healthcare-oriented context.

The objective was to apply Business Intelligence concepts through the implementation of an end-to-end analytical platform, from operational data integration to multidimensional analysis and visualization.

The repository has been adapted for public presentation by removing sensitive data and environment-specific configuration.

---

# ⚠️ Disclaimer

This repository is intended for **educational and portfolio purposes**.

The public version does not contain the original patient or laboratory records.

Any data used to reproduce the project should be synthetic, anonymized, or otherwise authorized for public use.

---

# 👤 Author

**Ismail Essbiti**

Master's-level academic project in Business Intelligence / Data & Decision Support.
