<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>
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
CTD = REQUEST.QueryString("CTD")
DOC = REQUEST.QueryString("DOC")
LIN = REQUEST.QueryString("LIN")
TBL1 = "RSFACCAR..AL" + CIA + "ARTI"
TBL2 = "RSFACCAR..AL" + CIA + "MOVD"

KAD =   " Select  A.C6_CITEM as IT , A.C6_CCODIGO AS COD ,      " & _
        " A.C6_CDESCRI AS DESCRI, A.C6_CCODMON AS MON,          " & _
        " A.C6_NPREUNI AS PRECIO, B.AR_CUNIDAD AS UNI ,         " & _
        " A.C6_NCANTID AS CANT                                  " & _
        " From "&TBL2&" A                                       " & _
        " LEFT JOIN "&TBL1&" B ON B.AR_CCODIGO=A.C6_CCODIGO     " & _
        " Where C6_CALMA='"&ALM&"' AND C6_CTD='"&CTD&"'  AND    " & _
        " C6_CNUMDOC LIKE '%"&DOC&"' AND C6_CITEM ='"&LIN&"'    " & _
        " Order by C6_CALMA,C6_CTD,C6_CNUMDOC,C6_CITEM          "


RS.Open KAD, Cnn
'RESPONSE.WRITE(cad)
'response.end
IF NOT RS.EOF OR NOT RS.BOF THEN	RS.MOVEFIRST
%>

<script language="jscript" type="text/jscript">
    oldrow = 1
    function llena(t, pos) {
        return true
    }

    function dd2(ff) {	// LLENA TEXTBOX ADICIONALES AL COMUN
        // LOS DEL COMUN SON CODIGO Y DESCRIPCION
        var t = document.all.TABLA;
        var pos = parseInt(ff);
        dd(ff);
    }
</script>
 </head>

<body style="margin-top:0; margin-left:0; margin-right:0; background-color:#A3B87A" >
<form name="thisForm" METHOD="post" >
<table  border="0" cellspacing="4" cellpadding="0" align="center" width="100%" style="background-color:#A3B87A" >
   
    <tr valign="middle">
        <td align="right" class="Estilo8" width="10%" > C&oacute;digo :</td>
        <td width="15%" >
        <input type="text" class="Estilo55" id="cod" name="cod" style="text-align:center" value="<%=rs("cod") %>"/>
        </td>
        <td width="75%"></td>
    </tr>
    <tr valign="middle">
        <td align="right" class="Estilo8" > Descripci&oacute;n :&nbsp;</td>
        <td align="left" width="90%" colspan="2" >
            <input type="text" class="INPUTS" id="des" name="des" value="<%=trim(rs("descri")) %>" maxlength="50"/>
        </td>
    </tr>
    <tr valign="top">
       <td width="15%" class="Estilo8" align="right" >Cantidad :</td>
       <td><input type="text" class="INPUTS" id="can" name="can" style="text-align:center"  value="<%=formatnumber(rs("cant"),3,,,true) %>"/></td>
       </tr>
    <tr><td></td>
        <td  align="right"><input type="button" value="Aceptar" id="ok" name="ok" onClick="envia(1)" /></td>
        <td align="left"><input type="button" value="Cancelar" id="no" name="no" onClick="envia(0)" /></td>
    </tr>
</table>

<script language="jscript" type="text/jscript">
cod = '<%=trim(ucase(rs("cod"))) %>'
if (cod == 'TXT') {
    document.all.can.value = 0
    document.all.can.disabled = true
}
function envia(op) {  
if (op == '0') {
    this.window.close()
    return false
}

if (document.all.des.value == "")
    {   alert("Debe informar descripcion")
        document.all.des.focus()
        return false
    }

    if (parseFloat(document.all.can.value)  == 0)
        {if (document.all.can.disabled == false) {
                alert("Debe ingresar la Cantidad ")
                document.all.can.focus()
                return false;
            }
        }
    LIN = '<%=rs("it")%>' 
    cad  = '../COMUN/UPDATE_DOC.ASP?LIN='+LIN+'&ALM='+'<%=ALM%>'+'&CTD='+'<%=CTD%>'+'&DOC='+'<%=DOC%>'
    cad += '&CAN=' + document.all.can.value
    cad += '&DES=' + document.all.des.value
    cad += '&cod=' + document.all.cod.value
 alert(cad)
    window.location.replace(cad)

}
</script>
</form>
</body>
</HTML>
