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
  background-image:url('../images/OK.PNG');
  background-repeat: no-repeat;
  background-position: left center;
  cursor:pointer;
  width:35px;
  height:35px;
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
<%'*********************************************************************%>
<table align="center" width="100%" bgcolor="<%=application("color2") %>" cellpadding="0" cellspacing="0" border="0">
	<tr>
		<td align="center" colspan="6" class="ESTILO2">Proveedores</td>
        <td width="40px" style="height:40px" align="right"><input type="button" class="botonimagen" value="&nbsp;&nbsp;&nbsp;&nbsp;" onClick="veri()"/></td>
	</tr>
    <tr valign="middle">
    <td width="5%" align="right" class="titulito" bgcolor="<%=(Application("barra"))%>">RUC :</td>
    <td width="19%" ><input type="text" id="COD" name="COD" class="barra333" style="width:100%; vertical-align:middle" />
    </td>
    <td width="15%" colspan="1" bgcolor="<%=(Application("barra"))%>" class="titulito" style="vertical-align:middle">
        RAZON SOCIAL :</td>
    <td bgcolor="#FFFFFF" colspan="5"> 
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
    else
    {   cad = 'HLPprovREAL.asp?cod=' + trim(thisForm.COD.value)+ '&des='+ltrim(thisForm.DES.value)
        parent.window.location.replace(cad)
        
    }
}
</script>
</body>
</html>
