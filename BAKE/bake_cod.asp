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

<script language="javascript" type="text/jscript">
  //  alert(eval("parent.window.document.all.COD" + 1 + ".value"))
</script>
<%
cod  =  Request.QueryString("pos")
op  =  Request.QueryString("op") 
TBL = "RSFACCAR..AL" + CIA + "ARTI"

CAD =	" select  AR_CCODIGO , AR_CDESCRI, ar_cunidad FROM "&TBL&" " & _
        " WHERE AR_CCODIGO = '"&cod&"'" 
RESPONSE.Write(CAD)

RESPONSE.Write("<br>")
RESPONSE.Write(op)
rs.open cad,cnn
if rs.recordcount <=0 then%>
    <script language="javascript" type="text/jscript">
        op = parseInt('<%=op %>', 10);
        des = 'ARTICULO NO EXISTE EN EL SOFCOM _ REAL'
        eval("parent.window.document.all.DES" + op + ".value=des");
    </script>

<%else %>
    <script language="javascript" type="text/jscript">
        op = parseInt('<%=op %>', 10);
        COD = '<%=rs("AR_CCODIGO") %>'
        DES = '<%=rs("AR_CDESCRI") %>'
        UNI = '<%=rs("ar_cunidad") %>'
        eval("parent.window.document.all.COD"+op+".value=COD");
        eval("parent.window.document.all.DES" + op + ".value=DES");
        eval("parent.window.document.all.UNI" + op + ".value=UNI");
</script>
<%end if
	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
    <HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">


</HEAD>
<BODY >
    </BODY>
</HTML>