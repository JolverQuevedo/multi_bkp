<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<%
COD = TRIM(Request.QueryString("COD"))
    
	
			CAD =	 " delete FROM menu " & _
			" WHERE  menu = '"&COD&"' "
Response.Write (CAD)

Cnn.Execute(CAD)
    Cnn.close


%>
<script language="javascript" type="text/jscript">
    alert("Se elimino correctamente");
    window.parent.recargar();
</script>