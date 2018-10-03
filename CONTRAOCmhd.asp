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
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<script language="jscript" type="text/jscript">
    function busca() {
       // cabe = "transferencias.asp?op=1"
        // window.location.replace(cabe)

    }
	function calcHeight(frm) {
        //find the height of the internal page
        var the_height = document.getElementById(frm).contentWindow.document.body.scrollHeight;
        document.getElementById(frm).height = the_height  + "px";
    }
    </script>
<body style="margin-top:0; margin-left:0; margin-right:0;">
<table align="center"  bordercolor="#FFFFFF"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
	<tr><td align="left" class="Estilo4">Criterios de Busqueda</td></tr>
</table>

<table  border="0" cellspacing="2" cellpadding="1" align="center" >
    <tr><td colspan="8" height="2 px"></td>  </tr>
  <tr>
      <td align="left" class="Estilo8" > &nbsp; &nbsp; &nbsp;# Orden de Compra :</td>
      <td><input type="text" class="inputs" id="oc" name="oc" style="text-align:center" value=""/></td>
      <td align="left" class="Estilo8"> &nbsp; &nbsp; &nbsp;Proveedor :</td>
      <td colspan="2"><input type="text" class="INPUTS" id="pr" name="pr" style="text-align:center; width:450px" value=""/></td>
      <td><img src="IMAGES/lupa.png" border="0" onclick="buscapr()" id="ima" name="ima" style="cursor:pointer"/></td>
      <td><input type="text" class="inputs" id="ruc" name="ruc" style="text-align:center" value=""/></td>
      <td align="center" rowspan="2"><img src="IMAGES/go1.png" border="0" onclick="MANDA()" onmouseover="this.src='images/go2.png'" id="pima" name="pima"
      onmouseout="this.src='images/go1.png'" style="cursor:pointer"/></td>
  </tr>
  <tr><td colspan="2"></td>
      <td align="left" class="Estilo8" > &nbsp; &nbsp; &nbsp;Factura :</td>
      <td colspan="1"><input type="text" class="INPUTS" id="fac" name="fac" style="text-align:center" value="" width="200px"/></td>
      <td colspan="3"></td>
  </tr>
</table>
<table align="center" width="100%">
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
	<tr><td align="left" class="Estilo4" width="83%">Facturas de la Orden de Compra</td>
    <td align="left" class="Estilo4">Reportes :</td>
    <td width="15%"  class="Estilo4"><select id="rep" name="rep" class="inputs" style="width:100%">
    <option value="1">Listado de O/C</option>
    <option value="2">Movimientos O/C</option>
    </select></td>
    <td align="center" width="2%"><img src="IMAGES/xl1.png" border="0" onclick="XLL()" id="xll" name="xll" onmouseover="this.src='images/xl2.png'" onmouseout="this.src='images/xl1.png'"
    style="cursor:pointer"/></td>
    </tr>
</table>
<iframe  width="100%"  style="display:block;vertical-align:top; height:300px;" src="" id="orden" name="orden" onload="calcHeight('orden')"  frameborder="1"  align="middle"></iframe>
<iframe  width="100%"  style="display:none;vertical-align:top; height:0px;" src="" id="deta" name="deta"  scrolling="yes" frameborder="1" height="1px" align="middle"></iframe>
<table align="center"  bordercolor="#FFFFFF"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
	<tr><td align="left" class="Estilo4">Partes de Entrada/Salida x O/C</td>
    <td align="center" width="2%"><input type="button" value="Asignar Factura" onclick="asigna()" style="cursor:pointer"/></td>
    </tr>
</table>
<iframe  width="100%"  style="display:block; vertical-align:top; height:300px" src="" id="partes" name="partes" onload="calcHeight('partes')" scrolling="yes" frameborder="1" align="middle"></iframe>

<script language="jscript" type="text/jscript">

function buscapr() {

    window.open('HELP/busca_prov_oc.ASP?NOM=' + ltrim(document.all.pr.value))
    return true;
}

function MANDA() {
/*
    if (trim(document.all.ruc.value) == '') {
        alert("Por favor se necesita RUC válido")
        return false;
    }
*/
    cad = 'FRAMES/frm_CONTRAOCMHD.asp?oc=' + trim(document.all.oc.value)
    cad += '&pro=' + trim(document.all.ruc.value) + '&fac=' + trim(document.all.fac.value)
    document.all.orden.src = cad


}

function XLL() {

if (document.all.rep.value=='1')
    {cad = 'reportes/listado_oc.asp?oc=' + trim(document.all.compra.value)
    cad += '&pro=' + trim(document.all.ruc.value) + '&fac=' + trim(document.all.fac.value)
    }
else {
    cad = 'reportes/movimientos_oc.asp?oc=' + strzero(trim(document.all.compra.value),10)
    cad += '&pro=' + trim(document.all.rucid.value) + '&fac=' + trim(document.all.fac.value)
    cad += '&nom=' + ltrim(document.all.nombre.value)
    cad += '&fec=' + Left(trim(document.all.fecdoc.value),10)
    cad += '&mon=' + trim(document.all.moneda.value)  
    str = document.all.montoc.value
 cad += '&usd=' + str
  //  alert(cad)
    }
window.open (cad)
}
function asigna() {
    var opc = "directories=no,";
    opc = opc + "hotkeys=no,location=no,";
    opc = opc + "menubar=no,resizable=yes, height=150,width=150,";
    opc = opc + "left=500,top=400,scrollbars=no,";
    opc = opc + "status=no,titlebar=no,toolbar=no";

    if (trim(document.all.numfacs.value) == '') {
        alert("Primero seleccionamos una Orden")
        return false;
    }
    
    cad = 'help/hlp_asigna_fact_ocMHD.asp?oc=' + strzero(trim(document.all.compra.value), 10)
    cad += '&pro=' + trim(document.all.rucid.value)
    //alert(cad)
    window.open (cad,"FACTURAS", opc)
    return true;
}


</script>
</body>
</html>
