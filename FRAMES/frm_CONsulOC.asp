<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<link href="multisty.css" rel="stylesheet" type="text/css">
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<%
oc = request.querystring("oc")
pro= request.QueryString("pro")
ini = request.querystring("ini")
fin = request.querystring("fin")
edo = request.querystring("edo")
ruc = request.querystring("ruc")
cart = request.querystring("cart")
%>
<script language="jscript" type="text/jscript">
    function calcHeight() {
       pag = 'orden'
        //find the height of the internal page
        var the_height = document.getElementById(pag).contentWindow.document.body.scrollHeight;

        //change the height of the iframe
        document.getElementById(pag).height = the_height + 50;
    }


</script>
<body style="margin-top:0; margin-left:0; margin-right:0;">


<iframe  width="100%"  style="display:block; vertical-align:top" onLoad="calcHeight()" src="" id="orden" name="orden"  scrolling="yes" frameborder="0" height="150" align="middle"></iframe>

<script language="jscript" type="text/jscript">
cad  = 'TOP_ordenes_consul.asp'
cad += '?oc=' + '<%=oc%>'
cad += '&pro=' + '<%=pro%>'
cad += '&ini=' + '<%=ini%>'
cad += '&fin=' + '<%=fin%>'
cad += '&edo=' + '<%=edo%>'
cad += '&ruc=' + '<%=ruc%>'
cad += '&cart=' + '<%=cart%>'
//alert(cad)
document.all.orden.src = cad


</script>
</body>
</html>
