      		select

			'Column_name'			= name,

			'Type'					= type_name(user_type_id),

			'Computed'				= case when ColumnProperty(object_id, name, 'IsComputed') = 0 then 'no' else 'si' end,

			'Length'					= convert(int, max_length),
			'Collation'		= collation_name

		from sys.all_columns where object_id = 2077250455