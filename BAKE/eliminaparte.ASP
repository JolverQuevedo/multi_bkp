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
<!--#include file="COMUN/COMUNqry.ASP"-->
<script language="jscript" type="text/jscript">
    oldrow = 1
    function llena(t, pos) {
        document.all.deta.value = trim(t.rows(pos).cells(1).innerText);
        var subcadena = Right(trim(t.rows(pos).cells(3).innerText), 4)
        //alert(subcadena)
        var elemento = document.all.anio;
        document.all.anio.selectedIndex = seleindice(subcadena, elemento);
        //document.all.anio.value = Right(trim(t.rows(pos).cells(3).innerText), 4)
        return true
    }
    function dd2(ff) {	// LLENA TEXTBOX ADICIONALES AL COMUN
        // LOS DEL COMUN SON CODIGO Y DESCRIPCION
        var t = document.all.TABLA;
        var pos = parseInt(ff);
        dd(ff);
    }
    function MANDA() {
        if (trim(document.all.anio.value) == '') {
            alert("Por favor indique el anio a buscar")
            return false
        }
        if (trim(document.all.deta.value) == '') {
            alert("Por favor indique el número de documento")
            return false
        }
        cabe = "eliminaparte.asp?op=1&doc=" + trim(document.all.deta.value)
        cabe += '&anio=' + document.all.anio.value
        window.location.replace(cabe)
    }
    </script>
<body onload="javascript: document.all.anio.focus()" >

<table  border="0" cellspacing="6" cellpadding="0" align="center" >
  <tr>
  <td colspan="5" align="left" class="Estilo4">Criterios de Busqueda   </td>
  </tr>
  <tr><td colspan="4">&nbsp;</td>
   <td  align="center" rowspan="3"><img src="IMAGES/go1.png" border="0" onclick="MANDA()" onmouseover="this.src='images/go2.png'" id="ima" name="ima"
  onmouseout="this.src='images/go1.png'" style="cursor:pointer"/></td>
  </tr>
  <tr>
  <td align="left" class="LOG_LABEL" width="100px"> &nbsp; &nbsp; &nbsp;Año </td>
    <td width="60px" >
    <select class="data" id="anio" name="anio" onchange ="javascript:document.all.deta.focus()" style="text-align:center; border:1px solid gainsboro"  >
        <option value=""></option>
        <%for i=2013 to year(date) %>
        <option value ="<%=i%>"><%=i%></option>
        <%next %>
    </select>
    </td>
    <td align="left" class="LOG_LABEL">&nbsp; &nbsp; &nbsp;Número de Documeto</td>  
    <td  width="100px"><input type="text" class="data" id="deta" name="deta" value=""  style="text-align:center;border:1px solid gainsboro;"/></td>
    
   </tr>
   <tr><td>&nbsp;</td></tr>
</table>
<%OP = REQUEST.QueryString("OP") %>
<%IF OP = "" THEN RESPONSE.END%>
<%  anio = REQUEST.QueryString("anio")
    doc = "%" +REQUEST.QueryString("doc")
TBL1 = "RSFACCAR..AL" + CIA + "MOVC"
cad =   " select C5_CALMA, C5_CNUMDOC, C5_CTD,  " & _
        " C5_DFECDOC, c5_ccodmov,C5_CRFTDOC,    " & _
        " C5_CRFNDOC,C5_CGLOSA1,C5_CGLOSA2      " & _
        " from "&TBL1&"                         " & _
        " where C5_CTD in ('PE','PS')           " &  _
        " and year(c5_dfecdoc)= '"&anio&"'      " & _
        " and C5_CNUMDOC like '"&doc&"'         " & _
        " order by C5_CALMA,C5_CNUMDOC ;        "
rs.open cad, cnn
if rs.recordcount <= 0 then  response.End
rs.movefirst
cont = 1%>

<table id="TABLA" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
        <%'**************************%>
        <%'LINEA DE CABECERA STANDAR %>
        <%'**************************%>
        <%LIMITE =  RS.fields.count - 1	%>
        <tr bgcolor=#006699 >
            <%for I=0 to LIMITE %>
	            <td align="center" class="Estilo8"><%=RS.FIELDS(I).NAME%></td>
            <%next%>	
        </tr>
        <%IF  RS.EOF THEN response.end%>
        <%DO WHILE NOT RS.EOF%>
	        <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
                ondblclick="show('<%=(cont)%>')">
	            <%FOR i=0 TO LIMITE%>
		            <td align="center" class="Estilo5"><%=RS.FIELDS.ITEM(I)%></td>
	            <%NEXT%>
	        </tr>
	        <%RS.MOVENEXT%>
	        <%CONT = CONT + 1%>
	        <%LOOP%>
        </table>

    </td>
</tr>
</table>
<script type="text/jscript" language="jscript">
    dd2('1');
function show(ff) {
    var t = document.all.TABLA;
    var pos = parseInt(ff, 10)
    cad  = '?doc=' + document.all.deta.value
    cad += '&ctd=' + trim(t.rows(pos).cells(2).innerText);
    cad += '&alm=' + trim(t.rows(pos).cells(0).innerText);
    cad += '&anio=' + document.all.anio.value
       // alert(trim(t.rows(pos).cells(14).innerText))
    //alert(cad)

    var si
	    {si = confirm("¿ Desea eliminar el Documento \n"+ trim(t.rows(pos).cells(2).innerText) + " --> " +document.all.deta.value+ "\nAlmacén = "+ trim(t.rows(pos).cells(0).innerText) + "?");} 
	    if (si == false)
	    { return false;}

    document.all.dele.src = 'comun/DELE_parte.asp' + cad
    return true;
}



</script>
<iframe  width="100%"  style="display:block;vertical-align:top;" src="" id="dele" name="dele"  scrolling="yes" frameborder="1" height="150" align="middle" ></iframe>
</body>
</html>
