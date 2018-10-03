<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->

<%Response.Buffer = TRUE %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************

OPE = ucase(TRIM(Request.QueryString("OPE")))
CAD = ""

if ope = "E" then
    cod = TRIM(Request.QueryString("COD"))
    des = ucase(TRIM(Request.QueryString("des")))
    cia = ucase(TRIM(Request.QueryString("cia")))
    tbl = ucase(TRIM(Request.QueryString("tbl")))
    CAD = "delete from "+tbl+" where calma='"+des+"' and cusuario='"+cod+"'"
    response.Write(cad)
    Cnn.Execute(CAD)
    RESPONSE.Write("<script language='javascript' type='text/jscript'>alert('eliminado');parent.location.replace = 'http://intranet/multi/comun/buscausralm.asp?usr="+cod+"&tabla="+tbl+"&cia="+cia+"'</script>")
else 
    if ope = "I" then
        cod = TRIM(Request.QueryString("COD"))
        des = ucase(TRIM(Request.QueryString("des")))
        cia = ucase(TRIM(Request.QueryString("cia")))
        tbl = ucase(TRIM(Request.QueryString("tbl")))
        CAD = "insert into "+tbl+" values('"+des+"','"+cod+"')"
        response.Write(cad)
        
        Cnn.Execute(CAD)
        RESPONSE.Write("<script language='javascript' type='text/jscript'>alert('Nuevo');parent.location.replace = 'http://intranet/multi/comun/buscausralm.asp?usr="+cod+"&tabla="+tbl+"&cia="+cia+"'</script>")
    end if
    if ope = "A" then
        cod = TRIM(Request.QueryString("COD"))
        des = ucase(TRIM(Request.QueryString("des")))
		cia = ucase(TRIM(Request.QueryString("cia")))
        old = ucase(TRIM(Request.QueryString("ciaold")))
        CAD = "update MULTI..[USR-CIA] set cia='"+des+"' where usuario='"+cod+"' and cia='"+old+"'"
        response.Write(cad)
        Cnn.Execute(CAD)
        RESPONSE.Write("<script language='javascript' type='text/jscript'>alert('Actualizado');parent.location.replace = 'http://intranet/multi/comun/buscausralm.asp?usr="+cod+"&tabla="+tbl+"&cia="+cia+"'</script>")
    end if
end if
    


'Cnn.close

%>

</BODY>
</HTML>
