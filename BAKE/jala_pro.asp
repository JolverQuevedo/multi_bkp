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
ruc	= Request.QueryString("ruc") 

TBL = "RSCONCAR..CP" + CIA + "MAES"


CAD =   " Select AC_CCODIGO, AC_CNOMBRE From "&tbl&"    " & _
        " WHERE AC_CVANEXO='P' AND AC_CESTADO='V'       " & _
        " AND AC_CCODIGO='"&ruc&"'                      "

'RESPONSE.Write(CAD)
	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
		RS.MOVEFIRST
        cod = rs("AC_CCODIGO")
        des = rs("AC_CNOMBRE") %>
        <script language="javascript" type="text/jscript">
            COD = '<%=cod %>'
            DES = '<%=des %>'
            parent.window.document.all.RUC.value=COD
            parent.window.document.all.NOM.value=DES
        </script>
        <%else %>
            <script language="javascript" type="text/jscript">
                alert("RUC no registrado...")
                parent.window.document.all.RUC.value = ''
                parent.window.document.all.NOM.value=''
            </script>
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