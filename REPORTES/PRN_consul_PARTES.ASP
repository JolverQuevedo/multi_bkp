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
    archivo = "c:\temp\listado_excel.xls"
    Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 
end if
'****************************************************
gui = request.QueryString("gui")	
ini = request.QueryString("ini")	
fin = request.QueryString("fin")	
oc  = request.QueryString("oc")
mov = request.QueryString("mov")
ruc = request.QueryString("ruc")
lot = request.QueryString("lot")
ser = request.QueryString("ser")
art = request.QueryString("art")
col = request.QueryString("col")
doc = request.QueryString("doc")
nre = request.QueryString("nre")
alm = request.QueryString("alm")



'****************************************************
if len(trim(gui) + trim(ini) + trim(fin) + trim(oc) + trim(mov) + trim(ruc) + trim(lot) + trim(ser) + trim(art) + trim(col) + trim(doc)+ trim(nre) + trim(alm))= 0 then
    ini = date()
    fin = date() - 30
end if
IF LEN(TRIM(INI)) = 0 AND LEN(TRIM(FIN)) = 0 THEN
    INI = "01/01/2008"
    fin = date()
END IF

IF LEN(TRIM(INI)) > 0 AND LEN(TRIM(FIN)) = 0 THEN
    FIN = DATE()
END IF
TBL1 = "RS_ALMOVD" + CIA 
TBL2 = "AL_TiposMov" + CIA 
TBL3 = "RSFACCAR..CO"+ CIA+ "MOVD"
TBL4 = "RSFACCAR..CO"+ CIA+ "MOVC"
TBL5 = "RS_ALMOVD_TALLA" + CIA 

CAD = " set dateformat dmy;   Select distinct                                                      " & _ 
      " top 1000 dfecdoc as FECHA,ccodmov as MOV, cnumord NUM_MOV,B.CODTIPOMOV as COD_MOT,         " & _ 
      " destipomov as DES_MOT, CTD,cnumdoc as NUM_CTD,crftdoc as TIP, CRFNDOC as DOC_REF,          " & _
      " CITEM as It, calma as Alm, CCODIGO Codigo, CDESCRI Descripcion, ccodprov as RUC,           " & _
      " cnomprov as proveedor, Color, Lote, UNIMED AS Und, oc_ccodmon as MON, isnull(vv.oc_npreuni,0) as UNIT," & _
      " isnull(NCANTID,0) AS Cantid, isnull(KGNETO,0), isnull(KGBRUTO,0), isnull(NCANTIDPROV,0),   " & _
      " isnull(KGNETOPROV,0),  isnull(KGBRUTOPROV,0),                                              " & _
      " Tallas=CASE WHEN Detallado='S' THEN                                                        " & _
      " LTRIM(DBO.concat_Tallas(CALMA,CTD,CNUMDOC,CITEM, '"&TBL5&"'))                              " & _
      " ELSE '' END  , left(convert(varchar(500),OBSERV) ,150) as observ                           " & _
      " From "&TBL1&" A                                                                            " & _
      " full outer  join "&TBL3&" as vv on vv.oc_cnumord = a.cnumord  AND CCODIGO = VV.OC_CCODigo  " & _
      " INNER  join "&TBL4&" as cc on cc.oc_cnumord = a.cnumord                                    " & _ 
      " LEFT JOIN "&TBL2&" B  ON(A.CODTIPOMOV=B.CODTIPOMOV)                                        " & _
      " Where dfecdoc between '"&INI&"' AND DateAdd(day,1,'"&FIN&"')                               "
IF len(trim(art)) > 0 then   CAD = CAD + " and CCODIGO = '"&art&"'      "
IF len(trim(gui)) > 0 then   CAD = CAD + " and ccodmov = '"&gui&"'      "
IF len(trim(ser)) > 0 then   CAD = CAD + " and B.CODTIPOMOV = '"&ser&"' "
IF len(trim(mov)) > 0 then   CAD = CAD + " and ctd = '"&mov&"'          "
IF len(trim(alm)) > 0 then   CAD = CAD + " and calma = '"&alm&"'        "
IF len(trim(ruc)) > 0 then   CAD = CAD + " and ccodprov = '"&ruc&"'     "
IF len(trim(col)) > 0 then   CAD = CAD + " and color ='"&col&"'         "
IF len(trim(lot)) > 0 then   CAD = CAD + " and lote = '"&lot&"'         "
IF len(trim(oc))  > 0 then   CAD = CAD + " and cnumord = '"&oc&"'       "
IF len(trim(doc)) > 0 then   CAD = CAD + " and cnumdoc = '"&doc&"'      "
IF len(trim(nre)) > 0 then   CAD = CAD + " and CRFNDOC = '"&nre&"'      "
        CAD = CAD + " Order by dfecdoc, CRFNDOC,CITEM                   "

 '   response.Write(cad)
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
	            <%FOR i=0 TO 18%>
		            <td align="center" class="estilo5"><%=UCASE(RS.FIELDS.ITEM(I))%>&nbsp;</td>
	            <%NEXT%>
                <%FOR i=19 TO limite-3%>
		            <td align="center" class="estilo5"><%=FORMATNUMBER(RS.FIELDS.ITEM(I),3,,TRUE)%></td>
	            <%NEXT%>
                <%FOR i=LIMITE-2 TO LIMITE%>
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
