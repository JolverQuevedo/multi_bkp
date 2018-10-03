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
		Movimiento de PO's POR CLIENTE
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
		<select id="CLI" name="CLI" class="Data" onchange="ENVIO()">
			<option value=''></option>
		<%DO WHILE NOT RS.EOF%>
			<option value='<%=TRIM(rs("codigo"))%>'><%=trim(rs("nombre"))%></option>
			<%RS.MOVENEXT%>
		<%LOOP%>
		</select>
	</TD>
</tr>

</table>
<hr>
<%rs.close
set rs = nothing
set cnn=nothing%>
<SCRIPT>
function ENVIO()
{	cad = 'DETAacabados.asp?pos='+trim(thisForm.CLI.value)
    //alert(parent.window.frames.item(1).name)
	parent.window.frames.item(1).window.location.replace(cad)
}
</SCRIPT>
</BODY>
</HTML>
