<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MULTI-Tasks</title>
</head>
<script language="jscript" type="text/jscript">
    function opciones(prg) {
        window.location.replace(prg)
    }
</script>

<body style="background-image:url(../IMAGES/fondo.png;); margin-top:10px"  >
   <table align="center" border="0" cellpaddding="10" cellspacing="20">
    <tr>
        <td height="100px">&nbsp;</td>
    </tr>
     <tr align="center">
        <td style="cursor:pointer; background-image:url(images/horizontal_d_orange_classic_bg.jpg);  font-family:Arial, Helvetica, sans-serif; color:#fff; 
            padding-top:10px; padding-bottom:10px; padding-left:10px; padding-right:10px; font-weight:700" onclick=" window.location.replace('reportes/filtros_movimientos.asp')">Opciones Multiples</td>
    </tr>
     <tr align="center">
        <td style="cursor:pointer; background-image:url(images/horizontal_d_orange_classic_bg.jpg);  font-family:Arial, Helvetica, sans-serif; color:#fff; 
            padding-top:10px; padding-bottom:10px; padding-left:10px; padding-right:10px; font-weight:700" onclick=" window.location.replace('reportes/filtros_acumula.asp')">Resumen Acumulados</td>
    </tr>

   </table>


</body>
</html>
