<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
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
<%  tip = Request.QueryString("tip")
IF TIP = "E" THEN tipo = "INGRESOS" ELSE TIPO = "SALIDAS"
    ope= Request.QueryString("ope")
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
    ' DATOS DE CABECERA
    cad =   " EXEC FICHAMOV_HEAD '"&ope&"','"&TIP&"'  "
        rs.open cad, cnn
    IF RS.RECORDCOUNT > 0 THEN     rs.movefirst
    'RESPONSE.END
dim aUni()
dim aDuni() 
REDIM PRESERVE AUNI(0)
REDIM PRESERVE AdUNI(0)
	CAD =	" SELECT  CODIGO as UNI, descripcion as DES	" & _
            " from unidades where ESTADO = 'A' ORDER BY des		"
                         
        rs2.OPEN CAD, Cnn 
                          
        if rs2.recordcount <=0 then
            adUni(ubound(adUni))=  "No Hay unidades Registradas"
            aUni(ubound(AUNI)) = ""
        else
            rs2.movefirst
            do while not rs2.eof
                REDIM PRESERVE AUNI(ubound(auni)+1)
                REDIM PRESERVE AdUNI(ubound(aduni)+1)
                aUni(ubound(aUni)) = rs2("UNI")
                adUni(ubound(aDuni)) = rs2("DES")
                rs2.movenext
            loop
        end if 
        RS2.CLOSE
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="tintocss.CSS" />
</head>
<body onload="document.all.PRO.focus()">
<form id="thisForm" method="post" name="thisForm" action="comun/inserFICHAMOV.asp">
<table align="center" cellpadding="0" cellspacing="0"  bordercolor="#FFFFFF"  border="0" width="100%">
    <tr>
        <td width="20%"><img src="images/OUT.PNG" style="cursor:pointer;" onClick="window.close()" /></td>	
        <td align="center" >
            <table align="center" cellpadding="7" cellspacing="1"  bordercolor="<%=application("borde") %>"  border="1">
                <tr><td class="Estilo8">MOVIMIENTOS&nbsp;-&nbsp;<%=TIPO %></td></tr>
            </table>    
        </td>
         <td align="RIGHT" width="20%"><img id="Img3" alt="GRABA CAMBIOS" style="cursor:pointer; " onClick="graba(1)" src="images/rec.png" />
	     </td>
    </tr>
</table>
<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>
<input id="veri" name="veri" value="0" style="display:none">

<br />

<table id="TABLA" align="center" bordercolor="<%=application("borde") %>" bgcolor="<%=application("color2") %>"  cellpadding="2" cellspacing="1" border="1">
    <tr valign="middle">
    <td bgcolor="<%=(Application("BARRA"))%>" class="etiqueta" width="5%">OPERACION #:</td>
    <td width="10%"><input type="text" id="OPE" name="OPE" value="<%=RS("OPE")%>" class="INPUTS" maxlength="10" readonly tabindex="-1"  /></td>

         <td bgcolor="<%=(Application("BARRA"))%>" class="etiqueta" width="8%">PROVEEDOR:</td>  
        <%CAD = "select RUC, NOMBRE from PROVEEDORES where ESTADO ='A' order by 2"
        ' RESPONSE.Write(CAD)%>  
        <td width="20%" colspan="3"><select id="PRO" name="PRO" class="INPUTS">
        <option value=""></option>
        <%rs2.open CAD , cnn
                  
        if rs2.recordcount >0 then
        rS2.movefirst %>
        <%DO WHILE NOT RS2.EOF%>
            <option value="<%=rs2("RUC")%>" ><%=rs2("NOMBRE")%></option>
        <%RS2.MOVENEXT%>
        <%LOOP %>
                    
        <%END IF %>
        <%RS2.CLOSE %>
        </select>
        </td>
        <td bgcolor="<%=(Application("BARRA"))%>" class="etiqueta" width="5%">MONEDA:</td> 
        <td width="20%">
        <select id="MON" name="MON" class="INPUTS">
            <option value=""></option>
            <%CAD = "select CODIGO, DESCRIPCION from MONEDAS where ESTADO = 'A' order by 2"
            rs2.open CAD , cnn     
            if rs2.recordcount >0 then
            rS2.movefirst %>
            <%DO WHILE NOT RS2.EOF%>
                <option value="<%=rs2("codigo")%>" ><%=rs2("DESCRIPCION")%></option>
            <%RS2.MOVENEXT%>
            <%LOOP %>
                    
            <%END IF %>
            <%RS2.CLOSE %>
        </select>
    </td>

    </tr>
    <tr>
     <td bgcolor="<%=(Application("BARRA"))%>" class="etiqueta" width="5%">F. Doc :</td>
     <%IF LEN(TRIM(RS("FECMOV"))) > 0 THEN FECMOV = FORMATDATETIME(RS("FECMOV"),2) ELSE FECMOV = "" %>
    <td width="10%"><input type="text" id="FECMOV" name="FECMOV" value="<%=FECMOV%>" class="INPUTS" maxlength="10"  onblur="validaFecha()" /></td>

       <td bgcolor="<%=(Application("BARRA"))%>" class="etiqueta" width="10%">MOTIVO:</td>  
        <%CAD = "select CODIGO, DESCRIPCION from TIPMOV where TIPO = '"&TIP&"' AND ESTADO = 'A' order by 2"
        ' RESPONSE.Write(CAD)%>  
        <td width="20%" colspan="1"><select id="MOV" name="MOV" class="INPUTS">
        <option value=""></option>
        <%rs2.open CAD , cnn        
        if rs2.recordcount >0 then
        rS2.movefirst %>
        <%DO WHILE NOT RS2.EOF%>
            <option value="<%=rs2("codigo")%>" ><%=rs2("DESCRIPCION")%></option>
        <%RS2.MOVENEXT%>
        <%LOOP %>
                    
        <%END IF %>
        <%RS2.CLOSE %>
        </select>
        </td>
    
    <td bgcolor="<%=(Application("BARRA"))%>" class="etiqueta" width="10%">TIP DOC:</td>  
    <td width="20%">
        <select id="DOC" name="DOC" class="INPUTS">
            <option value=""></option>
            <%CAD = "select DOC AS CODIGO, DESDOC AS DESCRIPCION from view_motdoc where  LEFT(MOT,1)= '"&TIP&"' order by 2"
            rs2.open CAD , cnn     
            if rs2.recordcount >0 then
            rS2.movefirst %>
            <%DO WHILE NOT RS2.EOF%>
                <option value="<%=rs2("codigo")%>" ><%=rs2("DESCRIPCION")%></option>
            <%RS2.MOVENEXT%>
            <%LOOP %>
                    
            <%END IF %>
            <%RS2.CLOSE %>
        </select>
    </td>
    <td bgcolor="<%=(Application("BARRA"))%>" class="etiqueta" width="5%">DOC #:</td>
   
    <td width="8%"><input type="text" id="NUME" name="NUME" value="<%=RS("NUMDOC")%>" class="INPUTS" maxlength="18" /></td>
    </tr>  
</table>                  
<br />
<table  border="1" cellspacing="1" cellpadding="1" align="left" width="100%">
    <tr style="background-color:'<%=application("barra")%>'; text-align:center  ">
        <td style="width:01%" class="Etiqueta_LIMON">IT</td>
        <td style="width:07%" class="Etiqueta_LIMON">CODIGO</td>
        <td style="width:35%" class="Etiqueta_LIMON">DESCRIPCION</td>
        <td width"5%"  <%IF TIP = "E" THEN %> style="display:none" <%END IF %> class="Etiqueta_LIMON">Kg/ml</td>
        <td width="5%" <%IF TIP = "E" THEN %> style="display:none" <%END IF %> class="Etiqueta_LIMON">FACT</td>

        <td style="width:8%" class="Etiqueta_LIMON">CANT</td>
        <td style="width:5%"  class="Etiqueta_LIMON">&nbsp;UNI&nbsp;</td>
        <td style="width:10%" class="Etiqueta_LIMON">$ UNIT S/Igv</td>
        <td style="width:10%" class="Etiqueta_LIMON">TOT S/Igv</td>
        <td style="width:10%" class="Etiqueta_LIMON">STK</td>
    </tr>
<%i =1
cad = "exec fichamov_deta '"&ope&"', '"&TIP&"' "
rs2.open cad,cnn
RS.MOVEFIRST
DO WHILE NOT RS2.EOF %>
<tr id="LIN<%=i%>" name="LIN<%=i%>" >
        <td><%=i%>&nbsp;</td>
        <td><input id="COD<%=I%>" name="COD<%=i%>" value="<%=rs2("cod")%>" class="bakes" onfocus="lineas('<%=i%>')" ondblclick="help('<%=i%>')"  onkeyup="this.value = toInt(this.value)" readonly/></td>
        <td align="left"><input id="DES<%=I%>" name="DES<%=i%>" value="<%=rs2("DESCRI")%>" readonly class="INPUTS" tabindex="-1"/></td>
        
        <td  <%IF TIP = "E" THEN %> style="display:none" <%END IF %>><input id="CON<%=i%>" name="CON<%=i%>" value="<%=formatnumber(rs2("con"),6,,true)%>" class="INPUTS" style="text-align:right" onblur="canti('<%=i%>');" /></td>
        <td  <%IF TIP = "E" THEN %> style="display:none" <%END IF %>><input id="FAC<%=i%>" name="FAC<%=i%>" value="<%=rs2("FAC") %>" class="INPUTS" style="text-align:right" readonly tabindex="-1"/></td>
    
        <td><input id="CAN<%=I%>" name="CAN<%=i%>" value="<%if trim(rs2("can")) <> "" then response.write(formatnumber(rs2("can"),6,,true))%>" class="INPUTS" style="text-align:right" <%IF TIP = "S" THEN %> readonly tabindex="-1" <%end if %> onkeyup="this.value = toInt(this.value)" /></td>
        <%if  trim(rs2("can")) <> ""  then if rs2("can") > 0 then bru = rs2("bru")/rs2("can") else bru = 0%>
        <td><INPUT id="UNI<%=i%>" name="UNI<%=i%>" value="<%=rs2("uni") %>" class="INPUTS" style="text-align:center" readonly tabindex="-1" /></td>
        <td><input id="BRU<%=I%>" name="BRU<%=i%>" value="<%=formatnumber(bru,2,,,true)%>" class="INPUTS" style="text-align:right" <%IF TIP = "S" THEN %> readonly tabindex="-1" <%end if %>  onkeyup="this.value = toInt(this.value)" /></td>
        <td><input id="PRE<%=i%>" name="PRE<%=i%>" value="<%=formatnumber(rs2("bru"),2,,,true)%>"  class="INPUTS" style="text-align:right" readonly tabindex="-1"/></td>
        <td><input id="STK<%=i%>" name="STK<%=i%>" value="<%=formatnumber(rs2("STK"),6,,,false)%>" class="INPUTS" style="text-align:right" readonly tabindex="-1"/></td> 
          
    </tr>
    <%i = i + 1 %>


    <%RS2.MOVENEXT %>
<%LOOP %>
<tr style="display:block" id="LIN<%=i%>" name="LIN<%=i%>" >
        <td><%=i %>&nbsp;</td>
        <td><input id="COD<%=i%>" name="COD<%=i%>" value="" class="bakes" onfocus="lineas('<%=i%>')" ondblclick="help('<%=i%>')"  onkeyup="this.value = toInt(this.value)" readonly/></td>
        <td align="left"><input id="DES<%=i%>" name="DES<%=i%>" value=""  class="INPUTS" readonly tabindex="-1"/></td>
          
        <td  <%IF TIP = "E" THEN %> style="display:none" <%END IF %>><input id="CON<%=i%>" name="CON<%=i%>" value="" class="INPUTS" style="text-align:right" onkeyup="this.value=toInt(this.value)" onblur="canti('<%=i%>');" /></td>
        <td  <%IF TIP = "E" THEN %> style="display:none" <%END IF %>><input id="FAC<%=i%>" name="FAC<%=i%>" value="" class="INPUTS" style="text-align:right" readonly tabindex="-1"/></td>
    
        <td><input id="CAN<%=i%>" name="CAN<%=i%>" value="" class="INPUTS" style="text-align:right"<%IF TIP = "S" THEN %> readonly tabindex="-1" <%end if %>  onkeyup="this.value = toInt(this.value)" /></td>
        <td><input id="UNI<%=i%>" name="UNI<%=i%>" value="" class="inputs" readonly tabindex="-1" style="text-align:center" /></td>
        <td><input id="BRU<%=i%>" name="BRU<%=i%>" value="" class="INPUTS" style="text-align:right" <%IF TIP = "S" THEN %> readonly tabindex="-1" <%end if %>  onkeyup="this.value = toInt(this.value)" /></td>
        <td><input id="PRE<%=i%>" name="PRE<%=i%>" value="" class="INPUTS" style="text-align:right" readonly tabindex="-1"/></td>  
        <td><input id="STK<%=i%>" name="STK<%=i%>" value="" class="INPUTS" style="text-align:right" readonly tabindex="-1"/></td>  
    </tr>

<%cont = i+1%>
    <%for i=cont to 50 %>
    <tr style="display:none" id="LIN<%=i%>" name="LIN<%=i%>" >
        <td><%=i %>&nbsp;</td>
        <td><input id="COD<%=i%>" name="COD<%=i%>" value="" class="bakes" onfocus="lineas('<%=i%>')" ondblclick="help('<%=i%>')"  onkeyup="this.value = toInt(this.value)" readonly/></td>
        <td align="left"><input id="DES<%=I%>" name="DES<%=i%>" value="" readonly class="INPUTS" tabindex="-1"/></td>

        <td  <%IF TIP = "E" THEN %> style="display:none" <%END IF %>><input id="CON<%=i%>" name="CON<%=i%>" value="" class="INPUTS" style="text-align:right" onkeyup="this.value=toInt(this.value)"  onblur="canti('<%=i%>');" /></td>
        <td  <%IF TIP = "E" THEN %> style="display:none" <%END IF %>><input id="FAC<%=i%>" name="FAC<%=i%>" value="" class="INPUTS" style="text-align:right" readonly tabindex="-1"/></td>

        <td><input id="CAN<%=I%>" name="CAN<%=i%>" value="" class="INPUTS" style="text-align:right" <%IF TIP = "S" THEN %> readonly tabindex="-1" <%end if %>  onkeyup="this.value = toInt(this.value)" /></td>
        <td><input id="UNI<%=i%>" name="UNI<%=i%>" value="" class="inputs" readonly tabindex="-1" style="text-align:center" /></td>
        <td><input id="BRU<%=I%>" name="BRU<%=i%>" value="" class="INPUTS" style="text-align:right" <%IF TIP = "S" THEN %> readonly tabindex="-1" <%end if %>  onkeyup="this.value = toInt(this.value)" /></td>
        <td><input id="PRE<%=i%>" name="PRE<%=i%>" value="" class="INPUTS" style="text-align:right" readonly tabindex="-1"/></td>  
        <td><input id="STK<%=i%>" name="STK<%=i%>" value="" class="INPUTS" style="text-align:right" readonly tabindex="-1"/></td>  
    </tr>

    <%next %>
</table>

<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe>

<script type="text/jscript" language="jscript">
var TOPE= parseInt('<%=I%>',10)

var opc  = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no," ;
	opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900" ;

var subcadena ='<%=RS("PROV")%>' ;
var elemento = document.all.PRO;
document.all.PRO.selectedIndex = seleindice(subcadena,elemento);	

var subcadena ='<%=RS("MON")%>' ;
var elemento = document.all.MON ;
document.all.MON.selectedIndex = seleindice(subcadena,elemento);

var subcadena = '<%=RS("MOV")%>';
var elemento = document.all.MOV;
document.all.MOV.selectedIndex = seleindice(subcadena, elemento);

var subcadena = '<%=RS("DOC")%>';
var elemento = document.all.DOC;
document.all.DOC.selectedIndex = seleindice(subcadena, elemento);

TOPE = parseInt('<%=i-1%>', 10)


// stock en almacen
var aStk = new Array()
// cantidades
var aCan = new Array()
// códigos
var aCod = new Array()

for (poto = 1; poto <= TOPE; poto++) {
    aCod[poto] = eval("document.all.COD" + poto + ".value");
    aCan[poto] = parseFloat(eval("document.all.FAC" + poto + ".value"));
    aStk[poto] = parseFloat(eval("document.all.STK" + poto + ".value"));

}

function canti(op) {
    op = parseInt(op, 10)
    aStk[op] = parseFloat(eval("document.all.STK" + op + ".value"))
   // alert(aStk[op])

    dato = eval("document.all.CON" + op + ".value")
    dato = toInt(dato)
    if (dato.length <= 0)
        dato = 0
    eval("document.all.CON" + op + ".value=dato")
    // si el consumo tiene valor, lo dividimos entre el factor y obtenemos la cantidad de salida
    // con la 
    fac = parseFloat(eval("document.all.FAC" + op + ".value"))
    //alert(fac)
    if (parseFloat(eval("document.all.CON" + op + ".value")) > 0 && fac != 0) {
        cons = dato
        sale1 = parseFloat((cons * fac) / 1000)
        aStk[op] = aStk[op] - sale1
        eval("document.all.CAN" + op + ".value= sale1")
       // alert(sale1)
    }
    else
    { eval("document.all.CAN" + op + ".value= dato") }
   //alert(op)
   // stock(op)
    return true
}

function stock(op) {
    aDisp = new Array();
    op = parseInt(op, 10);
 
    aCod[op] = eval("window.document.all.COD" + op + ".value");
    aCan[op] = eval("window.document.all.CAN" + op + ".value");
    aStk[op] = parseFloat(eval("window.document.all.STK" + op + ".value"));

    // BUSCA SI EXISTE EL CODIGO EN LAS LINEAS DEL DOCUMENTO

   
    aDisp = Ascan(aCod, aCod[op]);
    //alert(aStk[op])
    


    if (aDisp.length > 0) {   // cuenta las prendas en las multiples lineas
        stk = aStk[op];
        for (k = 0; k < aDisp.length; k++) { 
        
        //alert(stk)
        stk -= aCan[aDisp[k]] }
        //verifica si queda Stock para poder descargar
        if (stk < 0) {
            alert("Esta salida genera un saldo negativo de : " + stk );
            eval("window.document.all.CAN" + op + ".value=''");
            eval("window.document.all.CON" + op + ".value=''");
            aCan[op] = 0;
            return true;
        }
    }




}


function help(op) {
    if (document.all.MON.value == '') {
        alert("Por favor seleccione la moneda");
        document.all.MON.focus();
        return false;
    }
    cad = 'help/HLPquimicos.asp?op=' + op + '&mon=' + document.all.MON.value
    window.open(cad,'',opc)
}

function valida(){
    if (trim(document.all.PRO.value)=='')
    {   alert("Favor seleccionar Proveedor")
        document.all.PRO.focus()
        return false;
    }
    if (trim(document.all.MON.value) == '') {
        alert("Favor indicar moneda")
        document.all.MON.focus()
        return false;
    }
       if (trim(document.all.MOV.value) == '') {
        alert("Favor indicar el Tipo de Movimiento")
        document.all.MOV.focus()
        return false;
    }
       if (trim(document.all.DOC.value) == '') {
        alert("Favor El tipo de Documento")
        document.all.DOC.focus()
        return false;
    }
    if (trim(document.all.FECMOV.value) == '') {
        alert("Favor indicar la Fecha del Documento")
        document.all.FECMOV.focus()
        return false;
    }
    
    ninguno = 0
    for (d = 1; d < TOPE; d++) 
    {   // revisa si alguna lineas tiene codigo

        if (trim(eval("document.all.COD" + d + ".value")) != '' && parseFloat(eval("document.all.CAN" + d + ".value"))> 0) 
        {   ninguno++ ;
         break;   }    
    }
 if (ninguno == 0) 
 {   si = confirm("¿ Confirma que este documento quedará sin detalle de productos? "); 
     
     if (si == false)
     { return false; }
     else
     { return true; }
 }

 return true;
}


function graba()
{   var aCod = new Array()
    var aCan = new Array()
    var aPre = new Array()
    var aUni = new Array()
    var aCon = new Array()
    var aFac = new Array()  
    if (valida() == true) 
    {   
         for (mum = 1; mum < TOPE - 1; mum++) 
         {   
             aCod[mum] = eval("document.all.COD" + mum + ".value")
             aCan[mum] = toInt(trim(eval("document.all.CAN" + mum + ".value")))
             aPre[mum] = toInt(trim(eval("document.all.BRU" + mum + ".value")))
             aUni[mum] = toAlpha(trim(eval("document.all.UNI" + mum + ".value")))
             aCon[mum] = toInt(trim(eval("document.all.CON" + mum + ".value")))
             aFac[mum] = toInt(trim(eval("document.all.FAC" + mum + ".value")))
         }
         CAD  = '?OPE=' + trim(document.all.OPE.value)
         CAD += '&PRO=' + trim(document.all.PRO.value)
         CAD += '&MON=' + trim(document.all.MON.value)
         CAD += '&MOV=' + trim(document.all.MOV.value)
         CAD += '&DOC=' + trim(document.all.DOC.value)
         CAD += '&NUME=' + trim(document.all.NUME.value)
         CAD += '&FECMOV=' + trim(document.all.FECMOV.value)
         CAD += '&COD=' + aCod
         CAD += '&PRE=' + aPre
         CAD += '&CAN=' + aCan
         CAD += '&UNI=' + aUni
         CAD += '&COn=' + aCon
         CAD += '&FAC=' + aFac
         CAD += '&tip=' + '<%=tip%>'
     document.all.body10.style.display = 'block'
         document.all.body10.height = "350"
         document.all.body10.width = "100%"

        //alert(CAD)
         document.all.body10.src = "comun/inserMOV.asp" + CAD;
         //document.all.body10.style.display = 'none'
     } 
     return true;
 }

function lineas(op)
{   op = parseInt(op,10)

if (op < TOPE)
{   op++
    eval("document.all.LIN"+op+".style.display='block'")
    }
}

var nuevo = trim(document.all.OPE.value)
if (trim(nuevo) != 'AUTO') {
    document.all.OPE.disabled = true;
    document.all.MON.disabled = true;
    document.all.OPE.disabled = true;
    document.all.MOV.disabled = true
}


function validaFecha()
{  /* document.all.body10.style.display = 'block'
    document.all.body10.height = "350"
    document.all.body10.width = "100%"
    */
    NFEC = trim(document.all.FECMOV.value)
    if (NFEC.length != 10) {
        alert("Formato de Fecha: dd/mm/aaaa")
        document.all.FECMOV.focus()
        return false;
    }
   
    document.all.body10.src = 'bake/bakeFecmov.asp?fec=' + trim(document.all.FECMOV.value)

}
</script>
<%RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>