SELECT		SCHEMA_NAME(SysT.schema_id) as SchemaName,
			SysT.name AS TableName
			,SysI.name AS IndexName
			,SysI.index_id
			,SysI.type_desc AS IndexType
			,sysi.allow_row_locks
			,sysi.allow_page_locks
            ,CASE SysI.is_primary_key 	WHEN 0 THEN 'no' WHEN 1 THEN 'YES'   END AS PrimaryKey
			,fill_factor
	FROM        sys.indexes AS SysI 
	INNER JOIN  sys.tables AS SysT ON SysI.object_id = SysT.object_id 
    WHERE sysI.allow_row_locks = 0 OR SysI.allow_page_locks = 0 
 ORDER BY SCHEMA_NAME(SysT.schema_id), SysT.name ,SysI.name
 
