<%@ Language=VBScript %>
<% Response.Buffer = true %>

<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<link href="multisty.css" rel="stylesheet" type="text/css">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<form name="thisForm" METHOD="post"  >
<table WIDTH=100% border="0">
<tr> 
	<td class="estilo2" align="center" colspan="7">Reporte de Guias</td>
</TR>    
<tr><td width="20%"></td>
    <td class="Estilo9" valign="middle" align="right">Guias Nro.
	<td align="center" width="30%"><input id="GUI" name="GUI" value="" style="width:100%" class="Estilo9" /></td>
    <td class="Estilo9" valign="middle" align="right"><label for="Radio2">Tipo:&nbsp;&nbsp;</label></td> 
    <td class="Estilo9" align="left"><input type="Radio" name="Radio2" id="Radio2" value="P" checked>Pantalla</td>
    <td class="Estilo9" align="left"><input type="Radio" name="Radio2" id="Radio2" value="E" >Excel</td>
    <td width="30%" align="left"><input type="button" value="enviar" onclick="ENVIO()"</td>   


</TR>

</table><HR>
<SCRIPT>
function ENVIO() {
    if (document.all.Radio2[0].checked == true)
        tipo = "P"
    else 
        tipo ="E"
    if (trim(document.all.GUI.value) == '') {
        alert("Favor Informar al menos una guia")
        return false;
    }
    ss = trim(thisForm.GUI.value)
    off = ''
    while (ss.length > 0) {
        off += strzero(Left(ss, ss.indexOf(",")), 8) + "*";
        ss = Right(ss, ss.length - ss.indexOf(",") - 1)
        if (ss.indexOf(",") == -1) {
            off += strzero(trim(ss), 8) + "*";
            ss = ''
        }
    }


    off = "'" + Left(off, off.length - 1) + "'"





    cad = 'reportes/prnconsulgui.asp?gui=' + off + '&xls=' + tipo
    //alert(top.window.frames.length)

    top.window.frames.item(0).frames.item(1).window.location.replace(cad)
    top.window.parent.window.calcHeight()

//top.window.frames[1].item(1).window.location.replace(cad)


//	window.frames[1].window.location.replace(cad)


}
</SCRIPT>
</BODY>
</HTML>
