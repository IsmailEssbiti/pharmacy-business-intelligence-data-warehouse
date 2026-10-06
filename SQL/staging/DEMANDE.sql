
USE bi_db_staging
GO
 IF NOT EXISTS(SELECT * FROM sys.schemas WHERE [name] = N'bi_db_staging')      
     EXEC (N'CREATE SCHEMA bi_db_staging')                                   
 GO                                                               

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'demande'  AND sc.name = N'bi_db_staging'  AND type in (N'U'))
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
             WHERE so.name = N'demande'  AND sc.name = N'bi_db_staging'  AND type in (N'U')
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

  DROP TABLE [bi_db_staging].[demande]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bi_db_staging].[demande]
(
   [id] int IDENTITY(133688, 1)  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   [reference] varchar(25)  NOT NULL,
   [id_organisme] int  NOT NULL,
   [date_demande] date  NULL,
   [heure_demande] time  NOT NULL,
   [date_saisie] date  NOT NULL,
   [date_sortie] date  NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR(MAX) according to character set mapping for latin1 character set
   */

   [complement] varchar(max)  NOT NULL,
   [id_patient] int  NOT NULL,
   [e_o] smallint  NOT NULL,
   [etat] int  NOT NULL,
   [payeur] int  NOT NULL,
   [cree_par] int  NOT NULL,
   [id_medecin] int  NOT NULL,
   [etat_suivi] int  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   [num_prise_en_charge] varchar(15)  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bi_db_staging.demande',
        N'SCHEMA', N'bi_db_staging',
        N'TABLE', N'demande'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_demande_id'  AND sc.name = N'bi_db_staging'  AND type in (N'PK'))
ALTER TABLE [bi_db_staging].[demande] DROP CONSTRAINT [PK_demande_id]
 GO



ALTER TABLE [bi_db_staging].[demande]
 ADD CONSTRAINT [PK_demande_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO


USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'demande$reference'  AND sc.name = N'bi_db_staging'  AND type in (N'UQ'))
ALTER TABLE [bi_db_staging].[demande] DROP CONSTRAINT [demande$reference]
 GO



ALTER TABLE [bi_db_staging].[demande]
 ADD CONSTRAINT [demande$reference]
 UNIQUE 
   NONCLUSTERED ([reference] ASC)

GO


USE bi_db_staging
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'demande'  AND sc.name = N'bi_db_staging'  AND si.name = N'cree_par' AND so.type in (N'U'))
   DROP INDEX [cree_par] ON [bi_db_staging].[demande] 
GO
CREATE NONCLUSTERED INDEX [cree_par] ON [bi_db_staging].[demande]
(
   [cree_par] ASC
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
       WHERE so.name = N'demande'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_medecin' AND so.type in (N'U'))
   DROP INDEX [id_medecin] ON [bi_db_staging].[demande] 
GO
CREATE NONCLUSTERED INDEX [id_medecin] ON [bi_db_staging].[demande]
(
   [id_medecin] ASC
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
       WHERE so.name = N'demande'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_organisme' AND so.type in (N'U'))
   DROP INDEX [id_organisme] ON [bi_db_staging].[demande] 
GO
CREATE NONCLUSTERED INDEX [id_organisme] ON [bi_db_staging].[demande]
(
   [id_organisme] ASC
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
       WHERE so.name = N'demande'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_patient' AND so.type in (N'U'))
   DROP INDEX [id_patient] ON [bi_db_staging].[demande] 
GO
CREATE NONCLUSTERED INDEX [id_patient] ON [bi_db_staging].[demande]
(
   [id_patient] ASC
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
       WHERE so.name = N'demande'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_patient_2' AND so.type in (N'U'))
   DROP INDEX [id_patient_2] ON [bi_db_staging].[demande] 
GO
CREATE NONCLUSTERED INDEX [id_patient_2] ON [bi_db_staging].[demande]
(
   [id_patient] ASC
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
       WHERE so.name = N'demande'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_patient_3' AND so.type in (N'U'))
   DROP INDEX [id_patient_3] ON [bi_db_staging].[demande] 
GO
CREATE NONCLUSTERED INDEX [id_patient_3] ON [bi_db_staging].[demande]
(
   [id_patient] ASC
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
       WHERE so.name = N'demande'  AND sc.name = N'bi_db_staging'  AND si.name = N'id_patient_4' AND so.type in (N'U'))
   DROP INDEX [id_patient_4] ON [bi_db_staging].[demande] 
GO
CREATE NONCLUSTERED INDEX [id_patient_4] ON [bi_db_staging].[demande]
(
   [id_patient] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'demande$demande_ibfk_1'  AND sc.name = N'bi_db_staging'  AND type in (N'F'))
ALTER TABLE [bi_db_staging].[demande] DROP CONSTRAINT [demande$demande_ibfk_1]
 GO



ALTER TABLE [bi_db_staging].[demande]
 ADD CONSTRAINT [demande$demande_ibfk_1]
 FOREIGN KEY 
   ([id_patient])
 REFERENCES 
   [bi_db_staging].[bi_db_staging].[patient]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'demande$demande_ibfk_2'  AND sc.name = N'bi_db_staging'  AND type in (N'F'))
ALTER TABLE [bi_db_staging].[demande] DROP CONSTRAINT [demande$demande_ibfk_2]
 GO



ALTER TABLE [bi_db_staging].[demande]
 ADD CONSTRAINT [demande$demande_ibfk_2]
 FOREIGN KEY 
   ([cree_par])
 REFERENCES 
   [bi_db_staging].[bi_db_staging].[compte]     ([id_compte])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'demande$demande_ibfk_3'  AND sc.name = N'bi_db_staging'  AND type in (N'F'))
ALTER TABLE [bi_db_staging].[demande] DROP CONSTRAINT [demande$demande_ibfk_3]
 GO



ALTER TABLE [bi_db_staging].[demande]
 ADD CONSTRAINT [demande$demande_ibfk_3]
 FOREIGN KEY 
   ([id_organisme])
 REFERENCES 
   [bi_db_staging].[bi_db_staging].[organisme]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'demande$demande_ibfk_4'  AND sc.name = N'bi_db_staging'  AND type in (N'F'))
ALTER TABLE [bi_db_staging].[demande] DROP CONSTRAINT [demande$demande_ibfk_4]
 GO



ALTER TABLE [bi_db_staging].[demande]
 ADD CONSTRAINT [demande$demande_ibfk_4]
 FOREIGN KEY 
   ([id_medecin])
 REFERENCES 
   [bi_db_staging].[bi_db_staging].[medecin]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE bi_db_staging
GO
ALTER TABLE  [bi_db_staging].[demande]
 ADD DEFAULT N'' FOR [reference]
GO

ALTER TABLE  [bi_db_staging].[demande]
 ADD DEFAULT NULL FOR [date_demande]
GO

ALTER TABLE  [bi_db_staging].[demande]
 ADD DEFAULT NULL FOR [date_sortie]
GO

ALTER TABLE  [bi_db_staging].[demande]
 ADD DEFAULT 0 FOR [etat]
GO

