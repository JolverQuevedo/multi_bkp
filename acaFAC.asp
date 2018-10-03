<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<link href="multisty.css" rel="stylesheet" type="text/css">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNqry.ASP"-->

<script language="jscript" type="text/jscript">
oldrow = 1
function llena(t, pos) {
    return true
}
function llamame() {

    var sel = thisForm.POS
    pos = ''
    for (var n = 0; n < sel.length; n++) {
        if (sel[n].selected) {
            pos += "'" + sel.options[n].value + "',"
        }
    }
    pos = trim(pos)
    pos = Left(pos, (pos.length-1))

    cadena = trim(document.all.EST1.value) + trim(document.all.cli.value)
    cadena += trim(document.all.PZA.value) + trim(pos)

    if (cadena.length == 0) {
        alert("Favor Colocar algun Criterio de filtro")
        return true;
    }
    if (trim(document.all.cli.value) == '') {
        alert("Favor Indicar cliente")
        return true;
    }

    dd  = '?cli='  + trim(thisForm.cli.value) 
    dd += '&tem='  + ltrim(document.all.PZA.value)
    dd += '&est='  + trim(document.all.EST1.value)
    dd += '&pos='  + trim(pos)
    dd += '&fec='  + trim(document.all.emb.value)
    dd += '&fexp=' + trim(document.all.fexp.value)
    //   alert(dd)
    cad = 'DETAacaFAC.asp'+ dd
    //  alert(cad)
    document.all.body0.src=cad
}

function clean() {    
    var sele1 = window.thisForm.PZA
    sele1.options.length = 0;
    var sele2 = window.thisForm.EST1
    sele2.options.length = 0;
    var sele3 = window.thisForm.POS
    sele3.options.length = 0;
document.all.cli.selectedIndex= -1
document.all.emb.value = ''
document.all.fexp.value = ''
}
function borra() {
    cadena = trim(document.all.EST1.value) + trim(document.all.cli.value)
    cadena += trim(document.all.PZA.value) + trim(document.all.POs.value)

    if (cadena.length == 0) {
        alert("Favor Colocar algun Criterio de filtro")
        return true;
    }
    if (trim(document.all.cli.value) == '') {
        alert("Favor Indicar cliente")
        return true;
    }
    var sel = thisForm.POS
    pos = ''
    for (var n = 0; n < sel.length; n++) {
        if (sel[n].selected) {
            pos += "'" + sel.options[n].value + "',"
        }
    }
    pos = trim(pos)
    pos = Left(pos, (pos.length - 1))


    document.all.fexp.value = ''
    document.all.emb.value = ''
    dd  = '&est=' + ltrim(document.all.EST1.value)
    dd += '&tem=' + trim(document.all.PZA.value)
    dd += '&pos=' + trim(pos)
    dd += '&fec=' + trim(document.all.emb.value)
    dd += '&fexp=' + trim(document.all.fexp.value)
       
    //   alert(dd)
    cad = 'DETAacaFAC.asp?cli=' + trim(thisForm.cli.value) + dd + '&borra=1'
    //alert(cad)
    document.all.body0.src = cad
}

function cambiaTEM()
    {  var sele1 = window.thisForm.PZA
    // borra los elementos PRE - existentes
    sele1.options.length = 0;
    var sele2 = window.thisForm.EST1
    sele2.options.length = 0;
    var sele3 = window.thisForm.POS      
    sele3.options.length = 0;
    document.all.body0.src = 'bake/bakeTEMPORADAcliente.asp?cli=' + trim(document.all.cli.value) + '&sele=PZA'

}

function cargaESTILO() {
    var sele2 = window.thisForm.EST1
    sele2.options.length = 0;
    var sele3 = window.thisForm.POS
    sele3.options.length = 0;

    if (trim(document.all.cli.value) == '') {
        alert("Favor seleccionar un cliente")
        return false;
    }
    else {
        if (trim(document.all.PZA.value) == '') {
            document.all.body0.src = 'bake/BAKEclienteESTILO2.asp?cli=' + trim(document.all.cli.value) + '&sele=PZA' + '&tem=' + trim(document.all.PZA.value)
            }
    }
}

function cambiaEST() 
{  dd = 'bake/bakeTEMPORADAestilo2.asp?cli=' + trim(document.all.cli.value) + '&sele=EST1' + '&tem=' + trim(document.all.PZA.value)
    document.all.body0.src = dd
}

function cambiaPO() 
{   dd = 'bake/bakeTEMPORADApoESTILO.asp?cli=' + trim(document.all.cli.value) + '&sele=pos' + '&tem=' + trim(document.all.PZA.value)
    dd += '&est=' + trim(document.all.EST1.value)
    //  alert(dd)
    document.all.body0.src = dd
}

function poCLI() {
    if (   ( trim(document.all.cli.value) == '') || ( trim(document.all.cli.value) == '' && trim(document.all.PZA.value) == '' && trim(document.all.EST1.value) == '')  ) 
    {  alert("Favor seleccionar un cliente")
        return false;
    }
    else {
        if (trim(document.all.PZA.value) == '' && trim(document.all.EST1.value) == '') {
           
            document.all.body0.src = 'bake/bakePOcli.asp?cli=' + trim(document.all.cli.value) + '&sele=POS'
        }
        else { 
               
            if (trim(document.all.PZA.value) != '' && trim(document.all.EST1.value) == '')
                document.all.body0.src = 'bake/bakeTEMPORADAclientePO.asp?cli=' + trim(document.all.cli.value) + '&sele=POS' + '&tem=' + trim(document.all.PZA.value)
            else {
                if (trim(document.all.PZA.value) != '' && trim(document.all.EST1.value) != '') {
                    document.all.body0.src = 'bake/bakeTEMPORADApoESTILO.asp?cli=' + trim(document.all.cli.value) + '&sele=POS' + '&tem=' + trim(document.all.PZA.value) + '&est=' + trim(document.all.EST1.value)
                }
                else {
                    document.all.body0.src = 'bake/bakeESTILOpo.asp?cli=' + trim(document.all.cli.value) + '&sele=POS' + '&tem=' + trim(document.all.PZA.value) + '&est=' + trim(document.all.EST1.value)
                }
            }
        } 
    }
}

 function calcHeight() {
        //find the height of the internal page
        var the_height =
    document.getElementById('body0').contentWindow.
      document.body.scrollHeight + 25;
        //change the height of the iframe
        document.getElementById('body0').height =
      the_height + 150;
    }
</script>

<title></title>
<link href="reportes/CalendarControl.css" rel="stylesheet" type="text/css">
<script src="reportes/CalendarControl.js" language="javascript"></script>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
 
<form name="thisForm" id="thisForm" METHOD="post" ><HTML>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body style="margin-top:0; margin-left:0; margin-right:0;" >
<center>
<div class="Estilo2">Asigna Facturas a Despachos de Exportacion</div>
</center>
<table id="TABLA" align="center"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="5"  cellspacing="5"  border="0" >  
    <tr>
        <td  class="Estilo11" >Cliente:</td>
        <td>
            <select id="cli" name="cli" onchange="cambiaTEM()" >
                <option value=""></option>
                <%rs.open "select * from MODELADOR..cliENTE WHERE ESTADO = 'A' ORDER BY NOMBRE", cnn%>
                <%if rs.recordcount > 0 then%>
                    <%RS.MOVEFIRST%>
                    <%DO WHILE NOT rs.EOF%>
                        <option value="<%=rs("CODIGO")%>"><%=LTRIM(RTRIM(rs("NOMBRE")))%></option>
                        <%rs.MOVENEXT%>
                    <%LOOP%>
                <%end if%>
                <%rs.CLOSE%>
	        </select>
        </td>
        <td class="Estilo11" >Temporada:</td>
        <td><select id="PZA" name="PZA" style="width:100px"  class="INPUTS" onchange="cambiaEST()"  ></select></td>
        <td  class="Estilo11" >Estilo:</td>
        <td class="style4"><select id="EST1" name="EST1" class="inputs" style="width:100px"  onchange="cambiaPO()" ></select></td>  
        <td  class="Estilo11" >PO #:</td>
        <td class="style6" ><select id="POS" name="POS" multiple ondblclick="poCLI()"  class="bakes" style="width:100px"  ></select></td>
    </tr>
    <tr>
        <td class="Estilo11" >Fec_Emb:</td>
        <td><input name="emb" id="emb" onfocus="showCalendarControl(this);" type="text"></td>
        <td class="Estilo11" >Fac_Exp:</td>
        <td><input name="fexp" id="fexp" class="INPUTS" type="text" style="width:100px"  width="100px" ></td>
        <td colspan="1" ><input type="button" value="Genera" onclick="llamame()"/></td>
        <td colspan="1" ><input type="button" value="Borra Datos" onclick="borra()"/></td>
        <td colspan="1" ><input type="button" value="Reset" onclick="clean()"/></td>
    </tr>
</table>

<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="0" height="100" 
align="middle" onload="calcHeight()"></iframe>
</form>
</body>
</html>

