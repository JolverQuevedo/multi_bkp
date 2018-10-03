<%@ Language=VBScript %>
<%Response.Buffer = TRUE %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html>
<head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body>

<%
alm = ucase(TRIM(Request.QueryString("alm")))
tip = ucase(TRIM(Request.QueryString("CTD")))
doc = ucase(TRIM(Request.QueryString("Doc")))
ITM = ucase(TRIM(Request.QueryString("ITM")))
UNI = ucase(TRIM(Request.QueryString("UNI")))
COL = ucase(TRIM(Request.QueryString("COL")))
LOT = ucase(TRIM(Request.QueryString("LOT")))
BUL = replace(ucase(TRIM(Request.QueryString("BUL"))),",","")
CON = replace(ucase(TRIM(Request.QueryString("CON"))),",","")
KGN = replace(ucase(TRIM(Request.QueryString("KGN"))),",","")
KGB = replace(ucase(TRIM(Request.QueryString("KGB"))),",","")
CNP = replace(ucase(TRIM(Request.QueryString("CNP"))),",","")
KNP = replace(ucase(TRIM(Request.QueryString("KNP"))),",","")
KBP = replace(ucase(TRIM(Request.QueryString("KBP"))),",","")
SER = ucase(TRIM(Request.QueryString("SER")))
UBI = ucase(TRIM(Request.QueryString("UBI")))
OBS = ucase(TRIM(Request.QueryString("OBS")))
TAL = ucase(TRIM(Request.QueryString("TAL")))
VBC = ucase(TRIM(Request.QueryString("VBC")))
REF = ucase(TRIM(Request.QueryString("REF")))
OC  = ucase(TRIM(Request.QueryString("OC")))
ata  = ucase(TRIM(Request.QueryString("ata")))
aca  = ucase(TRIM(Request.QueryString("aca")))
aTal = Split(ata, ",") 
aCan = Split(aca, ",")
TBL1 = "RS_ALMOVD" + cia
TBL2 = "RS_ALMOVD_TALLA" + cia
' ACTUALIZA LA LINEA DE DETALLE DE MOVIMIENTO
CAD =   " UPDATE "&TBL1&" SET CRFNDOC='"&REF&"',CNUMORD='"&OC&"',UNIMED='"&UNI&"',COLOR='"&COL&"', LOTE='"&LOT&"',   " & _
        " BULTOS= '"&BUL&"', CONOS='"&CON&"',	KGBRUTO='"&KGB&"', 	KGNETO='"&KGN&"', NCANTIDPROV='"&CNP&"',        " & _
        " KGBRUTOPROV='"&KBP&"', KGNETOPROV='"&KNP&"', CODTIPOMOV='"&SER&"', CUBICACION='"&UBI&"', OBSERV='"&OBS&"'," & _
		" DETALLADO='"&TAL&"', 	VBCC='"&VBC&"' 	WHERE CALMA='"&ALM&"' AND CTD='"&tip&"' AND CNUMDOC='"&DOC&"' AND   " & _
        " CITEM='"&ITM&"' ;                                                                                         "
' SE CHIFA LAS CANTIDADES POR TALLA
CAD = CAD + " DELETE "&TBL2&" WHERE CALMA='"&ALM&"' AND CTD='"&tip&"' AND CNUMDOC='"&DOC&"' AND CITEM='"&ITM&"' ;   "
' VOLVER A CREAR LAS CANTIDADES POR Talla EN CASO HAYA MODIFICADO
if (ubound(atal) >=0 ) then
    FOR I= lbound(atal) TO ubound(aTal)
        ttt = aTal(i)
        ccc = aCan(i)
        cad = cad + "Insert into "&tbl2&" (CALMA,CTD,CNUMDOC,CITEM,TALLA,CANTIDAD,ORDEN) VALUES(    " & _
                    " '"&alm&"', '"&tip&"', '"&doc&"', '"&itm&"', '"&ttt&"', "&ccc&", '"&i&"' ) ;   "
    Next
end if

response.write(cad)
'RESPONSE.END
  Cnn.Execute(CAD)
%>

<script language="jscript" type="text/jscript">
   // alert(window.parent.window.opener.document.all.compra.value)
    //alert(top.window.window.opener.document.all.compra.value)
/*
    kag = 'frames/partes_deta_oc_contra.asp?doc=' + trim(window.parent.window.opener.document.all.compra.value)
    */
    //alert(window.opener.window.parent.document.all.ruc.value)
    window.opener.window.parent.MANDA()
   window.close()
</script>
    
</body>
</html>
