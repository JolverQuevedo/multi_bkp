 <%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<link href="multisty.css" rel="stylesheet" type="text/css">


<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
 <style type="text/css">
        .style1
        {  
            font-family:Arial;   font-size:12px; 
            color:#000000; font-weight:300; padding: 0.0em 0.0em;
            background-color:#f68b21; 
        }
        .style2
        {
            font-family: Arial;
            font-size: 12px;
            color: #000000;
            font-weight: 300;
            width: 114px;
            border-style: hidden;
            padding: 0.0em;
            background-color: #A3B87A;
        }
        .style3
        {
            width: 315px;
        }
        .style5
        {
            width: 127px;
        }
        .style6
        {
            font-family: Arial;
            font-size: 12px;
            color: #000000;
            font-weight: 300;
            width: 100px;
            border-style: hidden;
            padding: 0.0em;
            background-color: #A3B87A;
        }
    </style>
</head>
<%TITULO = "Conviete GUIAS del Modelador a PE de JACINTAS" %>

<body>
<html xmlns="http://www.w3.org/1999/xhtml">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<table id="Table1" align="center"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="1"  cellspacing="2"  border="0" ><tr>
<td class="Estilo2"><%=titulo%></td>
</tr>
</table>
<form name="thisForm" id="thisForm" method="post" action="JALAGUIA.asp">

<table border="0" id="DATAENTRY" align="center" cellpadding="2" cellspacing="1">
     <tr>            
	    <td bgcolor="#f68b21" align="right" class="style1" width="15%">ALMACEN MODELADOR:</td>
       	<td bgcolor="<%=(Application("color2"))%>" width="25%">
        <select id="ORI" name= "ORI" class="datosgrande" style="width:100%">
            <option value=""></option>
            <%tt1 = "RSFACCAR..AL0001ALMA"
            cad = "Select A1_CALMA, A1_CDESCRI From "&tt1&" ORDER BY 1 "
            rs.open cad, cnn
            if rs.recordcount > 0 then rs.movefirst %>
            <%DO while not rs.eof%>
                <option value="<%=rs("A1_CALMA")%>"><%=TRIM(rs("A1_CALMA"))%> - <%=rs("A1_CDESCRI")%></option>
                <%rs.movenext%>
            <%loop %>
        </select>
        <%RS.CLOSE %>
        </td>
        <tr>
	    <td bgcolor="<%=(Application("barra"))%>" align="right" class="style1" width="15%">ALMACEN JF:</td>
       	<td bgcolor="<%=(Application("color2"))%>" width="25%">
        <select id="DES" name= "DES" class="datosgrande" style="width:100%">
            <option value=""></option>
            <%tt1 = "RSFACCAR..AL0012ALMA"
            cad = "Select A1_CALMA, A1_CDESCRI,A1_CDIRECC From "&tt1&" ORDER BY 1"
            rs.open cad, cnn
            if rs.recordcount > 0 then rs.movefirst %>
            <%DO while not rs.eof%>
                <option value="<%=rs("A1_CALMA")%>"><%=TRIM(rs("A1_CALMA"))%> - <%=rs("A1_CDESCRI")%> - <%=rs("A1_CDIRECC")%></option>
                <%rs.movenext%>
            <%loop %>
        </select>
        <%RS.CLOSE %>
        </td>
        </tr>        
        <tr>
        <td bgcolor="<%=(Application("barra"))%>" align="right" class="style1" width="10%">GUIA MODELADOR # :</td>
       	<td bgcolor="<%=(Application("color2"))%>" width="10%"> 
            <input type="text" id="GUI" name="GUI" class="datosGRANDE" maxlength="10" style="width:100%" onkeyup="this.value=toInt(this.value)"/></td>  
    </tr>
    <tr>
      <td bgcolor="<%=(Application("barra"))%>" align="right" class="style1" width="10%">GLOSA :</td>             
      <td bgcolor="<%=(Application("color2"))%>" width="90%" colspan="5"> 
      <input type="text" id="GLO" name="GLO" class="datosGRANDE" maxlength="30" style="width:100%"/></td>    
    </tr>
    <tr bgcolor="<%=application("color2") %>" align="center">
        <td colspan="6"><img src="images/ok.png"   alt="GRABAR" onClick="GRABAR_onclick()" style="cursor:pointer;" /></td>		               
    </tr>
</table>
</form>


<script language="jscript" type="text/jscript">
function GRABAR_onclick() {
    if (ltrim(rtrim(document.all.ORI.value)) == '') {
        alert("Favor informar el código de almacén MODELADOR")
        document.all.ORI.focus()
        return true;
    }
    
    if (ltrim(rtrim(document.all.DES.value)) == '') {
        alert("Favor informar el código de almacén JF")
        document.all.DES.focus()
        return true;
    }
    
    if (ltrim(rtrim(document.all.GUI.value)) == '') {
        alert("Favor informar numero de Docuemnto")
        document.all.GUI.focus()
        return true;
    }
    
    cad = 'comun/PASAGUIA.asp?ORI=' + ltrim(rtrim(document.all.ORI.value))
    cad += '&DES=' + ltrim(rtrim(document.all.DES.value))
    cad += '&GUI=' + ltrim(rtrim(document.all.GUI.value))
    cad += '&GLO=' + ltrim(rtrim(document.all.GLO.value))

    var si
    { si = confirm("¿ Confirma la CREACION de este PARTE DE ENTRADA? "); }
    if (si == false)
    { return false; }
    //document.all.body10.style.display='block'
    //document.all.body10.src=cad
    window.location.replace(cad)
}
(function(){
	if(confirm("T1 por defecto?")){
	var sel=document.all.ORI;
	
	sel.value=("00T1");}
})();
</script>
</body>
</html>
