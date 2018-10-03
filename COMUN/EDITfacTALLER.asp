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
SRV = request.QueryString("SRV")
op = request.QueryString("op")
TBL1 = "multi..po_movi "
if trim(op) = "1" then
    CAD =   " update "&tbl1&" set FECPRO = '"&fec&"' WHERE  [id] = '"&idd&"' ;   " 
ELSEIF TRIM(OP)   = "2" THEN
    CAD =   " update "&tbl1&" set  FACPRO = '"&fac&"' WHERE  [id] = '"&idd&"' ;   " 
ELSE
    CAD =   " update "&tbl1&" set  NUMSER = '"&SRV&"' WHERE  [id] = '"&idd&"' ;   " 
END IF
       
response.write(cad)
Cnn.Execute(CAD)
%>
<script language="jscript" type="text/jscript">
    cad = '../detafacTALLER.asp'
   // parent.window.parent.window.llamame()
</script>
</BODY>
</HTML>
