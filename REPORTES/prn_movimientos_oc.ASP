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


'RS.Open KAD, Cnn
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.ActiveConnection = Cnn
	RS2.CursorType       = 3 'CONST adOpenStatic = 3
	RS2.LockType         = 1 'CONST adReadOnly = 1
	RS2.CursorLocation   = 3 'CONST adUseClient = 3

Set RS3 = Server.CreateObject("ADODB.Recordset")
	RS3.ActiveConnection = Cnn
	RS3.CursorType       = 3 'CONST adOpenStatic = 3
	RS3.LockType         = 1 'CONST adReadOnly = 1
	RS3.CursorLocation   = 3 'CONST adUseClient = 3
	CONT = 1 %>

 <%   archivo = "c:\temp\prn_MOVIM_OC_"+oC+".xls"
      Response.Charset = "UTF-8"
      Response.ContentType = "application/vnd.ms-excel" 
      Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 
 %>
 <%
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
            " OC_CDETENT Observacion, OC_CCODPRO From "&tbl1&"   " & _
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
RS3.OPEN KAD,CNN 
IF RS3.RECORDCOUNT > 0 THEN RS3.MOVEFIRST   
  %>
<title>MOVIMIENTO DE ORDENES DE COMPRA </title>
<HTML>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body style="margin-top:0; margin-left:0; margin-right:0;" >

<table width="100%" border="0">
<%do while not rs3.eof%>
<tr><td>
    <%  OC= RS3("OC_CNUMORD")
        MON = RS3("MND")
        FEC= RS3("FECHA")
        usd = replace( RS3("IMPORTE"),",",".")
        PRO = RS3("OC_CCODPRO")
        NOM = RS3("PROVEEDOR") %>
    

    <table id="Table8" align="left" cellpadding="0"  cellspacing="0"  border="0" width="100%">
    <tr><td>
        <table id="Table1" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
        <tr>
        <td colspan="5" align="left" class="ESTILO2">ORDEN DE COMPRA</td>
        </tr>
        <tr>
            <td align="left" class="Estilo8"  width="15%" >Orden de Compra :</td>
            <td align="left"  class="estilo5">&nbsp;<%=trim(oc)%></td>
            <td align="right" width="40%"></td>
            <td align="right" class="Estilo8" width="15%">Moneda :</td>
            <td align="right" class="estilo5" width="15%"><%=trim(ucase(mon))%></td>
        </tr>
        <tr>
            <td align="left" class="Estilo8" >Fecha : </td>
            <td align="left" colspan="2" class="estilo5">&nbsp;<%=formatdatetime(fec,2)%></td>
            <td align="right" class="Estilo8" >Monto OC :</td>
            <td align="right" style="padding-right:5px;" class="estilo5"><%=formatnumber(usd,2,,,true)%></td>
        </tr>
        <tr>
            <td align="left"  class="Estilo8" width="15%" >Proveedor : </td>
            <td align="left"  class="estilo5"  colspan="2">&nbsp;<%=trim(ucase(pro))%>
            &nbsp;&nbsp;-&nbsp;&nbsp;<%=trim(ucase(nom))%></td>
            <td align="right" class="Estilo8" width="15%">Monto FC : </td>
            <%  TBL1 = "RSFACCAR..AL" + CIA + "MOVC"
            TBL2 = "RSFACCAR..AL" + CIA + "MOVD"
            TBL3 = "MULTI..RS_ALMOVC" + CIA
            TBL4 = "RSCONCAR..CP" + CIA + "CART"
    
        CAD =  "EXEC BuscaFT_OC_Contra_ACUM  '"&OC&"', '"&PRO&"', '"&TBL1&"', '"&TBL2&"' , '"&TBL3&"', '"&TBL4&"' "
       'RESPONSE.WRITE(CAD)
        RS.OPEN CAD, CNN
        MONTO = 0
        IF NOT RS.EOF OR NOT RS.BOF THEN	
            RS.MOVEFIRST 
            IF MON = "MN" THEN MONTO = RS("SOLES") ELSE MONTO = RS("DOLARES")
        END IF
        if len(trim(monto)) = 0 then monto = 0
    
          RS.CLOSE     %>
            <td align="right" class="estilo5" width="15%"><%=FORMATNUMBER(MONTO,2,,,TRUE)%></td>
        </tr>
        </table>
    </td>
    </tr>
    <tr>
    <td>
        <table id="Table4" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
        <tr>
            <td colspan="5" align="left" class="ESTILO2">ATENCION DE ORDEN DE COMPRA</td>
        </tr>
        </table>
        </td>
    </tr>
    <tr>
    <td>
        <table id="Table5" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
        <!------------------------------------------------------>
        <%  TBL1 = "RSFACCAR..AL" + CIA + "MOVC"
            TBL2 = "RSFACCAR..AL" + CIA + "MOVD"
            TBL3 = "RSFACCAR..co" + CIA + "MOVD"
            TBL4 = "RSFACCAR..AL" + CIA + "ARTI"

        KAD = "EXEC BuscaOC_Deta_Agrupado  '"&OC&"', '"&TBL1&"', '"&TBL2&"' , '"&TBL3&"', '"&TBL4&"' "
       ' response.Write(kad)
	        RS2.Open KAD, Cnn
	        CONT = 1
           ' RESPONSE.WRITE(RS2.RECORDCOUNT)
	        IF RS2.RECORDCOUNT>0 THEN	RS2.MOVEFIRST%>

                <%'**************************%>
                <%'LINEA DE CABECERA STANDAR %>
                <%'**************************%>
                <%LIMITE =  RS2.fields.count - 1	%>
                <tr bgcolor=#006699 >
                    <%for I=0 to LIMITE %>
	                    <td align="center"  bgcolor=#A3B87A class="Estilo8"><%=RS2.FIELDS(I).NAME%></td>
                    <%next%>	
                </tr>
                <%DO WHILE NOT RS2.EOF%>
                 <%porcen = formatnumber(cdbl(RS2.FIELDS.ITEM(6))*100,2,,true) %>
	                <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                        response.write(Application("color2"))
                        else
	                    response.write(Application("color1"))
	                    end IF%>"  class="<%if porcen > 105 then 
                        response.write("estilo6") 
                        else
                        response.write("estilo5")
                        end if%>">
		               <td align="center" >&nbsp;<%=RS2.FIELDS.ITEM(0)%></td>
	                   <td align="left" ><%=ucase(RS2.FIELDS.ITEM(1))%></td>
                       <td align="center" ><%=RS2.FIELDS.ITEM(2)%></td>
                       <td align="right"  style="padding-right:5px;"><%=formatnumber(RS2.FIELDS.ITEM(3),3,,true)%></td>
                       <td align="right"  style="padding-right:5px;"><%=formatnumber(RS2.FIELDS.ITEM(4),3,,true)%></td>
                       <td align="right" style="padding-right:5px;"><%=formatnumber(RS2.FIELDS.ITEM(5),3,,true)%></td>
              
                       <td align="right"  style="padding-right:5px;"><%=porcen%>&nbsp;%</td>
	                </tr>
	                <%RS2.MOVENEXT%>
	                <%CONT = CONT + 1%>
	                <%LOOP%>
        </table>

    </td>
    </tr>
    <tr>
    <td>
    <!------------------------------------------------------>
        <table id="Table6" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
        <tr>
        <td colspan="5" align="left" class="ESTILO2">PARTES DE ENTRADA/SALIDA</td>
        </tr>
        </table>
    </td>
    </tr>
    <tr>
    <td>
        <!-------------------------------------------------------------------------->
     <%  TBL1 = "RS_ALMOVD" + CIA 
        TBL2 = "RSFACCAR..AL" + CIA + "MOVD"
        TBL3 = "RS_ALMOVC" + CIA
        TBL4 = "RS_ALMOVD_TALLA" + CIA 
        CAD =  "EXEC BuscaMOVD_PRN_OC  '"&OC&"',  '"&TBL1&"', '"&TBL2&"' , '"&TBL3&"', '"&TBL4&"' "
         '   RESPONSE.WRITE(CAD)
        RS.OPEN CAD, CNN
    %>
    <%IF RS.RECORDCOUNT>0 THEN	RS.MOVEFIRST%>

            <table id="Table2" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="1"  cellspacing="0"  border="1" width="100%">
            <%'**************************%>
            <%'LINEA DE CABECERA STANDAR %>
            <%'**************************%>
            <%LIMITE =  RS.fields.count - 1	%>
            <tr  bgcolor="#A3B87A" align="center" class="Estilo8">
                    <td colspan="12">&nbsp;</td>
                    <td colspan="3"><%=CIANAME%></td>
                    <td colspan="4">PROVEEDOR</td>
                    <td colspan="7">&nbsp;</td>
            </tr>
            <tr bgcolor="#A3B87A" align="center" class="Estilo8">
                    <td>ALM</td>
	                <td >FECHA</td>
                    <td >TIP</td>
                    <td >MOV</td>
                    <td >DOCUMENTO</td>
                    <td >DOC REF</td>
                    <td >PROVEEDOR</td>
                    <td >FACTURA</td>
                    <td >CODIGO</td>
                    <td >DESCRIPCION</td>
                    <td >COLOR</td>
                    <td >LOTE</td>
                    <td >CANTIDAD</td>
                    <td >KGS BRUTO</td>
                    <td >KGS NETO</td>
                    <td >CANTIDAD</td>
                    <td >KGS BRUTO</td>
                    <td >KGS NETO</td>
                    <td >% MERMA</td>
                    <td >MONTO</td>
                    <td >TIP SERV</td>
                    <td >U.M.</td>
                    <td >BULTOS</td>
                    <td >CONOS</td>
                    <td >TALLAS</td>
                    <td >OBSERVACION</td>
            </tr>
            <%  C1=0
                C2=0
                M0 = 0%>
            <%DO WHILE NOT RS.EOF%>
	            <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                    response.write(Application("color2"))
                    else
	                response.write(Application("color1"))
	                end IF%>"  class="estilo5">
                     <%monto = cdbl(rs("ncantid")) * cdbl(rs("c6_npreun1")) %>
                    <%C1 = C1 + CDBL(RS("NCANTID"))
                    C2 = C2 + CDBL(RS("NCANTIDPROV")) 
                    M0 = M0 + MONTO %>
		           <td align="center" >&nbsp;<%=RS("CALMA")%></td>
	               <td align="left" ><%=FORMATDATETIME(RS("DFECDOC"),2)%></td>
                   <td align="center" ><%=RS("CTD")%></td>
                   <td align="center" ><%=RS("ccodmov")%></td>
                   <td align="right"  style="padding-right:5px;">&nbsp;<%=RS("CNUMDOC")%></td>
                   <td align="right"  style="padding-right:5px;">&nbsp;<%=RS("CRFNDOC")%></td>
                   <td align="right"  style="padding-right:5px;">&nbsp;<%=RS("CNOMPROV")%></td>
                   <td align="right"  style="padding-right:5px;">&nbsp;<%=RS("cp_cnumdoc")%></td>
                   <td align="right"  style="padding-right:5px;">&nbsp;<%=RS("CCODIGO")%></td>
                   <td align="left"  style="padding-right:5px;">&nbsp;<%=RS("CDESCRI")%></td>
                   <td align="left"  style="padding-right:5px;">&nbsp;<%=RS("COLOR")%></td>
                   <td align="center"  style="padding-right:5px;">&nbsp;<%=RS("LOTE")%></td>
                   <td align="right"  style="padding-right:5px;"><%=formatnumber(RS("NCANTID"),3,,true)%></td>
                   <td align="right"  style="padding-right:5px;"><%=formatnumber(RS("KGBRUTO"),3,,true)%></td>
                   <td align="right"  style="padding-right:5px;"><%=formatnumber(RS("KGNETO"),3,,true)%></td>
                   <td align="right"  style="padding-right:5px;"><%=formatnumber(RS("NCANTIDPROV"),3,,true)%></td>
                   <td align="right"  style="padding-right:5px;"><%=formatnumber(RS("KGBRUTOPROV"),3,,true)%></td>
                   <td align="right"  style="padding-right:5px;"><%=formatnumber(RS("KGNETOPROV"),3,,true)%></td>
             
                  <%if cdbl(rs("KGnetoPROV")) > 0 and cdbl(rs("KGBRUTOPROV")) then porcen= (1-(cdbl(rs("KGnetoPROV"))/cdbl(rs("KGBRUTOPROV"))))*100 else porcen = 0 %>
                   <td align="right"  style="padding-right:5px;"><%=FORMATNUMBER(porcen,2,,,TRUE)%>&nbsp;%</td>
                   <td align="right"  style="padding-right:5px;"><%=formatnumber(monto,2,,true)%></td>
                   <td align="left"  style="padding-right:5px;"><%=RS("TIPSERVICIO")%></td>
                   <td align="left"  style="padding-right:5px;"><%=RS("unimed")%></td>
                   <td align="right"  style="padding-right:5px;"><%=formatnumber(RS("BULTOS"),0,,true)%></td>
                   <td align="right"  style="padding-right:5px;"><%=formatnumber(RS("CONOS"),0,,true)%></td>
                   <td align="left"  style="padding-right:5px;"><%=RS("TALLAS")%></td>
                   <td align="left"  style="padding-right:5px;"><%=RS("OBSERV")%></td>
	            </tr>
	            <%RS.MOVENEXT%>
	            <%CONT = CONT + 1%>
	            <%LOOP%>
                <tr bgcolor=#A3B87A align="center" class="Estilo55">
                    <td colspan="12">&nbsp;</td>
                    <td colspan="1"><%=FORMATNUMBER(C1,3,,TRUE)%></td>
                    <td colspan="2">&nbsp;</td>
                    <td colspan="1"><%=FORMATNUMBER(C2,3,,TRUE)%></td>
                    <td colspan="3">&nbsp;</td>
                    <td colspan="1"><%=FORMATNUMBER(M0,2,,TRUE)%></td>
                    <td colspan="6">&nbsp;</td>
            </tr>
            </table>
    
        <!--------------------------------------------------------------------------->
       </td>
    </tr>

    </table>
    <%RS.CLOSE %>
    <%RS2.CLOSE %>
    <%RS3.MOVENEXT%>
</td></tr>
<%loop %>

</table>
</BODY>
</HTML>
