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

Fec = REQUEST.QueryString("Fec")
'RESPONSE.Write(FEC)

ANO= RIGHT(TRIM(FEC),4)
DIA = LEFT(TRIM(FEC),2)
MES = MID(TRIM(FEC),4,2)


'RS.Open KAD, Cnn
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.ActiveConnection = Cnn
	RS2.CursorType       = 3 'CONST adOpenStatic = 3
	RS2.LockType         = 1 'CONST adReadOnly = 1
	RS2.CursorLocation   = 3 'CONST adUseClient = 3
	CONT = 1 %>

 <% archivo = "c:\temp\MOVIM_dia.xls"
    Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 
 %>
   <%       TBL1 = "RS_ALMOVD_TALLA" + CIA
            TBL2 = "RS_ALMOVD" + CIA 
            TBL3 = "RS_ALMOV_UBICACION" + CIA
            TBL4 = "RS_USUALM" + CIA
            cad = " Select top 100 percent A.CALMA as ALM,A.CTD,A.CNUMDOC AS DOC_NUM,A.CITEM AS ITEM,           " & _
                  " A.DFECDOC AS FEC,A.CRFTDOC R_DOC,A.CRFNDOC AS DOC_REF,A.CTIPMOV AS TIP,A.CCODMOV AS MOV,    " & _
                  " A.CCODIGO,A.CDESCRI,A.NCANTID AS CANT,A.CCODPROV AS RUC,A.CNOMPROV AS PROVEEDOR,            " & _
                  " A.UNIMED AS UNI,  A.CNUMORD AS OC,A.COLOR,A.LOTE,ISNULL(A.KGBRUTO,0) AS K_BRUTO,            " & _
                  " ISNULL(A.KGNETO,0)AS K_NETO,ISNULL(A.KGBRUTOPROV,0) AS BRUT_PRO, ISNULL(A.KGNETOPROV,0) AS  " & _
                  " NET_PRO,ISNULL(A.BULTOS,0) AS BULTOS ,ISNULL(A.CONOS,0) AS CONOS,                           " & _
                  " C.DesTipoMov AS TIP_MOV, A.CUBICACION AS UBI,A.OBSERV,A.DETALLADO, Tallas=CASE WHEN         " & _
                  " A.Detallado='S' THEN LTRIM(dbo.concat_Tallas(A.CALMA,A.CTD,A.CNUMDOC,A.CITEM, '"&tbl1&"'))  " & _
                  " ELSE '' END, A.CALMA+A.CTD+a.CNUMDOC+a.CITEM AS CAD,                                        " & _
                  " B.CESTANTE+' ['+B.FILA+CAST(B.COLUMNA AS VARCHAR(5))+']' AS Ubicacion,A.ESTADO              " & _
                  " From  "&TBL2&" A                                                                            " & _
                  " full outer JOIN "&TBL3&"  B ON(A.CUBICACION COLLATE                                         " & _
                  " SQL_Latin1_General_CP1_CI_AI=B.CUBICACION)  full outer JOIN AL_TIPOSMOV0001  C              " & _   
                  " ON (A.CodTipoMov=C.CodTipoMov) Where year(A.dfecdoc) ="&ANO&"                               " & _
                  " and month(A.dfecdoc) = "&MES&" and day(A.dfecdoc) = "&DIA&"  and  A.CALMA  collate          " & _
                  "  Modern_Spanish_CI_AS  in (select [CALMA] from "&tbl4&" where [CUSUARIO] collate            " & _
                  " Modern_Spanish_CI_AS = '"&usr&"')                                                           " & _
                  " order by 1, 2, 3                                                                            "

       RESPONSE.WRITE(CAD)
       RS.OPEN CAD, CNN
       %>
<title>MOVIMIENTO DE ORDENES DE COMPRA </title>
<HTML>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body style="margin-top:0; margin-left:0; margin-right:0;" >
<table id="Table8" align="left" cellpadding="0"  cellspacing="0"  border="0" width="100%">
<tr><td>
    <table id="Table4" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
    <tr>
        <td colspan="5" align="left" class="ESTILO2">TODOS LOS ALMACENES</td>
    </tr>
    <tr>
        <td colspan="5" align="left" class="ESTILO2">FECHA: <%=FORMATDATETIME(FEC,2)%></td>
    </tr>
    </table>
    </td>
</tr>
<tr>
<td>

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
	            <td>TIP</td>
                <td>DOCUMENTO</td>
                <td>DOC REF</td>
                <td>PROVEEDOR</td>
                <td>CODIGO</td>
                <td>DESCRIPCION</td>
                <td>COLOR</td>
                <td>O/C</td>
                <td>LOTE/PARTIDA</td>
                <td>CANTIDAD<br />REC/ENTR</td>
                <td>KGS <BR />BRUTO</td>
                <td>KGS <BR />NETO</td>
                <td>KGS <BR />BRUTO</td>
                <td>KGS <BR />NETO</td>
                <td>TIP SERV</td>
                <td>U.M.</td>
                <td>BULTOS</td>
                <td>CONOS</td>
                <td>TALLAS</td>
                <td>OBSERVACION</td>
                <td>UBICACION</td>
        </tr>
        <%IF  RS.EOF THEN response.end%>
        <%DO WHILE NOT RS.EOF%>
         
	        <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color2"))
                else
	            response.write(Application("color1"))
	            end IF%>"  class="estilo5">
                
		       <td align="center" >&nbsp;<%=RS("ALM")%></td>
               <td align="center" ><%=RS("CTD")%></td>
               <td align="right"  style="padding-right:5px;">&nbsp;<%=RS("DOC_NUM")%></td>
               <td align="right"  style="padding-right:5px;">&nbsp;<%=RS("DOC_REF")%></td>
               <td align="right"  style="padding-right:5px;">&nbsp;<%=RS("PROVEEDOR")%></td>
               <td align="right"  style="padding-right:5px;">&nbsp;<%=RS("CCODIGO")%></td>
               <td align="left"  style="padding-right:5px;">&nbsp;<%=RS("CDESCRI")%></td>
               <td align="left"  style="padding-right:5px;">&nbsp;<%=RS("COLOR")%></td>
               <td align="left"  style="padding-right:5px;">&nbsp;<%=RS("OC")%></td>
               <td align="center"  style="padding-right:5px;">&nbsp;<%=RS("LOTE")%></td>
               <td align="right"  style="padding-right:5px;"><%=formatnumber(RS("CANT"),3,,true)%></td>
               <td align="right"  style="padding-right:5px;"><%=formatnumber(RS("K_BRUTO"),3,,true)%></td>
               <td align="right"  style="padding-right:5px;"><%=formatnumber(RS("K_NETO"),3,,true)%></td>
               <td align="right"  style="padding-right:5px;"><%=formatnumber(RS("BRUT_PRO"),3,,true)%></td>
               <td align="right"  style="padding-right:5px;"><%=formatnumber(RS("NET_PRO"),3,,true)%></td>
               <td align="left"  style="padding-right:5px;"><%=RS("TIP_MOV")%></td>
               <td align="left"  style="padding-right:5px;"><%=RS("uni")%></td>
               <td align="right"  style="padding-right:5px;"><%=formatnumber(RS("BULTOS"),0,,true)%></td>
               <td align="right"  style="padding-right:5px;"><%=formatnumber(RS("CONOS"),0,,true)%></td>
               <td align="left"  style="padding-right:5px;"><%=RS("TALLAS")%></td>
               <td align="left"  style="padding-right:5px;"><%=RS("OBSERV")%></td>
               <td align="left"  style="padding-right:5px;"><%=RS("Ubicacion")%></td>
	        </tr>
	        <%RS.MOVENEXT%>
	        <%CONT = CONT + 1%>
	        <%LOOP%>
           
        </table>

   </td>
</tr>
</table>
</BODY>
</HTML>
