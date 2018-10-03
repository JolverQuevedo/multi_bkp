<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<link href="multisty.css" rel="stylesheet" type="text/css">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNqry.ASP"-->

<script language="jscript" type="text/jscript">
    oldrow = 1
    function calcHeight() {
        //find the height of the internal page
        var the_height =
    document.getElementById('body0').contentWindow.
      document.body.scrollHeight + 25;
        //change the height of the iframe
        document.getElementById('body0').height =
      the_height + 450;
    }




    function llamame() {
          
        if (trim(document.all.ini.value) == '') {
            alert("Favor Indicar Fecha de Inicio")
            return true;
        }
        if (trim(document.all.fin.value) == '') {
            alert("Favor Indicar Fecha de Fin")
            return true;
        }
        //   alert(dd)
        cad = 'detaasistencia.asp?ini=' + trim(thisForm.ini.value) + '&fin=' + trim(thisForm.fin.value) 
      //  alert(cad)
       document.all.body0.src=cad
    } 
</script>

<title></title>
<link href="reportes/CalendarControl.css" rel="stylesheet" type="text/css">
<script src="reportes/CalendarControl.js" language="javascript"></script>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
 
<form name="thisForm" id="thisForm" METHOD="post" ><HTML>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body style="margin-top:0; margin-left:0; margin-right:0;" >
<center>
<div class="Estilo2">Reporte de Asistencia OBREROS - Modelador</div>
</center>
<table id="TABLA" align="center" width="100%"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="0" >  
  <tr>
    
    <td class="Estilo11" >Fec_Ini:</td>
    <td><input name="ini" id="ini" onFocus="showCalendarControl(this);" type="text" readonly></td>
    <td class="Estilo11" >Fec_Fin:</td>
    <td><input name="fin" id="fin" onFocus="showCalendarControl(this);" type="text" readonly></td>
    <td ><input type="button" value="Genera" onClick="llamame()"></td>

</tr>
</table>

<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="0" height="100" 
align="middle" onload="calcHeight()" ></iframe>
</form>
</body>
</html>

