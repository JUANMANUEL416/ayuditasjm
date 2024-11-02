!BRW1.SetFilter(Glo:Filtro)
if clip(GLO:FILTRO)=''
 BRW1::View:Browse{PROP:SQLFILTER}='A.ESTADO=<39>Activo<39>'
 loc:filtro = 'A.ESTADO=<39>Activo<39>'
else
 BRW1::View:Browse{PROP:SQLFILTER}=clip(GLO:FILTRO)&' AND A.ESTADO=<39>Activo<39>'
 loc:filtro = clip(GLO:FILTRO)&' AND A.ESTADO=<39>Activo<39>'
end
ThisWindow.Reset(1)


CLEAR (WDUM:RECORD)
LOC:SQL=' SELECT B.COMPROBANTE,B.NOREFERENCIA FROM FCJ A INNER JOIN MCP B ON  A.NROCOMPROBANTE=B.NROCOMPROBANTE'&CHR(12) &|
        '                                                INNER JOIN FCXPP C ON A.CODCAJA=C.CODCAJA AND A.CNSFACJ=C.CNSFACJ' &CHR(12) &|
        ' WHERE A.CNSFACJ='&FNSQLFMT(FCXPP:CNSFACJ) & ' AND A.CODCAJA='&FNSQLFMT(FCXPP:CODCAJA) & ' AND C.CNSFCXPP='& FNSQLFMT(FCXPP:CNSFCXP)
WDUM{PROP:SQL}=LOC:SQL
ACCESS:WDUM.NEXT()
LOC:TIPOCOM=WDU:C1
LOC:COMPROBANTE=WDU:C2

IF FnValidaAcceso(GLO:GRUPO,Globalerrors.getprocedurename(), '?Crecaudo') Then Unhide(?Crecaudo).


Frm:FCESCXC

LIST,AT(8,15,376,158),USE(?List1),HVSCROLL,VCR,FORMAT('10L|M@s20@25L|M~Tabla~@s2@80L|M~Campo~@s20@33R(2)|M~Registro~L(0)@n-7@320L|M~Err' &|
           'or~@s80@'),FROM(Glo:errorips),#ORIG(?List1),#FIELDS(GLO:CNT,Glo:tabla,Glo:Campo,Glo:Registro,Glo:Descerrorips)
		   
		   
		   kcs0 SERVICIOS EN TARIFA
		   KCS5 PLM:FILGCA