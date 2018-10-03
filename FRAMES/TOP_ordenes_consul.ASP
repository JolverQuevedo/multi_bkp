<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<script type="text/jscript" language="jscript">
    oldrow = 1
function llena(t, pos) {
    ruc = ltrim(t.rows(pos).cells(2).innerText);
    doc = ltrim(t.rows(pos).cells(0).innerText);
    document.all.factura.src = 'factura_oc_contra.asp?doc=' + doc + '&ruc=' + ruc


    return true
}   

</script>
<link href="../multisty.css" rel="stylesheet" type="text/css">
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<%'****************************************************
oc = request.querystring("oc")
pro= request.QueryString("pro")
ini = request.querystring("ini")
fin = request.querystring("fin")
edo = request.querystring("edo")
ruc = request.querystring("ruc")
cart = request.querystring("cart")
%>
<script language="jscript" type="text/jscript">
    function calcHeight(op) {
        if (op == '1')
            pag = 'OC'
        else 
            pag= 'factura'
        //find the height of the internal page
        var the_height = document.getElementById(pag).contentWindow.document.body.scrollHeight;

        //change the height of the iframe
        document.getElementById(pag).height = the_height ;
    }


</script>

<form name="thisForm" METHOD="post" ><HTML>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body style="margin-top:0; margin-left:0; margin-right:0;">
<%'*********************************************************************%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
    <td width="100%" valign="top">
      <iframe  width="100%"  style="display:block; vertical-align:top;" src="" id="OC" name="OC"  scrolling="yes" frameborder="1" height="200px" align="middle"></iframe>
    </td>
    
</tr>
</table>

</form>
<script language="jscript" type="text/jscript">

    cad  = 'ordenes_consul.asp'
    cad += '?oc=' + '<%=oc%>'
    cad += '&pro=' + '<%=pro%>'
    cad += '&ini=' + '<%=ini%>'
    cad += '&fin=' + '<%=fin%>'
    cad += '&edo=' + '<%=edo%>'
    cad += '&ruc=' + '<%=ruc%>'
    cad += '&cart=' + '<%=cart%>'
    document.all.OC.src = cad
</script>

</BODY>
</HTML>
