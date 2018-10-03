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
DOC = ucase(TRIM(Request.QueryString("DOC")))
CTD = ucase(TRIM(Request.QueryString("CTD")))

TBL1 = "RSFACCAR..AL"+CIA+"MOVC" 
TBL2 = "RSFACCAR..AL"+CIA+"MOVD" 
TBL3 = "RSFACCAR..AL"+CIA+"ASER"
TBL4 = "RS_ALMOVD" + cia
TBL5 = "RS_ALMOVC_Del" + cia
TBL6 = "RS_ALASER_Del" + cia
TBL7 = "RS_ALMOVd_Del" + cia
CAD = ""
CAD = CAD + " INSERT INTO "&tbl5&" select *,'"&USR&"' as Usu,GETDATE() as fecha from "&tbl1&"      " & _
            " Where C5_CALMA='"&ALM&"' AND C5_CTD='"&CTD&"' AND C5_CNUMDOC='"&doc&"';   " & _
            " INSERT INTO "&tbl7&" select *,'"&usr&"' as Usu, GETDATE() as fecha        " & _
            " from "&tbl2&" Where C6_CALMA='"&alm&"' AND C6_CTD='"&ctd&"' AND           " & _
            " C6_CNUMDOC='"&doc&"' ;                                                    " & _
            " INSERT INTO "&tbl6&" select *, '"&USU&"' as Usu, GETDATE() as fecha       " & _
            " from "&tbl3&" Where C6_CALMA='"&ALM&"' AND C6_CTD='"&CTD&"'               " & _
            " AND C6_CNUMDOC='"&DOC&"' ;                                                " & _
            " delete "&tbl3&" Where C6_CALMA='"&ALM&"' AND C6_CTD='"&CTD&"'             " & _
            " AND C6_CNUMDOC='"&DOC&"' ;                                                " & _
            " Delete "&tbl2&" Where C6_CALMA='"&ALM&"' AND C6_CTD='"&CTD&"'             " & _
            " AND C6_CNUMDOC='"&DOC&"' ;                                                " & _
            " Delete "&tbl1&" Where C5_CALMA='"&ALM&"' AND C5_CTD='"&CTD&"'             " & _
            " AND C5_CNUMDOC='"&doc&"';                                                 " & _
            " Delete "&tbl4&" Where CALMA='"&ALM&"' AND  CTD='"&CTD&"'                  " & _
            " AND CNUMDOC='"&DOC&"' ;                                                   "
CNN.BEGINTRANS
response.write(cad)
'RESPONSE.END
CNN.EXECUTE CAD

if  err.number <> 0 then%>
	
<script language="jscript" type="text/jscript">
    alert("No se han podido actualizar los datos, reintente en unos momentos")
</script>    
    
    Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	<%Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if

%>

<script language="jscript" type="text/jscript">
    alert("Datos Actualizados!")
    window.parent.document.all.gui.value = '<%=doc%>'
    window.parent.window.cargadatos()

 
</script>
</BODY>
</HTML>
