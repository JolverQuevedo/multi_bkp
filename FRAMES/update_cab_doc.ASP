<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<html>
<head>
<title>Edicion de Cabecera</title>

<style type="text/css">
.conter { width: 100%; border: 1px solid #fff; }
.textareaContainer {
    display: block;
    border: 1px solid #fff;
    padding: 2px;
    width: 100%; 
}
textarea { width: 100%; margin: 1.5px; padding: 0; border-width: 1; vertical-align:top; }
</style>
<link href="../multisty.css" rel="stylesheet" type="text/css">
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<SCRIPT language="javascript" src="../includes/cal.js"></SCRIPT>
<script language="jscript" type="text/jscript">
function agranda() { 
    window.resizeTo(500,200)
}
</script>



<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<%'****************************************************

alm = request.QueryString("alm")	
CTD = REQUEST.QueryString("MOV")
DOC = REQUEST.QueryString("DOC")
fec = REQUEST.QueryString("fec")
ruC = REQUEST.QueryString("ruc")
pro = REQUEST.QueryString("pro")
TBL = "RSFACCAR..AL" + CIA + "movc"

cad = "Select * from "&tbl&" Where C5_CALMA='"&alm&"' AND C5_CTD='" & ctd & "' AND C5_CNUMDOC LIKE '%"&doc&"'"
'RESPONSE.Write(CAD)
'RESPONSE.END
	RS.Open CAD, Cnn
	CONT = 1
	IF RS.RECORDCOUNT > 0 THEN
		RS.MOVEFIRST
        cod = rs("c5_ccodpro") ' RUC DEL PROVEEDOR
        des = rs("c5_cnompro") ' NOMBRE DEL PROVEEDOR 
        FEC = rs("c5_dfecdoc") ' FECHA DEL DOCUMENTO
        fin = rs("C5_DFECEMB")
END IF
%>

 </head>

<body onload="agranda()" style="margin-top:0; margin-left:0; margin-right:0; background-color:#A3B87A"  >
<form name="thisForm" METHOD="post" >
<table  border="0" cellspacing="4" cellpadding="0" align="center" width="100%" style="background-color:#A3B87A" >
   
    <tr valign="middle">
        <td align="right" class="Estilo8" width="9%" > Fecha Emisi&oacute;n :</td>
        <td width="8%" ><A href="javascript:showCal('Calendar2')"><img height=16 src="../images/cal.gif" width=16 border=0></A>
    </td>
       <td width="15%" ><input id="fec" name="fec" readonly value="<%=fec%>" tabindex="-1" Class="Estilo55">
    </td>
    <td colspan="2"></td>
    </tr>
    <tr valign="middle">
         <td align="right" width="9%" class="Estilo8"> Proveedor :&nbsp;</td>

        <td colspan="2"><input type="text" class="INPUTS" id="ruc" name="ruc" style="text-align:center" value="<%=ruc%>" onBlur="jala_ruc()"/></td> 
        <td width="5%" align="left"><img src="../IMAGES/lupa.png" border="0" onClick="buscapr()" id="img1" name="img1" style="cursor:pointer"/></td>
     <td colspan="3" width="63%"><input type="text" class="Inputs" id="pr" name="pr" style="text-align:left;" value="<%=pro%>"/></td>    
    </tr>
   
    <tr><td colspan="2"></td>
        <td  align="right"><input type="button" value="Aceptar" id="ok" name="ok" onClick="envia(1)" /></td>
        <td colspan="1"></td>
        <td align="left"><input type="button" value="Cancelar" id="no" name="no" onClick="envia(0)" /></td>
    </tr>
     <tr valign="middle">
        <td align="right" class="Estilo8" width="9%" > Fecha Entrega :</td>
        <td width="8%" ><A href="javascript:showCal('Calendar1')"><img height=16 src="../images/cal.gif" width=16 border=0></A>
    </td>
       <td width="15%" ><input id="fin" name="fin" readonly value="<%=fin%>" tabindex="-1" Class="Estilo55">
    </td>
    <td colspan="2"></td>
    </tr>




</table>
<iframe  width="100%"  style="display:none" src="" id="body0" name="body0"  scrolling="no" frameborder="0" height="100" align="middle"></iframe>

</form>
<script language="jscript" type="text/jscript">
    addCalendar("Calendar1", "Elija una fecha", "fin", "thisForm")
    addCalendar("Calendar2", "Elija una fecha", "fec", "thisForm")
 //   alert('<%=ruc%>')
function envia(op) {  
    if (op == '0') {
        this.window.close()
        return false
    }
    if (trim(document.all.fec.value) == '') {
        alert("Favor informar la fecha del documento")
        return false
    }
    if (trim(document.all.ruc.value) == '') {
        alert("Favor informar el RUC del Proveedor")
        return false
    }
    if (trim(document.all.fin.value) == '') {
        alert("Favor informar la fecha de Entrega")
        return false
    }
   // alert(document.all.ruc.value)
    jala_ruc();

    cad = '../COMUN/graba_cab_DOC.ASP?ALM=' + '<%=ALM%>' + '&CTD=' + '<%=CTD%>' + '&DOC=' + '<%=DOC%>'
    
    cad += '&RUC=' + document.all.ruc.value

    cad += '&FEC=' + document.all.fec.value
    cad += '&Fin=' + document.all.fin.value
    //alert(cad)
    window.location.replace(cad)

}

function buscapr() {

    window.open('../HELP/busca_prov_oc.ASP?NOM=' + ltrim(document.all.pr.value))
    return true;
}


function jala_ruc() {
    if (trim(document.all.ruc.value) != '') {
       
        cad = '../bake/jala_ruc.asp?ruc=' + document.all.ruc.value
       // document.all.body0.style.display = 'block'
       //  alert(document.all.ruc.value) 
       //alert(cad)
        document.all.body0.src = cad
    }
}



</script>

</body>
</HTML>
