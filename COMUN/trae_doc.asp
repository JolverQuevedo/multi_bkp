<%@ Language=VBScript %>
<%Response.Buffer = TRUE %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%
alm = ucase(TRIM(Request.QueryString("alm")))
ctd = ucase(TRIM(Request.QueryString("tip")))
doc = ucase(TRIM(Request.QueryString("Doc")))


TBL1 = "RSFACCAR..AL"+CIA+"MOVc" 
TBL2 = "RS_ALMOVD" + CIA
TBL3 = "RS_ALMOVD_TALLA" + CIA
TBL4 = "RSFACCAR..AL"+CIA+"MOVD" 



'response.end


	cad = "exec UPDATE_DOC '"&alm&"', '"&ctd&"', '"&doc&"', '"&tbl1&"', '"&tbl2&"', '"&tbl3&"', '"&tbl4&"' "
'response.write(cad)
'response.end
Cnn.Execute(CAD)
%>

<script language="jscript" type="text/jscript">
 

    alert("Datos Actualizados!")

    window.parent.window.MANDA()
    window.close()
 
</script>
</BODY>
</HTML>
