create  Procedure sp_export_to_excel      
@tablename sysname,      
 @ruta varchar(1000),  
@filename varchar(500)     
As      
declare @Sqlcmd varchar(1000)      
declare @SqlShell varchar(1000)    
Set @Sqlcmd = 'SELECT top (10) * FROM '  +'basedatos.dbo.'+@tablename       
Set @SqlShell = 'EXEC xp_cmdshell ' +char(39) +'bcp' +' "'+@Sqlcmd+'"'+  ' QUERYOUT '+ '"'+@ruta+@filename+'"' +' -T -c -t"\t"'+char(39)      
    
Begin      
Execute  (@SqlShell)      
     
end 


exec sp_export_to_excel 'tutabla','\\rutaservidor\','archivo.xls'