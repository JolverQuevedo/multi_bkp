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
	<td class="estilo2" align="center" colspan="7">Reportes de Produccion anual</td>
</TR>    
<tr><td width="30%"></td>
<td class="Estilo9" valign="middle" align="right">A&ntilde;o
	<TD ALIGN=CENTER>	
		<SELECT ID="ano" NAME="ano" CLASS=DATOSGRANDE >
			<option value=''></option>
            <%for x = 2010 to year(date())%>
			<option value='<%=x %>'><%=x%></option>
            <%next %>
		</SELECT>
	</TD>
    <td class="Estilo9" valign="middle" align="right"><label for="Radio2">Tipo:&nbsp;&nbsp;</label></td> 
    <td class="Estilo9" align="left"><input type="Radio" name="Radio2" id="Radio2" value="P" checked>Pantalla</td>
    <td class="Estilo9" align="left"><input type="Radio" name="Radio2" id="Radio2" value="E" >Excel</td>
    <td width="30%" align="left"><input type="button" value="enviar" onclick="ENVIO()"</td>   


</TR>
<TR><td COLSPAN=3><HR></td></TR>
</table>
<SCRIPT>
function ENVIO() {
    if (document.all.Radio2[0].checked == true)
        tipo = "P"
    else 
        tipo ="E"
    if (document.all.ano.value == '') {
        alert("Favor Seleccionar el anio")
        return false;
        }
    cad = 'reportes/prnprod_real.asp?anio=' + trim(thisForm.ano.value) + '&tip=' + tipo
    //alert(top.window.frames.length)

    top.window.frames.item(0).frames.item(1).window.location.replace(cad)
    top.window.parent.window.calcHeight()

//top.window.frames[1].item(1).window.location.replace(cad)


//	window.frames[1].window.location.replace(cad)


}
</SCRIPT>
</BODY>
</HTML>
