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
idd = request.QueryString("id")
fec = request.QueryString("fec")
fac = request.QueryString("fac")
TBL1 = "multi..po_movi "
CAD =   " update "&tbl1&" set fecemb = null, facexp = null "
cad = cad + " WHERE  [id] = '"&idd&"' ;   " 
       
response.write(cad)
Cnn.Execute(CAD)
%>
<script language="jscript" type="text/jscript">
    cad = '../detaACAfac.asp'
    parent.window.location.replace(cad)
</script>
</BODY>
</HTML>
