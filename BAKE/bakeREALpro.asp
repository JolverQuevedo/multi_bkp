<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>
<link href="multisty.css" rel="stylesheet" type="text/css">
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HEAD>
</HEAD>
<BODY >
<HTML>
PROCESANDO...

<%	
pos = Request.QueryString("pos")
tbl = "RSCONCAR..CP"+cia+"MAES"
CAD =	"Select * From "&tbl&" Where AC_CVANEXO='P' And AC_CCODIGO='"&pos&"'" 
		RS.OPEN CAD, CNN
		RESPONSE.Write(RS.RECORDCOUNT)
		if RS.RECORDCOUNT <= 0 then%>
			<script type="text/jscript" language="jscript">
			    alert("Proveedor no registrado")
			    window.parent.thisForm.PRO.value = ''
			    window.parent.thisForm.RUC.value = ''
			    window.parent.thisForm.NOM.value = ''
			    window.parent.thisForm.FAX.value = ''
			    window.parent.thisForm.DPRO.value = ''

            </script>
		<%else%>
		<%RS.MoveFirst%>
            <script type="text/jscript" language="jscript">
                window.parent.thisForm.PRO.value = '<%=trim(rs("ac_cCODIGO"))%>';
                window.parent.thisForm.RUC.value = '<%=trim(rs("ac_cRUC"))%>'
                window.parent.thisForm.NOM.value = '<%=trim(rs("ac_cNOMBRE"))%>'
                window.parent.thisForm.FAX.value = '<%=trim(rs("ac_cFAXACR"))%>'
                window.parent.thisForm.DPRO.value = '<%=trim(rs("ac_cDIRECC"))%>'
			</script>	
        <%end if%>
		
</BODY>
</HTML>
