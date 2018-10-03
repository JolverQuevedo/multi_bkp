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
        dd  = '&col=' + ltrim(document.all.COL.value)
        dd += '&ser=' + document.all.SER.value
        dd += '&po='  + document.all.PO.value
        //   alert(dd)
        cad = 'DETAacaFAC.asp?cli=' + trim(thisForm.CLI.value) + dd
        parent.window.frames.item(1).window.location.replace(cad)
    }

    function cambiaCOL() { 
    document.all.body0.src= 'bake/bakecolores.asp?po='+ trim(document.all.PO.value) + '&sele=COL'
    }
</script>

<title></title>
<link href="reportes/CalendarControl.css"   rel="stylesheet" type="text/css">
<script src="reportes/CalendarControl.js"     language="javascript"></script>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
 
<form name="thisForm" id="thisForm" METHOD="post" ><HTML>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body style="margin-top:0; margin-left:0; margin-right:0;" >
<center>
<div class="Estilo2">Asigna Facturas a Despachos de Exportacion</div>
</center>
<table id="TABLA" align="center"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="0" >  
  <tr>
    <td class="style5">Cliente:</td>
    <td>
        <select id="CLI" name="CLI"/>
            <option value=""></option>
            <%rs.open "select * from MODELADOR..CLIENTE WHERE ESTADO = 'A' ORDER BY NOMBRE", cnn %>
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
     <td class="style2">PO #:</td>
    <td class="style6" ><input type="text" id="PO" name="PO" value="" class="inputs" onchange="cambiaCOL()" /></td>
    <td class="style1" >Color:</td>
    <td class="style4"><select id="COL" name="COL" class="inputs"  ></select>
    </td>  
   
    <td class="style5" >Servicio:</td>
    <td>
        <select id="SER" name="SER"   />
        <option value=""></option>
        <% rs.open "select * from SERVICIOS ORDER BY 2", cnn %>
        <%if rs.recordcount > 0 then%>
            <%rs.MOVEFIRST%>
            <%DO WHILE NOT rs.EOF%>
                <option value="<%=rs("CODIGO")%>"><%=LTRIM(RTRIM(rs("DESCRIPCION")))%></option>
                <%rs.MOVENEXT %>
            <%LOOP %>
        <%end if %>
        <%rs.CLOSE%>
	    </select>
    </td>
    <td class="style5" >Fec_Exp:</td>
     <td><input name="emb" id="emb" onfocus="showCalendarControl(this);" type="text"></td>
    <td><input type="button" value="Filtra" onclick="llamame()"></td>
</tr>
</table>

<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe>
</form>
</body>
</html>
