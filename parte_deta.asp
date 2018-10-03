<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057
 %>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link href="multisty.css" rel="stylesheet" type="text/css">
<SCRIPT language="javascript" src="includes/cal.js"></SCRIPT>
</head>
<body >

<%pe = request.QueryString("pe")
  al = request.QueryString("al")
  cn = round(request.QueryString("cAn"),0)
  cd = request.QueryString("cod")
  id = request.QueryString("idd")

  Set RS2 = Server.CreateObject("ADODB.Recordset")
      RS2.ActiveConnection = Cnn
      RS2.CursorType       = 3 'CONST adOpenStatic = 3
      RS2.LockType         = 1 'CONST adReadOnly = 1
      RS2.CursorLocation   = 3 'CONST adUseClient = 3

%>
<form id="thisForm" method="post" name="thisForm" action="">
<%  TBL1 = "RSFACCAR..AL" + CIA + "MOVC"
    TBL2 = "RSFACCAR..AL" + CIA + "MOVD"
    TBL3 = "RSFACCAR..AL" + CIA + "ARTI"
    TBL4 = "MULTI..POS" + CIA

cad1 = " select * from "&TBL1&" where C5_CALMA = '"&al&"' and C5_CTD = 'pe' and C5_CNUMDOC= '"&pe&"' " 
cad2 = " select * from "&TBL2&" AS DD INNER JOIN "&TBL3&" AS AA ON  AA.AR_CCODIGO = DD.C6_CCODIGO " & _
       " where C6_CALMA = '"&al&"' and C6_CTD = 'pe' and C6_CNUMDOC= '"&pe&"' order by C6_CITEM; "
CAD3 = "SELECT * FROM "&TBL4&" WHERE ID = "&ID&" "
'response.write(cad1)
rs.open cad1,cnn                

%>

<form name="thisForm" METHOD="post" >
<table  border="1" cellspacing="1" cellpadding="0" align="center" width="100%" style="background-color:#A3B87A" >
    <tr valign="middle" class="data">
        <td align="right"  width="10%">&nbsp;Entrada :&nbsp;</td>
        <td width="5%"><input class="data" id="ent" name="ent" value="E" readonly tabindex="-1"></td>
        <td align="right" width="15%">&nbsp; Movimiento :&nbsp;</td>
        <td width="5%"> 
            <%tt1 = "RSFACCAR..AL"+cia+"TABM"
            movi = rs("C5_CCODMOV")
            cad =   " Select tm_ccodmov ,tm_cdescri From "&tt1&" Where TM_CTIPMOV='E' and tm_ccodmov = '"&movi&"'" 
           ' response.write(cad)
            RS2.OPEN CAD, CNN  
            rs2.movefirst   %>
            <input type="text"  class="data" id="tdm" name="tdm" value="<%=movi%>" readonly tabindex="-1"/>
        </td>
        <td width="40%" colspan="2"><input class="data" id="movi" name="movi" value="<%=ucase(trim(rs2("tm_cdescri")))%>" readonly tabindex="-1"></td>
        <%rs2.close%>
        <td align="right"  width="10%">&nbsp;Parte Nro. :&nbsp;</td>
        <td width="10%"><input class="data" id="pe" name="pe" value="<%=pe%>" readonly tabindex="-1"></td>
    </tr>
    <tr class="data">
        <td align="right" >&nbsp;Fec Doc :&nbsp;</td>
        <td colspan="2"><input class="data" id="fec" name="fec" value="<%=formatdatetime(rs("c5_dfecdoc"),2)%>" readonly tabindex="-1"></td>
        <td align="right" >&nbsp;</td>
        <td align="right" >&nbsp;Can PO :&nbsp;</td>
        <td><input class="data" id="cnp" name="cnp" style="text-align:right" value="<%=cn%>" readonly tabindex="-1"></td>
        <td align="right" >&nbsp;Cantidad :&nbsp;</td>
        <%cad = " select ISNULL(sum(isnull(c6_ncantid,0)),0) as tota from "&TBL2&" where C6_CALMA = '"&al&"' and C6_CTD = 'pe' and C6_CNUMDOC= '"&pe&"'" 
        RS2.OPEN CAD, CNN
        'RESPONSE.WRITE(CAD)
        IF RS2.RECORDCOUNT > 0 THEN TOTA = CDBL(RS2("TOTA")) ELSE TOTA = 0%>
        <%rs2.close%>
        <td><input class="data" id="can" name="can" style="text-align:right" value="<%=Tota%>" readonly tabindex="-1"></td>
    </tr> 
</table>

<% RS2.OPEN CAD3, CNN
IF RS2.RECORDCOUNT <=0 THEN 
    RESPONSE.WRITE("NO SE COLOCO PRECIO EN LA PANTALLA INICIAL")
    PRECIO = 0
ELSE 
    PRECIO = REPLACE(RS2("PRECIO"),",",".")
    sty = rs2("ESTILO")
END IF

cencos = rs("c5_ccencos")
RS.CLOSE
	' DATOS DE DETALLE
    rs.open cad2, cnn
' RESPONSE.WRITE (CAD2)
    
%>
<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>
<table  border="0" cellspacing="0" cellpadding="1" align="left" width="100%">
<tr><td width="100%">
<table  border="1" cellspacing="0" cellpadding="1" align="left" width="100%" >   
    <tr class="DATA" align="center" style="background-color: #f68b21; font-size:8px">
        <td width="5%">LIN</td>
        <td width="8%">CODIGO</td> 
        <td width="30%" >DESCRIPCION</td>
        <td width="3%">UNI</td>
        <td width="4%">CEN COS</td>
        <td width="3%">ORDEN/STY</td>
        <td width="3%">CANTIDAD</td>
        <td width="5%">PREC UN</td>
        <td width="9%" colspan="2" style="text-align:center;">&nbsp;&nbsp;DCT 1<br />%&nbsp;&nbsp;&nbsp;USD</td>
        <td width="9%" colspan="2" style="text-align:center;">&nbsp;&nbsp;DCT 2<br />%&nbsp;&nbsp;&nbsp;USD</td>
        <td width="9%" colspan="2" style="text-align:center;">&nbsp;&nbsp;DCT 3<br />%&nbsp;&nbsp;&nbsp;USD</td>
        <td width="9%" colspan="2" style="text-align:center;">&nbsp;&nbsp;DCT 4<br />%&nbsp;&nbsp;&nbsp;USD</td>
        <td width="5%">VALOR TOTAL</td>
    </tr>
<%i =1
IF RS.RECORDCOUNT > 0 THEN rs.movefirst

DO WHILE NOT RS.EOF %>
<tr id="LIN<%=i%>" name="LIN<%=i%>" class="DATA" >      
       <td><input id="ITM<%=I%>" name="ITM<%=i%>" class="DATA"   value="<%=RS("C6_CITEM")%>"   readonly tabindex="-1"   /></td>
       <td><input id="COD<%=i%>" name="COD<%=i%>" class="DATA"   value="<%=RS("C6_CCODIGO")%>" readonly tabindex="-1"  /></td>
       <td><input id="DES<%=i%>" name="DES<%=i%>" class="DATA"   value="<%=RS("C6_CDESCRI")%>" readonly tabindex="-1"  /></td>        
       <td><input id="UNI<%=i%>" name="UNI<%=i%>" class="DATA"   value="<%=RS("AR_CUNIDAD")%>"readonly tabindex="-1"  /></td>
       <td><input id="COS<%=i%>" name="COS<%=i%>" class="DATA"   value="<%=RS("C6_CCENCOS")%>" readonly tabindex="-1"  /></td>
       <td><input id="COR<%=i%>" name="COR<%=i%>" class="DATA"   value="<%=RS("C6_CORDEN")%>"  readonly tabindex="-1"  /></td>
       <td><input id="CAN<%=i%>" name="CAN<%=i%>" class="inputs" value="<%=RS("C6_NCANTID")%>" onChange="calcula('<%=i%>');graba('<%=i%>')" /></td>
       <td><input id="PRE<%=i%>" name="PRE<%=i%>" class="inputs" value="<%=RS("C6_NPREUNI")%>" onChange="calcula('<%=i%>');graba('<%=i%>')" /></td>
       <td width="4%"><input id="PD1<%=i%>" name="PD1<%=i%>" class="inputs" value="<%=RS("C6_NPORDE1")%>"   /></td> 
       <td width="4%"><input id="IM1<%=i%>" name="ID1<%=i%>" class="DATA"   value="<%=RS("C6_NIMPO1")%>"  readonly tabindex="-1"     /></td> 
       <td width="4%"><input id="PD2<%=i%>" name="PD2<%=i%>" class="inputs" value="<%=RS("C6_NPORDE2")%>"   /></td> 
       <td width="4%"><input id="ID2<%=i%>" name="ID2<%=i%>" class="DATA"   value="<%=RS("C6_NIMPO2")%>"  readonly tabindex="-1"   /></td> 
       <td width="4%"><input id="PD3<%=i%>" name="PD3<%=i%>" class="inputs" value="<%=RS("C6_NPORDE3")%>"  />%</td>      
       <td width="4%"><input id="ID3<%=i%>" name="ID3<%=i%>" class="DATA"   value="<%=RS("C6_NIMPO3")%>"  readonly tabindex="-1"     /></td> 
       <td width="4%"><input id="PD4<%=i%>" name="PD4<%=i%>" class="inputs" value="<%=RS("C6_NPORDE4")%>"   /></td>    
       <td width="4%"><input id="ID4<%=i%>" name="ID4<%=i%>" class="DATA"   value="<%=RS("C6_NIMPO4")%>"  readonly tabindex="-1"    /></td> 
       <td><input id="TOT<%=i%>" name="TOT<%=i%>" class="DATA"   value="<%=(RS("C6_NVALTOT"))%>" readonly tabindex="-1"    /></td> 
    </tr>
    <%i = i + 1 %>
    <%RS.MOVENEXT %>
<%LOOP %>
<tr style="display:block" id="LIN<%=i%>" name="LIN<%=i%>" class="DATA" >
       <td><input id="ITM<%=I%>" name="ITM<%=i%>" class="DATA"   value='<%=right("0000"&i,4)%>'readonly tabindex="-1"   /></td>
       <td><input id="COD<%=i%>" name="COD<%=i%>" class="bakes" value="" onFocus="lineas('<%=i%>')" onChange="BAKE('<%=i%>')" onDblClick="help('<%=i%>')" /></td>
       <td><input id="DES<%=i%>" name="DES<%=i%>" class="DATA"   value="" readonly tabindex="-1"  /></td>        
       <td><input id="UNI<%=i%>" name="UNI<%=i%>" class="DATA"   value="" readonly tabindex="-1"  /></td>
       <td><input id="COS<%=i%>" name="COS<%=i%>" class="DATA"   value="<%=cencos%>" readonly tabindex="-1"  /></td>
       <td><input id="COR<%=i%>" name="COR<%=i%>" class="DATA"   value="<%=STY%>" readonly tabindex="-1"  /></td>
       <td><input id="CAN<%=i%>" name="CAN<%=i%>" class="inputs" value="" onkeyup="this.value = toInt(this.value)" maxlength=6 onblur="calcula('<%=i%>')"/></td>
       <td><input id="PRE<%=i%>" name="PRE<%=i%>" class="inputs" value="<%=PRECIO%>"readonly tabindex="-1"  /></td>
       <td width="4%"><input id="PD1<%=i%>" name="PD1<%=i%>" class="inputs" value=""  onblur="calcula('<%=i%>')"    /></td> 
       <td width="4%"><input id="IM1<%=i%>" name="ID1<%=i%>" class="DATA"   value="" readonly tabindex="-1"      /></td> 
       <td width="4%"><input id="PD2<%=i%>" name="PD2<%=i%>" class="inputs" value="" onblur="calcula('<%=i%>')"   /></td>   
       <td width="4%"><input id="ID2<%=i%>" name="ID2<%=i%>" class="DATA"   value=""   readonly tabindex="-1"    /></td> 
       <td width="4%"><input id="PD3<%=i%>" name="PD3<%=i%>" class="inputs" value=""  onblur="calcula('<%=i%>')"  /></td> 
       <td width="4%"><input id="ID3<%=i%>" name="ID3<%=i%>" class="DATA"   value=""  readonly tabindex="-1"     /></td> 
       <td width="4%"><input id="PD4<%=i%>" name="PD4<%=i%>" class="inputs" value=""  onblur="calcula('<%=i%>')"   /></td>     
       <td width="4%"><input id="ID4<%=i%>" name="ID4<%=i%>" class="DATA"   value=""   readonly tabindex="-1"    /></td> 
       
       <td><input id="TOT<%=i%>" name="TOT<%=i%>" class="DATA"   value=""   readonly tabindex="-1"    /></td> 
    </tr>
<%cont = i+1%>
    <%for i=cont to cont  %>
    <tr style="display:none" id="LIN<%=i%>" name="LIN<%=i%>" class="DATA" >
       <td><input id="ITM<%=I%>" name="ITM<%=i%>" class="DATA"   value='<%=right("0000"&i,4)%>'readonly tabindex="-1"   /></td>
       <td><input id="COD<%=i%>" name="COD<%=i%>" class="bakes"  value="" onFocus="graba('<%=i-1%>')" /></td>
       <td><input id="DES<%=i%>" name="DES<%=i%>" class="DATA"   value="" readonly tabindex="-1"  /></td>        
       <td><input id="UNI<%=i%>" name="UNI<%=i%>" class="DATA"   value="" readonly tabindex="-1"  /></td>
       <td><input id="COS<%=i%>" name="COS<%=i%>" class="DATA"   value="" readonly tabindex="-1"  /></td>
       <td><input id="COR<%=i%>" name="COR<%=i%>" class="DATA"   value="" readonly tabindex="-1"  /></td>
       <td><input id="CAN<%=i%>" name="CAN<%=i%>" class="inputs" value=""  /></td>
       <td><input id="PRE<%=i%>" name="PRE<%=i%>" class="inputs" value="<%=PRECIO%>"  /></td>
       <td><input id="PD1<%=i%>" name="PD1<%=i%>" class="inputs" value=""  /></td> 
       <td><input id="IM1<%=i%>" name="ID1<%=i%>" class="DATA"   value=""   readonly tabindex="-1"    /></td> 
       <td><input id="PD2<%=i%>" name="PD2<%=i%>" class="inputs" value=""   /></td>    
       <td><input id="ID2<%=i%>" name="ID2<%=i%>" class="DATA"   value=""   readonly tabindex="-1"    /></td> 
       <td><input id="PD3<%=i%>" name="PD3<%=i%>" class="inputs" value=""   /></td>   
       <td><input id="ID3<%=i%>" name="ID3<%=i%>" class="DATA"   value=""   readonly tabindex="-1"    /></td> 
       <td><input id="PD4<%=i%>" name="PD4<%=i%>" class="inputs" value=""   /></td>    
       <td><input id="ID4<%=i%>" name="ID4<%=i%>" class="DATA"   value=""   readonly tabindex="-1"    /></td> 
       <td><input id="TOT<%=i%>" name="TOT<%=i%>" class="DATA"   value=""   readonly tabindex="-1"    /></td> 
    </tr>
    <%next %>
</table>
<tr>
    <td>
        <center><img src="IMAGES/print1.png" border="0" onClick="previu()" id="prn" name="prn" alt="Preview del Grid" style="cursor:pointer"/>
        <img src="IMAGES/kill.png" border="0" onClick="dele()" id="Img1" name="prn" alt="elimina todos los registros en bloque" style="cursor:pointer"/></center>
    </td>
</tr>
</table>


<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe>

<script type="text/jscript" language="jscript">
cd = '<%=cd%>'
var TOPE= parseInt('<%=I-1%>',10)
eval("document.thisForm.COD" + TOPE + ".focus()")

var opc  = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no," ;
	opc += "menubar=no,resizable=yes,scrollbars=yes,left=50,top=50,height=600,width=900" ;

id = '<%=trim(id)%>'

function previu()
	{ window.open('reportes/pos_pendientes.asp','',opc)}

function help(op) {
	   	    
    CAD = "help/hlp_cod.asp?cod=" + Left(cd,5) + '&op=' + op
    window.open (CAD,"",opc)
    //alert(CAD)   
    cant = trim(eval("document.all.CAN" + op + ".value"))
    if (cant.length > 0)
        calcula(op)

	    return true;
	}

	function BAKE(op) {
op = parseInt(op,10)
    CAD = ltrim(eval("document.all.COD" + op + ".value")) + '&op=' + op
	    document.all.body10.src = "bake/bake_cod.asp?pos=" + CAD;
	    cant = trim(eval("document.all.CAN" + op + ".value"))
	    if (cant.length > 0)
	        calcula(op)
	    return true;
	}

function graba(op) {
	op = parseInt(op, 10)
	var aCod = Array()
	var aCan = Array()
	var aPre = Array()
	var aPc1 = Array()
	var aPc2 = Array()
	var aPc3 = Array()
	var aPc4 = Array()
    var aDc1 = Array()
    var aDc2 = Array()
	var aDc3 = Array()
	var aDc4 = Array()
	var aTot = Array()

    for (y = 1; y <= op; y++) {
        aCod[y] = eval("window.document.all.COD" + y + ".value")
        aCan[y] = eval("window.document.all.CAN" + y + ".value")
        aPre[y] = eval("window.document.all.PRE" + y + ".value")
        aPc1[y] = eval("window.document.all.PD1" + y + ".value")
        aDc1[y] = eval("window.document.all.ID1" + y + ".value")
        aPc2[y] = eval("window.document.all.PD2" + y + ".value")
        aDc2[y] = eval("window.document.all.ID2" + y + ".value")
        aPc3[y] = eval("window.document.all.PD3" + y + ".value")
        aDc3[y] = eval("window.document.all.ID3" + y + ".value")
        aPc4[y] = eval("window.document.all.PD4" + y + ".value")
        aDc4[y] = eval("window.document.all.ID4" + y + ".value") 
        aTot[y] = eval("window.document.all.TOT" + y + ".value") 
    }

    cad  = 'comun/inserped.asp?alm=' + trim('<%=al%>')
    cad += '&pe=' + trim('<%=pe%>') + '&atot=' + aTot 
    cad += '&acod=' + aCod + '&acan=' + aCan + '&apre=' + aPre 
    cad += '&apc1=' + aPc1 + '&adc1=' + aDc1
    cad += '&apc2=' + aPc2 + '&adc2=' + aDc2
    cad += '&apc3=' + aPc3 + '&adc3=' + aDc3
    cad += '&apc4=' + aPc4 + '&adc4=' + aDc4
    cad += '&totpo=' + '<%=Request.QueryString("can") %>'
    cad += '&idd=' + '<%=Request.QueryString("idd") %>'
    cad += '&cd=' + '<%=Request.QueryString("cod") %>'
    document.all.body10.style.display = 'block'
    document.all.body10.height = "350"
    document.all.body10.width = "100%"
     
      //  alert(CAD)
         document.all.body10.src = cad
         //document.all.body10.style.display = 'none'

     return true;
 }

function lineas(op)
{   op = parseInt(op,10)
    if (op < TOPE)
        {   op++
            eval("document.all.LIN"+op+".style.display='block'")
        }
}

function calcula(op) {
    op = parseInt(op,10)
    if (eval("document.all.COD"+op+".value") == '') {
        alert("Favor indicar el codigo de la prenda")
        return false;
    }

    cant = trim(eval("document.all.CAN" + op + ".value"))
    if (cant.length == 0)
        return false;

    tot = parseInt(cant, 10) * parseFloat('<%=precio%>')

    pd1 = trim(eval("document.all.PD1" + op + ".value"))
    if (pd1.length > 0) {
        dc1 = parseFloat(pd1) / 100
        dc1 = parseFloat(dc1) * parseFloat(tot)
        eval("document.all.ID1" + op + ".value=cerea(dc1,2)")
        tot = parseFloat(tot) - parseFloat(dc1)
    }

    pd2 = trim(eval("document.all.PD2" + op + ".value"))
    if (pd2.length > 0) {
        dc2 = parseFloat(pd2) / 100
        dc2 = parseFloat(dc2) * parseFloat(tot)
        eval("document.all.ID2" + op + ".value=cerea(dc2,2)")
        tot = parseFloat(tot) - parseFloat(dc2)
    }

    pd3 = trim(eval("document.all.PD3" + op + ".value"))
    if (pd3.length > 0) {
        dc3 = parseFloat(pd3) / 100
        dc3 = parseFloat(dc3) * parseFloat(tot)
        eval("document.all.ID3" + op + ".value=cerea(dc3,2)")
        tot = parseFloat(tot) - parseFloat(dc3)
    }

    pd4 = trim(eval("document.all.PD4" + op + ".value"))
    if (pd4.length > 0) {
        dc4 = parseFloat(pd4) / 100
        dc4 = parseFloat(dc4) * parseFloat(tot)
        eval("document.all.ID4" + op + ".value=cerea(dc4,2)")
        tot = parseFloat(tot) - parseFloat(dc4)
    }
    eval("document.all.TOT" + op + ".value=cerea(tot,2)")
    canti = 0
    for (y = 1; y <= op; y++) {
        if (trim(eval("window.document.all.CAN" + y + ".value")) != '')
            canti += parseInt(eval("window.document.all.CAN" + y + ".value"),10)
    }
    window.document.all.can.value = canti

    if (parseInt(canti, 10) > parseInt(document.all.cnp.value, 10)) {
        alert("La cantidad de la PO es " + parseInt(document.all.cnp.value, 10))
        eval("document.all.CAN" + op + ".value=0")

        return false;
    }
    else {
        var si
        { si = confirm("La cantidad de la PO es " + parseInt(document.all.cnp.value, 10)); }
        if (si == false)
        { return false; }
      
    }
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