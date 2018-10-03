<%@ Language=VBScript %>
<% Response.Buffer = true %>

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title></title>
</head>
<body>
PROCESANDO...
<%	
pos	= Request.QueryString("us")
pwd	= Request.QueryString("pw")
CAD =  " SELECT nombres, clave FROM usuarios              " & _
       " WHERE USUARIO = '"&pos&"' and clave= '"&pwd&"'  " 
        
		RS.OPEN CAD, CNN
		RESPONSE.Write(cad)
		RESPONSE.Write("<br>")
		RESPONSE.Write(RS.RECORDCOUNT)
		'response.end
		if RS.RECORDCOUNT > 0 then%>
            <script type="text/jscript" language="jscript">
                parent.window.frmIngreso.oks.value = 'OK'				  
            </script>	
        <%else%>
            <script type="text/jscript" language="jscript">
                parent.window.frmIngreso.oks.value = 'PWD INCORRECTO'
                parent.window.alert("Contraseña invalida")
                parent.window.frmIngreso.txtpwd.focus();
            </script>	
		<%end if%>


</body>
</html>