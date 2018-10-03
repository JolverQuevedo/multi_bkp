<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
</head>
<body>
<html>
<%	cli 	= Request.QueryString("pos")
	tbL		= trim(Request.QueryString("alias"))
    tem      = TRIM(Request.QueryString("tem"))
    pag     = Request.QueryString("PAG")
    cod     = ""
CAD =	" SELECT top "&pag&" [id]	" & _
		" from "&tbl&"				" & _
        " where codcli = '"&cli&"'  " & _
        " and tempo = '"&tem&"'     " & _
		" order by [id]   desc		"
		Response.Write(cad)
      '  response.end
		RS.Open  CAD
	IF rs.recordcount > 0 THEN 
	    RS.movelast
	         id = rs.fields.item(0)	
	END IF  
%>
<script>
    cad = '../detaACAtemp.asp?pos=' + '<%=cli%>'
    cad += '&tem=' + '<%=tem%>'
    cad += '&id=' + '<%=id%>'
    window.location.replace(cad);
</script>
</body>
</html>
