
USE bi_db_staging
GO
 IF NOT EXISTS(SELECT * FROM sys.schemas WHERE [name] = N'bi_db_staging')      
     EXEC (N'CREATE SCHEMA bi_db_staging')                                   
 GO                                                               

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'patient'  AND sc.name = N'bi_db_staging'  AND type in (N'U'))
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
             WHERE so.name = N'patient'  AND sc.name = N'bi_db_staging'  AND type in (N'U')
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

  DROP TABLE [bi_db_staging].[patient]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bi_db_staging].[patient]
(
   [id] int IDENTITY(110641, 1)  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   [code] varchar(10)  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   [sexe] varchar(1)  NOT NULL,
   [date] date  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0003: The following SQL clause was ignored during conversion: COMMENT '0 : non, 1: autre, 2: cnops, 3:cnss, 4:far'.
   */

   [assure] int  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bi_db_staging.patient',
        N'SCHEMA', N'bi_db_staging',
        N'TABLE', N'patient'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_patient_id'  AND sc.name = N'bi_db_staging'  AND type in (N'PK'))
ALTER TABLE [bi_db_staging].[patient] DROP CONSTRAINT [PK_patient_id]
 GO



ALTER TABLE [bi_db_staging].[patient]
 ADD CONSTRAINT [PK_patient_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO


USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'patient$code'  AND sc.name = N'bi_db_staging'  AND type in (N'UQ'))
ALTER TABLE [bi_db_staging].[patient] DROP CONSTRAINT [patient$code]
 GO



ALTER TABLE [bi_db_staging].[patient]
 ADD CONSTRAINT [patient$code]
 UNIQUE 
   NONCLUSTERED ([code] ASC)

GO


USE bi_db_staging
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'patient'  AND sc.name = N'bi_db_staging'  AND si.name = N'code_2' AND so.type in (N'U'))
   DROP INDEX [code_2] ON [bi_db_staging].[patient] 
GO
CREATE NONCLUSTERED INDEX [code_2] ON [bi_db_staging].[patient]
(
   [code] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE bi_db_staging
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'patient'  AND sc.name = N'bi_db_staging'  AND si.name = N'code_3' AND so.type in (N'U'))
   DROP INDEX [code_3] ON [bi_db_staging].[patient] 
GO
CREATE NONCLUSTERED INDEX [code_3] ON [bi_db_staging].[patient]
(
   [code] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE bi_db_staging
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'patient'  AND sc.name = N'bi_db_staging'  AND si.name = N'code_4' AND so.type in (N'U'))
   DROP INDEX [code_4] ON [bi_db_staging].[patient] 
GO
CREATE NONCLUSTERED INDEX [code_4] ON [bi_db_staging].[patient]
(
   [code] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE bi_db_staging
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'patient'  AND sc.name = N'bi_db_staging'  AND si.name = N'code_5' AND so.type in (N'U'))
   DROP INDEX [code_5] ON [bi_db_staging].[patient] 
GO
CREATE NONCLUSTERED INDEX [code_5] ON [bi_db_staging].[patient]
(
   [code] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE bi_db_staging
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'patient'  AND sc.name = N'bi_db_staging'  AND si.name = N'code_6' AND so.type in (N'U'))
   DROP INDEX [code_6] ON [bi_db_staging].[patient] 
GO
CREATE NONCLUSTERED INDEX [code_6] ON [bi_db_staging].[patient]
(
   [code] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO
