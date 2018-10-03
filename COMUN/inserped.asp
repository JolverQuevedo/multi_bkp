<%@ Language=VBScript %>
<%Response.Buffer = TRUE %>
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

<%'response.write(Request.QueryString())
alm	= Request.QueryString("alm") 
nro	= Request.QueryString("pe") 
cd	= Request.QueryString("cd") 
cod	= Request.QueryString("acod")

can	= Request.QueryString("acan")
pre	= Request.QueryString("apre")
tot	= Request.QueryString("atot")
pc1	= Request.QueryString("aPc1")
pc2	= Request.QueryString("aPc2")
pc3	= Request.QueryString("aPc3")
pc4	= Request.QueryString("aPc4")
dc1	= Request.QueryString("aDc1")
dc2	= Request.QueryString("aDc2")
dc3	= Request.QueryString("aDc3")
dc4	= Request.QueryString("aDc4")
response.write(can)
aCod = split(cod,",")

aCan = split(can,",")
aPre = split(pre,",")
atot = split(tot,",")
' porcentajes dedescuento
aPc1 = split(pc1,",")
aPc2 = split(pc2,",")
aPc3 = split(pc3,",")
aPc4 = split(pc4,",")
'importes del descuento
aDc1 = split(dc1,",")
aDc2 = split(dc2,",")
aDc3 = split(dc3,",")
aDc4 = split(dc4,",")
response.write( cint(aCan(1)))


' los arrays empiezan a tener datos a partir del elemento 1
' el elemento 0 se queda en blanco porque sinó no coinciden los 
' números de línea con el id

TBL2 = "RSFACCAR..AL" + cia + "MOVC"
cad =   " select * from "&tbl2&"  where " & _
        " C5_CALMA = '"&alm&"' and  C5_CTD = 'PE' and c5_cnumdoc = '"&nro&"'"
response.write(cad)
rs.open cad, cnn
rs.movefirst
pe = rs("c5_ccodmov")
loc = rs("c5_clocali")
ep = rs("c5_ccodmov")
cord = rs("c5_crftdoc")
fec = formatdatetime(rs("c5_dfecdoc"),2)
cto = rs("c5_ccencos")
sol = rs("c5_csoli")
mon =rs("c5_ccodmon")
ctip = rs("c5_ctipo")
cam = rs("c5_ntipcam")
edo = rs("c5_csitua")

TBL1 = "RSFACCAR..AL" + CIA + "MOVD"
TBL3 = "RSFACCAR..AL" + CIA + "ARTI"
TBL4 = "RSFACCAR..AL" + CIA + "STOC"

cad = ""
'***********************************************************************
' descarga el stock
'***********************************************************************
  Set RS2 = Server.CreateObject("ADODB.Recordset")
      RS2.ActiveConnection = Cnn
      RS2.CursorType       = 3 'CONST adOpenStatic = 3
      RS2.LockType         = 1 'CONST adReadOnly = 1
      RS2.CursorLocation   = 3 'CONST adUseClient = 3

cad = " select * from "&TBL1&" AS DD INNER JOIN "&TBL3&" AS AA ON  AA.AR_CCODIGO = DD.C6_CCODIGO " & _
       " where C6_CALMA = '"&alm&"' and C6_CTD = 'pe' and C6_CNUMDOC= '"&nro&"' order by C6_CITEM; "

RS2.OPEN CAD,CNN

if rs2.recordcount > 0 then rs2.movefirst



do while not rs2.eof
    CAN = CDBL(RS2("C6_NCANTID"))
    cod = rs2("C6_CCODIGO")
    CAD = CAD + " Update "&TBL4&" Set SK_NSKDIS=SK_NSKDIS-"&CAN&"  ,SK_DFECMOV=GETDATE()    " & _
                " Where  SK_CALMA='"&alm&"' AND SK_CCODIGO='"&cod&"' ;                      " 
    rs2.movenext
loop


'***********************************************************************
' elimina detalle del movimiento
'***********************************************************************

cad = cad +  " delete "&TBL1&" where C6_CALMA = '"&alm&"' and C6_CTD = 'PE' and c6_cnumdoc = '"&nro&"';  " 
    
    ' tengo un segundo contador porque como elimine todo el detalle...
    ' solo se ingresaran las lineas que tengan cantidad > 0
    ' para eliminar una linea solo pone la cantidad en 0  
    j = 1
' barre todas las lineas
 for i = 1 to ubound(aCod)
  if cint(aCan(i)) > 0 then
    itm = right("0000" & j,4)
    j = j + 1
    cod = trim(acod(i))
    rs2.close
    fast = "Select ar_cdescri From "&tbl3&" Where AR_CCODIGO= '"&cod&"'"
    rs2.open fast,cnn
    des = trim(rs2("ar_cdescri"))
    can = aCan(i)
    pre = aPre(i)
    tot = aTot(i)
    if len(trim(aDc1(i))) > 0 then  dc1 = aDc1(i) else dc1 = 0
    if len(trim(aDc2(i))) > 0 then  dc2 = aDc2(i) else dc2 = 0
    if len(trim(aDc3(i))) > 0 then  dc3 = aDc3(i) else dc3 = 0
    if len(trim(aDc4(i))) > 0 then  dc4 = aDc4(i) else dc4 = 0
    mn= round(cdbl(pre) * cdbl(cam) ,2)
    mnt = round(mn*cdbl(can),2)
    cad = cad + "Insert Into  "&tbl1&" (C6_CALMA, C6_CTD, C6_CNUMDOC, C6_CCODMOV, C6_CITEM, " & _
                " C6_CCODIGO, C6_CDESCRI, C6_CORDEN, C6_NCANTID, C6_DFECDOC, C6_CLOCALI,    " & _
                " C6_CCENCOS, C6_CSOLI, C6_CCODMON, C6_CTIPO, C6_NTIPCAM, C6_NPREUN1,       " & _
                " C6_NPREUNI, C6_NVALTOT, C6_NPORDE1, C6_NPORDE2, C6_NPORDE3, C6_NPORDE4,   " & _
                " C6_CESTADO, C6_NUSIMPO, C6_NUSPRUN, C6_NMNIMPO, C6_NMNPRUN) Values(       " & _
                " '"&ALM&"','PE','"&nro&"','"&ep&"','"&itm&"',                              " & _
                " '"&cod&"','"&des&"','"&cord&"' , "&can&", Convert(datetime,'"&fec&"',103)," & _
                " '"&loc&"','"&cto&"','"&sol&"', '"&mon&"','"&ctip&"',"&cam&", "&pre&",     " & _
                " "&pre&", "&tot&", "&dc1&", "&dc2&", "&dc3&", "&dc4&", '"&edo&"', "&tot&", " & _
                " "&pre&", "&mnt&", "&mn&") ;                                               " & _
                " Update "&TBL4&" Set SK_NSKDIS=SK_NSKDIS-"&CAN&",  SK_DFECMOV=GETDATE()    " & _
                " Where  SK_CALMA='"&alm&"' AND SK_CCODIGO='"&cod&"' ;                      " 
    end if
next

response.write(cad)
'response.end
Cnn.Execute(CAD)
%>
<script language="jscript" type="text/jscript">
    cad = '../parte_deta.asp?pe=' + '<%=Request.QueryString("pe") %>' + '&al=' + '<%=Request.QueryString("alm") %>'
    cad += '&can=' + '<%=Request.QueryString("totpo") %>'
    cad += '&idd=' + '<%=Request.QueryString("idd") %>'
    cad += '&cod=' + '<%=Request.QueryString("cd") %>'
    window.parent.window.location.replace(cad)
    
</script>
</BODY>
</HTML>
