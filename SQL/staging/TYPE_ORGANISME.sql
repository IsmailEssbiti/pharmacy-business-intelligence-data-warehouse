
USE bi_db_staging
GO
 IF NOT EXISTS(SELECT * FROM sys.schemas WHERE [name] = N'bi_db_staging')      
     EXEC (N'CREATE SCHEMA bi_db_staging')                                   
 GO                                                               

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'type_organisme'  AND sc.name = N'bi_db_staging'  AND type in (N'U'))
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
             WHERE so.name = N'type_organisme'  AND sc.name = N'bi_db_staging'  AND type in (N'U')
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

  DROP TABLE [bi_db_staging].[type_organisme]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[bi_db_staging].[type_organisme]
(
   [id] int IDENTITY(9, 1)  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   [label] varchar(25)  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR according to character set mapping for latin1 character set
   */

   [labels] varchar(30)  NOT NULL,

   /*
   *   SSMA informational messages:
   *   M2SS0055: Data type was converted to VARCHAR(MAX) according to character set mapping for latin1 character set
   */

   [informations] varchar(max)  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'bi_db_staging.type_organisme',
        N'SCHEMA', N'bi_db_staging',
        N'TABLE', N'type_organisme'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO

USE bi_db_staging
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'PK_type_organisme_id'  AND sc.name = N'bi_db_staging'  AND type in (N'PK'))
ALTER TABLE [bi_db_staging].[type_organisme] DROP CONSTRAINT [PK_type_organisme_id]
 GO



ALTER TABLE [bi_db_staging].[type_organisme]
 ADD CONSTRAINT [PK_type_organisme_id]
   PRIMARY KEY
   CLUSTERED ([id] ASC)

GO

