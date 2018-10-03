<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
</head>
<body>
<html>
<%	DATO	= Request.QueryString("pos")
	pk		= Request.QueryString("pk")
	ds		= Request.QueryString("ds")	
	tbL		= trim(Request.QueryString("alias"))
	url		= Request.QueryString("url")
    largo = TRIM(Request.QueryString("l1"))
    largo2 = TRIM(Request.QueryString("l2"))
    pag     = Request.QueryString("PAG")
    cod     = ""
CAD =	" SELECT top "&pag&" "&pk&"	" & _
		" from "&tbl&"				" & _
        " where estado = 'a'        " & _
		" order by "&pk&" desc		"
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount > 0 THEN 
        rs.movelast
        cod= rs.fields.item(0)	
    end if
	
%>
<script>
	tbl = '<%=tbl %>'
	cad = trim('<%=url%>') + 'pos=' + '<%=trim(cod)%>' + '&tbl=' + '<%=trim(tbl)%>'
	cad += '&l1=' + '<%=largo%>' + '&l2=' + '<%=largo2%>'
	window.location.replace(cad);
</script>
</body>
</html>
