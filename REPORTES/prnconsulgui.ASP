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
    archivo = "GUIAS_excel.xls"
    Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 
end if
'****************************************************

gui= request.QueryString("gui")
gui = replace(gui,"*","','")
gui = "(" + gui + ")"
xls = request.QueryString("xls")
'response.write(gui)



 cad =  " select  GUIA, FECGUI1 AS FECHA,bolsa as ORD_SERV,        " & _
        " DESSER AS SERVICIO,CORTE, ESTCLI, PO, COLOR,             " & _
        " (c0+c1+c2+c3+c4+c5+c6+c7+c8+c9) as TOT,  RUC, NOMPRO,    " & _
        " RIGHT(LTRIM(RTRIM(CODART)),5) AS CODIGO, DESART          " & _
        " from VIEW_POS_MOVI where guia IN   "&gui&"             " & _
        " ORDER BY GUIA                                            " 

  ' response.Write(cad)
    rs.open cad,cnn
	CONT = 1
'response.end    
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
	            <%FOR i=0 TO 7%>
		            <td align="center" class="estilo5"><%=UCASE(RS.FIELDS.ITEM(I))%>&nbsp;</td>
	            <%NEXT%>
                <%FOR I= 8 TO 8%>
		            <td align="center" class="estilo5"><%=FORMATNUMBER(CDBL(RS.FIELDS.ITEM(I)),0,,TRUE)%></td>
	            <%NEXT%>
                 <%FOR i=9 TO LIMITE%>
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
