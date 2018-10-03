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

TBL = "RSFACCAR..al" + CIA + "tran"


CAD =   " Select * From "&tbl&"         " & _
        " Where TR_CCODIGO='"&ruc&"'    "

'RESPONSE.Write(CAD)
	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
		RS.MOVEFIRST
        cod = rs("tr_CCODIGO")
        des = rs("tr_CNOMBRE") %>
        <script language="javascript" type="text/jscript">
            COD = '<%=cod %>'
            DES = '<%=des %>'
            parent.window.document.all.tra.value=COD
            parent.window.document.all.dtr.value=DES
        </script>
        <%else %>
            <script language="javascript" type="text/jscript">
                alert("Transportista no registrado...")
                parent.window.document.all.tra.value = ''
                parent.window.document.all.dtr.value=''
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