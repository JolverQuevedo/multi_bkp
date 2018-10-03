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
<SCRIPT language="javascript" src="includes/cal.js"></SCRIPT>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<script language="jscript" type="text/jscript">
    function busca() {
       // cabe = "transferencias.asp?op=1"
        // window.location.replace(cabe)

    }
    </script>
<body style="margin-top:0; margin-left:0; margin-right:0;">
<form id="thisForm" method="post" name="thisForm" action="consuloc.asp">
<table align="center"  bordercolor="#FFFFFF"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
	<tr><td align="left" class="Estilo4">Criterios de Busqueda</td></tr>
</table>

<table  border="0" cellspacing="2" cellpadding="1" align="center" >
    <tr><td colspan="8" height="2 px"></td>  </tr>
  <tr>
      <td align="left" class="Estilo8" > &nbsp; &nbsp; &nbsp;# Orden de Compra :</td>
      <td><input type="text" class="INPUTS" id="oc" name="oc" style="text-align:center; width:150px;" value=""/></td>
     <td align="right" class="Estilo8" > Estado :&nbsp;</td>
        <td colspan="3">
        <%cad = "SELECT TG_CDESCRI as descri, rtrim(ltrim(TG_CCLAVE)) as cod FROM RSFACCAR..AL0001TABL Where TG_CCOD='31' Order by 1" 
        rs.open cad,cnn 
        %>
             <select  class="INPUTS" id="edo" name="edo"  value="" style="text-align:center;width:80px">
              <option value="">- TODOS - </option>
            <%if rs.recordcount > 0 then %>
                <%rs.movefirst%>
                <%do while not rs.eof%>
                     <option value="<%=rs("cod")%>"><%=rs("descri") %></option>
                    <%RS.MOVENEXT%>
                <%loop%>
                <%end if%>
                <%rs.close%>
                        </select> 
               
            </select> 
        </td>
      <td  align="right" class="Estilo8">Fecha :
   
        <td align="right" class="Estilo8" > Ini :&nbsp;</td>
        <td  id="fini" name ="fini"><A href="javascript:showCal('Calendar1')"><img height=16 src="images/cal.gif" width=16 border=0></A></td>
        <td><input type="text" class="INPUTS" id="ini" name="ini" style="text-align:center; width:50px" readonly tabindex="-1"  value="" /></td>
        <td align="left" class="Estilo8"> Fin : &nbsp; </td>
        <td  id="ffin" name="ffin"  ><A href="javascript:showCal('Calendar2')"><img height=16 src="images/cal.gif" width=16 border=0></A></td>
        <td ><input type="text" class="INPUTS" id="fin" name="fin" style="text-align:center; width:50px"   value=""/></td>
          <td align="center" rowspan="2"><img src="IMAGES/go1.png" border="0" onclick="MANDA('0')" onmouseover="this.src='images/go2.png'" id="pima" name="pima"
      onmouseout="this.src='images/go1.png'" style="cursor:pointer"/></td>
     
  </tr>
  <tr>
   <td align="left" class="Estilo8"> &nbsp; &nbsp; &nbsp;Proveedor :</td>
      <td ><input type="text" class="INPUTS" id="ruc" name="ruc" style="text-align:center;" value=""/></td>
      <td align="center"><img src="IMAGES/lupa.png" border="0" onclick="buscapr()" id="ima" name="ima" style="cursor:pointer"/></td>
      <td colspan="10"><input type="text" class="INPUTS" id="pr" name="pr" style="text-align:center" value=""/></td>
    </tr>
  <tr>
      <td align="left" class="Estilo8" > &nbsp; &nbsp; &nbsp;Art&iacute;culo :</td>
      <td colspan="1"><input type="text" class="INPUTS" id="cart" name="cart" style="text-align:center" value="" /></td>
      <td align="center"><img src="IMAGES/lupa.png" border="0" onclick="hlpART()" id="ima" name="ima" style="cursor:pointer"/></td>
      <td colspan="10"><input type="text" class="INPUTS" id="dart" name="dart" style="text-align:center" value=""/></td>
  </tr>
</table>
<table align="center" width="100%" style="display:none">
<tr>
<td><input id="compra" name="compra" /></td>
<td><input id="artic" name="artic" /></td>
<td><input id="pentr" name="pentr" /></td>
<td><input id="rucid" name="rucid" /></td>
<td><input id="factu" name="factu" /></td>
<td><input id="fecdoc" name="fecdoc" /></td>
<td><input id="nombre" name="nombre" /></td>
<td><input id="montoc" name="montoc" /></td>
<td><input id="moneda" name="moneda" /></td>
<td><input id="numfacs" name="numfacs" /></td>
<td><input id="almacen" name="almacen" /></td>
<td><input id="tipoes" name="tipoes" /></td>
</tr>
</table>
<table align="center"  bordercolor="#FFFFFF"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
	<tr><td align="left" class="Estilo4" width="83%">Orden de Compra</td>
    <td align="left" class="Estilo4">Reportes :</td>
    <td width="15%"  class="Estilo4"><select id="rep" name="rep" class="inputs" style="width:100%">
    <option value="1">Listado de O/C</option>
    <option value="2">Movimientos O/C</option>
    </select></td>
    <td align="center" width="2%"><img src="IMAGES/xl1.png" border="0" onclick="MANDA()" id="xll" name="xll" onmouseover="this.src='images/xl2.png'" onmouseout="this.src='images/xl1.png'"
    style="cursor:pointer"/></td>
    </tr>
</table>
<iframe  width="100%"  style="display:block;vertical-align:top;" src="" id="orden" name="orden"  scrolling="yes" frameborder="1" height="150" align="middle"></iframe>
<iframe  width="100%"  style="display:block;vertical-align:top;" src="" id="deta" name="deta"  scrolling="yes" frameborder="1" height="100" align="middle"></iframe>
<table align="center"  bordercolor="#FFFFFF"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
	<tr><td align="left" class="Estilo4">Partes de Entrada/Salida x O/C</td>
   
    </tr>
</table>
<iframe  width="100%"  style="display:block" src="" id="partes" name="partes"  scrolling="yes" frameborder="1" height="100" align="middle"></iframe>
</form>
<script language="jscript" type="text/jscript">

    addCalendar("Calendar1", "Elija una fecha", "ini", "thisForm")
    addCalendar("Calendar2", "Elija una fecha", "fin", "thisForm")
function buscapr() {

    window.open('HELP/busca_prov_oc.ASP?NOM=' + ltrim(document.all.pr.value)  + '&ruc=' + trim(document.all.ruc.value)) 
    return true;
}

function MANDA(opc) {
/*
    if (trim(document.all.ruc.value) == '') {
        alert("Por favor se necesita RUC válido")
        return false;
    }
*/
    buss = ltrim(rtrim(document.all.ini.value)) + ltrim(rtrim(document.all.fin.value))
    buss += ltrim(rtrim(document.all.edo.value)) + ltrim(rtrim(document.all.oc.value))
    buss += ltrim(rtrim(document.all.pr.value)) + ltrim(rtrim(document.all.ruc.value))
    buss += ltrim(rtrim(document.all.cart.value)) + ltrim(rtrim(document.all.dart.value))
    ini =''
    fin = ''
    if (trim(buss) == '') {
        ini = '<%=year(date())+month(date())+day(date()) %>'
        fin = '<%=year(date())+month(date())+day(date()) %>'
        document.all.ini.value = '<%=FORMATDATETIME(DATE(),2) %>'
        document.all.fin.value = '<%=FORMATDATETIME(DATE(),2) %>'
        MANDA()
    }
    else {
        if (ltrim(rtrim(document.all.ini.value)) != '') {
            pini = trim(document.all.ini.value)
            ini = (pini.substring(6) + pini.substr(3, 2) + pini.substr(0, 2))
            if (ltrim(rtrim(document.all.fin.value)) == '')
                fin = '<%=year(date())+month(date())+day(date()) %>'
        }
        if (ltrim(rtrim(document.all.fin.value)) != '') {
            pini = trim(document.all.fin.value)
            fin = (pini.substring(6) + pini.substr(3, 2) + pini.substr(0, 2))
            if (ltrim(rtrim(document.all.ini.value)) == '')
                ini = fin
        }
    }
    cad = ''
    if (opc == "0")
        mad = 'FRAMES/frm_CONsulOC.asp'
    
    cad += '?oc=' + trim(document.all.oc.value)
    cad += '&pro=' + trim(document.all.ruc.value) 
    cad += '&ini=' + ini
    cad += '&fin=' + fin 
    cad += '&edo=' + trim(document.all.edo.value)
    cad += '&ruc=' + trim(document.all.ruc.value)
    cad += '&cart=' + trim(document.all.cart.value)
    //alert(cad)
    if (opc == "0"  )
        document.all.orden.src = mad + cad
    else
        XLL(cad)
}

function XLL(cad) {

if (document.all.rep.value=='1')
    {cad = 'reportes/prn_ordenes_consul.asp' + cad
    }
else {
    cad = 'reportes/prn_movimientos_oc.asp' + cad
    //alert(str)
    }
window.open (cad)
}


function hlpART() {

    window.open('HELP/busca_ARTICULOS.ASP?NOM=' + ltrim(document.all.dart.value) + '&cod=' + trim(document.all.cart.value)) 
    return true;
}



</script>
</body>
</html>
