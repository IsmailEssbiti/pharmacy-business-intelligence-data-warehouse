
USE bi_db_staging
GO
 IF NOT EXISTS(SELECT * FROM sys.schemas WHERE [name] = N'bi_db_staging')      
     EXEC (N'CREATE SCHEMA bi_db_staging')                                   
 GO                                                               

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'facture'  AND sc.name = N'bi_db_staging'  AND type in (N'U'))
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
             WHERE so.name = N'facture'  AND sc.name = N'bi_db_staging'  AND type in (N'U')
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

  DROP TABLE [bi_db_staging].[facture]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bi_db_staging].[facture]
(
   [id] int IDENTITY(133554, 1)  NOT NULL,
   [total_calcule] float(24)  NULL,
   [remise] numeric(10, 0)  NULL,
   [tar] float(24)  NULL,
   [total_a_payer] float(24)  NULL,
   [id_demande] int  NOT NULL,
   [etat] int  NOT NULL,
   [date] date  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR(MAX) according to character set mapping for latin1 character set
   */

   [raison_remise] varchar(max)  NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bi_db_staging.facture',
        N'SCHEMA', N'bi_db_staging',
        N'TABLE', N'facture'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_facture_id'  AND sc.name = N'bi_db_staging'  AND type in (N'PK'))
ALTER TABLE [bi_db_staging].[facture] DROP CONSTRAINT [PK_facture_id]
 GO



ALTER TABLE [bi_db_staging].[facture]
 ADD CONSTRAINT [PK_facture_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO


USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'facture$id_demande_5'  AND sc.name = N'bi_db_staging'  AND type in (N'UQ'))
ALTER TABLE [bi_db_staging].[facture] DROP CONSTRAINT [facture$id_demande_5]
 GO



ALTER TABLE [bi_db_staging].[facture]
 ADD CONSTRAINT [facture$id_demande_5]
 UNIQUE 
   NONCLUSTERED ([id_demande] ASC)

GO


USE bi_db_staging
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'facture'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_demande' AND so.type in (N'U'))
   DROP INDEX [id_demande] ON [bi_db_staging].[facture] 
GO
CREATE NONCLUSTERED INDEX [id_demande] ON [bi_db_staging].[facture]
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
       WHERE so.name = N'facture'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_demande_2' AND so.type in (N'U'))
   DROP INDEX [id_demande_2] ON [bi_db_staging].[facture] 
GO
CREATE NONCLUSTERED INDEX [id_demande_2] ON [bi_db_staging].[facture]
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
       WHERE so.name = N'facture'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_demande_3' AND so.type in (N'U'))
   DROP INDEX [id_demande_3] ON [bi_db_staging].[facture] 
GO
CREATE NONCLUSTERED INDEX [id_demande_3] ON [bi_db_staging].[facture]
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
       WHERE so.name = N'facture'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_demande_4' AND so.type in (N'U'))
   DROP INDEX [id_demande_4] ON [bi_db_staging].[facture] 
GO
CREATE NONCLUSTERED INDEX [id_demande_4] ON [bi_db_staging].[facture]
(
   [id_demande] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'facture$facture_ibfk_1'  AND sc.name = N'bi_db_staging'  AND type in (N'F'))
ALTER TABLE [bi_db_staging].[facture] DROP CONSTRAINT [facture$facture_ibfk_1]
 GO



ALTER TABLE [bi_db_staging].[facture]
 ADD CONSTRAINT [facture$facture_ibfk_1]
 FOREIGN KEY 
   ([id_demande])
 REFERENCES 
   [bi_db_staging].[bi_db_staging].[demande]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE bi_db_staging
GO
ALTER TABLE  [bi_db_staging].[facture]
 ADD DEFAULT NULL FOR [total_calcule]
GO

ALTER TABLE  [bi_db_staging].[facture]
 ADD DEFAULT NULL FOR [remise]
GO

ALTER TABLE  [bi_db_staging].[facture]
 ADD DEFAULT NULL FOR [tar]
GO

ALTER TABLE  [bi_db_staging].[facture]
 ADD DEFAULT NULL FOR [total_a_payer]
GO

ALTER TABLE  [bi_db_staging].[facture]
 ADD DEFAULT NULL FOR [raison_remise]
GO

