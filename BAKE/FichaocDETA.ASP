<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>
<link href="multisty.css" rel="stylesheet" type="text/css">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<script type="text/jscript" language="jscript">
var aCod = Array() 
function calcHeight()
{
  //find the height of the internal page
  var the_height=
    document.getElementById('body0').contentWindow.
      document.body.scrollHeight+25;
  //change the height of the iframe
  document.getElementById('body0').height=
      the_height;
}
</script>
<%	oc = Request.QueryString("Oc")
    if trim(oc)= "" then oc = "AUTO"

%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title>FICHA O/C</title>

</head>
<body >
<form id="thisForm" method="post" name="thisForm" action="comun/inserFICHAoc.asp">
<table border="0" cellpadding="0" cellspacing="0" width="100%" >
	<tr valign="center" > 
		  <td width="20%"><img src="images/CLOSE.PNG" style="cursor:pointer;" onClick="window.close()" /></td>	
          
          <td align = "center" class="TALASBLUE" width="60%">
            <table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center" width="100%" bordercolorlight="#f7d975">
		        <tr><td align="center" class="estilo4">DETALLE O/C</td></tr>
		    </table> 
         </td>
         <td id="grab" align="center" width="10%">&nbsp;    
	     </td>
         <td  width="20%" align="right"><img src="images/logo.jpg" border="0"  alt="" id="GRABA" /></td>
    </tr>
</table>  
<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>

<table width="100%" border="0" bordercolordark="DarkOrange" cellpadding="0" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975" style="height:1px;"></td>	
	</tr>
</table>

<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table border="1" cellpadding="2" width="100%" cellspacing="0" bgcolor="#dbe3cd" bordercolordark="<%=(Application("color2"))%>" bordercolorlight="<%=(Application("COLOR2"))%>">
    <tr valign="top">
        <td bgcolor="<%=(Application("BARRA"))%>" class="log_label"  width="20%">Orden de Compra</td>
        <td width="10%"><input type="text" id="OC" name="OC" value="" class="data2" disabled/></td>
        <td colspan="4">&nbsp;</td>
  </tr>
  <tr>  
  <td bgcolor="<%=(Application("BARRA"))%>" class="log_label" width="10%"><p>Proveedor</p></td>
    <td width="12%"><input type="text" id="PRO" name="PRO" value="" class="DESCRIPTORES" disabled/></td>
    <td colspan="4"><input type="text" id="NOM" name="NOM" value="" class="DESCRIPTORES" disabled/></td>
  </tr>
  <tr>

         <td bgcolor="<%=(Application("BARRA"))%>" class="log_label" width="11%">Nro. cotizaci&oacute;n</td>
    <td><input type="text" id="COT" name="COT" value="" class="DESCRIPTORES" disabled/></td>
      <td colspan="4">&nbsp;</td> 
 
  </tr>
  <tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="log_label" width="10%">Moneda</td>
    <td><input type="text" id="MON" name="MON" value="" class="DESCRIPTORES" disabled/></td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="log_label" width="10%">% IGV</td>
    <td><input type="text" id="IGV" name="IGV" value="" class="DESCRIPTORES" disabled/></td>
     <td bgcolor="<%=(Application("BARRA"))%>" class="log_label"  width="10%">Fecha de Registro</td>
        <td width="10%"><input type="text" id="FEC" name="FEC" value="" class="DESCRIPTORES" disabled style="text-align:center; width:100%"/></td>
  </tr>
  <tr>
    <td bgcolor="<%=(Application("BARRA"))%>" class="log_label" >Tipo de Cambio</td>
     <td><input type="text" id="TCAM" name="TCAM" value="" style="width:100%" class="DESCRIPTORES" disabled/></td>
     <td bgcolor="<%=(Application("BARRA"))%>" class="log_label" width="20%" >% Dcto Financiero</td>
    <td><input type="text" id="FIN" name="FIN" value="" class="DESCRIPTORES" style="width:100%" disabled/></td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="log_label" width="20%">Fecha de Entrega</td>
    <td width="12%"><input type="text" id="ENT" name="ENT" value="" class="DESCRIPTORES" style="width:100%;text-align:center" disabled/></td>
   
  </tr> 
</table>
<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<iframe  width="100%" style="display:block; width:100%; height:250px" src='<%="lineasoc.asp?oc="+oc%>' id="detalle" name="detalle" scrolling="yes" frameborder="1" ></iframe>
<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<%
 tbl1 = "RSFACCAR..CO"+ cia +"MOVC"
 tbl2 = "RSFACCAR..CO"+ cia +"MOVD"

CAD =   " Select sum(ss.oc_ncanord)  as items, sum(ss.oc_npreun2*ss.oc_ncanord) as bruto, sum(ss.oc_nigv) as igv, " & _
        " total =case when aa.oc_ccodmon = 'MN' then sum(ss.oc_ntotmn) else sum(ss.oc_ntotus) end                 " & _
	    " From "&TBL2&" ss inner join "&TBL1&" aa on ss.oc_cnumord = aa.oc_cnumord                                " & _
	    " Where ss.OC_CNUMORD='"&OC&"'                                                                            " & _
        " GROUP BY AA.OC_CCODMON                                                                                  "  


'response.write(cad)
RS.OPEN CAD, CNN

if rs.recordcount <= 0 then 
    cad = "SELECT	0 AS ITEMS, 0 AS BRUTO, 0 AS IGV,	0 AS TOTAL"
    rs.close
    rs.open cAD,CNN
END IF
RS.MOVEFIRST %>
<table border="0" cellpadding="1" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
    <tr valign="top">
        <td bgcolor="<%=(Application("color2"))%>" class="log_label" style="text-align:right; padding-right:10px" colspan="7" width="80%">Total Bruto: </td>
        <td width="10%"><input type="text" id="BRUT" name="BRUT" value="<%=FORMATNUMBER(RS("BRUTO"),3,,TRUE)%>" class="data" style="text-align:right; padding-right:10px"   tabindex="-1" readonly/></td>
  </tr>
  <tr valign="top">
        <td bgcolor="<%=(Application("color2"))%>" class="log_label" style="text-align:right; padding-right:10px"  colspan="7"  width="80%">Total Dscto: </td>
        <td width="10%"><input type="text" id="DCTO" name="DCTO" value="0.000" class="data" style="text-align:right; padding-right:10px"   tabindex="-1" readonly/></td>
  </tr>
  <tr valign="top">
        <td bgcolor="<%=(Application("color2"))%>" class="log_label" style="text-align:right; padding-right:10px"  colspan="7"  width="80%">I.G.V.: </td>
        <td width="10%"><input type="text" id="NIGV" name="NIGV" value="<%=FORMATNUMBER(RS("IGV"),3,,TRUE)%>" class="data" style="text-align:right; padding-right:10px"   tabindex="-1" readonly/></td>
  </tr>
  <tr valign="top"><td bgcolor="<%=(Application("color2"))%>" width="65%">&nbsp;</td>
    <td bgcolor="<%=(Application("color2"))%>" width="3%"><img src="images/new.PNG" alt="NUEVA LINEA" style="cursor:pointer" onclick="newo()" /></td>
    <td bgcolor="<%=(Application("color2"))%>" width="3%"><img src="images/del.png" alt="eliminar LINEA" style="cursor:pointer" onclick="delo()" /></td>
    <td bgcolor="<%=(Application("color2"))%>" width="3%"><img src="images/edit.png" alt="editar " style="cursor:pointer" onclick="abro()" /></td>
    <td bgcolor="<%=(Application("color2"))%>" width="3%"><img src="images/ok.png" alt="grabar" style="cursor:pointer" onclick="grabo()" /></td>
    <td bgcolor="<%=(Application("color2"))%>" width="3%"><img src="images/close.png" alt="cerrar" style="cursor:pointer" onclick="closer()" /></td>
    <td bgcolor="<%=(Application("color2"))%>" class="log_label" style="text-align:right; padding-right:10px"  width="20%">Neto : </td>
    <td width="10%"><input type="text" id="NETO" name="NETO" value="0.00" class="data" style="text-align:right; padding-right:10px"   tabindex="-1" readonly/></td>
  </tr>
  </table>

<!-------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------!-->
<script type="text/jscript" language="jscript">
//**********************************************************************************************
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900";



document.all.OC.value   = window.opener.document.all.OC.value
document.all.PRO.value  = window.opener.document.all.PRO.value
document.all.NOM.value  = window.opener.document.all.NOM.value
document.all.COT.value  = window.opener.document.all.DOC1.value
document.all.MON.value  = window.opener.document.all.MON.value
document.all.TCAM.value = window.opener.document.all.TCAM.value
//document.all.ENT.value  = window.opener.document.all.ENT.value
document.all.FIN.value  = window.opener.document.all.FIN.value
if (trim(document.all.MON.value)=='MN')
    document.all.NETO.value = window.opener.document.all.soles.value
else
    document.all.NETO.value = window.opener.document.all.dolares.value




function newo() 
{   var iframe = document.getElementById('detalle');
    var innerDoc = iframe.contentDocument || iframe.contentWindow.document;
    var input = innerDoc.getElementById('linea');
    var ende = innerDoc.getElementById('final');
    var pose = innerDoc.getElementById('pose');
    var cad
    cad = ''
    
    if (parseInt(input.value, 10) < parseInt(ende.value, 10)) {
        lin = parseInt(input.value, 10)
        var show = innerDoc.getElementById('fila' + lin)
        lin++
        var show = innerDoc.getElementById('fila' + lin)
        show.style.display = 'block'
        input.value = lin 
        cad += '&lin=' + strzero(parseInt(input.value,10)+1,4) 
    }
    else
    {   alert("no hay mas lineas disponibles")
        return true;
    }
    kkk = 'MAINarticuloOC.asp?oc=' + trim(window.opener.document.all.OC.value) + cad
    //alert(kkk)
    window.open(kkk)
return true;
}

function delo() {
    alert("delo")
    return true;
}
function updates(can,cod,pes,ln) {
    var iframe = document.getElementById('detalle');
    var innerDoc = iframe.contentDocument || iframe.contentWindow.document;
    var pose = innerDoc.getElementById('pose');
    var cad
    cad = ''
    pos = parseInt(pose.value, 10)
    var deta = innerDoc.getElementById('fila' + pos)
    deta.cells(6).innerText = can
    pre = toInt(deta.cells(8).innerText)
    deta.cells(16).innerText = addCommas(redondea((pre * can), 3))
    deta.cells(2).innerText = cod
    deta.cells(3).innerText = pes
    deta.cells(0).innerText = ln
}
function abro() {
//alert("va a newo")
    var iframe = document.getElementById('detalle');
    var innerDoc = iframe.contentDocument || iframe.contentWindow.document;
    var input = innerDoc.getElementById('linea');
    var ende = innerDoc.getElementById('final');
    var pose = innerDoc.getElementById('pose');
    var cad
    cad = ''
    pos = parseInt(pose.value, 10)
    var deta = innerDoc.getElementById('fila' + pos)
    // verifica que la linea actual tenga datos para 
    // que no se muestren lineas por gusto
    if (trim(deta.cells(0).innerText) != '') {
        cad += '&lin=' + trim(deta.cells(0).innerText);
        cad += '&cod=' + trim(deta.cells(2).innerText);
        cad += '&des=' + trim(deta.cells(3).innerText);
        cad += '&uni=' + trim(deta.cells(4).innerText);
        cad += '&can=' + trim(deta.cells(6).innerText);
        cad += '&pre=' + trim(deta.cells(8).innerText);
        cad += '&com=' + trim(deta.cells(20).innerText);
        cad += '&igv=' + trim(deta.cells(11).innerText);
        cad += '&isc=' + trim(deta.cells(12).innerText);
    }
    kkk = 'MAINarticuloOC.asp?oc=' + trim(window.opener.document.all.OC.value) + cad
    //alert(kkk)
    window.open(kkk)
    return true;
}

function grabo() {
    alert("grabo")
    // colcocar rutina de grabacion
    var si
    { si = confirm("¿ Desea Imprimir esta Orden de Compra ? "); }
    if (si == false)
    { return false; }
    // imprimir.......................
    return true;
}


function closer() {
    var si
    { si = confirm("¿ Confirma la salida de esta Orden de Compra ? "); }
    if (si == false)
    { return false; }
    window.opener.close()
    window.close()

return true;

}

</script>

</form>
</body>
</html>



