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
xls = request.QueryString("xls")
if xls = "E" then 
    archivo = "STOCKS_excel.xls"
    Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 
end if
'****************************************************
alm = request.QueryString("alm")	
lis = request.QueryString("lis")	
edo = request.QueryString("edo")	
lin = request.QueryString("lin")
art = request.QueryString("art")
xls = request.QueryString("xls")

'****************************************************
TBL1 = "RSFACCAR..AL" + CIA + "STOC"
TBL2 = "RSFACCAR..AL" + CIA + "ARTI"
tbl3 = "RSFACCAR..AL" + CIA + "TABL"

if len(trim(alm) + trim(lis) + trim(edo) + trim(lin) + trim(art) )= 0 then
    cad = " select distinct top 1000 "
else
    cad = "select distinct "
END IF
cad = CAD +   "  a.sk_calma as ALM, A.SK_CCODIGO AS COD,                  " & _
              " B.AR_CDESCRI AS DESCRI, B.AR_CUNIDAD AS UNI, sum(A.SK_NSKDIS) as STKDIS, " & _
              " TG_CDESCRI AS LINEA ,AR_CESTADO AS EDO                                   " & _
              " From  "&TBL1&" A                                                         " & _
              " LEFT JOIN "&tbl2&" B ON B.AR_CCODIGO=A.SK_CCODIGO                        " & _
              " LEFT JOIN "&tbl3&" ON TG_CCLAVE=AR_CMODELO AND TG_CCOD='39'              " 
IF len(trim(alm)) > 0 then   
    CAD = CAD + "  WHERE SK_CALMA=  '"&alm&"'     "
else
    cad = cad + " WHERE SK_CALMA COLLATE SQL_Latin1_General_CP1_CI_AI IN (SELECT CALMA FROM RS_USUALM0001 " & _
                " WHERE CUSUARIO COLLATE Modern_Spanish_CI_AS='"&usr&"' )  "
end if

IF len(trim(art)) > 0 then  
    CODIGO = "%"  + ART + "%"
    CAD = CAD + " AND A.SK_CCODIGO LIKE '"&CODIGO&"'   "
END IF 

IF lis = "1"  then   CAD = CAD + "  AND SK_NSKDIS > 0  "
IF lis = "2"  then   CAD = CAD + "  AND SK_NSKDIS = 0  "

IF len(trim(EDO)) > 0 then   CAD = CAD + " AND AR_CESTADO= '"&EDO&"' "

IF len(trim(LIN)) > 0 then   CAD = CAD + "  AND AR_CLINEA= '"&LIN&"'       "

CAD = CAD + " GROUP BY A.SK_CCODIGO,B.AR_CDESCRI,B.AR_CUNIDAD,TG_CDESCRI,AR_CESTADO , sk_calma " & _
            " ORDER BY SK_CCODIGO"


  '  response.Write(cad)
    rs.open cad,cnn
	CONT = 1
    'RESPONSE.WRITE(RS.RECORDCOUNT)

	IF NOT RS.EOF OR NOT RS.BOF THEN	RS.MOVEFIRST%>

<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = RS.Fields.Count%>

<script language="jscript" type="text/jscript">
    oldrow = 1
function llena(t, pos) {
    return true
}

</script>
<title>Detalle OC <%=oc%></title>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ><HTML>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body style="margin-top:0; margin-left:0; margin-right:0;" >
<%'*********************************************************************%>
        <table id="TABLA" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
        <%'**************************%>
        <%'LINEA DE CABECERA STANDAR %>
        <%'**************************%>
        <%LIMITE =  RS.fields.count - 1	%>
        <tr bgcolor=#006699 >
            <%for I=0 to LIMITE %>
	            <td align="center" class="Estilo8"><%=RS.FIELDS(I).NAME%></td>
            <%next%>	
        </tr>
        <%IF  RS.EOF THEN response.end%>
        <%DO WHILE NOT RS.EOF%>
	        <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"    >
	            <%FOR i=0 TO 3%>
		            <td align="center" class="estilo5"><%=UCASE(RS.FIELDS.ITEM(I))%>&nbsp;</td>
	            <%NEXT%>
                <%FOR I= 4 TO 4%>
		            <td align="center" class="estilo5"><%=FORMATNUMBER(CDBL(RS.FIELDS.ITEM(I)),3,,TRUE)%></td>
	            <%NEXT%>
                 <%FOR i=5 TO LIMITE%>
		            <td align="center" class="estilo5"><%=UCASE(RS.FIELDS.ITEM(I))%>&nbsp;</td>
	            <%NEXT%>
	        </tr>
	        <%RS.MOVENEXT%>
	        <%CONT = CONT + 1%>
	        <%LOOP%>
        </table>

    </td>
</tr>
</table>

</form>

</BODY>
</HTML>
