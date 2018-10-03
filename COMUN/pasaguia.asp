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
ori	= Request.QueryString("ori") 
des	= Request.QueryString("des") 
gui	= Request.QueryString("gui") 
glo	= Request.QueryString("glo") 


cad = "exec jacinta..sp_jalaguias '"&des&"',  '"&gui&"', '"&glo&"', '"&ori&"'"
'response.write(cad)
'response.end
Cnn.Execute(CAD)

rs.open "SELECT A1_NNUMENT FROM RSFACCAR..AL0012ALMA  Where A1_CALMA='"&des&"' ", cnn
rs.movefirst



%>
<table border="0" id="DATAENTRY" align="center" cellpadding="2" cellspacing="1">
     <tr>            
	    <td bgcolor="#f68b21" align="right" class="style1" width="15%">NOTA DE INGRESO : </td>
        <td><input value="<%= rs("A1_NNUMENT")%>"</td>
    </tr>
    <tr>
        <td colspan="2" align="center"><input type="button" onclick="atras()" value="REGRESAR" /> </td>
    </tr>
</table>

<script language="jscript" type="text/jscript">
    function atras() {
        cad = '../jalaguia.asp'
        window.location.replace(cad)
    }
</script>
</BODY>
</HTML>
