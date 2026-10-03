# Pharmacy Business Intelligence & Data Warehouse

> **Academic Business Intelligence project focused on designing and implementing a data warehouse and analytical platform for a pharmacy, using Microsoft SQL Server, SSIS, SSAS, and Power BI.**

## 📌 Project Overview

This project implements an end-to-end **Business Intelligence (BI) solution for a pharmacy**.

The objective is to transform operational healthcare and pharmacy-related data into a structured analytical environment that supports reporting and decision-making.

The solution covers the main stages of a traditional BI architecture:

**Operational Data → Staging → Data Warehouse / Data Marts → ETL → OLAP Cube → Power BI**

**The project combines database development, ETL engineering, multidimensional analysis, and business reporting into a single BI workflow.**

---

## 🏗️ Architecture

```text
                  Operational Data
                         │
                         ▼
              ┌─────────────────────┐
              │   SQL Server Source │
              │       Database      │
              └──────────┬──────────┘
                         │
                         ▼
              ┌─────────────────────┐
              │      Staging        │
              │       Layer         │
              └──────────┬──────────┘
                         │
                    SSIS / ETL
                         │
                         ▼
              ┌─────────────────────┐
              │  Data Warehouse /   │
              │     Data Marts      │
              └──────────┬──────────┘
                         │
                         ▼
              ┌─────────────────────┐
              │   SSAS Multidim.    │
              │        Cube         │
              └──────────┬──────────┘
                         │
                         ▼
              ┌─────────────────────┐
              │      Power BI       │
              │     Reporting      │
              └─────────────────────┘
```

---

## 🎯 Business & Analytical Scope

The project models and analyzes pharmacy-related activities involving entities such as:

* Patients
* Doctors
* Medical examinations
* Requests
* Organizations
* Accounts
* Payments
* Invoices
* Settlements
* Payment methods

The analytical layer supports reporting around indicators such as:

* Revenue / **Chiffre d'Affaires (CA)**
* Number of requests
* Activity over time
* Activity by examination
* Activity by organization
* Payment-related information

The project therefore goes beyond simple sales reporting and demonstrates how operational healthcare/pharmacy data can be transformed into an analytical environment.

---

## 🛠️ Technology Stack

| Technology                | Role                                    |
| ------------------------- | --------------------------------------- |
| **Microsoft SQL Server**  | Relational database and data storage    |
| **SQL**                   | Database, staging and data-mart scripts |
| **SSIS**                  | ETL and data integration                |
| **SSAS Multidimensional** | OLAP cube and analytical model          |
| **Power BI**              | Interactive reporting and visualization |
| **Visual Studio / SSDT**  | Development environment                 |
| **Enterprise Architect**  | Data/database modeling                  |

---

## 🔄 ETL Pipeline

The ETL component is implemented using **SQL Server Integration Services (SSIS)**.

The main SSIS project is:

```text
BI_Pharmacie_ETL
```

The project contains the `Fill_DataMarts` package responsible for populating the analytical layer.

The ETL workflow follows the general process:

1. Extract data from the source environment.
2. Load and prepare data in the staging layer.
3. Transform data for analytical use.
4. Populate the data marts.
5. Make the resulting data available to the OLAP layer.

This demonstrates practical experience with **data integration and ETL pipeline development**.

---

## 🧊 SSAS Multidimensional Cube

The analytical layer is implemented using **SQL Server Analysis Services (SSAS)**.

The original SSAS project is:

```text
BI_Pharmacie_CUBE
```

The cube contains analytical dimensions including:

* Patient
* Date
* Examination
* Organization
* Payment
* Account

The multidimensional model provides a structured layer for aggregating and analyzing business indicators across different dimensions.

---

## 📊 Power BI Reporting

The reporting layer is implemented with **Microsoft Power BI**.

The project contains a Power BI report:

```text
Project Reports.pbix
```

The reports provide analytical views based on indicators such as:

* Revenue
* Number of requests
* Revenue by date
* Revenue by examination
* Revenue by organization
* Number of requests by date
* Number of requests by examination
* Number of requests by organization

Example exported analytical datasets are also present in the original project materials.

For the public portfolio version, these exports should only be included if they contain **synthetic or fully anonymized data**.

---

## 🗄️ Database & Data Model

The SQL layer contains scripts for the project's database and analytical environment.

The source entities include:

```text
PATIENT
MEDECIN
EXAMEN
DEMANDE
DEMANDE_EXAMEN
FACTURE
REGLEMENT
ORGANISME
TYPE_ORGANISME
MODE_PAIEMENT
COMPTE
```

The project separates operational/staging concerns from the analytical data-mart layer, allowing the BI pipeline to transform transactional data into structures suitable for reporting and multidimensional analysis.

---

## 🚀 Reproducing the Project

A complete local setup requires Microsoft BI tooling compatible with the project:

* Microsoft SQL Server
* SQL Server Integration Services (SSIS)
* SQL Server Analysis Services (SSAS)
* Visual Studio with the appropriate SQL Server Data Tools extensions
* Power BI Desktop

The general deployment workflow is:

```text
1. Create the SQL Server database
2. Create the staging environment
3. Create the data marts
4. Deploy and execute the SSIS ETL package
5. Deploy the SSAS multidimensional cube
6. Process the cube
7. Connect Power BI to the analytical layer
8. Open and explore the reports
```

> **Note:** Exact Visual Studio, SSDT, SQL Server, and SSAS versions should be documented once the development environment used for the original project has been confirmed.

---

## 💡 Skills Demonstrated

This project demonstrates practical experience in:

### Data Engineering

* Relational database development
* SQL development
* Data staging
* ETL pipeline design
* Data transformation
* Data integration

### Business Intelligence

* Data warehouse concepts
* Data-mart design
* Dimensional analysis
* OLAP modeling
* Multidimensional cubes
* KPI-oriented reporting

### Microsoft BI Stack

* SQL Server
* SSIS
* SSAS
* Power BI
* Visual Studio / SSDT

### Data Visualization

* Business reporting
* Time-based analysis
* Organizational analysis
* Examination/activity analysis
* Revenue analysis

---

## 🎓 Academic Context

This project was developed as an **academic Business Intelligence project** focused on applying the concepts of data warehousing, ETL, OLAP, and business reporting to a pharmacy/healthcare-oriented context.

The project demonstrates an end-to-end BI workflow rather than an isolated database or visualization exercise.

---

## 📌 Portfolio Disclaimer

This repository presents an academic project as part of a professional data and Business Intelligence portfolio.

The public version is intended to demonstrate the **architecture, engineering approach, analytical modeling, and reporting workflow** while respecting data privacy and confidentiality.

---

## 👤 Author

**Ismail Essbiti**

Business Intelligence & Data Engineering Portfolio

---

## 🔎 Project Keywords

`Business Intelligence` · `Data Warehouse` · `SQL Server` · `SSIS` · `SSAS` · `Power BI` · `ETL` · `OLAP` · `Data Marts` · `SQL` · `Data Engineering` · `Healthcare Analytics` · `Pharmacy Analytics`
