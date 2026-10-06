
USE bi_db_staging
GO
 IF NOT EXISTS(SELECT * FROM sys.schemas WHERE [name] = N'bi_db_staging')      
     EXEC (N'CREATE SCHEMA bi_db_staging')                                   
 GO                                                               

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'demande_examen'  AND sc.name = N'bi_db_staging'  AND type in (N'U'))
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
             WHERE so.name = N'demande_examen'  AND sc.name = N'bi_db_staging'  AND type in (N'U')
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

  DROP TABLE [bi_db_staging].[demande_examen]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bi_db_staging].[demande_examen]
(
   [id] int IDENTITY(163120, 1)  NOT NULL,
   [id_demande] int  NOT NULL,
   [id_examen] int  NOT NULL,
   [prix] float(24)  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   [detail] varchar(20)  NOT NULL,
   [id_compte] int  NOT NULL,
   [date] date  NOT NULL,
   [heure] time  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bi_db_staging.demande_examen',
        N'SCHEMA', N'bi_db_staging',
        N'TABLE', N'demande_examen'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_demande_examen_id'  AND sc.name = N'bi_db_staging'  AND type in (N'PK'))
ALTER TABLE [bi_db_staging].[demande_examen] DROP CONSTRAINT [PK_demande_examen_id]
 GO



ALTER TABLE [bi_db_staging].[demande_examen]
 ADD CONSTRAINT [PK_demande_examen_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO


USE bi_db_staging
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'demande_examen'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_demande' AND so.type in (N'U'))
   DROP INDEX [id_demande] ON [bi_db_staging].[demande_examen] 
GO
CREATE NONCLUSTERED INDEX [id_demande] ON [bi_db_staging].[demande_examen]
(
   [id_demande] ASC
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
       WHERE so.name = N'demande_examen'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_demande_2' AND so.type in (N'U'))
   DROP INDEX [id_demande_2] ON [bi_db_staging].[demande_examen] 
GO
CREATE NONCLUSTERED INDEX [id_demande_2] ON [bi_db_staging].[demande_examen]
(
   [id_demande] ASC
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
       WHERE so.name = N'demande_examen'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_demande_3' AND so.type in (N'U'))
   DROP INDEX [id_demande_3] ON [bi_db_staging].[demande_examen] 
GO
CREATE NONCLUSTERED INDEX [id_demande_3] ON [bi_db_staging].[demande_examen]
(
   [id_demande] ASC
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
       WHERE so.name = N'demande_examen'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_demande_4' AND so.type in (N'U'))
   DROP INDEX [id_demande_4] ON [bi_db_staging].[demande_examen] 
GO
CREATE NONCLUSTERED INDEX [id_demande_4] ON [bi_db_staging].[demande_examen]
(
   [id_demande] ASC
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
       WHERE so.name = N'demande_examen'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_examen' AND so.type in (N'U'))
   DROP INDEX [id_examen] ON [bi_db_staging].[demande_examen] 
GO
CREATE NONCLUSTERED INDEX [id_examen] ON [bi_db_staging].[demande_examen]
(
   [id_examen] ASC
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
       WHERE so.name = N'demande_examen'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_examen_2' AND so.type in (N'U'))
   DROP INDEX [id_examen_2] ON [bi_db_staging].[demande_examen] 
GO
CREATE NONCLUSTERED INDEX [id_examen_2] ON [bi_db_staging].[demande_examen]
(
   [id_examen] ASC
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
       WHERE so.name = N'demande_examen'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_examen_3' AND so.type in (N'U'))
   DROP INDEX [id_examen_3] ON [bi_db_staging].[demande_examen] 
GO
CREATE NONCLUSTERED INDEX [id_examen_3] ON [bi_db_staging].[demande_examen]
(
   [id_examen] ASC
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
       WHERE so.name = N'demande_examen'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_examen_4' AND so.type in (N'U'))
   DROP INDEX [id_examen_4] ON [bi_db_staging].[demande_examen] 
GO
CREATE NONCLUSTERED INDEX [id_examen_4] ON [bi_db_staging].[demande_examen]
(
   [id_examen] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'demande_examen$demande_examen_ibfk_1'  AND sc.name = N'bi_db_staging'  AND type in (N'F'))
ALTER TABLE [bi_db_staging].[demande_examen] DROP CONSTRAINT [demande_examen$demande_examen_ibfk_1]
 GO



ALTER TABLE [bi_db_staging].[demande_examen]
 ADD CONSTRAINT [demande_examen$demande_examen_ibfk_1]
 FOREIGN KEY 
   ([id_demande])
 REFERENCES 
   [bi_db_staging].[bi_db_staging].[demande]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'demande_examen$demande_examen_ibfk_2'  AND sc.name = N'bi_db_staging'  AND type in (N'F'))
ALTER TABLE [bi_db_staging].[demande_examen] DROP CONSTRAINT [demande_examen$demande_examen_ibfk_2]
 GO



ALTER TABLE [bi_db_staging].[demande_examen]
 ADD CONSTRAINT [demande_examen$demande_examen_ibfk_2]
 FOREIGN KEY 
   ([id_examen])
 REFERENCES 
   [bi_db_staging].[bi_db_staging].[examen]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

