
USE bi_db_staging
GO
 IF NOT EXISTS(SELECT * FROM sys.schemas WHERE [name] = N'bi_db_staging')      
     EXEC (N'CREATE SCHEMA bi_db_staging')                                   
 GO                                                               

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'reglement'  AND sc.name = N'bi_db_staging'  AND type in (N'U'))
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
             WHERE so.name = N'reglement'  AND sc.name = N'bi_db_staging'  AND type in (N'U')
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

  DROP TABLE [bi_db_staging].[reglement]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bi_db_staging].[reglement]
(
   [id] int IDENTITY(163000, 1)  NOT NULL,
   [date] date  NOT NULL,
   [date_saisie] date  NOT NULL,
   [montant] float(24)  NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   [reference] varchar(24)  NULL,
   [id_facture] int  NOT NULL,
   [effectue_par] int  NOT NULL,
   [mode_paiement_id] int  NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bi_db_staging.reglement',
        N'SCHEMA', N'bi_db_staging',
        N'TABLE', N'reglement'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_reglement_id'  AND sc.name = N'bi_db_staging'  AND type in (N'PK'))
ALTER TABLE [bi_db_staging].[reglement] DROP CONSTRAINT [PK_reglement_id]
 GO



ALTER TABLE [bi_db_staging].[reglement]
 ADD CONSTRAINT [PK_reglement_id]
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
       WHERE so.name = N'reglement'  AND sc.name = N'bi_db_staging'  AND si.name = N'effectue_par' AND so.type in (N'U'))
   DROP INDEX [effectue_par] ON [bi_db_staging].[reglement] 
GO
CREATE NONCLUSTERED INDEX [effectue_par] ON [bi_db_staging].[reglement]
(
   [effectue_par] ASC
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
       WHERE so.name = N'reglement'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_facture' AND so.type in (N'U'))
   DROP INDEX [id_facture] ON [bi_db_staging].[reglement] 
GO
CREATE NONCLUSTERED INDEX [id_facture] ON [bi_db_staging].[reglement]
(
   [id_facture] ASC
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
       WHERE so.name = N'reglement'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_facture_2' AND so.type in (N'U'))
   DROP INDEX [id_facture_2] ON [bi_db_staging].[reglement] 
GO
CREATE NONCLUSTERED INDEX [id_facture_2] ON [bi_db_staging].[reglement]
(
   [id_facture] ASC
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
       WHERE so.name = N'reglement'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_facture_3' AND so.type in (N'U'))
   DROP INDEX [id_facture_3] ON [bi_db_staging].[reglement] 
GO
CREATE NONCLUSTERED INDEX [id_facture_3] ON [bi_db_staging].[reglement]
(
   [id_facture] ASC
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
       WHERE so.name = N'reglement'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_facture_4' AND so.type in (N'U'))
   DROP INDEX [id_facture_4] ON [bi_db_staging].[reglement] 
GO
CREATE NONCLUSTERED INDEX [id_facture_4] ON [bi_db_staging].[reglement]
(
   [id_facture] ASC
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
       WHERE so.name = N'reglement'  AND sc.name = N'bi_db_staging'  AND si.name = N'mode_paiement_id' AND so.type in (N'U'))
   DROP INDEX [mode_paiement_id] ON [bi_db_staging].[reglement] 
GO
CREATE NONCLUSTERED INDEX [mode_paiement_id] ON [bi_db_staging].[reglement]
(
   [mode_paiement_id] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'reglement$reglement_ibfk_1'  AND sc.name = N'bi_db_staging'  AND type in (N'F'))
ALTER TABLE [bi_db_staging].[reglement] DROP CONSTRAINT [reglement$reglement_ibfk_1]
 GO



ALTER TABLE [bi_db_staging].[reglement]
 ADD CONSTRAINT [reglement$reglement_ibfk_1]
 FOREIGN KEY 
   ([id_facture])
 REFERENCES 
   [bi_db_staging].[bi_db_staging].[facture]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'reglement$reglement_ibfk_2'  AND sc.name = N'bi_db_staging'  AND type in (N'F'))
ALTER TABLE [bi_db_staging].[reglement] DROP CONSTRAINT [reglement$reglement_ibfk_2]
 GO



ALTER TABLE [bi_db_staging].[reglement]
 ADD CONSTRAINT [reglement$reglement_ibfk_2]
 FOREIGN KEY 
   ([effectue_par])
 REFERENCES 
   [bi_db_staging].[bi_db_staging].[compte]     ([id_compte])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'reglement$reglement_ibfk_3'  AND sc.name = N'bi_db_staging'  AND type in (N'F'))
ALTER TABLE [bi_db_staging].[reglement] DROP CONSTRAINT [reglement$reglement_ibfk_3]
 GO



ALTER TABLE [bi_db_staging].[reglement]
 ADD CONSTRAINT [reglement$reglement_ibfk_3]
 FOREIGN KEY 
   ([mode_paiement_id])
 REFERENCES 
   [bi_db_staging].[bi_db_staging].[mode_paiement]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE bi_db_staging
GO
ALTER TABLE  [bi_db_staging].[reglement]
 ADD DEFAULT NULL FOR [montant]
GO

ALTER TABLE  [bi_db_staging].[reglement]
 ADD DEFAULT NULL FOR [reference]
GO

ALTER TABLE  [bi_db_staging].[reglement]
 ADD DEFAULT 0 FOR [id_facture]
GO

ALTER TABLE  [bi_db_staging].[reglement]
 ADD DEFAULT NULL FOR [mode_paiement_id]
GO

