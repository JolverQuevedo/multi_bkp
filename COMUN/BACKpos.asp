<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<html>
<head>
</head>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>

<% 	cli	    = Request.QueryString("pos")
	pk		= trim(Request.QueryString("pk"))
	tbL		= trim(Request.QueryString("ALIAS"))
	id		= Request.QueryString("id")
	pag     = Request.QueryString("PAG")
    po      = TRIM(Request.QueryString("po"))
    ubi     = TRIM(Request.QueryString("ubi"))
    cod     = ""
    

CAD =	" SELECT top "&pag&" [id] " & _
		" from "&tbl&"			            " & _
		" where codcli = '"&cli&"'          " & _
        " and [id]<='"&id&"'  " & _
		" order by [id] desc        "
		Response.Write(cad)
		RS.Open  CAD
	IF rs.recordcount >0 THEN 
        RS.movelast
	    id = rs.fields.item(0)	
       
	END IF    
	
%>
	<script>
	    cad = '../detaACABADOS.asp?pos=' + '<%=cli%>'
        cad += '&id='  + '<%=id%>'
	    window.location.replace(cad);

	</script>
</BODY>
</HTML>
