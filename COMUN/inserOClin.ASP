<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>
<link href="multisty.css" rel="stylesheet" type="text/css">
<!--#include file="../includes/Cnn.inc"-->

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************

OC =    TRIM(REQUEST.QUERYSTRING("OC"))
tbl1 = "RSFACCAR..CO"+cia+"MOVC"
rs.open ("select oc_Ccodpro,OC_CTIPORD, OC_DFECDOC, oc_ntipcam, oc_ccodmon from "&tbl1&"  where oc_cnumord = '"&OC&"'"),cnn
pro  = rs("oc_ccodpro")
TIP = RS("OC_CTIPORD")
FECD = RS("OC_DFECDOC")
cam = rs("oc_ntipcam")
mon = rs("oc_ccodmon")

rs.close
' capturo el codigo de proveedor de la cabecera
cod =   UCASE(TRIM(REQUEST.QUERYSTRING("cod")))
lin =   UCASE(TRIM(REQUEST.QUERYSTRING("lin")))
uni =   UCASE(TRIM(REQUEST.QUERYSTRING("uni")))
des =   UCASE(TRIM(REQUEST.QUERYSTRING("des")))
com =   UCASE(TRIM(REQUEST.QUERYSTRING("com")))
fin =   UCASE(TRIM(REQUEST.QUERYSTRING("fin")))
cto =   UCASE(TRIM(REQUEST.QUERYSTRING("cto")))
soli =  UCASE(TRIM(REQUEST.QUERYSTRING("sol")))
ent =   UCASE(TRIM(REQUEST.QUERYSTRING("ent")))
ref =   UCASE(TRIM(REQUEST.QUERYSTRING("ref")))
USR =   UCASE(LEFT(USUARIO,5))
HOR =   LEFT(TIME(),5)
KAN =   UCASE(TRIM(REQUEST.QUERYSTRING("aCan")))
ofi =   UCASE(TRIM(REQUEST.QUERYSTRING("aOfi")))

aCan =  split(kan,",")
aOfi =  split(ofi,",")
for i=0 to ubound(aofi)
    aofi(i) = right(aofi(i),8)
next
' cantidad total pedida del item
ped =   TRIM(REQUEST.QUERYSTRING("ped"))
'**************************************************
    pre =   TRIM(REQUEST.QUERYSTRING("pre"))
'**************************************************
' % dcto item incluido
ch1 =   TRIM(REQUEST.QUERYSTRING("ch1")) 
dct =   TRIM(REQUEST.QUERYSTRING("dct"))
if dct = "" then ddct = 100 else ddct = dct
if ch1 = "1" then  dite = pre -(pre * (ddct/100)) else dite = 0
' % dcto adicional incluido
ch2 =   TRIM(REQUEST.QUERYSTRING("ch2")) 
adi =   TRIM(REQUEST.QUERYSTRING("adi"))
if adi = "" then aadi = 100 else aadi = adi
if ch2 = "1" then  dadi = pre -(pre * (aadi/100)) else dadi = 0
' % igv incluido
ch3 =   TRIM(REQUEST.QUERYSTRING("ch3")) 
igv =   TRIM(REQUEST.QUERYSTRING("igv"))
if igv = "" then iigv = 100 else iigv = igv
' % isc incluido
ch4 =   TRIM(REQUEST.QUERYSTRING("ch4")) 
isc =   TRIM(REQUEST.QUERYSTRING("isc"))
if isc = "" then iisc = 100 else iisc = isc
pre     = cdbl(pre)
pre2    = cdbl(pre2)
cam     = cdbl(cam)
ped     = cdbl(ped)
'************************************************
'  --- casos del precio unitario informado ---
'************************************************
' preuni ==> tiene el igv incluido
if ch3 = "1" then 
    preuni = pre 
    pre2   = pre - (pre * (iigv/100)) 
else    
    preuni = preuni + (pre * (iigv/100))
    pre2 = pre
end if


pigv = pre * (iigv/100)
' * ped


'--------------------------------
'   igv e isc son excluyentes
'--------------------------------
' preuni == tiene el isc incluido
if ch4 = "1" then 
    preuni = pre 
    pre2   = pre - (pre * (iisc/100)) 
else    
    preuni = preuni + (pre * (iisc/100))
    pre2 = pre
end if
pisc = pre2 * (iisc/100)

if mon = "MN" then 
    usd = ((pre+pigv) / cam) * ped 
    sol = (pre+pigv) * ped
else 
    usd = (pre+pigv) * ped
    sol = ((pre+pigv) * cam) * ped
end if

' incluir el igv...
preuni = pre 
pigv = pre * (iigv/100) * ped
'-------------------------------------------------------------------
' PRIMERO SE BORRA LA LINEA DE DETALLE DEL REAL Y DEL MODELADOR
' ESTO LO HACE COMO RUTINA REAL PARA "EVITAR" HORRORES DE UPDATE???
'-------------------------------------------------------------------

tbl2= "RSFACCAR..CO"+cia+"MOVD"
tbl3 = "RSFACCAR..AL"+cia+"APRO "

CAD = " DELETE modelador..ORDENCOMPRA WHERE NUMORD = '"&OC&"' AND ITEM = '"&LIN&"' ; "
CAD = cad + " DELETE "&tbl3&" WHERE pm_cordcom = '"&OC&"' and pm_ccodmat = '"&cod&"' ; "
CAD = CAD + " Delete From "&tbl2&" Where OC_CNUMORD='"&OC&"' AND OC_CITEM='"&LIN&"' ; "
' INSERT

    ' INSERTA LA CABECERA DE LA O/C  
  cad = cad +   " Insert "&tbl2&" (                                                                     " & _
                " OC_CTIPORD, OC_CNUMORD, OC_DFECDOC, OC_CCODPRO, OC_CESTADO, OC_CITEM,   OC_CCODIGO,   " & _                                         
                " OC_CCODREF, OC_CDESREF, OC_CUNIDAD, OC_NCANORD, OC_NPREUN2, OC_NDESCAD, OC_NDSCPAD,   " & _
                " OC_NIGV,    OC_NIGVPOR, OC_NISC,    OC_NISCPOR, OC_NCANSAL, OC_NTOTUS,  OC_NTOTMN,    " & _
                " OC_NTOTMO,  OC_NPREUNI, OC_COMENTA, OC_NDSCPFI, OC_NDESCFI, OC_NDSCPIT, OC_NDESCIT,   " & _
                " OC_NDSCPOR, OC_NDESCTO, OC_CCENCOS, OC_CSOLICI, OC_CNUMREQ, OC_DFECENT, OC_CITMPOR,   " & _
                " OC_CDSCPOR, OC_CIGVPOR, OC_CISCPOR, OC_CUNIPRO, OC_CDEUNPR, OC_NCANTEN, OC_FUNICOM,   " & _
                " OC_NCANREF, OC_CSERIE,  OC_NANCHO,  OC_NCORTE,  OC_CITEREQ, OC_CREFCOD, OC_CPEDINT,   " & _
                "  OC_CITEINT, OC_CREFCOM, OC_CNOMFAB, OC_NCANEMB  ) Values  (                          " & _ 
                " '"&TIP&"', '"&OC&"',   Convert(datetime,'"&FECD&"',103),'"&PRO&" ', '1', '"&lin&"',   " & _
                " '"&cod&"', '"&ref&"','"&des&"', '"&uni&"', '"&ped&"', "&pre2&", "&dct&", "&Dite&" , "&pigv&",   " & _
                " '"&igv&"', "&pisc&", '"&isc&"', '"&ped&"', '"&usd&"', '"&sol&"', 0, '"&preuni&"',     " & _
                " '"&com&"', '"&fin&"', 0, '"&adi&"', "&dadi&", 0, 0, '"&cto&"', '"&soli&"', '',        " & _
                " Convert(datetime,'"&ent&"',103), 'N', 'N', 'N', 'N' , '', '', 0,'', 0, '', 0, 0,'',   " & _
                " '', '', '', '',  '', 0) ;                                                             " & _
                " Insert "&tbl3&" (PM_CCODMAT, PM_CCODPRO, PM_DFECDOC, PM_CTIPMON,PM_NVALOR, PM_CCOTIZA," & _
                "  PM_CORDCOM,  PM_DFECCRE, PM_CHORA, PM_CUSER) Values (                 " & _
                " '"&cod&"', '"&pro&"', Convert(datetime,'"&FECD&"',103), '"&mon&"',                    " & _
                " "&pre2&", '', '"&oc&"', Convert(datetime,'"&FECD&"',103), '"&hor&"', '"&USR&"')     ; "
' INCLUIR LOS INSERTS DE LAS OFIS.....

for i= 0 to ubound(aofi)
    SIT = RIGHT("00"+ CSTR(I+1),2)
    CAN = AcAN(I)
    OFI = AOFI(I)
    cad = cad + " INSERT modelador..ORDENCOMPRA (NUMORD, ITEM, SUB_IT, OFI, CODIGO, CANTIDAD, USUARIO,FECHA, ESTADO,        " & _
                " coddes, almdes) VALUES (  '"&OC&"', '"&LIN&"', '"&SIT&"', '"&OFI&"', '"&COD&"', '"&CAN&"', '"&USUARIO&"', " & _
                " GETDATE(), 'A', '"&ref&"', (select OC_CALMDES from rsfaccar..CO0001MOVc WHERE OC_CNUMORD = '"&oc&"'  ) ); "
NEXT




' Inicia transacción , para que los datos no queden a medias
RESPONSE.WRITE("<br>")
RESPONSE.WRITE(CAD)
'response.end
Cnn.BeginTrans	
Cnn.Execute(CAD)





if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>
<script language="javascript" type="text/jscript">
//top.window.opener.window.location.replace('../FICHAOCdeta.ASP?OC='+ '<%=OC%>')
//window.opener.top.window.location.replace('../FICHAOCdeta.ASP?OC=' + '<%=OC%>')


//    parent.window.opener.window.top.parent.frames['mainFrame'].window.location.replace('../detaoc.asp?fecha=<%=month(date())%>/<%=year(date())%>');
</script>
</BODY>
</HTML>
