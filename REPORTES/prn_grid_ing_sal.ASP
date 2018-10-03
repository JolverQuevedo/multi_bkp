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
<%'**********tri******************************************

alm = REQUEST.QueryString("alm")
gui = REQUEST.QueryString("gui")
ran = REQUEST.QueryString("ran")	
ini = request.QueryString("ini")	
fin = request.QueryString("fin")	
oc = request.QueryString("oc")	
mov = request.QueryString("mov")	
ruc = request.QueryString("ruc")	
lot = request.QueryString("lot")	
ser = request.QueryString("ser")	
cart = request.QueryString("cart")	
col = request.QueryString("col")	
doc = request.QueryString("doc")	

TBL1 = "RSFACCAR..AL" + CIA + "ALMA"
TBL2 = "MULTI..RS_USUALM" + CIA 
cad =   " select a1_calma, a1_cdescri as descri from "&tbl1&"  A " & _
    " INNER JOIN "&TBL2&" B ON (A1_CALMA COLLATE Modern_Spanish_CI_AS =CALMA) AND B.CUSUARIO='"&usr&"' and a1_calma = '"&alm&"' order by 1 " 
    'response.write(cad)
rs.open cad,cnn              
if rs.recordcount > 0 then
    desalm = rs("descri")
ELSE 
    DESALM = ""
END IF
RS.CLOSE
TBL1 = "RS_ALMOVD" + CIA 
TBL2 = "RS_ALMOVD_TALLA" + CIA 
TBL3 = "RS_ALMOV_UBICACION" + CIA 
TBL4 = "AL_TIPOSMOV" + CIA

KAD = "EXEC RS_MOV_S_ENT_SAL '"&alm&"', '"&gui&"', '"&ran&"', '"&ini&"', '"&fin&"', '"&oc&"', '"&mov&"', '"&ruc&"','"&lot&"', '"&ser&"', '"&cart&"', '"&col&"', '"&doc&"', '"&TBL1&"', '"&TBL2&"' , '"&TBL3&"', '"&TBL4&"' "
'response.Write(kad)
'RESPONSE.End
	RS.Open KAD, Cnn
	CONT = 1
  '  RESPONSE.WRITE(RS.RECORDCOUNT)

	IF NOT RS.EOF OR NOT RS.BOF THEN	RS.MOVEFIRST%>
 <%  archivo = "c:\temp\PRN_"+ALM+".xls"
     Response.Charset = "UTF-8"
     Response.ContentType = "application/vnd.ms-excel" 
     Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 
 %>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = RS.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ><HTML>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body style="margin-top:0; margin-left:0; margin-right:0;">
<%'*********************************************************************%>



 <table id="TABLA" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
       
       <tr>
           <td colspan="15" width="100%">
                <table id="Table1" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
                    <tr>
                    <td align="left" class="ESTILO2">ALMACEN <%=ALM%> - <%=UCASE(DESALM)%></td>
                    </tr>
                </table>
           </td>
       </tr>
       
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
	            end IF%>">
	            <%FOR i=0 TO LIMITE%>
		            <td align="center" class="estilo5"><%=RS.FIELDS.ITEM(I)%></td>
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
