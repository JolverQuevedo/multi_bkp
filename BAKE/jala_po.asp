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
pos	= Request.QueryString("pos") 
ecl	= Request.QueryString("ecl") 
if len(trim(ecl)) = 0 then 
    CAD =   " Select po from modelador..view_pos  where   po = '"&pos&"' "
else
    CAD =   " Select po from modelador..view_pos  where   po = '"&pos&"' and estcli = '"&ecl&"'"
end if
'RESPONSE.Write(CAD)
	RS.Open CAD, Cnn

	IF rs.recordcount <= 0 THEN %>
        <%if len(trim(ecl)) = 0 then %>
            <script language="javascript" type="text/jscript">
                alert("PO no registrada...")
                parent.window.document.all.POS.value = ''
            </script>
        <%else%>
            <script language="javascript" type="text/jscript">
            alert("PO no registrada para ese estilo...")
            parent.window.document.all.POS.value = ''
            </script>
        <%end if%>
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