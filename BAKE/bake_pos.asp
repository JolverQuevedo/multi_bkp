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
op 	= Request.QueryString("op") 
TBL =   "MULTI..POS" + CIA
CAD =   " SELECT PO, ESTADO FROM "&TBL&" AS PPPO WHERE PO = '"&POS&"' "
RESPONSE.Write(CAD)
RS.OPEN CAD, CNN
IF RS.RECORDCOUNT > 0 THEN
    RS.MOVEFIRST%>
    <script language="javascript" type="text/jscript">
        POS = '<%=RS("PO")%>'
        edo = '<%=rs("estado") %>'
     
        parent.window.alert("PO: " + POS + " ya existe con estado = " + edo)
        </script>
  <%response.end
  END IF  
  rs.close
CAD =   " SELECT PP.PO,ES.ESTCLI AS ESTILO, right(ES.CODARTICULO,5)+'00000' as ARTICULO,           " & _
        " ES.DESCRIPCION,PP.CLIENTE AS CLI, CL.NOMBRE AS CLIENTE,  PP.ESTADO AS EDO, es.CODEST     " & _
        " FROM   MODELADOR..POS AS PP                                                              " & _
        " INNER JOIN MODELADOR..CLIENTE AS CL ON PP.CLIENTE = CL.CODIGO                            " & _
        " INNER JOIN MODELADOR..ESTILOS AS ES ON pp.CLIENTE = ES.CLIENTE AND pp.codest = ES.CODEST " & _
        " where  PP.ESTADO = 'a' AND PP.PO = '"&pos&"'                                             "

RESPONSE.Write(CAD)
	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
		RS.MOVEFIRST
       %>
        <script language="javascript" type="text/jscript">
            op = parseInt('<%=op%>',10)
            est = '<%=rs("estilo")%>'
            cli = '<%=rs("cliente")%>'
            art = '<%=rs("articulo")%>'
            des = '<%=rs("descripcion")%>'
            ruc = '<%=rs("cli")%>'
 
            eval("parent.window.document.all.EST" + op + ".value=est")
            eval("parent.window.document.all.CLI" + op + ".value=cli")
            eval("parent.window.document.all.COD" + op + ".value=art")
            eval("parent.window.document.all.DES" + op + ".value=des")
            eval("parent.window.document.all.RUC" + op + ".value=ruc")
 
        </script>
        <%else %>
            <script language="javascript" type="text/jscript">
                alert("PO no ENCONTRADA...")
                op = parseInt('<%=op%>', 10)
                eval("parent.window.document.all.POS" + op + ".value=''")
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