<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<script type="text/jscript" language="jscript">
    var aCod = Array() 
var oldrow = 1
function calcHeight()
{
  //find the height of the internal page
  var the_height=
    document.getElementById('body0').contentWindow.
      document.body.scrollHeight+25;
  //change the height of the iframe
  document.getElementById('body0').height=
      the_height;
}
</script>
<%
	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation   = 3
	RS.CursorType       = 3    
	RS.LockType         = 1 	
    ' DATOS DE CABECERA
    TBL = "POS" + CIA 
    cad =   " SELECT PP.PO,ES.ESTCLI AS ESTILO, right(ES.CODARTICULO,5)+'00000' as ARTICULO, ES.DESCRIPCION,    " & _
            " PP.CLIENTE AS CLI, CL.NOMBRE AS CLIENTE,  PP.ESTADO AS EDO, es.CODEST ,                           " & _
            " ppo.CANTIDAD, PPO.PRECIO                                                                          " & _
            " FROM   MODELADOR..POS AS PP                                                                       " & _
            " INNER JOIN MODELADOR..CLIENTE AS CL ON PP.CLIENTE = CL.CODIGO                                     " & _
            " INNER JOIN MODELADOR..ESTILOS AS ES ON pp.CLIENTE = ES.CLIENTE AND pp.codest = ES.CODEST          " & _
            " FULL OUTER JOIN "&TBL&" AS PPO ON PPO.PO = PP.PO                                                  " & _
            " where  PP.ESTADO = 'a'                                                                            " & _
            " AND PP.PO IN (SELECT PO FROM "&TBL&" AS PPPO WHERE PP.PO = PPPO.PO AND PPPO.ESTADO='A') ORDER BY [ID]    "
   ' RESPONSE.WRITE(CAD)
        rs.open cad, cnn
 
    
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link href="multisty.css" rel="stylesheet" type="text/css">
</head>
<body >
<form id="thisForm" method="post" name="thisForm" action="">

<table align="center"  bordercolor="#FFFFFF"  cellpadding="0"  cellspacing="0"  border="1" width="100%">
	<tr><td align="left" class="Estilo4">Pos sin parte de Entrada</td></tr>
</table>

<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>
<table  border="1" cellspacing="1" cellpadding="1" align="left" width="100%">
    <tr class="Estilo8" align="center">
        <td >PO</td> 
        <td >ESTILO</td>
        <td >CLIENTE</td>
        <td >ARTICULO</td>
        <td>DESCRIPCION</td>
        <td>CANTIDAD</td>
        <td >PRECIO</td>
        <td>CODCLI</td>
    </tr>
<%i =1
IF RS.RECORDCOUNT > 0 THEN rs.movefirst

DO WHILE NOT RS.EOF %>
<tr id="LIN<%=i%>" name="LIN<%=i%>" >      
       <td><%=RS("PO")%>&nbsp;</td>
       <td><%=RS("ESTILO")%>&nbsp;</td>        
       <td><%=RS("CLIENTE") %>&nbsp;</td>
       <td><%=RS("ARTICULO") %>&nbsp;</td>
       <td><%=RS("DESCRIPCION") %>&nbsp;</td>
       <td><%=formatnumber(RS("CANTIDAD"),0,,true)%></td>
       <td><%=formatnumber(RS("PRECIO"),2,,true)%></td>
       <td><%=RS("CLI")%>&nbsp;</td> 
    </tr>
    <%i = i + 1 %>
    <%RS.MOVENEXT %>
<%LOOP %>
</table>


<script type="text/jscript" language="jscript">

var opc  = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no," ;
	opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900" ;

	function previu()
	{ window.open('reportes/pos_pendientes.asp')}


</script>
<%RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>