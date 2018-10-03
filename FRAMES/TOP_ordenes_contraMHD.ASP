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
    document.all.factura.src = 'factura_oc_contraMHD.asp?doc=' + doc + '&ruc=' + ruc


    return true
}   

</script>
<link href="../multisty.css" rel="stylesheet" type="text/css">
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<%'****************************************************
oc = request.QueryString("oc")	
PRO = REQUEST.QueryString("PRO")
FAC = REQUEST.QueryString("FAC")
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
    <td width="30%" valign="top">
      <iframe  width="100%"  style="display:block; vertical-align:top;height:290px" src="" id="OC" name="OC"  scrolling="yes" onLoad="calcHeight('1');" frameborder="0" align="middle"></iframe>
    </td>
    <td width="100%" valign="top">
    <iframe  width="70%"  style="display:block; vertical-align:top;" src="" id="factura" name="factura"  onLoad="calcHeight('2');" frameborder="0" align="middle"></iframe>

    </td>
</tr>
</table>

</form>
<script language="jscript" type="text/jscript">

    cad = 'ordenes_contraMHD.asp?oc=' + '<%=TRIM(OC) %>'
    cad += '&pro=' + '<%=TRIM(PRO) %>' + '&fac=' + '<%=TRIM(FAC) %>'
    document.all.OC.src = cad
</script>

</BODY>
</HTML>
