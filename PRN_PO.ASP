 <%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<script type="text/jscript" language="jscript">
    var aCod = Array() 
var oldrow = 1
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

<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link href="multisty.css" rel="stylesheet" type="text/css">
<SCRIPT language="javascript" src="includes/cal.js"></SCRIPT>
</head>
<body >
<%fini = request.QueryString("fini")
alma = request.QueryString("alma")
 %>
<form id="thisForm" method="post" name="thisForm" action="">

<table align="center"  bordercolor="#FFFFFF"  cellpadding="0"  cellspacing="0"  border="1" width="100%">
	<tr class="Estilo4">
        <td align="left" class="Estilo4">Pos sin parte de Entrada</td>
         <td align="right" class="Estilo8" > Almacen :&nbsp;</td>
        <td colspan="6">
<%  TBL1 = "RSFACCAR..AL" + CIA + "ALMA"
    TBL2 = "MULTI..RS_USUALM" + CIA 
cad =   " select a1_calma, a1_calma+space(5)+a1_cdescri as descri from "&tbl1&"  A " & _
        " INNER JOIN "&TBL2&" B ON (A1_CALMA COLLATE Modern_Spanish_CI_AS =CALMA) AND B.CUSUARIO='"&usr&"' order by 1 " 
        'response.write(cad)
rs.open cad,cnn                %>
            <select  class="INPUTS" id="alm" name="alm" value="" style="text-align:center;width:100%">
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
        <td align="right" class="Estilo4" > Fecha : <A href="javascript:showCal('Calendar1')"><img height=16 src="images/cal.gif" width=16 border=0></A></td>
        <td width="240"><input type="text" class="INPUTS" id="ini" name="ini" style="text-align:center" readonly tabindex="-1" 
         value="<%if len(trim(fini))> 0 then response.write(formatdatetime(fini,2)) %>"/>
    
    
    </tr>
</table>
<%
	' DATOS DE CABECERA
    TBL = "POS" + CIA 

    cad =   " SELECT PP.PO,ES.ESTCLI AS ESTILO, right(ES.CODARTICULO,5)+'00000' as ARTICULO, ES.DESCRIPCION,    " & _
            " cl.rsccliente AS CLI, CL.NOMBRE AS CLIENTE,  PP.ESTADO AS EDO, es.CODEST,                         " & _
            " ppo.CANTIDAD, ppo.precio, ppo.id, ppo.pe , PPO.ALM                                                " & _
            " FROM   MODELADOR..POS AS PP                                                                       " & _
            " INNER JOIN MODELADOR..CLIENTE AS CL ON PP.CLIENTE = CL.CODIGO                                     " & _
            " INNER JOIN MODELADOR..ESTILOS AS ES ON pp.CLIENTE = ES.CLIENTE AND pp.codest = ES.CODEST          " & _
            " FULL OUTER JOIN "&TBL&" AS PPO ON PPO.PO = PP.PO                                                  " & _
            " where  PP.ESTADO = 'a'   AND ppo.CANTIDAD!=0 AND ppo.PRECIO!=0                                    " & _
            " AND PP.PO IN (SELECT PO FROM "&TBL&" AS PPPO WHERE PP.PO = PPPO.PO AND PPPO.ESTADO='A')           " & _
            " order by id "
   ' RESPONSE.WRITE(CAD)
        rs.open cad, cnn
 
    
%>
<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>
<table  border="1" cellspacing="1" cellpadding="1" align="left" width="100%">
    <tr class="log_label" align="center">
        <td >PO</td> 
        <td >ESTILO</td>
        <td >CLIENTE</td>
        <td >ARTICULO</td>
        <td>DESCRIPCION</td>
        <td>CANTIDAD</td>
        <td >PRECIO</td>
        <td>CODCLI</td>
        <td>ID</td>
        <td>PE</td>
        <td>ALM</td>
    </tr>
<%i =1
IF RS.RECORDCOUNT > 0 THEN rs.movefirst

DO WHILE NOT RS.EOF %>
<tr id="LIN<%=i%>" name="LIN<%=i%>" ondblclick="parte('<%=i%>')" >      
       <td><input id="POS<%=I%>" name="POS<%=i%>" class="DATA" readonly tabindex="-1" value="<%=RS("PO")%>"                              /></td>
       <td><input id="EST<%=i%>" name="EST<%=i%>" class="DATA" readonly tabindex="-1" value="<%=RS("ESTILO")%>"                         /></td>        
       <td><input id="CLI<%=i%>" name="CLI<%=i%>" class="DATA" readonly tabindex="-1" value="<%=RS("CLIENTE") %>"                        /></td>
       <td><input id="COD<%=i%>" name="COD<%=i%>" class="DATA" readonly tabindex="-1" value="<%=RS("ARTICULO") %>"                      /></td>
       <td><input id="DES<%=i%>" name="DES<%=i%>" class="DATA" readonly tabindex="-1" value="<%=RS("DESCRIPCION")%>"                   /></td>
       <td><input id="CAN<%=i%>" name="CAN<%=i%>" class="inputs" value="<%=formatnumber(RS("CANTIDAD"),0,,true)%>" onchange="graba('<%=i%>')" /></td>
       <td><input id="PRE<%=i%>" name="PRE<%=i%>" class="inputs" value="<%=replace(round(rs("precio"),2),",",".")%>"  style="text-align:right" onchange="graba('<%=i%>')" /></td>
       <td><input id="RUC<%=i%>" name="RUC<%=i%>" class="DATA" readonly tabindex="-1" value="<%=RS("CLI")%>"                            /></td> 
       <td><input id="ID<%=i%>" name="ID<%=i%>" class="DATA" readonly tabindex="-1" value="<%=RS("id")%>"                            /></td> 
       <td><input id="PE<%=i%>" name="PE<%=i%>" class="DATA" readonly tabindex="-1" value="<%=RS("pe")%>"                            /></td> 
       <td><input id="AL<%=i%>" name="AL<%=i%>" class="DATA" readonly tabindex="-1" value="<%=RS("ALM")%>"                            /></td> 
    </tr>
    <%i = i + 1 %>
    <%RS.MOVENEXT %>
<%LOOP %>
<tr style="display:block" id="LIN<%=i%>" name="LIN<%=i%>" >
        <td><input id="POS<%=i%>" name="POS<%=i%>" value="" class="inputs" onfocus="lineas('<%=i%>')" onchange="BAKE('<%=i%>')"  /></td>
        <td><input id="EST<%=i%>" name="EST<%=i%>" value="" class="bakes" ondblclick="help('<%=i%>')" onfocus="lineas('<%=i%>')" /></td>
        <td><input id="CLI<%=i%>" name="CLI<%=i%>" value=""  class="DATA" readonly tabindex="-1"/></td>        
        <td><input id="COD<%=i%>" name="COD<%=i%>" value="" class="data" style="text-align:left"  readonly tabindex="-1"/></td>
        <td><input id="DES<%=i%>" name="DES<%=i%>" value="" class="data" style="text-align:right" readonly tabindex="-1"/></td>
        <td><input id="CAN<%=i%>" name="CAN<%=i%>" value="" class="INPUTS" style="text-align:right"  onkeyup="this.value = toInt(this.value)" /></td>
        <td><input id="PRE<%=i%>" name="PRE<%=i%>" value="" class="inputs"  /></td>
        <td><input id="RUC<%=i%>" name="RUC<%=i%>" value="" class="data" style="text-align:right" readonly tabindex="-1"/></td>
        <td><input id="ID<%=i%>" name="ID<%=i%>" value="" class="data" style="text-align:right" readonly tabindex="-1"/></td>
        <td><input id="PE<%=i%>" name="PE<%=i%>" value="" class="data" style="text-align:right" readonly tabindex="-1"/></td>
        <td><input id="AL<%=i%>" name="AL<%=i%>" value="" class="data" style="text-align:right" readonly tabindex="-1"/></td>
    </tr>

<%cont = i+1%>
    <%for i=cont to cont  %>
    <tr style="display:none" id="LIN<%=i%>" name="LIN<%=i%>" >
        <td><input id="POS<%=i%>" name="POS<%=i%>" value="" class="inputs" onfocus="graba('<%=i-1%>')" onchange="BAKE('<%=i%>')" /></td>
        <td><input id="EST<%=i%>" name="EST<%=i%>" value="" class="bakes"  onfocus="graba('<%=i-1%>')" /></td>
        <td><input id="CLI<%=i%>" name="CLI<%=i%>" value=""  class="DATA" readonly tabindex="-1"/></td>        
        <td><input id="COD<%=i%>" name="COD<%=i%>" value="" class="data" style="text-align:left"  readonly tabindex="-1" /></td>
        <td><input id="DES<%=i%>" name="DES<%=i%>" value="" class="data" style="text-align:right" readonly tabindex="-1"/></td>
        <td><input id="CAN<%=i%>" name="CAN<%=i%>" value="" class="INPUTS" style="text-align:right"  onkeyup="this.value = toInt(this.value)"  onfocus="graba('<%=i-1%>')" /></td>
        <td><input id="PRE<%=i%>" name="PRE<%=i%>" value="" class="inputs"  onfocus="graba('<%=i-1%>')" /></td>
        <td><input id="RUC<%=i%>" name="RUC<%=i%>" value=""  class="DATA" readonly tabindex="-1"/></td>  
        <td><input id="ID<%=i%>" name="ID<%=i%>" value=""  class="DATA" readonly tabindex="-1"/></td> 
        <td><input id="PE<%=i%>" name="PE<%=i%>" value=""  class="DATA" readonly tabindex="-1"/></td> 
        <td><input id="AL<%=i%>" name="AL<%=i%>" value=""  class="DATA" readonly tabindex="-1"/></td>
    </tr>

    <%next %>
<tr><td colspan="11" align="center"><img src="IMAGES/print1.png" border="0" onclick="previu()" id="prn" name="prn" alt="Preview del Grid" style="cursor:pointer"/>
<img src="IMAGES/kill.png" border="0" onclick="dele()" id="Img1" name="prn" alt="elimina todos los registros en bloque" style="cursor:pointer"/></td></tr>
</table>

<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe>

<script type="text/jscript" language="jscript">
addCalendar("Calendar1", "Elija una fecha", "ini", "thisForm")

var TOPE= parseInt('<%=I-1%>',10)
eval("document.all.POS"+TOPE+".focus()")
var opc  = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no," ;
	opc += "menubar=no,resizable=yes,scrollbars=yes,left=50,top=50,height=600,width=900" ;

var subcadena = '<%=trim(ucase(alma))%>'
	//alert(subcadena)
	var elemento = document.all.alm;
	document.all.alm.selectedIndex = seleindice(subcadena, elemento);


function dele() {
/*	   document.all.body0.style.display = 'block'
	    document.all.body0.height = "150"
	    document.all.body0.width = "100%"

  */
    document.all.body0.src = ('comun/dele_pos.asp') }

function previu()
	{ window.open('reportes/pos_pendientes.asp','',opc)}

function help(op) {   	    
    CAD = "help/hlp_pos.asp?est=" + ltrim(eval("document.all.EST" + op + ".value")) + '&op=' + op
    window.open (CAD,"",opc)
    //alert(CAD)   
	    return true;
}

function BAKE(op) {
    op = parseInt(op,10)
    CAD = ltrim(eval("document.all.POS" + op + ".value")) + '&op=' + op
/*
	    document.all.body10.style.display = 'block'
	    document.all.body10.height = "150"
	    document.all.body10.width = "100%"
	*/   
	    
	    //alert(CAD)
	    document.all.body10.src = "bake/bake_pos.asp?pos=" + CAD;
		
	    //document.all.body10.style.display = 'none'

	    return true;
	}
function graba(op) {
    CAD = ltrim(eval("document.all.POS" + op + ".value")) + '&op=' + op
    CAD += '&CAN=' + eval("window.document.all.CAN" + op + ".value")
    CAD += '&PRE=' + eval("window.document.all.PRE" + op + ".value")
    CAD += '&ID=' + eval("window.document.all.ID" + op + ".value")
    
       // alert(CAD)
         document.all.body0.src = "comun/inserpos.asp?pos=" + CAD;
         //document.all.body0.style.display = 'none'
     return true;
 }

function lineas(op)
{   op = parseInt(op,10)
    if (op < TOPE)
    {   op++
        eval("document.all.LIN"+op+".style.display='block'")
    }
}
function parte(op) {
op = parseInt(op,10)

    if (document.all.alm.value == '') {
        alert("Favor indicar el almacén de destino")
        return false;
    }

    if (document.all.ini.value == '') {
        alert("Favor indicar la fecha")
        return false;
    }
    obj = eval("document.all.LIN" + op) 
    
    obj.bgColor='#ccc'
    nro = trim(eval("window.document.all.PE" + op + ".value"))
    alm = trim(eval("window.document.all.AL" + op + ".value"))
    cod = trim(eval("window.document.all.COD" + op + ".value"))
    id = trim(eval("window.document.all.ID" + op + ".value")) 
   // alert('<%=cia %>')
    //alert("parte de ingreso")
    ccc = 'parte_entrada.asp?fini=' + trim(document.all.ini.value) + '&alma=' + document.all.alm.value + '&op=' + op + '&nro=' + nro + '&ALM=' + alm
    ccc += '&can=' + eval("window.document.all.CAN" + op + ".value") + '&cod=' + cod + '&id='+ id
    window.open(ccc,'PE_Head', opc)
   // window.location.replace('prn_po.asp?fini=' + trim(document.all.ini.value) + '&alma=' + document.all.alm.value)
    return true;

}



</script>
<%RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>