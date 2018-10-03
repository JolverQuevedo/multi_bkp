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
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<table align="center"  bordercolor="#FFFFFF"  cellpadding="0"  cellspacing="0"  border="1" width="100%">
	<tr><td align="left" class="Estilo4">Criterios de Busqueda</td></tr>
</table>

<table  border="0" cellspacing="0" cellpadding="0" align="center" width="100%" style="background-color:#A3B87A" >
    <tr valign="middle">
        <td align="right" class="Estilo8" > Almacen :&nbsp;</td>
        <td colspan="4">
<%  TBL1 = "RSFACCAR..AL" + CIA + "ALMA"
    TBL2 = "MULTI..RS_USUALM" + CIA 
cad =   " select a1_calma, a1_calma+space(5)+a1_cdescri as descri from "&tbl1&"  A " & _
        " INNER JOIN "&TBL2&" B ON (A1_CALMA COLLATE Modern_Spanish_CI_AS =CALMA) AND B.CUSUARIO='"&usr&"' order by 1 " 
        'response.write(cad)
rs.open cad,cnn                %>
            <select  class="INPUTS" id="alm" name="alm" onchange="SELE()" value="" style="text-align:center;width:100%">
                
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
         <td align="right" class="Estilo8">Doc Ref :</td>
          <td><input type="text" id="nre" name="nre" /></td>
        <td align="right" class="Estilo8">Excel :
          <input type="checkbox" id="exl" name="exl" /></td>
        <td align="right" class="Estilo8" > Ini :&nbsp;</td>
        <td width="16" id="fini" name ="fini" style="display:block" ><A href="javascript:showCal('Calendar1')"><img height=16 src="images/cal.gif" width=16 border=0></A></td>
        <td width="150"><input type="text" class="INPUTS" id="ini" name="ini" style="text-align:center" readonly tabindex="-1" style="display:none" value=""/>
            
        </td>
        <td width="34" align="left" class="Estilo8"> Fin : &nbsp; </td>
        <td width="21" id="ffin" name="ffin" style="display:block" ><A href="javascript:showCal('Calendar2')"><img height=16 src="images/cal.gif" width=16 border=0></A></td>
        <td width="150"><input type="text" class="INPUTS" id="fin" name="fin" style="text-align:center" style="display:none"  value=""/></td>
       
    </tr>
    <tr valign="middle">
        <td align="right" class="Estilo8" width="90"> Tip Mov:&nbsp;</td>
        <td colspan="5">
        <%  TBL1 = "RSFACCAR..AL" + CIA + "TABM"
            cad =  " select tm_ccodmov as cod, min(tm_ccodmov+space(5)+tm_cdescri) as Descri from "&TBL1&" group by tm_ccodmov order by 2 " 
        'response.write(cad)
rs.open cad,cnn                %>
            <select  class="INPUTS" id="gui" name="gui" value="" style="text-align:center;width:100%">
                
                <option value=""></option>
                <%if rs.recordcount > 0 then %>
                <%rs.movefirst%>
                <%do while not rs.eof%>
                    <option value='<%=rs("cod")%>'><%=ucase(rs("descri"))%></option>
                    <%RS.MOVENEXT%>
                <%loop%>
                <%end if%>
                <%rs.close%>
            </select> 


            </td>
       
        <td align="right" colspan="1" class="Estilo8" > Num Mov:</td>
        <td ><input type="text" class="INPUTS" id="oc" name="oc" style="text-align:center" value=""/></td>
        <td align="right" class="Estilo8" > Tip Doc :&nbsp;</td>
        <td colspan="3">
             <select  class="INPUTS" id="mov" name="mov"  value="" style="text-align:center;width:100%">
                            <option value=""></option>
                            <option value="PE">PE</option>
                            <option value="PS">PS</option>
                            <option value="GS">GS</option>
                            
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
        <td colspan="1"><input type="text" class="INPUTS" id="ruc" name="ruc" style="text-align:center" value="" onblur="jala_ruc()"/></td>
        <td width="36" align="left"><img src="IMAGES/lupa.png" border="0" onclick="buscapr()" id="img1" name="img1" style="cursor:pointer"/></td>
        <td width="120" colspan="3"><input type="text" class="INPUTS" id="pr" name="pr" style="text-align:center; " value=""/>
        </td> 
        <td align="right" class="Estilo8" > Lote :&nbsp;</td>
        <td colspan="1"><input type="text" class="INPUTS" id="lot" name="lot" style="text-align:center" value=""/></td>
        <td align="right" class="Estilo8" width="88" >Num. CTD :&nbsp;</td>
        <td colspan="3"><input type="text" class="INPUTS" id="doc" name="doc"  value=" "/></td>
    </tr>
    <tr valign="middle">
        <td align="right" class="Estilo8"> Articulo :&nbsp;</td>
        <td colspan="1" ><input type="text" class="INPUTS" id="cart" name="cart" style="text-align:center" value=""/></td>
        <td align="left"><img src="IMAGES/lupa.png" border="0" onclick="hlpART()" id="img2" name="img2" style="cursor:pointer"/></td>
        <td colspan="3"><input type="text" class="INPUTS" id="dart" name="dart" style="text-align:center; " value=""/>       </td> 
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


<iframe  width="100%"  style="display:none" src="" id="body0" name="body0"  scrolling="no" frameborder="0" height="20" align="middle"></iframe>
</form>

</body>
<script language="jscript" type="text/jscript">

addCalendar("Calendar1", "Elija una fecha", "ini", "thisForm")
addCalendar("Calendar2", "Elija una fecha", "fin", "thisForm")


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
    if (document.all.exl.checked == true)
        xls = "E"
    else
        xls = ""
    cad  = 'REPORTES/PRN_CONSUL_PARTES.ASP?alm=' + trim(document.all.alm.value)
    cad += '&gui=' + trim(document.all.gui.value)
    cad += '&ini=' + trim(document.all.ini.value)
    cad += '&fin=' + trim(document.all.fin.value) 
    cad += '&oc='  + trim(document.all.oc.value)
    cad += '&mov=' + trim(document.all.mov.value)
    cad += '&ruc=' + trim(document.all.ruc.value)
    cad += '&lot=' + ltrim(document.all.lot.value)
    cad += '&ser=' + trim(document.all.ser.value)
    cad += '&art=' + trim(document.all.cart.value)
    cad += '&col=' + ltrim(document.all.col.value)
    cad += '&doc=' + trim(document.all.doc.value)  
    cad += '&nre=' + trim(document.all.nre.value)
    cad += '&xls=' + xls
 //   alert(cad)
    document.all.ingresos.src = cad
}


function SELE() {
    cad = 'bake/bakeservicios.asp?sele=' + 'ser' + '&alm=' + trim(document.all.alm.value)
    // document.all.body0.style.display='block'
    //document.all.alma.value = document.all.alm.value
    document.all.body0.src = cad
   }

</script>

</html>
