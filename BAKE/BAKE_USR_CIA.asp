﻿<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<script type="text/jscript" language="jscript">


</script>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
</head>
<body>
PROCESANDO...
<script type="text/jscript" language="jscript">
var aData = new Array()
var aVal = new Array()
xx=0

// se crea una variable llamada SELECT que captura el elemento del form que queremos llenar....
var select = parent.window.frmIngreso.DESCIA
// borra los elementos PRE - existentes
select.options.length = 0;
// ARTIFICIO PARA QUE EL PRIMER ELEMENTO SE MUESTRE EN BLANCO
select.options[0] = new Option('','');
// POR EL ARTIFICIO ANTERIOR SE TIENE QUE RETROCEDER EL INDICE DE LOS ARRAYS CON LA DATA 
// Y QUEDA              P E R F E C T O O O O O O O ! ! ! ! 
</script>
<%	

DATO	= Request.QueryString("pos")
sele	= Request.QueryString("sele")

  cad = "select * from usuarios where usuario = '"&dato&"' "
  rs.open cad,cnn
if rs.recordcount>0 then
    rs.movefirst
    usuario = rs("nombres")
    RESPONSE.COOKIES("multi")("usr") = USR%>
    <script type="text/jscript" language="jscript">
    nomb = '<%=usuario %>'
    parent.window.frmIngreso.user.value = nomb
    </script>
<%END IF
rs.close

CAD =  " SELECT cia, nombre             " & _
        " FROM VIEW_USR_CIA             " & _
        " WHERE USUARIO = '"&DATO&"'    " 
        
		RS.OPEN CAD, CNN
		RESPONSE.Write(cad)
		RESPONSE.Write("<br>")
		RESPONSE.Write(RS.RECORDCOUNT)
		'response.end
		if RS.RECORDCOUNT > 0 then%>
			<%rs.movefirst%>
            <%do while not rs.eof%>
                <script type="text/jscript" language="jscript">
					aData[xx]     = '<%=trim(rs("CIA"))%>';
					aVal[xx++]    = '<%=trim(rs("NOMBRE"))%>';
                </script>
				<%=RS("CIA")%>
            	<%RS.MOVENEXT%>
            <%loop%>
            <script type="text/jscript" language="jscript">
				 for(i=1; i <= xx; i++) 
				  	select.options[i] = new Option( aVal[i-1], aData[i-1]); 				  
             </script>	
		<%end if%>


	FIN
</body>
</html>