<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<link href="../multisty.css" rel="stylesheet" type="text/css">
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<%'****************************************************
oc = request.QueryString("oc")	
PRO = REQUEST.QueryString("PRO")
FAC = REQUEST.QueryString("FAC")

TBL1 = "RSFACCAR..CO" + CIA + "MOVC"
TBL2 = "RSFACCAR..AL" + CIA + "TABL"
TBL3 = "RSCONCAR..CP" + CIA + "CART"

KAD = "EXEC BuscaOC_Contralor '"&OC&"', '"&PRO&"', '"&FAC&"', '"&TBL1&"', '"&TBL2&"' , '"&TBL3&"' "

TBL10 = "RSFACCAR..AL" + CIA + "MOVC"
            TBL20 = "RSFACCAR..AL" + CIA + "MOVD"
            TBL30 = "RSFACCAR..co" + CIA + "MOVD"
            TBL40 = "RSFACCAR..AL" + CIA + "ARTI"

RS.Open KAD, Cnn

Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.ActiveConnection = Cnn
	RS2.CursorType       = 3 'CONST adOpenStatic = 3
	RS2.LockType         = 1 'CONST adReadOnly = 1
	RS2.CursorLocation   = 3 'CONST adUseClient = 3
	CONT = 1
    'RESPONSE.WRITE(RS3.RECORDCOUNT)

	IF NOT RS.EOF OR NOT RS.BOF THEN	RS.MOVEFIRST%>
<% archivo = "c:\temp\listado_excel.xls"
    Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 
 %>
<title>LISTADO DE ORDENES DE COMPRA </title>
<HTML>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body style="margin-top:0; margin-left:0; margin-right:0;" >

<table id="TABLA" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<%LIMITE =  RS.fields.count - 1	%>
<%IF  RS.EOF THEN response.end%>
<%DO WHILE NOT RS.EOF%>
    <tr bgcolor=#006699 >
	        <td align="center" class="Estilo8"># O/C</td>
            <td align="center" class="Estilo8">Fecha</td>
            <td align="center" class="Estilo8">RUC</td>
            <td align="center" class="Estilo8">Proveedor</td>
            <td align="center" class="Estilo8">Mon</td>
            <td align="center" class="Estilo8">Importe</td>
            <td align="center" class="Estilo8">Estado</td>
            <td align="center" class="Estilo8">Tip</td>
            <td align="center" class="Estilo8">Facturas</td>
            <td align="center" class="Estilo8">Observacion</td>
    </tr>

	<tr>
        <%docum =  right("0000000000"+ cstr(RS.FIELDS.ITEM(0)),10) %>
		<td align="center" class="estilo5">&nbsp;<%=docum%></td>
        <td align="center" class="estilo5"><%=formatdatetime(RS.FIELDS.ITEM(1),2)%></td>
        <td align="center" class="estilo5"><%=cstr(RS.FIELDS.ITEM(2))%></td>
        <td align="left" class="estilo5"><%=RS.FIELDS.ITEM(3)%></td>
        <td align="center" class="estilo5"><%=RS.FIELDS.ITEM(4)%></td>
        <td align="center" class="estilo5"><%=formatnumber(RS.FIELDS.ITEM(5),2,,true)%></td>
        <td align="center" class="estilo5"><%=RS.FIELDS.ITEM(6)%></td>
        <td align="center" class="estilo5"><%=RS.FIELDS.ITEM(7)%></td>
        <td align="left" class="estilo5"><%=RS.FIELDS.ITEM(8)%></td>
        <td align="left" class="estilo5"><%=RS.FIELDS.ITEM(9)%></td>
	</tr>
    <tr><td>&nbsp;</td><td colspan="9">
    <%doc = RS.FIELDS.ITEM(0)
    ruc = RS.FIELDS.ITEM(2)
    KAD = "EXEC BuscaOC_Deta_Agrupado  '"&DOC&"', '"&TBL10&"', '"&TBL20&"' , '"&TBL30&"', '"&TBL40&"' " 
       'RESPONSE.WRITE (kad)
        rs2.open kad, cnn
        IF RS2.RECORDCOUNT>0 THEN	RS2.MOVEFIRST%>
        <table align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">       
        <%LIMITE =  RS2.fields.count - 1	%>
        <tr bgcolor=#006633 >
            <%for I=0 to LIMITE %>
	            <td align="center" class="Estilo8" style="color:White"><%=RS2.FIELDS(I).NAME%></td>
            <%next%>	
        </tr>
        <%IF  RS2.EOF THEN response.end%>
        <%DO WHILE NOT RS2.EOF%>
	        <tr>
	           <td align="center" class="estilo5">&nbsp;<%=RS2.FIELDS.ITEM(0)%></td>
                <td align="left" class="estilo5"><%=cstr(RS2.FIELDS.ITEM(1))%></td>
                <td align="center" class="estilo5"><%=RS2.FIELDS.ITEM(2)%></td>
                <td align="right" class="estilo5"><%=formatnumber(RS2.FIELDS.ITEM(3),0,,true)%></td>
                <td align="right" class="estilo5"><%=formatnumber(RS2.FIELDS.ITEM(4),2,,true)%></td>
                <td align="right" class="estilo5"><%=formatnumber(RS2.FIELDS.ITEM(5),2,,true)%></td>
                <td align="right" class="estilo5"><%=formatnumber(RS2.FIELDS.ITEM(6),0,,true)%></td>
	        </tr>
	        <%RS2.MOVENEXT%>
	        <%LOOP%>
    </table>
    <%rs2.close%>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
    </td></tr>
</table>


</BODY>
</HTML>
