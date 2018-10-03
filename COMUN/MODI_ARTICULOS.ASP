<%@ Language=VBScript %>
<%Response.Buffer = TRUE %>
<%Session.LCID=2057%>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%
cart  = ucase(trim(request.querystring("cart")))
'response.write(ucase(trim(request.querystring("cart"))))
'response.write("<br>")
dart  = ucase(trim(request.querystring("dart")))
cart2 = ucase(trim(request.querystring("cart2")))
dart2 = ucase(trim(request.querystring("dart2")))
uni   = ucase(trim(request.querystring("uni")))
cta   = ucase(trim(request.querystring("cta")))
tip   = ucase(trim(request.querystring("tip")))
lin   = ucase(trim(request.querystring("lin")))
gru   = ucase(trim(request.querystring("gru")))
mar   = ucase(trim(request.querystring("mar")))
mdl   = ucase(trim(request.querystring("mdl")))
fam   = ucase(trim(request.querystring("fam")))
ori   = ucase(trim(request.querystring("ori")))
sun   = ucase(trim(request.querystring("sun")))
ano   = ucase(trim(request.querystring("ano")))
sct   = ucase(trim(request.querystring("sct")))
dcm   = ucase(trim(request.querystring("dcm")))
sre   = ucase(trim(request.querystring("sre")))
lng   = ucase(trim(request.querystring("lng")))
lte   = ucase(trim(request.querystring("lte")))
cst   = ucase(trim(request.querystring("cst")))
plv   = ucase(trim(request.querystring("plv")))
dci   = ucase(trim(request.querystring("dci")))
are   = ucase(trim(request.querystring("are")))
rec   = ucase(trim(request.querystring("rec")))
edo   = ucase(trim(request.querystring("edo")))
ruc   = ucase(trim(request.querystring("ruc")))
mnc   = ucase(trim(request.querystring("mnc")))
igv   = ucase(trim(request.querystring("igv")))
cmp   = ucase(trim(request.querystring("cmp")))
fec   = ucase(trim(request.querystring("fec")))
cat   = ucase(trim(request.querystring("cat")))
mnf   = ucase(trim(request.querystring("mnf")))
fob   = ucase(trim(request.querystring("fob")))
mnk   = ucase(trim(request.querystring("mnk")))
cto   = ucase(trim(request.querystring("cto")))
par   = ucase(trim(request.querystring("par")))
mnv   = ucase(trim(request.querystring("mnv")))
pig   = ucase(trim(request.querystring("pig")))
pis   = ucase(trim(request.querystring("pis")))
ped   = ucase(trim(request.querystring("ped")))
pp1   = ucase(trim(request.querystring("pp1")))
pp2   = ucase(trim(request.querystring("pp2")))
pr1   = ucase(trim(request.querystring("pr1")))
pr2   = ucase(trim(request.querystring("pr2")))
pr3   = ucase(trim(request.querystring("pr3")))
pr4   = ucase(trim(request.querystring("pr4")))
pr5   = ucase(trim(request.querystring("pr5")))
pr6   = ucase(trim(request.querystring("pr6")))
pds   = ucase(trim(request.querystring("pds")))
pcm   = ucase(trim(request.querystring("pcm")))
dct   = ucase(trim(request.querystring("dct")))
tdc   = ucase(trim(request.querystring("tdc")))


'IGV = 0
'CMP = 0
'FOB = 0
'CTO = 0
'PIG = 0
'PIS = 0
'PED = 0
'PP1 = 0
'PP2 = 0
'PCM = 0
'PDS = 0
'DCT = 0
'PR1 = 0
'PR2 = 0
'PR3 = 0
'PR4 = 0
'PR5 = 0
'PR6 = 0
MRG = 0
'rec = 0
'lng= 0
MODI = DATE()

TBL1 = " RSFACCAR..AL" + cia + "ARTI "

'response.end


	cad =   " Update "&tbl1&" SET                                " & _
            " AR_CDESCRI='"&dart&"',                             " & _   
            " AR_CDESCR2='"&dart2&"',                            " & _
            " AR_CCODIG2='"&cart2&"',                            " & _
            " AR_CUNIDAD='"&uni&"',                              " & _
            " AR_CCUENTA='"&cta&"' ,                             " & _
            " AR_CTIPOI='"&sct&"',								 " & _	
            " AR_CFDECI='"&dcm&"',								 " & _	
            " AR_CFSERIE='"&sre&"',								 " & _	
            " AR_CFLOTE='"&lte&"',								 " & _	
            " AR_CESTADO='"&edo&"',								 " & _	
            " AR_CUSUMOD='"&usr&"',								 " & _	
            " AR_DFECMOD=Convert(datetime,'"&MODI&"',103),       " & _
            " AR_CTIPEXI='"&sun&"',						         " & _
            " AR_CANOFAB='"&ano&"',						         " & _
            " AR_CFLGRCN='"&are&"',				                 " & _
            " AR_CFSTOCK='"&cst&"',				                 " & _
            " AR_NPRECI1="&pR1&",                                " & _
            " AR_NPRECI2="&pR2&",	                             " & _
            " AR_NPRECI3="&PR3&",                                " & _
            " AR_NPRECI4="&PR4&",	                             " & _
            " AR_NPRECI5="&PR5&",                                " & _
            " AR_NPRECI6="&PR6&",	                             " & _
            " AR_CFPRELI='"&PLV&"',			                     " & _
            " AR_CFRESTA='"&DCI&"',			                     " & _
            " AR_NPERC1="&PP1&",				                 " & _
            " AR_NPERC2="&PP2&",				                 " & _
            " AR_NDETRA="&PED&",				                 " & _
            " AR_NTASRCN="&REC&",				                 " & _
            " AR_CTIPDES='"&TDC&"',			                     " & _
            " AR_NDESCTO="&DCT&",				                 " & _
            " AR_NPDIS="&PDS&",				                     " & _
            " AR_NPCOM="&PCM&",				                     " & _
            " AR_NMARVTA="&MRG&",				                 " & _
            " AR_CMONVTA='"&MNV&"',			                     " & _
            " AR_NIGVPOR="&PIG&",				                 " & _
            " AR_NISCPOR="&PIS&",				                 " & _
            " AR_DFECCOM=Convert(datetime,'"&FEC&"',103),        " & _
            " AR_DFECCOS= '',			                         " & _
            " AR_NLONSER = "&lng&",                              " & _ 
            " ar_cmarca = '"&mar&"'  ,                           " & _
            " AR_CMONCOS = '"&MNK&"',	                         " & _
            " AR_NPRECOS= "&CTO&",	                             " & _
            " AR_CCODPRO='"&RUC&"',	                             " & _
            " AR_CMONFOB='"&MNF&"',	                             " & _
            " AR_NPREFOB="&FOB&",		                         " & _
            " AR_CMONCOM='"&MNC&"',	                             " & _
            " AR_NPRECOM="&CMP&",		                         " & _
            " AR_CGRUPO='"&GRU&"',	                             " & _
            " AR_CPARARA='"&PAR&"',	                             " & _
            " AR_CCATEGO='"&CAT&"',	                             " & _
            " AR_NIGVCPR="&IGV&" 		                         " & _
            " Where AR_CCODIGO='"&cart&"' ;                      "



response.write(cad)
'response.end
Cnn.Execute(CAD)
%>

<script language="jscript" type="text/jscript">
    alert("Datos Actualizados!")
    parent.window.location.replace('../articulos.asp?cod='+ '<%=cart%>')
     
</script>
</BODY>
</HTML>
