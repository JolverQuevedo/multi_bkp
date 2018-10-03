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
oc = request.querystring("oc")
pro= request.QueryString("pro")
ini = request.querystring("ini")
fin = request.querystring("fin")
edo = request.querystring("edo")
ruc = request.querystring("ruc")
cart = request.querystring("cart")

TBL1 = "RSFACCAR..CO" + CIA + "MOVC"
TBL2 = "RSFACCAR..AL" + CIA + "TABL"

IF LEN(TRIM(OC)+TRIM(PRO)+TRIM(INI)+TRIM(FIN)+TRIM(EDO)+TRIM(RUC)+TRIM(CART)) = 0 THEN
    KAD =   " Select	TOP 10 "
ELSE
    KAD =   " Select	"
END IF
KAD = KAD + " rtrim(OC_CNUMORD) as OC_CNUMORD, OC_DFECDOC Fecha,  " & _
            " OC_CRAZSOC Proveedor,OC_CCODMON Mnd,   Importe = CASE         " & _
            " OC_CCODMON When 'US' Then OC_NIMPUS Else OC_NIMPMN END,       " & _
            " TG_CDESCRI AS Estado, OC_CTIPORD Tip,OC_CCOTIZA Cotiza,       " & _
            " OC_CDETENT Observacion From "&tbl1&"   " & _
            " Left Join "&tbl2&" On OC_CSITORD=TG_CCLAVE Where TG_CCOD='31' " 
if len(trim(ini)) > 0 then kad = kad + " AND OC_DFECDOC BETWEEN '"&ini&"' AND '"&fin&"'      " 
if len(trim(oc)) > 0 then  
    oc  = "%" + trim(oc)
    kad = kad + " AND OC_CNUMORD LIKE '"&oc&"'      " 
end if
if len(trim(ruc)) > 0 then kad = kad + " AND OC_CCODPRO ='"&ruc&"'  " 
if len(trim(edo)) > 0 then kad = kad + " AND OC_CSITORD ='"&edo&"'  " 
if len(trim(cart)) > 0 then  kad = kad + " AND OC_CNUMORD  IN(SELECT DISTINCT OC_CNUMORD FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO='"&cart&"' ) "

KAD = KAD + " Order by OC_CNUMORD,OC_DFECDOC                                "

'response.Write(kad)
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.ActiveConnection = Cnn
	RS2.CursorType       = 3 'CONST adOpenStatic = 3
	RS2.LockType         = 1 'CONST adReadOnly = 1
	RS2.CursorLocation   = 3 'CONST adUseClient = 3

	RS2.Open KAD, Cnn
	CONT = 1
    'RESPONSE.WRITE(RS2.RECORDCOUNT)

		IF NOT RS2.EOF OR NOT RS2.BOF THEN	RS2.MOVEFIRST%>
<%  archivo = "c:\temp\Prn_listado_excel.xls"
    Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 
 %>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs2.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ><HTML>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body style="margin-top:0; margin-left:0; margin-right:0;">
<%  TBL1 = "RSFACCAR..AL" + CIA + "MOVC"
    TBL2 = "RSFACCAR..AL" + CIA + "MOVD"
    TBL3 = "RSFACCAR..co" + CIA + "MOVD"
    TBL4 = "RSFACCAR..AL" + CIA + "ARTI"
%>
 <table id="TABLA" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
        <%'**************************%>
        <%'LINEA DE CABECERA STANDAR %>
        <%'**************************%>
        <%LIMITE =  RS2.fields.count - 1	%>
        <tr bgcolor="#006699" >
        <td align="center" class="Estilo8">&nbsp;<%=RS2.FIELDS(0).NAME%>&nbsp;</td>
        <td align="center" class="Estilo8">&nbsp;<%=RS2.FIELDS(1).NAME%>&nbsp;</td>
        
        <td colspan="2" align="center" class="Estilo8">&nbsp;<%=RS2.FIELDS(2).NAME%>&nbsp;</td>
            <%for I=3 to LIMITE %>
	            <td align="center" class="Estilo8"><%=RS2.FIELDS(I).NAME%></td>
            <%next%>	
        </tr>
        <tr bgcolor="white" >
	        <td align="center" class="Estilo8" colspan="2"></td>
            <td align="center" class="Estilo8">Codigo</td>
            <td align="center" class="Estilo8" colspan="1">Descripción</td>
            <td align="center" class="Estilo8">Uni</td>
            <td align="center" class="Estilo8">Qty Ord</td>
            <td align="center" class="Estilo8">Qty Ent</td>
            <td align="center" class="Estilo8">Qty Pend</td>
            <td align="center" class="Estilo8">% Aten</td>
        </tr>
        <%IF  RS2.EOF THEN response.end%>
        <%DO WHILE NOT RS2.EOF%>
	        <tr style="background-color:Scrollbar">
                <td align="center" class="estilo5"><b>&nbsp;<%=RS2.FIELDS.item(0)%>&nbsp;</b></td>
                <td align="center" class="estilo5"><b>&nbsp;<%=formatdatetime(RS2.fields.item(1),2)%>&nbsp;</b></td>
                <td>&nbsp;&nbsp;</td>
                <td align="left" class="estilo5"><b>&nbsp;<%=RS2.FIELDS.item(2)%>&nbsp;</b></td>
            <%for I=3 to LIMITE %>
		            <td align="center" class="estilo5"><b><%=RS2.FIELDS.ITEM(I)%></b></td>
	            <%NEXT%>
	        </tr>
            <% doc = rs2.fields.item(0)
            KAD = "EXEC BuscaOC_Deta_Agrupado  '"&DOC&"', '"&TBL1&"', '"&TBL2&"' , '"&TBL3&"', '"&TBL4&"' " 
            rs.open kad,cnn%>
             <%DO WHILE NOT RS.EOF%>
	        <tr  class="estilo5" >
	           <td colspan="2">&nbsp;</td>
                <td align="center">&nbsp;<%=RS.FIELDS.ITEM(0)%>&nbsp;</td>
	            <td align="left" class="estilo5"><%=RS.FIELDS.ITEM(1)%></td>
                <td align="center"><%=RS.FIELDS.ITEM(2)%></td>
                <td align="right"><%=formatnumber(RS.FIELDS.ITEM(3),3,,true)%></td>
                <td align="right"><%=formatnumber(RS.FIELDS.ITEM(4),3,,true)%></td>
                <td align="right"><%=formatnumber(RS.FIELDS.ITEM(5),3,,true)%></td>
                <td align="right"><%=formatnumber(cdbl(RS.FIELDS.ITEM(6))*100,2,,true)%> %</td>
	        </tr>
	        <%RS.MOVENEXT%>
	        <%LOOP%>
            <%rs.close %>

	        <%RS2.MOVENEXT%>
	        <%LOOP%>
        </table>

    </td>
</tr>
</table>

</form>
</BODY>
</HTML>
