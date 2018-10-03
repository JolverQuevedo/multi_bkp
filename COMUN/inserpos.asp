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
pos	= Request.QueryString("pos") 
op 	= Request.QueryString("op") 
CAN	= Request.QueryString("CAN") 
PRE	= Request.QueryString("PRE") 
ID	= Request.QueryString("ID") 
if ltrim(rtrim(can)) = "" then can = 0
if ltrim(rtrim(pre)) = "" then pre = 0
TBL =   "MULTI..POS" + CIA

cad =   " delete "&TBL&" where po = '"&pos&"' and estado = 'a' and ID = '"&ID&"' ;                  " & _
        " INSERT INTO "&TBL&" SELECT PP.PO,ES.ESTCLI, right(ES.CODARTICULO,5)+'00000' , PP.CLIENTE, " &  _
        " '"&can&"', '"&pre&"', ES.DESCRIPCION, '"&usr&"', getdate(), 'A' ,'' ,'' ,''               " & _
        " FROM   MODELADOR..POS AS PP                                                               " & _
        " INNER JOIN MODELADOR..CLIENTE AS CL ON PP.CLIENTE = CL.CODIGO                             " & _
        " INNER JOIN MODELADOR..ESTILOS AS ES ON pp.CLIENTE = ES.CLIENTE AND pp.codest = ES.CODEST  " & _
        " where  PP.ESTADO = 'a' AND PP.PO = '"&pos&"'                                              "

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
