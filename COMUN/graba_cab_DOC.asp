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

<%
alm = ucase(TRIM(Request.QueryString("alm")))
ctd = ucase(TRIM(Request.QueryString("ctd")))
doc = ucase(TRIM(Request.QueryString("Doc")))
ruc = ucase(TRIM(Request.QueryString("ruc")))
pro = ucase(TRIM(Request.QueryString("pro")))
fec = ucase(TRIM(Request.QueryString("fec")))
fin = ucase(TRIM(Request.QueryString("fin")))
dir = ""

TBL1 = "RSFACCAR..AL"+CIA+"MOVc" 
TBL2 = "RSFACCAR..AL"+CIA+"MOVD" 
TBL3 = "RSCONCAR..CP"+CIA+"MAES" 

'response.end
cad =   " Select AC_CDIRECC, AC_CNOMBRE From "&tbl3&" WHERE AC_CVANEXO='P'  " & _
        " AND AC_CESTADO='V' AND AC_CCODIGO='"&ruc&"'           "
rs.open cad, cnn
if rs.recordcount > 0  then
    rs.movefirst
    dir = rs("AC_CDIRECC")
    pro = rs("AC_CNOMBRE")
end if

cad =   " SET DATEFORMAT DMY;       " & _
        " UPDATE "&tbl1&"  SET      " & _
        " C5_DFECDOC= Convert(datetime,'"&FEC&"',103),     " & _
        " C5_CCODPRO='"&ruc&"',     " & _
        " C5_CNOMPRO='"&pro&"',     " & _
        " C5_CDIRENV='"&DIR&"',      " & _
        " C5_DFECEMB = Convert(datetime,'"&fin&"',103)     " & _
        " WHERE C5_CALMA='"&ALM&"'  " & _
        " AND C5_CTD='"&CTD&"'      " & _
        " AND C5_CNUMDOC='"&doc&"'; " & _
        " UPDATE "&tbl2&" SET       " & _
        " C6_DFECDOC= Convert(datetime,'"&FEC&"',103)       " & _
        " WHERE C6_CALMA='"&ALM&"'  " & _
        " AND C6_CTD='"&CTD&"'      " & _
        " AND C6_CNUMDOC='"&DOC&"'  "

'response.write(cad)
'response.end
Cnn.Execute(CAD)
%>

<script language="jscript" type="text/jscript">
    alert("Datos Actualizados!")
    window.opener.window.cargadatos()
    window.close()
 
</script>
</BODY>
</HTML>
