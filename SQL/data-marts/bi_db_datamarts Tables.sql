
USE bi_db_datamarts
GO
 IF NOT EXISTS(SELECT * FROM sys.schemas WHERE [name] = N'bi_datamarts')      
     EXEC (N'CREATE SCHEMA bi_datamarts')                                   
 GO                                                               

USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'compte_dim'  AND sc.name = N'bi_datamarts'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'compte_dim'  AND sc.name = N'bi_datamarts'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bi_datamarts].[compte_dim]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bi_datamarts].[compte_dim]
(
   [compte_id] int  NOT NULL,
   [Profil] nvarchar(255)  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bi_datamarts.compte_dim',
        N'SCHEMA', N'bi_datamarts',
        N'TABLE', N'compte_dim'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'date_dim'  AND sc.name = N'bi_datamarts'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'date_dim'  AND sc.name = N'bi_datamarts'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bi_datamarts].[date_dim]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bi_datamarts].[date_dim]
(
   [Date_ID] int  NOT NULL,
   [Jour] int  NOT NULL,
   [Mois] int  NOT NULL,
   [Annee] int  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bi_datamarts.date_dim',
        N'SCHEMA', N'bi_datamarts',
        N'TABLE', N'date_dim'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'exam_dim'  AND sc.name = N'bi_datamarts'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'exam_dim'  AND sc.name = N'bi_datamarts'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bi_datamarts].[exam_dim]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bi_datamarts].[exam_dim]
(
   [Exam_ID] int  NOT NULL,
   [Designation] nvarchar(255)  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bi_datamarts.exam_dim',
        N'SCHEMA', N'bi_datamarts',
        N'TABLE', N'exam_dim'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'non_organization_demande_fact'  AND sc.name = N'bi_datamarts'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'non_organization_demande_fact'  AND sc.name = N'bi_datamarts'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bi_datamarts].[non_organization_demande_fact]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bi_datamarts].[non_organization_demande_fact]
(
   [Date_id] int  NOT NULL,
   [Compte_id] int  NOT NULL,
   [Exam_id] int  NOT NULL,
   [Patient_id] int  NOT NULL,
   [CA] int  NOT NULL,
   [nbr_demande] int  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bi_datamarts.non_organization_demande_fact',
        N'SCHEMA', N'bi_datamarts',
        N'TABLE', N'non_organization_demande_fact'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'organization_demande_fact'  AND sc.name = N'bi_datamarts'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'organization_demande_fact'  AND sc.name = N'bi_datamarts'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bi_datamarts].[organization_demande_fact]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bi_datamarts].[organization_demande_fact]
(
   [Organization_ID] int  NOT NULL,
   [Exam_ID] int  NOT NULL,
   [Date_ID] int  NOT NULL,
   [Paiement_ID] int  NOT NULL,
   [CA] float(53)  NOT NULL,
   [nbr_demande] int  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bi_datamarts.organization_demande_fact',
        N'SCHEMA', N'bi_datamarts',
        N'TABLE', N'organization_demande_fact'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'organization_dim'  AND sc.name = N'bi_datamarts'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'organization_dim'  AND sc.name = N'bi_datamarts'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bi_datamarts].[organization_dim]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bi_datamarts].[organization_dim]
(
   [Organization_ID] int  NOT NULL,
   [Organization_Nom] nvarchar(255)  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bi_datamarts.organization_dim',
        N'SCHEMA', N'bi_datamarts',
        N'TABLE', N'organization_dim'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'paiement_dim'  AND sc.name = N'bi_datamarts'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'paiement_dim'  AND sc.name = N'bi_datamarts'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bi_datamarts].[paiement_dim]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bi_datamarts].[paiement_dim]
(
   [Paiement_ID] int  NOT NULL,
   [Libelle] nvarchar(255)  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bi_datamarts.paiement_dim',
        N'SCHEMA', N'bi_datamarts',
        N'TABLE', N'paiement_dim'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'patient_dim'  AND sc.name = N'bi_datamarts'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'patient_dim'  AND sc.name = N'bi_datamarts'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [bi_datamarts].[patient_dim]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bi_datamarts].[patient_dim]
(
   [patient_id] int  NOT NULL,
   [Genre] nvarchar(255)  NOT NULL,
   [Age] int  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bi_datamarts.patient_dim',
        N'SCHEMA', N'bi_datamarts',
        N'TABLE', N'patient_dim'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_compte_dim_compte_id'  AND sc.name = N'bi_datamarts'  AND type in (N'PK'))
ALTER TABLE [bi_datamarts].[compte_dim] DROP CONSTRAINT [PK_compte_dim_compte_id]
 GO



ALTER TABLE [bi_datamarts].[compte_dim]
 ADD CONSTRAINT [PK_compte_dim_compte_id]
   PRIMARY KEY
   CLUSTERED ([compte_id] ASC)

GO


USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_date_dim_Date_ID'  AND sc.name = N'bi_datamarts'  AND type in (N'PK'))
ALTER TABLE [bi_datamarts].[date_dim] DROP CONSTRAINT [PK_date_dim_Date_ID]
 GO



ALTER TABLE [bi_datamarts].[date_dim]
 ADD CONSTRAINT [PK_date_dim_Date_ID]
   PRIMARY KEY
   CLUSTERED ([Date_ID] ASC)

GO


USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_exam_dim_Exam_ID'  AND sc.name = N'bi_datamarts'  AND type in (N'PK'))
ALTER TABLE [bi_datamarts].[exam_dim] DROP CONSTRAINT [PK_exam_dim_Exam_ID]
 GO



ALTER TABLE [bi_datamarts].[exam_dim]
 ADD CONSTRAINT [PK_exam_dim_Exam_ID]
   PRIMARY KEY
   CLUSTERED ([Exam_ID] ASC)

GO


USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_non_organization_demande_fact_Date_id'  AND sc.name = N'bi_datamarts'  AND type in (N'PK'))
ALTER TABLE [bi_datamarts].[non_organization_demande_fact] DROP CONSTRAINT [PK_non_organization_demande_fact_Date_id]
 GO



ALTER TABLE [bi_datamarts].[non_organization_demande_fact]
 ADD CONSTRAINT [PK_non_organization_demande_fact_Date_id]
   PRIMARY KEY
   CLUSTERED ([Date_id] ASC, [Compte_id] ASC, [Exam_id] ASC, [Patient_id] ASC)

GO


USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_organization_demande_fact_Organization_ID'  AND sc.name = N'bi_datamarts'  AND type in (N'PK'))
ALTER TABLE [bi_datamarts].[organization_demande_fact] DROP CONSTRAINT [PK_organization_demande_fact_Organization_ID]
 GO



ALTER TABLE [bi_datamarts].[organization_demande_fact]
 ADD CONSTRAINT [PK_organization_demande_fact_Organization_ID]
   PRIMARY KEY
   CLUSTERED ([Organization_ID] ASC, [Exam_ID] ASC, [Date_ID] ASC, [Paiement_ID] ASC)

GO


USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_organization_dim_Organization_ID'  AND sc.name = N'bi_datamarts'  AND type in (N'PK'))
ALTER TABLE [bi_datamarts].[organization_dim] DROP CONSTRAINT [PK_organization_dim_Organization_ID]
 GO



ALTER TABLE [bi_datamarts].[organization_dim]
 ADD CONSTRAINT [PK_organization_dim_Organization_ID]
   PRIMARY KEY
   CLUSTERED ([Organization_ID] ASC)

GO


USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_paiement_dim_Paiement_ID'  AND sc.name = N'bi_datamarts'  AND type in (N'PK'))
ALTER TABLE [bi_datamarts].[paiement_dim] DROP CONSTRAINT [PK_paiement_dim_Paiement_ID]
 GO



ALTER TABLE [bi_datamarts].[paiement_dim]
 ADD CONSTRAINT [PK_paiement_dim_Paiement_ID]
   PRIMARY KEY
   CLUSTERED ([Paiement_ID] ASC)

GO


USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_patient_dim_patient_id'  AND sc.name = N'bi_datamarts'  AND type in (N'PK'))
ALTER TABLE [bi_datamarts].[patient_dim] DROP CONSTRAINT [PK_patient_dim_patient_id]
 GO



ALTER TABLE [bi_datamarts].[patient_dim]
 ADD CONSTRAINT [PK_patient_dim_patient_id]
   PRIMARY KEY
   CLUSTERED ([patient_id] ASC)

GO


USE bi_db_datamarts
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'non_organization_demande_fact'  AND sc.name = N'bi_datamarts'  AND si.name = N'Compte_id' AND so.type in (N'U'))
   DROP INDEX [Compte_id] ON [bi_datamarts].[non_organization_demande_fact] 
GO
CREATE NONCLUSTERED INDEX [Compte_id] ON [bi_datamarts].[non_organization_demande_fact]
(
   [Compte_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE bi_db_datamarts
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'organization_demande_fact'  AND sc.name = N'bi_datamarts'  AND si.name = N'Date_ID' AND so.type in (N'U'))
   DROP INDEX [Date_ID] ON [bi_datamarts].[organization_demande_fact] 
GO
CREATE NONCLUSTERED INDEX [Date_ID] ON [bi_datamarts].[organization_demande_fact]
(
   [Date_ID] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE bi_db_datamarts
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'organization_demande_fact'  AND sc.name = N'bi_datamarts'  AND si.name = N'Exam_ID' AND so.type in (N'U'))
   DROP INDEX [Exam_ID] ON [bi_datamarts].[organization_demande_fact] 
GO
CREATE NONCLUSTERED INDEX [Exam_ID] ON [bi_datamarts].[organization_demande_fact]
(
   [Exam_ID] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE bi_db_datamarts
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'non_organization_demande_fact'  AND sc.name = N'bi_datamarts'  AND si.name = N'Exam_id' AND so.type in (N'U'))
   DROP INDEX [Exam_id] ON [bi_datamarts].[non_organization_demande_fact] 
GO
CREATE NONCLUSTERED INDEX [Exam_id] ON [bi_datamarts].[non_organization_demande_fact]
(
   [Exam_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE bi_db_datamarts
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'organization_demande_fact'  AND sc.name = N'bi_datamarts'  AND si.name = N'Paiement_ID' AND so.type in (N'U'))
   DROP INDEX [Paiement_ID] ON [bi_datamarts].[organization_demande_fact] 
GO
CREATE NONCLUSTERED INDEX [Paiement_ID] ON [bi_datamarts].[organization_demande_fact]
(
   [Paiement_ID] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE bi_db_datamarts
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'non_organization_demande_fact'  AND sc.name = N'bi_datamarts'  AND si.name = N'Patient_id' AND so.type in (N'U'))
   DROP INDEX [Patient_id] ON [bi_datamarts].[non_organization_demande_fact] 
GO
CREATE NONCLUSTERED INDEX [Patient_id] ON [bi_datamarts].[non_organization_demande_fact]
(
   [Patient_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'non_organization_demande_fact$non_organization_demande_fact_ibfk_1'  AND sc.name = N'bi_datamarts'  AND type in (N'F'))
ALTER TABLE [bi_datamarts].[non_organization_demande_fact] DROP CONSTRAINT [non_organization_demande_fact$non_organization_demande_fact_ibfk_1]
 GO



ALTER TABLE [bi_datamarts].[non_organization_demande_fact]
 ADD CONSTRAINT [non_organization_demande_fact$non_organization_demande_fact_ibfk_1]
 FOREIGN KEY 
   ([Date_id])
 REFERENCES 
   [bi_db_datamarts].[bi_datamarts].[date_dim]     ([Date_ID])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'non_organization_demande_fact$non_organization_demande_fact_ibfk_2'  AND sc.name = N'bi_datamarts'  AND type in (N'F'))
ALTER TABLE [bi_datamarts].[non_organization_demande_fact] DROP CONSTRAINT [non_organization_demande_fact$non_organization_demande_fact_ibfk_2]
 GO



ALTER TABLE [bi_datamarts].[non_organization_demande_fact]
 ADD CONSTRAINT [non_organization_demande_fact$non_organization_demande_fact_ibfk_2]
 FOREIGN KEY 
   ([Compte_id])
 REFERENCES 
   [bi_db_datamarts].[bi_datamarts].[compte_dim]     ([compte_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'non_organization_demande_fact$non_organization_demande_fact_ibfk_3'  AND sc.name = N'bi_datamarts'  AND type in (N'F'))
ALTER TABLE [bi_datamarts].[non_organization_demande_fact] DROP CONSTRAINT [non_organization_demande_fact$non_organization_demande_fact_ibfk_3]
 GO



ALTER TABLE [bi_datamarts].[non_organization_demande_fact]
 ADD CONSTRAINT [non_organization_demande_fact$non_organization_demande_fact_ibfk_3]
 FOREIGN KEY 
   ([Exam_id])
 REFERENCES 
   [bi_db_datamarts].[bi_datamarts].[exam_dim]     ([Exam_ID])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'non_organization_demande_fact$non_organization_demande_fact_ibfk_4'  AND sc.name = N'bi_datamarts'  AND type in (N'F'))
ALTER TABLE [bi_datamarts].[non_organization_demande_fact] DROP CONSTRAINT [non_organization_demande_fact$non_organization_demande_fact_ibfk_4]
 GO



ALTER TABLE [bi_datamarts].[non_organization_demande_fact]
 ADD CONSTRAINT [non_organization_demande_fact$non_organization_demande_fact_ibfk_4]
 FOREIGN KEY 
   ([Patient_id])
 REFERENCES 
   [bi_db_datamarts].[bi_datamarts].[patient_dim]     ([patient_id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE bi_db_datamarts
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'organization_demande_fact$organization_demande_fact_ibfk_1'  AND sc.name = N'bi_datamarts'  AND type in (N'F'))
ALTER TABLE [bi_datamarts].[organization_demande_fact] DROP CONSTRAINT [organization_demande_fact$organization_demande_fact_ibfk_1]
 GO



ALTER TABLE [bi_datamarts].[organization_demande_fact]
 ADD CONSTRAINT [organization_demande_fact$organization_demande_fact_ibfk_1]
 FOREIGN KEY 
   ([Date_ID])
 REFERENCES 
   [bi_db_datamarts].[bi_datamarts].[date_dim]     ([Date_ID])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'organization_demande_fact$organization_demande_fact_ibfk_2'  AND sc.name = N'bi_datamarts'  AND type in (N'F'))
ALTER TABLE [bi_datamarts].[organization_demande_fact] DROP CONSTRAINT [organization_demande_fact$organization_demande_fact_ibfk_2]
 GO



ALTER TABLE [bi_datamarts].[organization_demande_fact]
 ADD CONSTRAINT [organization_demande_fact$organization_demande_fact_ibfk_2]
 FOREIGN KEY 
   ([Exam_ID])
 REFERENCES 
   [bi_db_datamarts].[bi_datamarts].[exam_dim]     ([Exam_ID])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'organization_demande_fact$organization_demande_fact_ibfk_3'  AND sc.name = N'bi_datamarts'  AND type in (N'F'))
ALTER TABLE [bi_datamarts].[organization_demande_fact] DROP CONSTRAINT [organization_demande_fact$organization_demande_fact_ibfk_3]
 GO



ALTER TABLE [bi_datamarts].[organization_demande_fact]
 ADD CONSTRAINT [organization_demande_fact$organization_demande_fact_ibfk_3]
 FOREIGN KEY 
   ([Organization_ID])
 REFERENCES 
   [bi_db_datamarts].[bi_datamarts].[organization_dim]     ([Organization_ID])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'organization_demande_fact$organization_demande_fact_ibfk_4'  AND sc.name = N'bi_datamarts'  AND type in (N'F'))
ALTER TABLE [bi_datamarts].[organization_demande_fact] DROP CONSTRAINT [organization_demande_fact$organization_demande_fact_ibfk_4]
 GO



ALTER TABLE [bi_datamarts].[organization_demande_fact]
 ADD CONSTRAINT [organization_demande_fact$organization_demande_fact_ibfk_4]
 FOREIGN KEY 
   ([Paiement_ID])
 REFERENCES 
   [bi_db_datamarts].[bi_datamarts].[paiement_dim]     ([Paiement_ID])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

