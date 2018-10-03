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
<HTML>
<%
OC	=	Request.QueryString("OC") 
' DATOS DE CABECERA DEL MODELADOR
empresa =   "Select * From RSFACCAR..ALCIAS Where AC_CCIA='"&cia&"' ; "
' CABECERA DE LA ORDEN DE COMPRA
tbl1 = "RSFACCAR..CO"+cia+"MOVC"
tbl2 = "RSCONCAR..CP"+cia+"MAES"
cab =	" Select * From "&tbl1&"            " & _
        " LEFT OUTER JOIN "&tbl2&"          " & _
        " on AC_CVANEXO='P' AND AC_CCODIGO=OC_CCODPRO   " & _
        " Where OC_CNUMORD='"&OC&"';                    "
' LINEAS DE DETALLE
tbl3= "RSFACCAR..CO"+cia+"MOVD "
det =   "Select * From "&tbl3&" Where OC_CNUMORD='"&oc&"' and  OC_CITEM <> ''" 
		
    ' response.Write(cab)   
        
        RS.OPEN empresa ,Cnn
		
If rs.eof or rs.bof then
	Response.Write("Tabla  Vacía")		
	Response.End
end if	
rs.movefirst
%>


<head>

<style type="text/css" media="print">
    .page
    { -webkit-transform: rotate(-90deg); -moz-transform:rotate(-90deg);
      filter:progid:DXImageTransform.Microsoft.BasicImage(rotation=3);
    }
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>OC_PRINT</title>
</head>

<body topmargin="0" leftmargin="0" rightmargin="0" border="0" class="page">

<table width="100%" border="1" align="center">
	<tr>
	    <td width="20%" class="micro" align="left"><%=ltrim(rtrim(UCASE(RS("AC_CNOMCIA")))) %></td>
		<td width="80%" align="center" class="data"><b> ORDEN DE COMPRA # <%=OC%> </b></td>
		<td width="20%" class="micro" align="right"><%=NOW() %></td>
    </tr>
</table>

<table width="100%">
	<tr>
        <table width="100%">
	<tr align="left" class="data">
	    <td  width="10%">Direccion: </td>
        <td ><%=UCASE(RS("AC_CDIRCIA")) %></td>
    </tr>
    <tr align="left" class="data">
	    <td  width="10%">Telefax: </td>
        <td ><%=UCASE(RS("AC_Cfax")) %></td>
    </tr>
    <tr align="left" class="data">
	    <td  width="10%">Telefono: </td>
        <td ><%=UCASE(RS("AC_Ctelef1")) %></td>
    </tr>
    <tr align="left" class="data">
	    <td  width="10%">RUC : </td>
        <td ><%=UCASE(RS("AC_Cruc")) %></td>
    </tr> 
</table>
<%
nomcia = rs("ac_cnomcia")

RS.CLOSE
RS.OPEN CAB,CNN
IF RS.RECORDCOUNT <=0 THEN
RESPONSE.WRITE("SIN DATOS....")
RESPONSE.End
END IF
RS.MOVEFIRST%>
<p></p>
<table width="100%">
	<tr>
        <table width="100%">
	<tr align="left" class="data">
	    <td  width="10%">Se&ntilde;ores: </td>
        <td  width="60%"><%=UCASE(RS("AC_Cnombre")) %></td>
        <td  width="10%">Telefax: </td>
        <td  width="20%"><%=UCASE(RS("AC_Cfaxacr")) %></td>
    </tr>
    <tr align="left"  class="data">
	    <td  width="10%">Ruc: </td>
        <%if rs("ac_ctipoac")= "EX" then xx = "" else xx = rs("ac_ccodigo") %>
        <td ><%=UCASE(xx) %></td>
        <td></td>
        <td></td>
    </tr>
    <tr align="left" class="data">
	    <td width="10%">Atencion: </td>
        <td><%=UCASE(RS("ac_crepres")) %></td>
        <td width="10%">Doc. Referencia: </td>
        <td width="40%"><%=UCASE(RS("oC_Ccotiza")) %></td>
    </tr>
    <tr align="left" class="data">
	    <td  width="10%">Direccion : </td>
        <td <%=UCASE(RS("AC_Cdirecc")) %></td>
    </tr> 
    <tr align="left" class="data">
	    <td  width="10%">Entregar  : </td>
        <td ><b><%=UCASE(nomcia) %></b>&nbsp;-&nbsp;<%=UCASE(RS("oC_Clugent")) %></td>
    </tr> 
</table>

<hr />

<%IF RS("OC_CCODMON") = "US" THEN DESMON = "US $" ELSE DESMON = "S/" %>
<table width="100%" cellpadding="1" cellspacing="1" border="0" >
<tr class="Estilo5" align="center" style="font-weight:900">
	<td WIDTH="2%">ITEM</td>
    <td WIDTH="8%">CODIGO</td>
    <td width="5%">CANT</td>
    <td width="2%">UNID</td>
    <td width="43%">DESCRIPCION</td>
    <td wodth="10%">PRECIO<br /><%=DESMON%></td>
    <td width="10%">TOTAL<br /><%=DESMON%></td>
    <td width="10%">DCTO<br /><%=DESMON%></td>
    <td width="10%">NETO<br /><%=DESMON%></td>
</tr>
<tr><td colspan="9"><hr />  </td></tr>
<%forpag = rs("oc_cforpa1")
fecent=rs("oc_dfecent")
tipenv = rs("oc_ctipenv")
obs = rs("oc_cdetent")
soli= rs("oc_csolict")
lent = rs("oc_clugent")
lfac=rs("oc_clugfac")

rs.close
tbl3 = "RSFACCAR..CO"+cia+"MOVD"
RS.OPEN "Select SUM(OC_NIGV) AS IIGV From "&tbl3&" Where OC_CNUMORD='"&OC&"' ",CNN
if rs.recordcount <=0 then
    response.Write("SIN DATOS")
    RESPONSE.End
END IF
RS.MOVEFIRST
IGVTOT = RS("IIGV")

RS.CLOSE


rs.open det,cnn
if rs.recordcount <=0 then
    response.Write("SIN DATOS")
    RESPONSE.End
END IF
RS.MOVEFIRST
importe = 0
do while not rs.eof%>
<tr  class="estilo5" valign="top" >
	<td align="center"><%=RS("OC_CITEM") %></td>
    <td align="center"><%=RS("OC_Ccodigo") %></td>
    <td align="center"><%=formatnumber(RS("OC_ncanord"),2,,,true) %></td>
    <td align="center"><%=RS("OC_Cunidad") %></td>
    <td align="left"><%=trim(RS("OC_Cdesref")) %>&nbsp;<br />&nbsp;<%=UCASE(RS("OC_COMENTA")) %></td>
    <td align="center"><%=formatnumber(RS("OC_nPREUN2"),5,,,true) %></td>
    <td align="right"><%=formatnumber(CDBL(RS("OC_nPREUN2"))*CDBL(RS("OC_ncanord")),2,,,true) %></td>
    <%importe = importe + (CDBL(RS("OC_nPREUN2"))*CDBL(RS("OC_ncanord")))-CDBL(RS("OC_nDESCTO")) %>
    <td align="right"><%=formatnumber(RS("OC_nDESCTO"),2,,,true) %></td>
    <td align="right"><%=formatnumber((CDBL(RS("OC_nPREUN2"))*CDBL(RS("OC_ncanord")))-CDBL(RS("OC_nDESCTO")),2,,,true) %></td>
</tr>
    <%RS.MOVENEXT%>
<%loop%>
<tr><td colspan="10"><hr /></td>
</tr>
<tr  class="Estilo5">
	<td align="center"></td>
    <td align="center"></td>
    <td align="center"></td>
    <td align="center"></td>
    <td align="left"></td>
    <td align="left" colspan="2">Importe</td>
    <td align="right"><%=desmon%></td>
    <td align="right"><%=formatnumber(importe,2,,,true) %></td>
</tr>
<tr  class="estilo5">
	<td align="center"></td>
    <td align="center"></td>
    <td align="center"></td>
    <td align="center"></td>
    <td align="left" ></td>
    <td align="left" colspan="2">IGV</td>
    <td align="right"><%=desmon%></td>
    <td align="right"><%=formatnumber(igvtot,2,,,true) %></td>
</tr>
<tr  class="estilo5">
	<td align="center"></td>
    <td align="center"></td>
    <td align="center"></td>
    <td align="center"></td>
    <td align="left"></td>
    <td align="left" colspan="2">Precio de Venta</td>
    <td align="right"><%=desmon%></td>
    <td align="right"><%=formatnumber((cdbl(importe) + cdbl(igvtot)),2,,,true) %></td>
</tr>
</table>
<hr /><center>
<span class="Estilo5" style="font-weight:500;" >Solo se acepta hasta el 3% adicional, todo excedente ser&aacute; devuelto, considerar esto para no afectar  el curso regular de sus facturas.<br />
“Cada guía de remisión y factura debe hacer referencia a una sola OC, no se aceptan varias OC en una misma guía y factura.”
<br /> “Las letras aceptadas se entregaran a partir del 10º día de recepción de las facturas  /   crédito a 30 días “</span>
<hr /></center>
<table width="100%">
	<tr align="left" class="estilo5">
	    <td  width="10%">Forma de Pago: </td>
        <td  width="40%"><%=UCASE(forpag) %></td>
        <td  width="10%">Solicitante: </td>
        <td  width="40%"><%=UCASE(soli) %></td>
    </tr>
    <tr align="left" class="estilo5">
	    <td  width="10%">Plazo de Entrega : </td>
        <td  width="40%"><%=fecent %></td>
        <td  width="10%">Lugar de Entrega: </td>
        <td  width="40%"><%=UCASE(lent) %></td>
    </tr>
    <tr align="left" class="estilo5">
	    <td  width="10%">Tipo de Envio : </td>
        <td  width="40%"><%=UCASE(tipenv) %></td>
        <td  width="10%">Lugar de Factura: </td>
        <td  width="40%"><%=UCASE(lfac) %></td>
    </tr>
    <tr align="left"  class="estilo5">
	    <td  width="10%">Observaci&oacute;n : </td>
        <td  width="40%"><%=UCASE(obs) %></td>
        <td  width="10%">Pais de Origen: </td>
        <td  width="40%"></td>
    </tr>
</table>

<hr />

<table width="100%">
<tr><td colspan="5" style="height:30">&nbsp;</td></tr>
	<tr  class="datA">
	    <td width="20%" >&nbsp;</td>
        <td width="10%" ><hr /></td>
        <td width="40%" >&nbsp;</td>
        <td width="10%" ><hr /></td>
        <td width="20%" >&nbsp;</td>
    </tr>
    <tr style="text-align:center"  class="DATA">
	    <td width="20%" >&nbsp;</td>
        <td width="10%" >GERENTE</td>
        <td width="40%" >&nbsp;</td>
        <td width="10%" >SOLICITANTE</td>
        <td width="20%" >&nbsp;</td>
    </tr>
</table>
</body>
</html>
