<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>
<link rel="stylesheet" type="text/css" href="MULTISTY.CSS" >
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<form name="thisForm" METHOD="post"  >


	<div class="Estilo11" align="center">
		Movimiento de PO's POR CLIENTE - TEMPORADA
</div>	
<%' recibe tabla, primary key, y descripcion
tbl = "modelador..cliente"
DS = "NOMBRE"

cad =	"select * from "&TBL&" WHERE ESTADO = 'A' order by "&DS&" "
rs.open cad,cnn
IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST%>
<table align="center" border="1" width="50%">
<tr>
	<td ALIGN="center">	
		<select id="CLI" name="CLI" class="Data" onchange="CAMBIA()">
			<option value=''></option>
		<%DO WHILE NOT RS.EOF%>
			<option value='<%=TRIM(rs("codigo"))%>'><%=trim(rs("nombre"))%></option>
			<%RS.MOVENEXT%>
		<%LOOP%>
		</select>
	</TD>
    <td ALIGN="center">	
		<select id="TEM" name="TEM" class="Data" onchange="ENVIO()">
			<option value=''></option>
		</select>
	</TD>
</tr>

</table>
<iframe  width="100%" src="BLANCO.HTM" id="body10" name="body10" scrolling="yes" frameborder="0" height="250" width="100%" align="middle" style="display:block"></iframe>
<hr>
<%rs.close
set rs = nothing
set cnn=nothing%>
<SCRIPT>
function ENVIO() {
    cad = 'DETAacatemp.asp?pos=' + trim(thisForm.CLI.value) + '&tem=' + ltrim(document.all.TEM.value)
    //alert(parent.window.frames.item(1).name)
	parent.window.frames.item(1).window.location.replace(cad)
}
function CAMBIA() {

    document.all.body10.src = "BAKE/BAKEtemporada.asp?cli=" + trim(document.all.CLI.value) + '&sele=TEM';


}

</SCRIPT>
</BODY>
</HTML>
