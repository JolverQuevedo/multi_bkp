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
        cadena = trim(document.all.COL.value) + trim(document.all.CLI.value)
        cadena += trim(document.all.SER.value) + trim(document.all.PO.value)

        if (cadena.length == 0) {
            alert("Favor Colocar algun Criterio de filtro")
            return true;
        }
        if (trim(document.all.CLI.value) == '') {
            alert("Favor Indicar Cliente")
            return true;
        }
        dd = '&col=' + ltrim(document.all.COL.value)
        dd += '&ser=' + trim(document.all.SER.value)
        dd += '&po=' + trim(document.all.PO.value)
        dd += '&fec=' + trim(document.all.emb.value)
        dd += '&fexp=' + trim(document.all.fexp.value)
        //   alert(dd)
        cad = 'DETAacaFAC.asp?cli=' + trim(thisForm.CLI.value) + dd
      //  alert(cad)
       document.all.body0.src=cad
    }
    function borra() {
        cadena = trim(document.all.COL.value) + trim(document.all.CLI.value)
        cadena += trim(document.all.SER.value) + trim(document.all.PO.value)

        if (cadena.length == 0) {
            alert("Favor Colocar algun Criterio de filtro")
            return true;
        }
        if (trim(document.all.CLI.value) == '') {
            alert("Favor Indicar Cliente")
            return true;
        }
        document.all.fexp.value = ''
        document.all.emb.value = ''
        dd = '&col=' + ltrim(document.all.COL.value)
        dd += '&ser=' + trim(document.all.SER.value)
        dd += '&po=' + trim(document.all.PO.value)
        dd += '&fec=' + trim(document.all.emb.value)
        dd += '&fexp=' + trim(document.all.fexp.value)
       
        //   alert(dd)
        cad = 'DETAacaFAC.asp?cli=' + trim(thisForm.CLI.value) + dd + '&borra=1'
        //alert(cad)
        document.all.body0.src = cad
    }

function cambiaCOL() {
        document.all.body0.src = 'bake/bakecolores.asp?po=' + trim(document.all.PO.value) + '&sele=COL'
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
<div class="Estilo2">Consulta Ventas por codigos Alternativos</div>
</center>
<table id="TABLA" align="center" width="100%"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="0" >  
  <tr>
    <td class="style5">Cliente:</td>
    <td>
        <select id="CLI" name="CLI"/>
            <option value=""></option>
            <%tbl1 = "RSFACCAR..AL"+cia+"CODA" 
            tbl2 = "RSFACCAR..AL"+cia+"ARTI"
            tbl3 = "RSFACCAR..FT"+cia+"CLIE"
            tbl4 = "RSFACCAR..FT"+cia+"Acud "
            rs.open "SELECT  distinct AT_CCODCLI, CL_CNOMCLI FROM "&tbl1&", "&tbl2&", "&tbl3&",  "&tbl4&" WHERE AT_CCODIGO=AR_CCODIGO AND AT_CCODIGO = F6_CCODIGO AND AT_CCODCLI=CL_CCODCLI order by 2", cnn %>
            <%if rs.recordcount > 0 then%>
                <%RS.MOVEFIRST%>
                <%DO WHILE NOT rs.EOF%>
                    <option value="<%=rs("AT_CCODCLI")%>"><%=LTRIM(RTRIM(rs("CL_CNOMCLI")))%></option>
                    <%rs.MOVENEXT%>
                <%LOOP%>
            <%end if%>
            <%rs.CLOSE%>
	    </select>
    </td>

    <td class="style5" >Año:</td>
    <td width="20%">
        <select id="ANO" name="ANO" width="100%" class="INPUTS" />
        <option value=""></option>
        <%FOR I = 2010 TO YEAR(DATE()) %>
                <option value="<%=I%>"><%=I%></option>
        <%NEXT %>
	    </select>
    </td>
    
    <td colspan="1" width="50%" align="right"><input type="button" value="Genera" onclick="llamame()"></td>
    <td colspan="1" width="50%" align="left"><input type="button" value="BORRA" onclick="borra()"></td>
    
    </tr>
    <tr>
    <td class="style2">Alternativo:</td>
    <td class="style6"><input type="text" id="SKU" name="SKU" value="" ondblclick="hlpART(2)" class="bakes"   width="200px"  /></td>
    <td class="style1">Real:</td>
    <td class="style4" width="20%"><input type="text" id="COD" ondblclick="hlpART(1)" name="COD" class="bakes"  >    </td>  
    <td class="style4" colspan="2"><input type="text" id="DES" name="DES" class="inputs"  >    </td>  
</tr>
</table>

<iframe  width="100%" src="BLANCO.HTM" id="body0" name="body0" scrolling="yes" frameborder="0" height="999" align="middle" onload="calcHeight()" ></iframe>
</form>
<script language="jscript" type="text/jscript">
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=550,width=500";

function hlpART(op) {
op = parseInt(op)
if (op == 1)
    window.open('HELP/busca_ARTICULOS2.ASP?NOM=' + ltrim(document.all.DES.value) + '&cod=' + trim(document.all.COD.value), "", opc)
else {
        if (trim(document.all.CLI.value) == '')
        {   alert("Favor indicar el Cliente")
            return false;
        }
        window.open('HELP/busca_alternativos.ASP?cli=' + ltrim(document.all.CLI.value) + '&cod=' + trim(document.all.SKU.value), "",opc)
    }
}

function llamame() {
cad = 'reportes/qry_alternativos.ASP?cli=' + ltrim(document.all.CLI.value) + '&sku=' + trim(document.all.SKU.value)
cad +=  '&cod=' + trim(document.all.COD.value) + '&ano=' + trim(document.all.ANO.value)
    document.all.body0.src= cad
}
function borra() {
    document.all.CLI.value = ''
    document.all.CLI.selectedIndex = 0
    document.all.ANO.value = ''
    document.all.ANO.selectedIndex = 0
    document.all.SKU.value = ''
    document.all.COD.value = ''
    document.all.DES.value = ''
    document.all.body0.src= 'blanco.htm'
}

</script>



</body>
</html>

