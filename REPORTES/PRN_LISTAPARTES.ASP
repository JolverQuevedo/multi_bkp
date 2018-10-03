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

KAD = " Select dfecdoc as FECHA,ccodmov as MOV, cnumord Doc_Ref,B.CODTIPOMOV as	COD_MOT,destipomov as DES_MOT, CTD, " & _
      " CRFNDOC  as NUM_CTD,crftdoc as TIP, cnumdoc as NUM_DOC, CITEM as It,                                        " & _
      " calma as Alm, CCODIGO Codigo, CDESCRI Descripcion, UNIMED Und,                                              " & _
      "                                                                                                             " & _
      " Color, Lote, NCANTID Cantid, KGNETO, KGBRUTO, NCANTIDPROV, KGNETOPROV,  KGBRUTOPROV, B.DESTIPOMOV,          " & _
      " Tallas=CASE WHEN Detallado='S' THEN LTRIM(DBO.concat_Tallas(CALMA,CTD,CNUMDOC,CITEM,'RS_ALMOVD_TALLA0001')) " & _
      " ELSE '' END , OBSERV                                                                                        " & _
      " From RS_ALMOVD0001 A                                                                                        " & _
      " LEFT JOIN AL_TiposMov0001 B  ON(A.CODTIPOMOV=B.CODTIPOMOV)                                                  " & _
      " Where CCODIGO = '1000790000000000'                                                                          " & _
      " Order by num_DOC,CITEM                                                                                      "
      RS.OPEN KAD,CNN
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
<%LIMITE =  RS.fields.count - 1
CONT="0"	%>
<%IF  RS.EOF THEN response.end%>
 <tr bgcolor=#006699 >
    <%FOR I= 0 TO LIMITE%>
	        <td align="center" class="Estilo8"><%=cstr(RS.FIELDS(I).NAME)%></td>
    <%NEXT%>             
    </tr>
    <%DO WHILE NOT RS.EOF%>
   

	<tr>
        <%FOR I= 0 TO LIMITE %>
        <td align="left" class="estilo5"><%=RS.FIELDS.ITEM(I)%></td>
        <%NEXT%>
	</tr>
    
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
    
</table>


</BODY>
</HTML>
