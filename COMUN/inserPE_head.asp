<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")    %>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<%
alm = ucase(TRIM(Request.QueryString("alm")))
mov = ucase(TRIM(Request.QueryString("mov")))
fec = ucase(TRIM(Request.QueryString("fec")))
ruc = ucase(TRIM(Request.QueryString("ruc")))
dc1 = ucase(TRIM(Request.QueryString("dc1")))
dc2 = ucase(TRIM(Request.QueryString("dc2")))
nr1 = ucase(TRIM(Request.QueryString("nr1")))
nr2 = ucase(TRIM(Request.QueryString("nr2")))
emp = ucase(TRIM(Request.QueryString("emp")))
occ = ucase(TRIM(Request.QueryString("occ")))
ofi = ucase(TRIM(Request.QueryString("ofi")))
sol = ucase(TRIM(Request.QueryString("sol")))
cto = ucase(TRIM(Request.QueryString("cto")))
al2 = ucase(TRIM(Request.QueryString("al2")))
cli = ucase(TRIM(Request.QueryString("cli")))
tam = ucase(TRIM(Request.QueryString("tam")))
ane = ucase(TRIM(Request.QueryString("ane")))
gl1 = ucase(TRIM(Request.QueryString("gl1")))
gl2 = ucase(TRIM(Request.QueryString("gl2")))
gl3 = ucase(TRIM(Request.QueryString("gl3")))
pro = ucase(TRIM(Request.QueryString("pr")))
mon = ucase(TRIM(Request.QueryString("mon")))
con = ucase(TRIM(Request.QueryString("con")))
tcm = ucase(TRIM(Request.QueryString("tcm")))
ncl = ucase(TRIM(Request.QueryString("ncl")))
idd = ucase(TRIM(Request.QueryString("idd")))
nro = ucase(TRIM(Request.QueryString("nro")))
can = ucase(TRIM(Request.QueryString("can")))
cod = ucase(TRIM(Request.QueryString("cod")))
UPD = ucase(TRIM(Request.QueryString("UPD")))
'UPD ES LA MARCA PARA VER SI YA EXISTE O ES NUEVO
    'upd = 1 update
    'upd = 0 nuevo 

TBL1 = "RSFACCAR..AL" + cia + "MOVC"
TBL2 = "RSFACCAR..AL" + cia + "ALMA"
TBL3 = "multi..pos" + cia
if cint(upd) = 0 then 
    CNN.BEGINTRANS
    CAD =   " set dateformat dmy ;                                                              " & _
            " Update "&TBL2&" Set A1_NNUMENT=A1_NNUMENT + 1 Where A1_CALMA='"&alm&"';           " 
    cnn.execute(cad)

    cad =   " Insert Into "&TBL1&" (C5_CALMA, C5_CTD, C5_CTIPMOV, C5_CCODMOV, C5_CNUMDOC,       " & _
            " C5_DFECDOC, C5_CCODPRO, C5_CRFTDOC, C5_CRFTDO2, C5_CRFNDOC, C5_CRFNDO2,           " & _
            " C5_CNUMORD, C5_CCIAS, C5_CORDEN, C5_CSOLI, C5_CCENCOS, C5_CRFALMA, C5_CCODCLI,    " & _
            " C5_CCODANE, C5_CtipANE, C5_CGLOSA1, C5_CGLOSA2, C5_CGLOSA3, C5_CNOMPRO, C5_CNOMCLI,           " & _
            " C5_DFECCRE, C5_CUSUCRE, C5_CLOCALI, C5_CSITUA, C5_CCODMON, C5_CTIPO,C5_NTIPCAM)   " & _
            " SELECT '"&alm&"', 'PE', 'E' , '"&mov&"', (select right(('0000000000' + LTRIM(RTRIM(    " & _
            " casT(A1_NNUMENT as char(11))))),11) from "&tbl2&" Where  A1_CALMA='"&alm&"'),     " & _        
            " Convert(datetime,'"&FEC&"',103), '"&ruc&"', '"&dc1&"', '"&dc2&"',                 " & _
            " '"&nr1&"', '"&nr2&"', '"&occ&"', '"&emp&"',  '"&ofi&"', '"&sol&"', '"&cto&"',     " & _
            " '"&al2&"','"&cli&"', '"&ane&"', '"&tam&"','"&gl1&"', '"&gl2&"',  '"&gl3&"', '"&pro&"',      " & _
            " '"&ncl&"',Convert(datetime,'"&FEC&"' ,103), '"&usr&"', '0001', 'V',               " & _
            " '"&mon&"', '"&con&"', "&tcm&"         ;                                           " & _
            " update "&tbl3&" set pe =  (select right(('0000000000' + LTRIM(RTRIM(                   " & _
            " casT(A1_NNUMENT as char(11))))),11) from "&tbl2&" Where  A1_CALMA='"&alm&"') ,    " & _
            " ALM = '"&ALM&"'    where id= '"&idd&"';                                           "
    response.write(cad)
   ' response.end
    Cnn.Execute(CAD)
    rs.open "select right(('000000000000' + LTRIM(RTRIM(casT(A1_NNUMENT as char(11))))),11) as nume from "&tbl2&" Where  A1_CALMA='"&alm&"'"
    nro = rs("nume")
    rs.close
else
    CNN.BEGINTRANS
    CAD =   " set dateformat dmy ;                              " & _
            " UPDATE  "&TBL1&" SET                              " & _
            " C5_CCODMOV  = '"&mov&"',                          " & _
            " C5_CNUMDOC  = '"&nro&"',                          " & _
            " C5_DFECDOC  = Convert(datetime,'"&FEC&"',103),    " & _
            " C5_CCODPRO  = '"&ruc&"',                          " & _
            " C5_CRFTDOC  = '"&dc1&"',                          " & _
            " C5_CRFTDO2  = '"&dc2&"',                          " & _
            " C5_CRFNDOC  = '"&nr1&"',                          " & _
            " C5_CRFNDO2  = '"&nr2&"',                          " & _
            " C5_CNUMORD  = '"&occ&"',                          " & _
            " C5_CCIAS    = '"&emp&"',                          " & _
            " C5_CORDEN   = '"&ofi&"',                          " & _
            " C5_CSOLI    = '"&sol&"',                          " & _
            " C5_CCENCOS  = '"&cto&"',                          " & _
            " C5_CRFALMA  = '"&al2&"',                          " & _
            " C5_CCODCLI  = '"&cli&"',                          " & _
            " C5_CtipANE  = '"&tam&"',                          " & _
            " C5_CCODANE  = '"&ane&"',                          " & _
            " C5_CGLOSA1  = '"&gl1&"',                          " & _
            " C5_CGLOSA2  = '"&gl2&"',                          " & _
            " C5_CGLOSA3  = '"&gl3&"',                          " & _
            " C5_CNOMPRO  = '"&pro&"',                          " & _
            " C5_CNOMCLI  = '"&ncl&"',                          " & _
            " C5_DFECCRE  = Convert(datetime,'"&FEC&"' ,103),   " & _
            " C5_CUSUCRE  = '"&usr&"',                          " & _
            " C5_CLOCALI  = '0001',                             " & _
            " C5_CSITUA   = 'V',                                " & _
            " C5_CCODMON  = '"&mon&"',                          " & _
            " C5_CTIPO    = '"&con&"',                          " & _
            " C5_NTIPCAM  = "&tcm&"                             " & _
            " where c5_ctd ='pe' and  c5_cnumdoc = '"&nro&"'    " & _
            " and c5_calma = '"&alm&"';                         "
 response.write(cad)
  '  response.end
    Cnn.Execute(CAD)
end if
if  err.number <> 0 then%>	
    <script language="jscript" type="text/jscript">
        alert("No se han podido actualizar los datos, reintente en unos momentos")
    </script>    
<%  Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if

%>
<script language="jscript" type="text/jscript">
   // alert(window.opener.document.all.compra.value)
    //alert(top.window.window.opener.document.all.compra.value)
    lin = parseInt(parent.window.document.all.posi.value,10)
    pe = '<%=nro%>'
    al = '<%=alm%>'
    cn = '<%=can%>'
    cd = '<%=cod%>'
    id = '<%=idd%>'
    eval("parent.window.opener.document.all.PE"+lin+".value=pe")
    eval("parent.window.opener.document.all.AL" + lin + ".value=al")
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=50,top=50,height=600,width=900";
    kad   = '../parte_deta.asp?pe='+pe+'&al='+al+'&can='+cn+'&cod='+cd + '&idd='+ id
    window.open(kad,"",opc)
  
</script>
</BODY>
</HTML>
