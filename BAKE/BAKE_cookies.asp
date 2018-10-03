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

<%	
usr	= Request.QueryString("us")
pwd	= Request.QueryString("pw")
cia	= Request.QueryString("cia")

cad = "select * from usuarios where usuario = '"&usr&"' "
  rs.open cad,cnn
if rs.recordcount>0 then
    rs.movefirst
    usuario = rs("nombres")
    RESPONSE.COOKIES("multi")("usr") = USR
    RESPONSE.COOKIES("multi")("usrName") = Usuario
END IF
rs.close
  cad = "select * from view_cias where cia = '"&cia&"' "
  rs.open cad,cnn
if rs.recordcount>0 then
    rs.movefirst
    descia= rs("nombre")
    RESPONSE.COOKIES("multi")("cia") = cia
    RESPONSE.COOKIES("multi")("ciaName") = descia
END IF
%>
 <script type="text/jscript" language="jscript">
     this.window.close();
            </script>

	FIN
</body>
</html>