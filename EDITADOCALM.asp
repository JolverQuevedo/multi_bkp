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
<body style="margin-top:0; margin-left:0; margin-right:0;" onload="document.all.alm.focus()">
<form id="thisForm" method="post" name="thisForm" action="ediciones.asp">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<table align="center"  bordercolor="#FFFFFF"  cellpadding="0"  cellspacing="0"  border="1" width="100%">
	<tr><td align="left" class="Estilo4">Criterios de Busqueda</td></tr>
</table>

<table  border="0" cellspacing="0" cellpadding="0" align="center" width="100%" style="background-color:#A3B87A" >
    <tr valign="middle">
        <td align="right" class="Estilo8" > Almacen :&nbsp;</td>
        <td colspan="2">
        <%  TBL1 = "RSFACCAR..AL" + CIA + "ALMA"
            TBL2 = "MULTI..RS_USUALM" + CIA 
        cad =   " select a1_calma, a1_calma+space(5)+a1_cdescri as descri from "&tbl1&"  A " & _
                " INNER JOIN "&TBL2&" B ON (A1_CALMA COLLATE Modern_Spanish_CI_AS =CALMA) AND B.CUSUARIO='"&usr&"' order by 1 " 
               ' response.write(cad)
        rs.open cad,cnn                %>
            <select  class="INPUTS" id="alm" name="alm" style="text-align:center;width:100%">
                <option value=""></option>
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
        <td colspan="3" >&nbsp; <input name="olvidealmacen" id="olvidealmacen" type="checkbox"/><span style="color:#ffffff">olvidé el almacen</span></td> 
        <td align="right" rowspan="3" width="5%">
            <img src="IMAGES/go1.png" border="0" onclick="cargadatos()" onmouseover="this.src='images/go2.png'" id="pima" name="pima" 
              onmouseout="this.src='images/go1.png'" style="cursor:pointer"/></td>
    </tr>
    <tr valign="middle">
        <td align="right" class="Estilo8" width="10%"> Tipo-Nro. Doc :&nbsp;</td>
        <td width="5%">
             <select  class="INPUTS" id="mov" name="mov"  value="" style="text-align:center;width:100%">
                            <option value=""></option>
                            <option value="PE">PE</option>
                            <option value="PS">PS</option>
                            <option value="GS">GS</option>
                           
                        </select> 
                <option value=""></option>
            </select> 
        </td>
        <td width="15%"><input type="text" class="INPUTS" id="gui" name="gui" style="text-align:center"  value=""/></td>
         <td >&nbsp;</td> 
        <td align="right" width="5%" class="Estilo8"> Estado :&nbsp;</td>
        <td width="10%"><input type="text" class="Estilo55" id="edo" name="edo" style="text-align:center" value="" /></td> 
    </tr>
    <tr valign="middle">
        <td align="right" width="10%" class="Estilo8"> Proveedor :&nbsp;</td>
        <td><input type="text" class="Estilo55" id="ruc" name="ruc" style="text-align:center" value=""  readonly tabindex="-1" /></td> 
        <td colspan="2" width="40%"><input type="text" class="Estilo55" id="pr" name="pr" style="text-align:left; width:100%" readonly tabindex="-1" value=""/></td>
        <td align="right" width="5%" class="Estilo8"> Fecha :&nbsp;</td>
        <td width="10%"><input type="text" class="Estilo55" id="fec" name="fec" style="text-align:center"  readonly tabindex="-1" value=""/></td> 
    </tr>
 
</table>
<iframe  width="100%"  style="display:block;vertical-align:top;" src="" id="lineas" name="lineas"  scrolling="yes" frameborder="1" height="250" align="middle" ></iframe>
<table align="center"  bordercolor="#FFFFFF"  cellpadding="0"  cellspacing="0"  border="0" width="100%" style="background-color:#A3B87A" >
	<tr>
        <td width="80%">
            <table align="center"  bordercolor="#FFFFFF"  cellpadding="2"  cellspacing="1"  border="1" width="100%" style="background-color:#A3B87A">
	            <tr>
                    <td align="center" width="10%"><input type="button" value="Modifica Cabecera" onclick="descri()" style="cursor:pointer" id="uno" name="uno" disabled/></td>
                    <td align="center" width="10%" style="display:none  "><input type="button" value="Modifica Cantidad" onclick="canti()" style="cursor:pointer" id="dos" name="dos" disabled/></td>
                    <td align="center" width="10%"><input type="button" value="Copiar Documento" onclick="copia()" style="cursor:pointer" id="tres" name="tres" disabled/></td>
                    <td align="center" width="10%"><input type="button" value="Eliminar Documento" onclick="elimina()" style="cursor:pointer" id="cuatro" name="cuatro" disabled/></td>
                    <td align="left" class="Estilo55" style="display:block"><input type="text" class="Estilo55" id="alma" name="alma" style="text-align:center" value="" readonly="readonly" tabindex="-1" /></td>
                    <td align="left" class="Estilo55" style="display:block"><input type="text" class="Estilo55" id="tipo" name="tipo" style="text-align:center" value="" readonly="readonly" tabindex="-1" /></td>
                    <td align="left" class="Estilo55" style="display:block"><input type="text" class="Estilo55" id="docu" name="docu" style="text-align:center" readonly="readonly" tabindex="-1" value=""/></td>
                    </tr>
            </table>
        </td>
    
</tr>
</table>
<iframe  width="100%"  style="display:none" src="" id="body0" name="body0"  scrolling="no" frameborder="0" height="200px" align="middle"></iframe>
</form>

</body>
<script language="jscript" type="text/jscript">
    var opc = "directories=no,";
    opc = opc + "hotkeys=no,location=no,";
    opc = opc + "menubar=no,resizable=yes, height=150,width=450,";
    opc = opc + "left=200,top=200,scrollbars=no,";
    opc = opc + "status=no,titlebar=yes,toolbar=no";

function cargadatos() {
if(document.all.olvidealmacen.checked){
	
		var c="muestradocsinalmacen.asp?ctd="+trim(document.all.mov.value)+"&doc="+trim(document.all.gui.value)+"";
		window.open(c, "", "width=800,height=600");
	    return false;
	}
    if (document.all.alm.value == "") {
        alert("Favor seleccionar el almacen")
        return false;
    }
     if (document.all.mov.value == "") {
        alert("Favor seleccionar el tipo de Documento")
        return false;
    }
    if (document.all.gui.value == "") {
        alert("Favor indicar el Nro. de Documento")
        return false;
    }
    
    
     cad  = 'bake/cabecera_doc_alm.asp'
     cad += '?alm=' + trim(document.all.alm.value)
     cad += '&ctd=' + trim(document.all.mov.value)
     cad += '&doc=' + trim(document.all.gui.value)
     //alert(cad)

     document.all.body0.src = cad
      return true        
    }

function copia() {
    if (trim(document.all.mov.value) != 'GS') {
        alert("Solo se pueden copiar GUIAS ...")
        return false;
    }
    cad  = 'frames/copia_doc_alm.asp?alm=' + document.all.alm.value
    cad += '&doc=' + document.all.gui.value
    
        window.open(cad,"COPIA_GUIA",opc)
    
}

function descri() {
    if (document.all.alm.value == "") {
        alert("Favor seleccionar el almacen")
        return false;
    }
     if (document.all.mov.value == "") {
        alert("Favor seleccionar el tipo de Documento")
        return false;
    }
    if (document.all.gui.value == "") {
        alert("Favor indicar el Nro. de Documento")
        return false;
    }
    
    cad = 'frames/update_cab_doc.asp?alm=' + document.all.alm.value
    cad += '&doc=' + document.all.gui.value + '&mov=' + document.all.mov.value
    cad += '&ruc=' + document.all.ruc.value
    cad += '&pro=' + document.all.pr.value
    cad += '&fec=' + document.all.fec.value

    window.open(cad, "ACTUALIZA_CABECERA", opc)

}

function elimina() {
    if (trim(document.all.mov.value) != 'GS') {
        alert("Solo se pueden eliminar GUIAS ...")
        return false;
    }
    cad = 'comun/elimina_guia.asp?alm=' + document.all.alm.value
    cad += '&doc=' + document.all.gui.value
    cad += '&ctd=' + trim(document.all.mov.value)
    document.all.body0.style.display='block'
    document.all.body0.src = cad

}


</script>

</html>
