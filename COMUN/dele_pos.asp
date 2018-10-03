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

TBL1 = "multi..pos"+CIA
CAD =   " DELETE "&tbl1&" WHERE estado = 'a' and ltrim(rtrim(pe)) != '' or ltrim(rtrim(fac))= '0000';   " 
       'and pe ='' 
response.write(cad)
'response.end
Cnn.Execute(CAD)
%>
<script language="jscript" type="text/jscript">
    cad = '../prn_po.asp'
    window.parent.window.location.replace(cad)
</script>
</BODY>
</HTML>
