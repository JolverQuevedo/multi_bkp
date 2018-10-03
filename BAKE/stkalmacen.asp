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
function calcHeight() {
    pag = 'ingresos'
    //find the height of the internal page
    var the_height = document.getElementById(pag).contentWindow.document.body.scrollHeight;

    //change the height of the iframe
    document.getElementById(pag).height = 450;
}
</script>

<body style="margin-top:0; margin-left:0; margin-right:0;" onload="document.all.alm.focus(); ">
<form id="thisForm" method="post" name="thisForm" action="ediciones.asp">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<table align="center"  bordercolor="#FFFFFF"  cellpadding="0"  cellspacing="0"  border="1" width="100%">
	<tr><td align="left" class="Estilo4">Criterios de Busqueda</td></tr>
</table>

<table  border="0" cellspacing="0" cellpadding="0" align="center" width="100%" style="background-color:#A3B87A" >
    <tr valign="middle">
        <td width="11%" align="right" class="Estilo8" > Almacen :&nbsp;</td>
        <td width="11%">
<%  TBL1 = "RSFACCAR..AL" + CIA + "ALMA"
    TBL2 = "MULTI..RS_USUALM" + CIA 
cad =   " select a1_calma, a1_calma+space(5)+a1_cdescri as descri from "&tbl1&"  A " & _
        " INNER JOIN "&TBL2&" B ON (A1_CALMA COLLATE Modern_Spanish_CI_AS =CALMA) AND B.CUSUARIO='"&usr&"' order by 1 " 
        'response.write(cad)
rs.open cad,cnn                %>
            <select  class="INPUTS" id="alm" name="alm"  value="" style="text-align:center;width:100%">
                
                <option value="">TODOS</option>
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
        
       
        
    
        <td width="5%" align="right" class="Estilo8"> Lista por:&nbsp;</td>
        <td colspan="4">
            <select  class="INPUTS" id="lis" name="lis" value="" style="text-align:center;width:100%">
                <option value="">TODOS</option>
                <option value="1">Con Stock</option>
                <option value="2">Sin Stock</option>
            </select> 
            </td>
             <td width="10%" colspan="2" rowspan="3" align="right">
            <img src="IMAGES/go1.png" border="0" onclick="MANDA()" onmouseover="this.src='images/go2.png'" id="pima" name="pima" 
              onmouseout="this.src='images/go1.png'" style="cursor:pointer"/></td>
       </tr>
       <tr>
        <td align="right" class="Estilo8" > Estado:&nbsp;</td>
        <td >
             <%  TBL1 = "RSFACCAR..AL" + CIA + "TABL"

                 cad  =  "select TG_CCLAVE, TG_CDESCRI from "&TBL1&"  A WHERE TG_CCOD= '15'   order by 1 " 
                 'RESPONSE.WRITE(CAD)
                rs.open cad,cnn %>
            <select  class="INPUTS" id="edo" name="edo"  value="" style="text-align:center;width:100%">
                
                <option value="">TODOS</option>
                <%if rs.recordcount > 0 then %>
                <%rs.movefirst%>
                <%do while not rs.eof%>
                    <option value='<%=rs("TG_CCLAVE")%>'><%=rs("TG_CDESCRI")%></option>
                    <%RS.MOVENEXT%>
                <%loop%>
                <%end if%>
                <%rs.close%>
            </select> 
                        </select> 
                <option value=""></option>
            </select> 
        </td>
      
         <td align="right" class="Estilo8" > Linea :&nbsp;</td>
        <td width="46%" >
             <%  TBL1 = "RSFACCAR..FT" + CIA + "LINE"
             
                 cad  =  "Select LI_CDESLIN, LI_CCODLIN From "&tbl1&"  order by 1 " 
                 'RESPONSE.WRITE(CAD)
                rs.open cad,cnn %>
            <select  class="INPUTS" id="lin" name="lin"  value="" style="text-align:center;width:100%">
                
                <option value="">TODOS</option>
                <%if rs.recordcount > 0 then %>
                <%rs.movefirst%>
                <%do while not rs.eof%>
                    <option value='<%=rs("LI_CCODLIN")%>'><%=rs("LI_CDESLIN")%></option>
                    <%RS.MOVENEXT%>
                <%loop%>
                <%end if%>
                <%rs.close%>
            </select> 
                        </select> 
                <option value=""></option>
            </select> 
        </td>
         <td width="3%" align="right" class="Estilo8">Excel :</td>
		 <td width="11%"><input type="checkbox" id="exl" name="exl" /></td>
    </tr>

    <tr valign="middle">
        <td align="right" class="Estilo8"> Articulo :&nbsp;</td>
        <td colspan="1" ><input type="text" class="INPUTS" id="cart" name="cart" style="text-align:center" value=""/></td>
        <td align="center"><img src="IMAGES/lupa.png" border="0" onclick="hlpART()" id="img2" name="img2" style="cursor:pointer"/></td>
        <td colspan="3"><input type="text" class="INPUTS" id="dart" name="dart" style="text-align:center; " value=""/>       </td> 
       
  </tr>
</table>


<iframe  width="100%"  style="display:block;vertical-align:top;" src="" id="ingresos" name="ingresos"  scrolling="yes" frameborder="1" height="250" align="middle" ></iframe>


<iframe  width="100%"  style="display:none" src="" id="body0" name="body0"  scrolling="no" frameborder="0" height="20" align="middle"></iframe>
</form>

</body>
<script language="jscript" type="text/jscript">

function buscapr() {

    window.open('HELP/busca_prov_oc.ASP?NOM=' + ltrim(document.all.pr.value))
    return true;
}
function hlpART() {

    window.open('HELP/busca_ARTICULOS.ASP?NOM=' + ltrim(document.all.dart.value))
    return true;
}


function MANDA() {
    if (document.all.exl.checked == true)
        xls = "E"
    else
        xls = ""
    cad = 'REPORTES/PRN_stks.ASP' 
    cad += '?alm=' + trim(document.all.alm.value)
    cad += '&lis=' + trim(document.all.lis.value)
    cad += '&edo=' + trim(document.all.edo.value)
    cad += '&lin=' + trim(document.all.lin.value) 
    cad += '&art=' + trim(document.all.cart.value)
    cad += '&xls=' + xls
 //   alert(cad)
    document.all.ingresos.src = cad
}


</script>

</html>
