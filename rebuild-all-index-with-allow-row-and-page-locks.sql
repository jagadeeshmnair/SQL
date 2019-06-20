DECLARE @TableName VARCHAR(255);
DECLARE @sql NVARCHAR(500);
DECLARE @fillfactor INT;
SET @fillfactor = 90;
SET NOCOUNT ON;
DECLARE TableCursor CURSOR FOR
SELECT	'['+SCHEMA_NAME(SysT.schema_id)+'].['+SysT.[name]+']' AS TableName
	FROM        sys.indexes AS SysI 
	INNER JOIN  sys.tables AS SysT ON SysI.object_id = SysT.object_id 
    WHERE sysI.allow_row_locks = 0 OR SysI.allow_page_locks = 0 
OPEN TableCursor;
FETCH NEXT FROM TableCursor INTO @TableName;
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @sql = 'ALTER INDEX ALL ON ' +@TableName+ ' REBUILD WITH (ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON);'
    EXEC (@sql);
    PRINT 'All indexes rebuilt for table: '+ @TableName
	FETCH NEXT FROM TableCursor INTO @TableName;
END;
CLOSE TableCursor;
DEALLOCATE TableCursor;
GO
