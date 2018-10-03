<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<link REL="stylesheet" TYPE="text/css" HREF="../MULTISTY.CSS" >
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
est	    = Request.QueryString("est") 
ruc	    = Request.QueryString("ruc") 
ser	    = Request.QueryString("ser") 
con	    = Request.QueryString("con") 
def	    = Request.QueryString("def") 
cli	    = Request.QueryString("cli")
PZA	    = Request.QueryString("PZA")
FEC	    = Request.QueryString("FEC")
LII	    = Request.QueryString("LIN")
MOT	    = Request.QueryString("MOT")
BOL	    = Request.QueryString("BOL")
GUI	    = Request.QueryString("GUI")
GUI2	= Request.QueryString("GUI2")
COR	    = Request.QueryString("COR")

cad = "select * from view_pos_movi where codcli = '"&cli&"' and estcli = '"&est&"' "
'response.write (cad)
rs.open cad, cnn
if rs.recordcount <= 0 then
%>
<table width="100%" border="0">
 <tr>       
		 <td class="estilo5" colspan="2" style="color:Red" align="center">No existe estilo <%=ucase(est)%> para el Cliente Seleccionado</td>
  </tr>
    <tr style="height:80px; vertical-align:middle">       
		 <td class="estilo5" colspan="2" style="color:Navy; cursor:pointer" onclick="javascript: window.close()" align="center"> << C E R R A R >></td>
  </tr>
  </table>
  <script language="jscript" type="text/jscript">
    parent.window.parent.window.document.all.DES.value = ''

</script>


<%response.end
else 

des = rs("estilo")
end if
rs.close
%>
<script language="jscript" type="text/jscript">
    parent.window.parent.window.document.all.DES.value = '<%=ucase(trim(DES)) %>'

</script>

<%CAD =	" exec SALDO_PO_COLOR_TOTAL_GUIA  '"&est&"' , '"&ruc&"', '"&ser&"', '"&con&"', '"&def&"', '"&gui&"' " 
            
' RESPONSE.Write(CAD)

	RS.Open CAD, Cnn   
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
		RS.MOVEFIRST
    ELSE 
        RESPONSE.WRITE("<FONT COLOR=RED SIZE=2 FACE=ARIAL>")
        RESPONSE.WRITE("Nada pendiente que mostrar con los criterios seleccionados")
        RESPONSE.END   
	END IF 

' Nro de columnas regresadas por el objeto RECORDSET	
	columnas = rs.Fields.Count-1
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">

<script language="javascript" type="text/jscript">
oldrow = 1

function redir(ff) {
    var t = document.all.TABLA;
    ff = parseInt(ff, 10);
    po = t.rows(ff).cells(0).innerText;
    est = t.rows(ff).cells(1).innerText;   
    window.opener.document.all.POS.value = po
    window.opener.window.BAKE('1')
    this.window.close();
}
function llena() {
    return true;
}

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}

</script>
</HEAD>
<BODY >

<form name="thisForm" METHOD="post" action="">

<table id="TABLA" align="center"  bordercolor="<%=application("color2")%>" bgcolor="<%=application("color2")%>"  cellpadding="2"  cellspacing="1"  border="0" width="100%">
<tr  >
	<td align="center" class="Estilo2" width="100%" colspan="2">ESTILO <%=trim(RS("ESTCLI"))%></td>
    <td align="right"><img id="ENVI" name="ENVI" alt="GRABA CAMBIOS" style="cursor:pointer; " onClick="graba()" src="../images/ok.png" /></td>
</tr>
<%	'**************************
	'LINEA DE CABECERA STANDAR 
	'**************************
	cont=1%>
<tr bgcolor="<%=APPLICATION("TITULO")%>" >
	<td align="center" class="estilo8" width="1%">GUIA</td>
    <td align="center" class="estilo8" width="1%">CORTE</td>
    <td align="center" class="estilo8" width="1%">PO</td>
    <td align="center" class="estilo8" width="1%">COLOR</td>
    
    
	<td align="center" class="estilo8" width="1%">DISPONIBLE</td>
    <td align="center" class="estilo8" width="1%">CANT</td>
</tr>
<%	'*****************************
	' MUESTRA EL GRID (2 COLORES) 
	'*****************************	%>
  <%' MUESTRA EL GRid (2 colorES) %>
    <%IF not RS.EOF THEN %>
    <%DO WHILE NOT RS.EOF%>
    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>">       
	    
		
         <td class="estilo5" align="right" width="20%">
            <input type="text" class="data2" id="g<%=cont%>" name="g<%=cont%>" readonly tabindex="-1" style="text-align:right" value="<%=trim(RS.FIELDS.ITEM(4))%>" /></td>
         <td class="estilo5" align="right" width="20%">
            <input type="text" class="data2" id="R<%=cont%>" name="R<%=cont%>" readonly tabindex="-1" style="text-align:right" value="<%=trim(RS.FIELDS.ITEM(3))%>" /></td>
	     <td class="estilo5" align="right" width="20%">
            <input type="text" class="data2" id="p<%=cont%>" name="p<%=cont%>" readonly tabindex="-1" style="text-align:right" value="<%=trim(RS.FIELDS.ITEM(5))%>" /></td>
          <td class="estilo5" align="left" width="20%">
            <input type="text" class="data2" id="k<%=cont%>" name="k<%=cont%>" readonly tabindex="-1" style="text-align:right" value="<%=trim(RS.FIELDS.ITEM(1))%>" /></td>
            <td class="estilo5" align="right" width="30%">
            <input type="text" class="data2" id="s<%=CONT%>" name="s<%=cont%>" readonly tabindex="-1" style="text-align:right" value="<%=trim(RS.FIELDS.ITEM(2))%>" /></td>
         <td class="estilo5" align="right"  width="30%">
            <input type="text" class="INPUTS" id="c<%=cont%>" name="c<%=cont%>" value="" onchange="veri('<%=cont%>')" /></td>
	    <%RS.MOVENEXT%>
	    <%CONT = CONT + 1%>
  </tr>
	<%loop%>
    <%else %>
    <tr>       
		 <td class="estilo5" colspan="2" style="color:Red" align="center">No existe estilo <%=ucase(est)%> para el Cliente Seleccionado</td>
  </tr>
    <tr style="height:80px; vertical-align:middle">       
		 <td class="estilo5" colspan="2" style="color:Navy; cursor:pointer" onclick="javascript: window.close()" align="center"> << C E R R A R >></td>
  </tr>
    <%end if %>
  </table>
<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="400" align="middle" style="display:block" onLoad="calcHeight();"></iframe>
<script language="javascript">
red ='<%=rs.recordcount %>'
if (parseInt(red,10) > 0)
    dd2('1');

function calcHeight() {
    //find the height of the internal page
    var the_height = document.getElementById('body0').contentWindow.document.body.scrollHeight;

    //change the height of the iframe
        document.getElementById('body0').height = the_height + 50;
}
function veri(op) {
    op = parseInt(op, 10)
 
    saldo = parseInt(eval("document.all.s" + op + ".value"), 10)
    canti  = parseFloat(eval("document.all.c" + op + ".value"))
    if (isNaN(canti)) {
        if (trim(canti) != '') {
            alert("Por favor ingrese NUMEROS")
            eval("document.all.c" + op + ".style.backgroundColor='red'")
            eval("document.all.c" + op + ".focus()")
            seleccionar(eval("document.all.c" + op))
            return false;
        }
        else
        { canti = 0 }
    }
    //alert(parseFloat(eval("document.all.c" + op + ".value")))

    if (saldo - canti < 0) {
        alert("Saldo pendiente de Ingresar INSUFICIENTE"+ (saldo-canti))
        eval("document.all.c" + op + ".style.backgroundColor='red'")
        eval("document.all.c" + op + ".focus()")
        seleccionar(eval("document.all.c" + op))
        return false;
    }
    else {
        eval("document.all.c" + op + ".style.backgroundColor='White'")
        eval("document.all.c" + op + ".value=canti")
    }

}

function graba() {
    maxim = parseInt('<%=rs.recordcount %>', 10)
    aCan = Array()
    aCol = Array()
    aPos = Array()
    aGui = Array() 
for (op = 1; op <= maxim; op++)
 {
    if (eval("document.all.c" + op + ".style.backgroundColor") == 'red') {
        alert("Tienes colores inconsistentes\n     R E V I S E . . . . ")
        return false;
    }
    else {
        if (trim(eval("document.all.c" + op + ".value")) != '') {
            if (trim(eval("document.all.c" + op + ".value")) != '0') {
                aCan[aCan.length++] = parseFloat(eval("document.all.c" + op + ".value"))
                aCol[aCol.length++] = trim(eval("document.all.k" + op + ".value"))
                aPos[aPos.length++] = trim(eval("document.all.p" + op + ".value"))
                aGui[aGui.length++] = trim(eval("document.all.g" + op + ".value"))
            }
        }
    }  
}

cad = 'llenapos2.asp?can=' + aCan + '&col=' + aCol + '&est=' + '<%=est%>' + '&pos=' + aPos + '&gui=' + aGui
cad += '&RUC=' + '<%=RUC%>' + '&SER=' + '<%=SER%>' + '&CON=' + '<%=CON %>' + '&DEF=' + '<%=DEF%>'
cad += '&PZA=' + '<%=PZA%>' + '&FEC=' + '<%=FEC%>' + '&LIN=' + '<%=LII %>' + '&MOT=' + '<%=MOT%>' + '&BOL=' + '<%=BOL%>' 
cad += '&G2=' + '<%=Gui2%>'   + '&cor=' + '<%=cor%>'
    
document.all.body0.src = cad 

return true;
}

</script>  
</form>
<%
	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
    </BODY>
</HTML>