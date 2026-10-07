# SSIS ETL — BI_Pharmacie

This folder contains the SQL Server Integration Services (SSIS) ETL project used to populate the BI data-mart layer.

## ETL package

The main package is:

- `Fill_DataMarts.dtsx`

The package contains the ETL workflow for loading the BI data marts and includes dimension/fact-oriented data flows from the staging layer to the reporting data marts.

## Connection configuration

The public version intentionally does **not** contain the original machine-specific configuration or encrypted user-sensitive settings.

Before running the package, configure these connections in SQL Server Data Tools (SSDT):

### 1. MySQL source

Connection used for the source database:

```text
Server: YOUR_MYSQL_HOST
Port: 3307
Database: bi_db
```

Configure authentication according to your local environment. Do not commit passwords or other credentials to Git.

### 2. SQL Server staging database

Connection name:

```text
LocalHost.bi_db_staging
```

Configure it to point to your local SQL Server staging database:

```text
Server: YOUR_SQL_SERVER_INSTANCE
Database: bi_db_staging
Authentication: Windows Authentication (recommended)
```

### 3. SQL Server data-mart database

Connection name:

```text
LocalHost.bi_db_datamarts
```

Configure it to point to:

```text
Server: YOUR_SQL_SERVER_INSTANCE
Database: bi_db_datamarts
Authentication: Windows Authentication (recommended)
```

## Before running the ETL

1. Create the required source, staging, and data-mart databases.
2. Execute the public SQL schema scripts from the repository.
3. Configure the three connection managers for your local environment.
4. Verify that the required SQL Server and MySQL drivers/providers are installed.
5. Open `Fill_DataMarts.dtsx` in SSDT.
6. Test the connection managers.
7. Execute the package.

## Privacy and security

The original academic project used real laboratory/patient data. The public repository therefore excludes the original database dumps and any real records.

The repository must not contain:

- patient or laboratory records;
- production database exports;
- passwords or credentials;
- encrypted user-specific SSIS secrets;
- local user or computer identifiers;
- compiled `.ispac` deployment packages;
- `bin/` or `obj/` build artifacts.

Use synthetic or anonymized data when reproducing the project publicly.
```
