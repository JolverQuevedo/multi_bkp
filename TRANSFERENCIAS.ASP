﻿<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<link href="multisty.css" rel="stylesheet" type="text/css">




<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<script language="jscript" type="text/jscript">
    function MANDA() {
        cabe =
        window.location.href("transferencias.asp?op=1")

    }
    </script>
<body  >
<table  border="0" cellspacing="0" cellpadding="1" align="center">
  <tr><td colspan="2" height="20px">&nbsp;</td>  </tr>
  <tr align="LEFT">
    <td colspan="2"><img src="IMAGES/HEAD_LOGIN.PNG" border="0" /></td>
  </tr>
  <tr><td colspan="2" height="5 px"></td>  </tr>
  <tr>
    <td width="60px" ><input type="text" class="data" id="cabe" name="cabe" style="text-align:center" VALUE=""/></td>
    <td align="left" class="LOG_LABEL" width="100px"> &nbsp; &nbsp; &nbsp;Documentos </td>
  </tr>
  <tr><td colspan="3" height="2px"></td>  </tr>
  <tr>
    <td><input type="text" class="data" id="deta" name="deta" value=""  style="text-align:center"/></td>
    <td align="left" class="LOG_LABEL">&nbsp; &nbsp; &nbsp;Lineas   </td>  
  </tr>
    <tr>
    <td colspan="2"><input type="text" class="data" id="MSG" name="MSG" value=""  style="text-align:center; width:100%"/></td>
  </tr>

  <tr><td colspan="2" align="center" >
  <A href="transferencias.asp?op=1" target="_self" ><img src="IMAGES/go1.png" border="0"  onmouseover="this.src='images/go2.png'" id="ima" name="ima"
  onmouseout="this.src='images/go1.png'" style="cursor:pointer"/></A>
  
  </td></tr>

</table>

<center>
	<img src="IMAGES/load.gif" id="carga" name ="carga" style="display:none"/><br />	
</center>
<%OP = REQUEST.QueryString("OP") %>
<%IF OP = "" THEN RESPONSE.END%>
<%TBL1 = "RSFACCAR..AL" + CIA + "MOVC"
cad = " SELECT count(*) as maxi from "&TBL1&"    " & _ 
        " WHERE YEAR(C5_DFECCRE)>2016 AND       " & _
        " C5_CCODAUT='' AND C5_CSITUA<>'A'      "  
'        RESPONSE.WRITE(CAD)
rs.open cad, cnn
' response.write(rs("maxi"))
if rs("maxi") <> 0 then %>
<script language="jscript" type="text/jscript">
    document.all.MSG.value = "0000000000000000000000000000000000000..."
    document.all.carga.style.display = 'block'
   // alert()
</script>

 <%else%>

 <script language="jscript" type="text/jscript">
     document.all.MSG.value = "8 8 8 8 8 8 8 8 8 8 ..."
     document.all.carga.style.display = 'none'
</script>
 
 <%end if
 rs.close
    Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.ActiveConnection = Cnn
	RS2.CursorType       = 3 'CONST adOpenStatic = 3
	RS2.LockType         = 1 'CONST adReadOnly = 1
	RS2.CursorLocation   = 3 'CONST adUseClient = 3

TBL1 = "RSFACCAR..AL" + CIA + "MOVC"
cad = " SELECT * from "&tbl1&"    " & _ 
        " WHERE YEAR(C5_DFECCRE)>2016 AND       " & _
        " C5_CCODAUT='' AND C5_CSITUA<>'A'      "  
        RESPONSE.WRITE(CAD)
        'RESPONSE.WRITE("<BR>")
rs.open cad,cnn
if rs.recordcount <= 0 then%>
<script language="jscript" type="text/jscript">
    document.all.MSG.value = "Nada que Procesar..."
    document.all.carga.style.display='none'
</script>
    
  <%  response.End
end if
rs.movefirst
TBL  = "RS_ALMOVD" + CIA
TBL1 = "RSFACCAR..AL" + CIA + "MOVC"
TBL2 = "RSFACCAR..AL" + CIA + "MOVD"
TBL3 = "MULTI..RS_ALMOVD" + CIA
TBL4 = "MULTI..RS_ALMOVD_TALLA" + CIA
CONT = 0
%>
<script language="jscript" type="text/jscript">
    document.all.cabe.value = '<%=rs.recordcount%>'
    //alert(document.all.cabe.value)
</script>
<%do while not rs.eof %>
    <%  NRO = RS("c5_cnumdoc")
        ALM = RS("c5_calma")
        TIP = RS("c5_ctd") %>
<%  '   LA TRANSFERENCIA DE DOCUMENTOS NO FUNCIONA
    '   HASTA EL MOMENTO EN QUE SE ASIGNA UNA FACTURA
    '   ******************* [RS_OC_U_ALMOVC_FACTURA] *******************************
     CAD = " SELECT count(*) AS MM FROM "&TBL&"  WHERE CALMA='"&ALM&"' AND CTD='"&TIP&"' AND CNUMDOC='"&NRO&"' "
    RESPONSE.WRITE(CAD)    
    RESPONSE.WRITE("<BR>")
    rs2.open cad, cnn
    if rs2("MM") = 0 then
        kad = "exec JALA_DOCUMENTOS '"&alm&"','"&tip&"', '"&nro&"', '"&tbl1&"', '"&tbl2&"', '"&tbl3&"', '"&tbl4&"' "
        RESPONSE.WRITE(kad)
        RESPONSE.WRITE("<BR>") 
        CNN.EXECUTE KAD
        CONT = CONT + 1 %>
    <%END IF
    RS2.CLOSE %>
    <script language="jscript" type="text/jscript">
        document.all.deta.value = '<%=cont%>'
    </script>
    <%rs.movenext %>
<%loop%>

  <script language="jscript" type="text/jscript">
  alert("proceso terminado")
  document.all.carga.style.display = 'none'
  cabe = "transferencias.asp?op="
  window.location.replace(cabe)
    </script>
</body>
</html>
