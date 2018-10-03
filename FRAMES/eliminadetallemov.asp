<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Untitled Document</title>
</head>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->

<%
    doc = request.QueryString("numdoc")
    prod = request.QueryString("producto")
    linea = request.QueryString("linea")
    almacen = request.QueryString("almacen")
    
    cad =   " update RSFACCAR..AL"&cia&"STOC set SK_NSKDIS=SK_NSKDIS-x.C6_NCANTID from (select * from RSFACCAR..AL0001MOVD where C6_CNUMDOC='"+doc+"'  and C6_CCODIGO='"+prod+"' and C6_CITEM='"+linea+"' and C6_CALMA='"+almacen+"' ) X where x.C6_CCODIGO = SK_CCODIGO ;"
	cad = cad+  "delete from RSFACCAR..AL"&cia&"MOVD where C6_CNUMDOC='"+doc+"' and C6_CCODIGO='"+prod+"' and C6_CITEM='"+linea+"' and C6_CALMA='"+almacen+"'; "
    
    response.write(cad)    
    CNN.EXECUTE CAD    
    
%>

<body></body>
<script language="jscript" type="text/jscript">
    alert("<%=cad%>")
    this.window.close()
</script>
</html>
