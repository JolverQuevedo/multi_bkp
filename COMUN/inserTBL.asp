<%@ Language=VBScript %>
<%Response.Buffer = TRUE %>
<%	usr     = ucase(Request.Cookies("multi")("USR"))
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../comun/funcionescomunes.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body>
<% 
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
CHK = Request.QueryString("chk")
COD = ucase(TRIM(Request.QueryString("pos")))
DES = ucase(TRIM(Request.QueryString("DES")))
TBL = TRIM(Request.QueryString("TBL"))
PK  = TRIM(Request.QueryString("PK"))
DS  = TRIM(Request.QueryString("DS"))
URL = TRIM(Request.QueryString("URL"))
largo = TRIM(Request.QueryString("l1"))
largo2 = TRIM(Request.QueryString("l2"))
FECHA ="{ fn NOW() }"


cad = "select "&pk&", "&ds&" from "&tbl&" where "&ds&" = '"&des&"' and estado= 'a'"
rs.open cad,cnn

if rs.recordcount > 0 and chk = "0" then
    rs.movefirst
    cod= rs.fields.item(0)
    response.Write(cad)
%>
<script type="text/jscript" language="jscript">
alert("Descriptor duplicado")
cad = trim('<%=url%>')+ 'perfil=1&pos='+ '<%=trim(cod)%>'
parent.window.location.replace(cad)
</script>

<%
response.End
end if
rs.close

CAD = " SELECT "&PK&" FROM "&TBL&" WHERE "&PK&"='"&COD&"' "
'response.Write(cad)

rs.open cad,cnn
'response.Write(rs.recordcount)
'response.end
TOTALREG = rs.recordcount
RS.CLOSE
IF TOTALREG>0 THEN	
	if chk = "1"  then
		CAD =	" UPDATE "&TBL&"                " & _
        		" SET  USUARIO = '"&usr&"',     " & _
			    " FECHA = "&fecha&" ,           " & _
			    " ESTADO = 'E'	                " & _ 
			    " WHERE "&PK&" = '"&COD&"';     "
			    cod=""
	else
    CAD =	" UPDATE  "&TBL&" set               " & _
				" "&DS&" = '"&DES&"',           " & _ 
				" ESTADO = 'A',                 " & _
				" USUARIO = '"&usr&"',          " & _
				" FECHA = "&fecha&"             " & _
				" WHERE   "&PK&" = '"&COD&"';   "
	end if
    	
else
    if 	trim(cod) = "AUTO" then
        rs.open "select count(*) from "&tbl&"", cnn
        xx = ""
        for i=0 to largo
            xx = xx + "0"
        next
        if rs.recordcount > 0  then
            cod = xx + trim(cstr(rs.fields.item(0)+1))    
            cod = right(cod,largo)
        ELSE
            cod = xx
        end if    
    end if        

	CAD = 	" insert into "&TBL&"               " & _
			" ("&PK&", "&DS&", ESTADO,          " & _
			" usuario, fecha )                  " & _
			" values('"&COD&"', '" & DES & "',  " & _
			"  'A', '"&usr&"', "&fecha&" )  " 
End if
' Inicia transacción , para que los datos no queden a medias
RESPONSE.WRITE("<br>")
RESPONSE.WRITE(CAD)
'RESPONSE.END
Cnn.BeginTrans	
Cnn.Execute(CAD)
if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>
<script language="javascript" type="text/jscript">
tbl = '<%=tbl %>'
cad =trim('<%=url%>') + 'pos=' +  '<%=trim(cod)%>' + '&tbl=' + '<%=trim(tbl)%>'
cad += '&l1=' + '<%=largo%>' + '&l2=' + '<%=largo2%>'
//alert(cad)
parent.window.location.replace(cad);

</script>
</BODY>
</HTML>
