<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->

<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
COD = ucase(TRIM(Request.QueryString("COD")))
DES = ucase(TRIM(Request.QueryString("DES")))

 
if COD <> "AUTO" then	

			CAD =	" UPDATE  menu set " & _
					" menu		= '"&COD&"',  " & _
					" desmenu	= '"&DES&"'  " & _
					" WHERE   " & _
					" menu = '"&COD&"' ; "
else	
	CAD =	" insert into menu SELECT TOP 1 RIGHT('00'+cast(MENU+1 as varchar(2)),2) as menu,'"+des+"' as desmenu FROM MENU ORDER BY MENU DESC"
End if

Cnn.Execute(CAD)
Cnn.close



%>
<script language="javascript" type="text/jscript">
    alert("Se registr�/actualiz� correctamente");
    

    window.parent.recargar();
    
	
</script>