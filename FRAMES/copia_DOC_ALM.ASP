<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<html>
<head>
<title>Edicion de Documentos</title>
<link href="multisty.css" rel="stylesheet" type="text/css">

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

<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<%'****************************************************

alm = request.QueryString("alm")	
DOC = REQUEST.QueryString("DOC")


TBL1 = "RSFACCAR..FT" + CIA + "NUME"
TBL2 = "RSFACCAR..AL" + CIA + "MOVD"

KAD =   " Select TN_CNUMSER AS SERIE, TN_NNUMERO+1 AS NUME          " & _
        " From "&TBL1&" Where TN_CCODIGO='GS' Order by TN_CNUMSER   "

RS.Open KAD, Cnn
'RESPONSE.WRITE(kad)
'response.end
IF NOT RS.EOF OR NOT RS.BOF THEN	RS.MOVEFIRST
%>

<script language="jscript" type="text/jscript">
    function llena(t, pos) {
        return true
    }

 
</script>
 </head>

<body style="margin-top:0; margin-left:0; margin-right:0; background-color:#A3B87A" >
<form name="thisForm" METHOD="post" >
<table  border="0" cellspacing="4" cellpadding="0" align="center" width="100%" style="background-color:#A3B87A" >
   
    <tr valign="middle">
        <td align="right" class="Estilo8" width="10%" > C&oacute;digo :</td>
        <td width="15%" >
       <select  class="INPUTS" id="SER" name="SER" style="text-align:center;width:100%" onchange="numero()">
            <option value=""></option>
            <%do while not rs.eof %>
            <option value="<%=trim(RS("serie"))+right("0000000"+trim(rs("nume")),7)%>"><%=rs("serie") %></option>
            <%rs.movenext %>
            <%loop %>
        </select> 
        </td>
        <td align="left" width="90%" colspan="2" >
            <input type="text" class="INPUTS" id="NUME" name="NUME" value="" maxlength="50"/>
        </td>
    </tr>
    <tr><td></td>
        <td  align="right"><input type="button" value="Aceptar" id="ok" name="ok" onClick="envia(1)" /></td>
        <td align="left"><input type="button" value="Cancelar" id="no" name="no" onClick="envia(0)" /></td>
    </tr>
</table>

<script language="jscript" type="text/jscript">
function numero() { 
    document.all.NUME.value = Right(strzero(document.all.SER.value,10),7)
    }

function envia(op) {
    if (op == "1") {
        if (document.all.SER.value == '') {
            alert("No ha seleccionado la serie")
            return false;
        }
        numero = Left(trim(document.all.SER.value),3)+ strzero(trim(document.all.NUME.value), 7)
       var si
       { si = confirm("¿ Desea crear el Documento \n" + numero + "?"); }
        if (si == false)
        { return false; }
        cad = '../COMUN/COPIA_DOC.ASP?OLD_DOC=' + '<%=DOC%>'
        cad += '&NDOC='+ numero
        cad += '&alm=' + '<%=alm%>'
        //alert(cad)
        window.location.replace(cad)
    }
    else
    { window.close() }
return true;
}
</script>
</form>
</body>
</HTML>
