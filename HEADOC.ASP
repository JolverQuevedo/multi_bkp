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
<HTML>
<HEAD>
<%' VALOR DEL TIPO DE CAMBIO
cad = "Select XMEIMP2 From RSCONCAR..CTCAMB Where  XCODMON='US' AND Convert(datetime,XFECCAM2,103)=Convert(datetime,getdate(),103) "

rs.open cad,cnn
if rs.recordcount > 0 then
    rs.movefirst
  '  response.write(rs("XMEIMP2"))
else
   ' response.write("No tenemos Tipo de cambio del d&iacute;a, avisar a Contabilidad")
    rs.close
    cad = "Select XMEIMP2 From RSCONCAR..CTCAMB Where  XCODMON='US' AND Convert(datetime,XFECCAM2,103)=Convert(datetime,'14/12/2012 00:00:00',103) "
    rs.open cad,cnn
    if rs.recordcount > 0 then
        rs.movefirst
      '  response.write(rs("XMEIMP2"))
        'response.End
    END IF
end if
rs.close
%>

<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<body style="margin-top:0px; margin-left:0px; margin-right:0px">
<form name="thisForm" METHOD="post"  >
<iframe frameborder="1" style="display:none" height="100" width="100%" id="ACTIV" name="ACTIV"></iframe>
<table WIDTH=100% border="0" cellpadding="2" cellspacing="0">
<tr class="Estilo2">
	<td align="center" colspan="12" class="Estilo2">ORDENES DE COMPRA</td>
</tr>
<tr class="estilo10">
<td width="3%">Proveedor</td>
<td width="5%"><input type="text" name="PRO" id="PRO" value="" class="bakes" onchange="BAKE(this.value)" ondblclick="help()"/></td>
<td width="25%"><input type="text" name="DPRO" id="DPRO" value="" class="inputs" readonly tabindex="-1" style="width:100%"/></td>
<td width="2%">Mes/A&ntilde;o</td>
<td width="5%"><input type="text" name="MESA" id="MESA" value="<%=RIGHT("00"&MONTH(DATE()),2)%>/<%=YEAR(DATE()) %>" class="inputs"/></td>
<td width="2%">Estado</td>
<%TBL1 = "RSFACCAR..AL"+CIA+"TABL"

cad =	"Select TG_CCLAVE, TG_CDESCRI From "&tbl1&" Where TG_CCOD='31' Order by TG_CCLAVE"
rs.open cad,cnn
IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST%>
	<td align="center" width="15%">	
		<select id="EDO" name="EDO" class="inputs">    
			<option value=''></option>
		<%DO WHILE NOT RS.EOF%>
			<option value='<%=TRIM(rs("TG_cCLAVE"))%>'><%=trim(rs("TG_CDESCRI"))%></option>
			<%RS.MOVENEXT%>
		<%LOOP%>
		</select>
	</td>
<td width="1%">Tipo</td>
<%' recibe tabla, primary key, y descripcion 

cad =	"Select TG_CCLAVE, TG_CDESCRI From "&tbl1&" Where TG_CCOD='63' Order by TG_CCLAVE"
rs.close
rs.open cad,cnn
IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST%>
	<td align="center" width="15%">	
		<select id="TIP" name="TIP" class="inputs">    
			<option value=''></option>
		<%DO WHILE NOT RS.EOF%>
			<option value='<%=TRIM(rs("tg_cclave"))%>'><%=trim(rs("tg_cdescri"))%></option>
			<%RS.MOVENEXT%>
		<%LOOP%>
		</select>
	</td>
<td style="width:5%;" ><input type="button" id="ENVI" name="ENVI" value="FILTRAR" class="boton" onclick="filtra()"/></td>
</tr>

</table>
<%rs.close
set rs = nothing
set cnn=nothing%>
<script language="jscript" type="text/jscript">
var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=800,width=600";


function filtra() {
    if (trim(thisForm.MESA.value) == '')
    { thisForm.MESA.value = '<%=right("00" + trim(cstr(MONTH(DATE()))),2)%>' + '/' + '<%=YEAR(DATE()) %>' }
    else {
        ff = parseInt(Left(trim(thisForm.MESA.value), 2), 10)
        if (ff > 12 || ff < 1) {
            alert("Solo hay 12 meses en un anio")
            thisForm.MESA.value = ''
            return true;
        }
        dd = trim(thisForm.MESA.value)
        if (dd.length != 7) {
            alert("El periodo a mostrar debe tener este formato: MM/AAAA")
            thisForm.MESA.value = ''
            return true
        }
        else {
            aa = parseInt('<%=YEAR(DATE()) %>', 10)
            if (parseInt(Right(dd, 4), 10) > aa) {
                alert("Todavia no hemos llegado a este anio")
                thisForm.MESA.value = ''
                return true;
            }
        }
    }

    cad  = 'detaoc.asp?fecha=' + thisForm.MESA.value
    cad += '&edo=' + thisForm.EDO.value
    cad += '&tip=' + thisForm.TIP.value
    cad += '&pro=' + thisForm.PRO.value
    parent.mainFrame.window.location.replace(cad)

}

function help() {
    cad = 'help/HLPprovREAL.asp?op=head&cod='
    cad += thisForm.PRO.value + '&des=' + thisForm.DPRO.value
    window.open(cad,"PROVEEDORES",opc)
}

function BAKE(ruc)
{	cad = 'BAKE/PROVEEDOR_REAL.asp?pos='+trim(ruc)
    /*alert(cad)
    window.document.all.ACTIV.style.display='block'
    */
	window.document.all.ACTIV.src= cad
}
</SCRIPT>
</BODY>
</HTML>
