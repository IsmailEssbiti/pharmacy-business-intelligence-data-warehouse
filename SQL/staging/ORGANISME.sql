
USE bi_db_staging
GO
 IF NOT EXISTS(SELECT * FROM sys.schemas WHERE [name] = N'bi_db_staging')      
     EXEC (N'CREATE SCHEMA bi_db_staging')                                   
 GO                                                               

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'organisme'  AND sc.name = N'bi_db_staging'  AND type in (N'U'))
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
             WHERE so.name = N'organisme'  AND sc.name = N'bi_db_staging'  AND type in (N'U')
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

  DROP TABLE [bi_db_staging].[organisme]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bi_db_staging].[organisme]
(
   [id] int IDENTITY(1834, 1)  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   [nom] varchar(45)  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   [specialite] varchar(50)  NOT NULL,
   [type] int  NOT NULL,
   [favoris] int  NOT NULL,
   [id_compte] int  NOT NULL,
   [id_facture_template] int  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   [ice] varchar(20)  NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bi_db_staging.organisme',
        N'SCHEMA', N'bi_db_staging',
        N'TABLE', N'organisme'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_organisme_id'  AND sc.name = N'bi_db_staging'  AND type in (N'PK'))
ALTER TABLE [bi_db_staging].[organisme] DROP CONSTRAINT [PK_organisme_id]
 GO



ALTER TABLE [bi_db_staging].[organisme]
 ADD CONSTRAINT [PK_organisme_id]
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
       WHERE so.name = N'organisme'  AND sc.name = N'bi_db_staging'  AND si.name = N'type' AND so.type in (N'U'))
   DROP INDEX [type] ON [bi_db_staging].[organisme] 
GO
CREATE NONCLUSTERED INDEX [type] ON [bi_db_staging].[organisme]
(
   [type] ASC
)
WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY] 
GO
GO

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'organisme$organisme_ibfk_1'  AND sc.name = N'bi_db_staging'  AND type in (N'F'))
ALTER TABLE [bi_db_staging].[organisme] DROP CONSTRAINT [organisme$organisme_ibfk_1]
 GO



ALTER TABLE [bi_db_staging].[organisme]
 ADD CONSTRAINT [organisme$organisme_ibfk_1]
 FOREIGN KEY 
   ([type])
 REFERENCES 
   [bi_db_staging].[bi_db_staging].[type_organisme]     ([id])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION

GO


USE bi_db_staging
GO
ALTER TABLE  [bi_db_staging].[organisme]
 ADD DEFAULT NULL FOR [ice]
GO

