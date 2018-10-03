<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HEAD>
</HEAD>
<BODY >
<HTML>
PROCESANDO...

<%	
RUC = Request.QueryString("RUC")
NOM = Request.QueryString("NOM")
IF TRIM(RUC) <> "" THEN
    CAD =	"Select AC_CCODIGO, AC_CNOMBRE From RSCONCAR..CP0001MAES Where AC_CVANEXO='P' And AC_CCODIGO='"&RUC&"'" 
ELSE
    CAD =	"Select AC_CCODIGO, AC_CNOMBRE From RSCONCAR..CP0001MAES Where AC_CVANEXO='P' And AC_CNOMBRE='"&NOM&"'" 
END IF
		RS.OPEN CAD, CNN
		RESPONSE.Write(RS.RECORDCOUNT)
		if RS.RECORDCOUNT <= 0 then%>
			<script type="text/jscript" language="jscript">
			    alert("Proveedor no registrado")
			    window.parent.thisForm.NOM.value = ''
			    window.parent.thisForm.RUC.value = ''
                //window.parent.open('../help/HLPproveedor.asp?ruc='+'<%=ruc%>'+'&nom='+'<%=nom%>')
            </script>
		<%else%>
		<%RS.MoveFirst%>
            <script type="text/jscript" language="jscript">
                window.parent.thisForm.NOM.value = '<%=trim(rs("ac_cnombre"))%>';
                window.parent.thisForm.RUC.value = '<%=trim(rs("AC_CCODIGO"))%>';
			</script>	
        <%end if%>
		
</BODY>
</HTML>
