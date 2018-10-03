<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>
<link href="../multisty.css" rel="stylesheet" type="text/css">
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HEAD>
</HEAD>
<BODY >
<HTML>
PROCESANDO...

<%	
pos = Request.QueryString("pos")

CAD =   " SELECT PP.PO,ES.ESTCLI AS ESTILO, right(ES.CODARTICULO,5)+'00000' as ARTICULO,           " & _
        " ES.DESCRIPCION,PP.CLIENTE AS CLI, CL.NOMBRE AS CLIENTE,  PP.ESTADO AS EDO, es.CODEST     " & _
        " FROM   MODELADOR..POS AS PP                                                              " & _
        " INNER JOIN MODELADOR..CLIENTE AS CL ON PP.CLIENTE = CL.CODIGO                            " & _
        " INNER JOIN MODELADOR..ESTILOS AS ES ON pp.CLIENTE = ES.CLIENTE AND pp.codest = ES.CODEST " & _
        " where  PP.ESTADO = 'a' AND PP.PO = '"&pos&"'                                             "
        RS.OPEN CAD,CNN
		if RS.RECORDCOUNT <= 0 then%>
			<script type="text/jscript" language="jscript">
			    alert("PO no registrada")
			    window.parent.thisForm.ECL.value = ''
			    window.parent.thisForm.EST.value = ''
			    window.parent.thisForm.DES.value = ''
            </script>
		<%else%>
		<%RS.MoveFirst%>
            <script type="text/jscript" language="jscript">
                window.parent.thisForm.ECL.value = '<%=trim(rs("ESTILO"))%>';
                window.parent.thisForm.EST.value = '<%=trim(rs("CODEST"))%>'
                window.parent.thisForm.DES.value = '<%=trim(rs("DESCRIPCION"))%>'
                window.parent.window.BAKE('')
			</script>	
        <%end if%>
		
</BODY>
</HTML>
