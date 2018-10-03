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
tip = ucase(TRIM(Request.QueryString("tip")))
doc = ucase(TRIM(Request.QueryString("Doc")))
num = ucase(TRIM(Request.QueryString("num")))

tbl = "RS_ALMOVC" + cia

CAD =   " EXEC ASIGNA_FACTURA '"&alm&"', '"&tip&"', '"&doc&"', 'FT', '"&num&"', '"&usr&"', '"&tbl&"' "

Cnn.Execute(CAD)
%>

<script language="jscript" type="text/jscript">
   // alert(window.parent.window.opener.document.all.compra.value)
    //alert(top.window.window.opener.document.all.compra.value)

    kag = 'frames/partes_deta_oc_contra.asp?doc=' + trim(window.parent.window.opener.document.all.compra.value)
    window.parent.window.opener.document.all.partes.src = kag

    tap = 'frames/frm_contraoc.asp?oc=' + trim(window.parent.window.opener.document.all.compra.value) + '&pro=' + trim(window.parent.window.opener.document.all.rucid.value)
 
    window.parent.window.opener.document.all.orden.src = tap
    window.close()
</script>
</BODY>
</HTML>
