<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<link REL="stylesheet" TYPE="text/css" HREF="../MULTISTY.CSS" >
<%
ecl	= Request.QueryString("ecl") 
cli = Request.QueryString("cli") 
if len(trim(cli)) > 0 then
    CAD =   " select * from modelador..estilos where cliente = '"&cli&"' and estcli = '"&ECL&"'"
else
    CAD =   " select * from modelador..estilos where estcli = '"&ECL&"'"
end if
RESPONSE.Write(CAD)
	RS.Open CAD, Cnn
	CONT = 1
	IF RS.recordcount > 0 THEN
		RS.MOVEFIRST
        des = rs("descripcion") %>
        <script language="javascript" type="text/jscript">
            DES = '<%=des %>'
            parent.window.document.all.DES.value = DES
           
        </script>
        <%else %>
            <%if len(trim(cli)) > 0 then %>
            <script language="javascript" type="text/jscript">
                alert("Estilo no registrado para este Cliente...")
                parent.window.document.all.ECL.value = ''
                parent.window.document.all.DES.value = 'no existe Estilo para este Cliente'
              
            </script>
            <%ELSE %>
                <script language="javascript" type="text/jscript">
                    alert("Estilo no registrado...")
                    parent.window.document.all.ECL.value = ''
                    parent.window.document.all.DES.value = 'no existe Estilo'
              
            </script>
            <%end if %>
	<%eND IF %>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">


</HEAD>
<BODY >


<%
	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
    </BODY>
</HTML>