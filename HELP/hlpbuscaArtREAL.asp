<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>
<link href="../multisty.css" rel="stylesheet" type="text/css">
</head>
<style>
.botonimagen{
  background-image:url('../images/lupa.png');
  background-repeat: no-repeat;
  background-position: left center;
  cursor:pointer;
  height:35px;
  width:35px;
}
</style>
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>
<title></title>
</head>

<body>
<form name="thisForm" id="thisForm" method="post" action="">
<%
opx = request.querystring("opp")
'*********************************************************************%>
<table align="center" width="100%" bgcolor="<%=application("color2") %>">
	<tr>
		<td align= left width="10%">
			<img src="../images/close.png" style="cursor:pointer;" 
			onclick="javascript: parent.window.close();">
		</td>
		<td align="center" width="85%" colspan="4">
			<font face=arial size= 2 color=DarkBlue><B>Art&iacute;culos</b></font>
		</td>
        <td width="5%" align="left"><input type="button" class="botonimagen" value="&nbsp;&nbsp;&nbsp;&nbsp;" onclick="veri()"/></td>
	</tr>
   
    <tr valign="middle">
    <td width="5%" align="right" class="titulito" bgcolor="<%=(Application("barra"))%>">
        CODIGO :        </td>
    <td width="5%" > 
        <input type="text" id="COD" name="COD" class="inputs" />
    </td>
    <td width="10%" bgcolor="<%=(Application("barra"))%>" class="titulito">
        DESCRIPCION :</td>
    <td bgcolor="#FFFFFF" colspan="3" WIDTH="70%"> 
        <input type="text" id="DES" name="DES"  style="width:100%"  />
    </td>
</tr>
       
</table>
</form>

<script language="jscript" type="text/jscript">
function veri() {
    if (trim(thisForm.COD.value) == '' && trim(thisForm.DES.value) == '') 
    {   alert("No hay nada que buscar")
        return true;
    }
    else {
     
        cad = 'HLPartREAL.asp?cod=' + trim(thisForm.COD.value) + '&des=' + ltrim(thisForm.DES.value) + '&opp='  +'<%=opx%>'
     //   alert(cad)
        parent.window.location.replace(cad)
        
    }
}
</script>
</body>
</html>
