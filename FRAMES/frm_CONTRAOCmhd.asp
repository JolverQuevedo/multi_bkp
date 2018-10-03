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
<%pro= request.QueryString("pro")
fac = request.querystring("fac")
oc = request.querystring("oc")
%>
<script language="jscript" type="text/jscript">
    function calcHeight() {
       pag = 'orden'
        //find the height of the internal page
        var the_height = document.getElementById(pag).contentWindow.document.body.scrollHeight;

        //change the height of the iframe
        document.getElementById(pag).height = the_height ;
    }


</script>
<body style="margin-top:0; margin-left:0; margin-right:0;">


<iframe  width="100%"  style="display:block; vertical-align:top" onLoad="calcHeight()" src="" id="orden" name="orden" frameborder="0" align="middle"></iframe>

<script language="jscript" type="text/jscript">
cad  = 'TOP_ordenes_contraMHD.asp?oc=' + '<%=oc%>'
cad += '&pro=' +'<%=pro%>' + '&fac=' + '<%=fac%>'
//alert(cad)
document.all.orden.src = cad


</script>
</body>
</html>
