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
ano = ucase(TRIM(Request.QueryString("anio")))
doc = ucase(TRIM(Request.QueryString("Doc")))
ctd = ucase(TRIM(Request.QueryString("ctd")))
alm = ucase(TRIM(Request.QueryString("alm")))
TBL1 = "RSFACCAR..AL"+CIA+"MOVC" 
TBL2 = "RSFACCAR..AL"+CIA+"MOVD" 

TBL3 = "MULTI..RS_ALMOVD_TALLA"+CIA
TBL4 = "MULTI..RS_ALMOVD"+CIA
TBL5 = "MULTI..RS_ALMOVC"+CIA 
TBL6 = "RSFACCAR..AL"+CIA+"STOC"

CAD =   " UPDATE "&TBL6&" set SK_NSKDIS=SK_NSKDIS-x.can FROM (SELECT C6_CALMA as alm,C6_CCODIGO as cod,SUM(C6_NCANTID) as can FROM RSFACCAR..AL0001STOC AS A INNER JOIN RSFACCAR..AL0001MOVd AS B ON A.SK_CALMA=B.C6_CALMA AND A.SK_CCODIGO=B.C6_CCODIGO WHERE B.C6_CNUMDOC='"&doc&"' and B.C6_CALMA ='"&ALM&"' and B.C6_ctd='"&CTD&"' GROUP BY C6_CALMA,C6_CCODIGO) as X where SK_CALMA=X.alm and SK_CCODIGO=X.cod;" & _
		" DELETE "&tbl2&" WHERE C6_CALMA='"&ALM&"' AND C6_CTD='"&CTD&"' AND C6_CNUMDOC='"&DOC&"';   " & _
        " DELETE "&TBL1&" WHERE C5_CALMA='"&ALM&"' AND C5_CTD='"&CTD&"' AND C5_CNUMDOC='"&DOC&"';    " & _
		" DELETE "&TBL3&" WHERE CALMA='"&ALM&"' AND CTD='"&CTD&"' AND CNUMDOC='"&DOC&"';    " & _
		" DELETE "&TBL4&" WHERE CALMA='"&ALM&"' AND CTD='"&CTD&"' AND CNUMDOC='"&DOC&"';    " & _
		" DELETE "&TBL5&" WHERE C5_CALMA='"&ALM&"' AND C5_CTD='"&CTD&"' AND C5_CNUMDOC='"&DOC&"';    "
		
response.write(cad)
Cnn.Execute(CAD)

%>
<script language="jscript" type="text/jscript">
    cad = '../eliminaparte.asp?op=1&doc=' + '<%=DOC%>'
    cad += '&anio=' + '<%=ANO%>'
    window.parent.window.location.replace(cad)
</script>
</BODY>
</HTML>
