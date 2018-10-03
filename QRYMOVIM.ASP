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
    <style type="text/css">
        .style1
        {
            width: 116px;
        }
    </style>
</head>
<link href="multisty.css" rel="stylesheet" type="text/css">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNqry.ASP"-->
<SCRIPT language="javascript" src="includes/cal.js"></SCRIPT>
<body >
<form id ="thisForm" name= "thisForm" >
<table  border="0" cellspacing="6" cellpadding="0" align="center" >
  <tr>
  <td colspan="5" align="left" class="Estilo4">Seleccione la Fecha  </td>
  </tr>
  <tr><td colspan="4">&nbsp;</td>
   <td  align="center" rowspan="3"><img src="IMAGES/go1.png" border="0" onclick="MUESTRA()" onmouseover="this.src='images/go2.png'" id="ima" name="ima"
  onmouseout="this.src='images/go1.png'" style="cursor:pointer"/></td>
  </tr>
  <tr>
  <td align="left" class="LOG_LABEL" width="100px"> &nbsp; &nbsp; &nbsp;Fecha </td>
    <td width="60px" ><A href="javascript:showCal('Calendar2')"><img height=16 src="images/cal.gif" width=16 border=0></A>
    </td>
    <td class="style1"><INPUT ID=final NAME=final readonly value="" tabindex="-1" width=70>
    </td>   
   </tr>
   <tr><td>&nbsp;</td></tr>
</table>
</form>
<script type="text/jscript" language="jscript">
    addCalendar("Calendar2", "Elija una fecha", "final", "thisForm")


function MUESTRA() {
    cad = 'reportes/movim_dia.asp?fec=' + document.all.final.value
    //alert(cad)
    
    window.open(cad)
}

</script>
</script>
</body>
</html>
