<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="multisty.css" rel="stylesheet" type="text/css">

<title>Ediciones</title>
</head>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<SCRIPT language="javascript" src="includes/cal.js"></SCRIPT>
<script language="jscript" type="text/jscript">
    function busca() {
       // cabe = "transferencias.asp?op=1"
        // window.location.replace(cabe)
    
    }

    function calcHeight() {
        pag = 'ingresos'
        //find the height of the internal page
        var the_height = document.getElementById(pag).contentWindow.document.body.scrollHeight;

        //change the height of the iframe
        document.getElementById(pag).height = 450;
    }


    </script>
<body style="margin-top:0; margin-left:0; margin-right:0;" onload="document.all.ser.focus(); SELE();document.all.alm.focus()">
<form id="thisForm" method="post" name="thisForm" action="ediciones.asp">

<table align="center"  bordercolor="#FFFFFF"  cellpadding="0"  cellspacing="0"  border="1" width="100%">
	<tr><td align="left" class="Estilo4">Criterios de Busqueda</td></tr>
</table>

<table  border="0" cellspacing="0" cellpadding="0" align="center" width="100%" style="background-color:#A3B87A" >
    <tr valign="middle">
        <td align="right" class="Estilo8" > Almacen :&nbsp;</td>
        <td colspan="6">
<%  TBL1 = "RSFACCAR..AL" + CIA + "ALMA"
    TBL2 = "MULTI..RS_USUALM" + CIA 
cad =   " select a1_calma, a1_calma+space(5)+a1_cdescri as descri from "&tbl1&"  A " & _
        " INNER JOIN "&TBL2&" B ON (A1_CALMA COLLATE Modern_Spanish_CI_AS =CALMA) AND B.CUSUARIO='"&usr&"' order by 1 " 
        'response.write(cad)
rs.open cad,cnn                %>
            <select  class="INPUTS" id="alm" name="alm" onchange="SELE()" value="" style="text-align:center;width:100%">
                <%if rs.recordcount > 0 then %>
                <%rs.movefirst%>
                <%do while not rs.eof%>
                    <option value='<%=rs("a1_calma")%>'><%=rs("descri")%></option>
                    <%RS.MOVENEXT%>
                <%loop%>
                <%end if%>
                <%rs.close%>
            </select> 
        </td>
        <td width="193" align="right" class="Estilo8">Fecha :
          <input type="checkbox" id="chfec" name="chfec" onclick="fechas()"/></td>
        <td align="right" class="Estilo8" > Ini :&nbsp;</td>
        <td width="16" id="fini" name ="fini" style="display:none" ><A href="javascript:showCal('Calendar1')"><img height=16 src="images/cal.gif" width=16 border=0></A></td>
        <td width="240"><input type="text" class="INPUTS" id="ini" name="ini" style="text-align:center" readonly tabindex="-1" style="display:none" value=""/>
            
        </td>
        <td width="34" align="left" class="Estilo8"> Fin : &nbsp; </td>
        <td width="21" id="ffin" name="ffin" style="display:none" ><A href="javascript:showCal('Calendar2')"><img height=16 src="images/cal.gif" width=16 border=0></A></td>
        <td width="196"><input type="text" class="INPUTS" id="fin" name="fin" style="text-align:center" style="display:none"  value=""/></td>
       
    </tr>
    <tr valign="middle">
        <td align="right" class="Estilo8" width="90"> # Guia :&nbsp;</td>
        <td width="143"><input type="text" class="INPUTS" id="gui" name="gui" style="text-align:center" value=""/></td>
        <td colspan="4"></td>
        <td align="right" class="Estilo8" > O/C :&nbsp;</td>
        <td colspan="1"><input type="text" class="INPUTS" id="oc" name="oc" style="text-align:center" value=""/></td>
        <td align="right" class="Estilo8" > Tip Mov :&nbsp;</td>
        <td colspan="3">
             <select  class="INPUTS" id="mov" name="mov"  value="" style="text-align:center;width:100%">
                            <option value=""></option>
                            <option value="PE">PE</option>
                            <option value="PS">PS</option>
                            <option value="GS">GS</option>
                            <option value="PS+GS">PS+GS</option>
                        </select> 
                <option value=""></option>
            </select> 
        </td>
         <td align="right" rowspan="3" colspan="2">
            <img src="IMAGES/go1.png" border="0" onclick="MANDA()" onmouseover="this.src='images/go2.png'" id="pima" name="pima" 
              onmouseout="this.src='images/go1.png'" style="cursor:pointer"/></td>
    </tr>
    <tr valign="middle">
        <td align="right" width="90" class="Estilo8"> Proveedor :&nbsp;</td>
        <td colspan="3"><input type="text" class="INPUTS" id="ruc" name="ruc" style="text-align:center" value="" onblur="jala_ruc()"/></td>
        <td width="36" align="left"><img src="IMAGES/lupa.png" border="0" onclick="buscapr()" id="img1" name="img1" style="cursor:pointer"/></td>
        <td width="120"><input type="text" class="INPUTS" id="pr" name="pr" style="text-align:center; " value=""/>
        </td> 
        <td align="right" class="Estilo8" > Lote :&nbsp;</td>
        <td colspan="1"><input type="text" class="INPUTS" id="lot" name="lot" style="text-align:center" value=""/></td>
        <td align="right" class="Estilo8" width="88" >Doc. Ref :&nbsp;</td>
        <td colspan="3"><input type="text" class="INPUTS" id="doc" name="doc"  value=" "/></td>
    </tr>
    <tr valign="middle">
        <td align="right" class="Estilo8"> Articulo :&nbsp;</td>
        <td colspan="3"><input type="text" class="INPUTS" id="cart" name="cart" style="text-align:center" value=""/></td>
        <td align="left"><img src="IMAGES/lupa.png" border="0" onclick="hlpART()" id="img2" name="img2" style="cursor:pointer"/></td>
        <td><input type="text" class="INPUTS" id="dart" name="dart" style="text-align:center; " value=""/>       </td> 
        <td align="right"  width="37" class="Estilo8" >Color :&nbsp;</td>
        <td colspan="1"><input type="text" class="INPUTS" id="col" name="col" style="text-align:center" value=""/></td>
        <td align="right" class="Estilo8" > Tip. Serv. :&nbsp;</td>
        <td colspan="3">
            <select  class="INPUTS" id="ser" name="ser"  value="" style="text-align:center;width:100%">
                <option value=""></option>
            </select> 
        </td>
  </tr>
</table>


<iframe  width="100%"  style="display:block;vertical-align:top;" src="" id="ingresos" name="ingresos"  scrolling="yes" frameborder="1" height="250" align="middle" ></iframe>
<table align="center"  bordercolor="#FFFFFF"  cellpadding="0"  cellspacing="0"  border="0" width="100%" style="background-color:#A3B87A" >
	<tr>
        <td width="80%">
            <table align="center"  bordercolor="#FFFFFF"  cellpadding="2"  cellspacing="1"  border="1" width="100%" style="background-color:#A3B87A">
	            <tr>
                    <td align="left" class="Estilo8" width="20%">
                     <select  class="INPUTS" id="tmo" name="tmo"  value="" onchange="document.all.tipo.value = this.value" style="text-align:center;width:100%">
                             <option value=""></option>
                            <option value="PE">PE</option>
                            <option value="PS">PS</option>
                            <option value="GS">GS</option>
                        </select> 
                    </td>
                    <td width="15%"><input type="text" class="INPUTS" id="dok" name="dok" onblur="document.all.docu.value=this.value" style="text-align:center" value=""/></td>
                    <td align="center" width="2%"><input type="button" value="Agregar Doc" onclick="asigna()" style="cursor:pointer"/></td>
                    <td align="left" class="Estilo8" width="20%"><<  === Traer Documento desde SofCOM</td>
                    <td align="left" class="Estilo8" style="display:block"><input type="text" class="INPUTS" id="alma" name="alma" style="text-align:center" value="" readonly="readonly" tabindex="-1" /></td>
                    <td align="left" class="Estilo8" style="display:block"><input type="text" class="INPUTS" id="tipo" name="tipo" style="text-align:center" value="" readonly="readonly" tabindex="-1" /></td>
                    <td align="left" class="Estilo8" style="display:block"><input type="text" class="INPUTS" id="docu" name="docu" style="text-align:center" readonly="readonly" tabindex="-1" value=""/></td>
                    </tr>
            </table>
        </td>
    
    <td width="10%">
     <table align="center"  bordercolor="#FFFFFF"  cellpadding="0"  cellspacing="0"  border="0" width="100%" style="background-color:#A3B87A">
        <tr>
            <td width=1%><img src="IMAGES/LABEL.png" border="0" onclick="PRINTA()" id="LAB" name="LAB" alt="Imprime Etiquetas" style="cursor:pointer"/></td>
            <td width=1%><img src="IMAGES/print1.png" border="0" onclick="previu()" id="prn" name="prn" alt="Preview del Grid" style="cursor:pointer"/></td>
            <td width=1%><img src="IMAGES/xl1.png" border="0" onclick="XLL()" id="xll" name="xll" onmouseover="this.src='images/xl2.png'" onmouseout="this.src='images/xl1.png'" style="cursor:pointer"/></td>
        </tr>
    </table>
    </td>
</tr>
</table>
<iframe  width="100%"  style="display:none" src="" id="body0" name="body0"  scrolling="no" frameborder="0" height="20" align="middle"></iframe>
</form>

</body>
<script language="jscript" type="text/jscript">

addCalendar("Calendar1", "Elija una fecha", "ini", "thisForm")
addCalendar("Calendar2", "Elija una fecha", "fin", "thisForm")

function fechas() { 
    if (document.all.chfec.checked == true)
        {   document.all.ini.style.display='block'
        document.all.fin.style.display = 'block'
        document.all.fini.style.display = 'block'
        document.all.ffin.style.display = 'block'
        }
    else
        {   document.all.ini.style.display='none'
        document.all.fin.style.display = 'none'
        document.all.fini.style.display = 'none'
        document.all.ffin.style.display = 'none'
        }
}
function buscapr() {

    window.open('HELP/busca_prov_oc.ASP?NOM=' + ltrim(document.all.pr.value))
    return true;
}
function hlpART() {

    window.open('HELP/busca_ARTICULOS.ASP?NOM=' + ltrim(document.all.dart.value))
    return true;
}

function jala_ruc() {
    if (trim(document.all.ruc.value) != '') {
        cad = 'bake/jala_ruc.asp?ruc=' + trim(document.all.ruc.value)
        document.all.body0.style.display = 'block'
        document.all.body0.src = cad
    }
}


function MANDA() {
/*
    if (trim(document.all.ruc.value) == '') {
        alert("Por favor se necesita RUC válido")
        return false;
    }
*/
    ini = trim(document.all.ini.value)
    
    fin = trim(document.all.fin.value)
    
    if (document.all.chfec.checked == true)
        rango = 'S'
    else 
        rango = 'N'
    
    cad  = 'FRAMES/GRID_INGRESOS_SALIDAS.ASP?alm=' + trim(document.all.alm.value)
    cad += '&gui=' + trim(document.all.gui.value)
    cad += '&ran=' + rango
    cad += '&ini=' + ini
    cad += '&fin=' + fin
    cad += '&oc='  + trim(document.all.oc.value)
    cad += '&mov=' + trim(document.all.mov.value)
    cad += '&ruc=' + trim(document.all.ruc.value)
    cad += '&lot=' + trim(document.all.lot.value)
    cad += '&ser=' + trim(document.all.ser.value)
    cad += '&cart=' + trim(document.all.cart.value)
    cad += '&col=' + trim(document.all.col.value)
    cad += '&doc=' + trim(document.all.doc.value)
     
    document.all.ingresos.src = cad


}

function XLL() {
    ini = trim(document.all.ini.value)

    fin = trim(document.all.fin.value)

    if (document.all.chfec.checked == true)
        rango = 'S'
    else
        rango = 'N'

    cad = 'reportes/prn_grid_ING_SAL.ASP?alm=' + trim(document.all.alm.value)
    cad += '&gui=' + trim(document.all.gui.value)
    cad += '&ran=' + rango
    cad += '&ini=' + ini
    cad += '&fin=' + fin
    cad += '&oc=' + trim(document.all.oc.value)
    cad += '&mov=' + trim(document.all.mov.value)
    cad += '&ruc=' + trim(document.all.ruc.value)
    cad += '&lot=' + trim(document.all.lot.value)
    cad += '&ser=' + trim(document.all.ser.value)
    cad += '&cart=' + trim(document.all.cart.value)
    cad += '&col=' + trim(document.all.col.value)
    cad += '&doc=' + trim(document.all.doc.value)
     

window.open (cad)
}
function asigna() {
    var opc = "directories=no,";
    opc = opc + "hotkeys=no,location=no,";
    opc = opc + "menubar=no,resizable=yes, height=150,width=150,";
    opc = opc + "left=500,top=400,scrollbars=no,";
    opc = opc + "status=no,titlebar=no,toolbar=no";

    if (trim(document.all.dok.value) == '') {
        alert("Por favor informar el numero de documento a traer")
        return false;
    }
    if (trim(document.all.tipo.value) == '') {
        alert("Por favor informar el tipo de documento a traer")
        return false;
    }
    cad = 'help/hlp_trae_doc.asp?alm=' + trim(document.all.alma.value)
    
    cad += '&tip=' + trim(document.all.tipo.value)
    cad += '&doc=' + trim(document.all.dok.value)
    //alert(cad)
    document.all.body0.style.display='block'
    document.all.body0.src =cad
    return true;
}
function SELE() {
    cad = 'bake/bakeservicios.asp?sele=' + 'ser' + '&alm=' + trim(document.all.alm.value)
    // document.all.body0.style.display='block'
    document.all.alma.value = document.all.alm.value
    document.all.body0.src = cad
   }

</script>

</html>
