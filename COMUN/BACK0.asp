<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html>
<head>
</head>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>

<% 	DATO	= Request.QueryString("pos")
	pk		= Request.QueryString("pk")
	ds		= Request.QueryString("ds")	
	tbL		= trim(Request.QueryString("ALIAS"))
	url		= Request.QueryString("url")
	pag     = Request.QueryString("PAG")
    largo   = TRIM(Request.QueryString("l1"))
    largo2  = TRIM(Request.QueryString("l2"))
    cod     = ""
CAD =	" SELECT top "&pag&" "&pk&"		" & _
		" from "&tbl&"			        " & _
		" where "&pk&" <= '"&dato&"'    " & _
        " AND ESTADO ='A'               " & _
		" order by "&pk&" 	DESC        "
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount >0 THEN 
        RS.movelast
	    COD = rs.fields.item(0)	
	END IF    
	
%>
	<script>
	    tbl = '<%=tbl %>'
	    cad = trim('<%=url%>') + '<%=trim(cod)%>' + '&tbl=' + '<%=trim(tbl)%>'
	    cad += '&l1=' + '<%=largo%>' + '&l2=' + '<%=largo2%>'

	    window.location.replace(cad);

	</script>
</BODY>
</HTML>
