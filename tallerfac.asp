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
        dd += '&SERV=' + trim(document.all.serv.value)
        //   alert(dd)
        cad = 'detaFACtaller.asp?cli=' + trim(thisForm.CLI.value) + dd
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
        document.all.serv.value = ''
        dd = '&col=' + ltrim(document.all.COL.value)
        dd += '&ser=' + trim(document.all.SER.value)
        dd += '&po=' + trim(document.all.PO.value)
        dd += '&fec=' + trim(document.all.emb.value)
        dd += '&fexp=' + trim(document.all.fexp.value)
        dd += '&serv=' + trim(document.all.serv.value)
        //   alert(dd)
        cad = 'detaFACtaller.asp?cli=' + trim(thisForm.CLI.value) + dd + '&borra=1'
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
<div class="Estilo2">Asigna Facturas a Despachos de Talleres</div>
</center>
<table id="TABLA" align="center" width="100%"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="0" >  
  <tr>
    <td width="55" class="style5">Cliente:</td>
    <td width="207">
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
     <td width="69" class="style2">Guia #:</td>
    <td class="style6" ><input type="text" id="PO" name="PO" value="" class="inputs"   width="100px"  /></td>
    <td width="31">&nbsp;</td>
    <td width="22" ><select id="COL" name="COL" style="width:100px;display:none" ></select>
    </td>  
   
    <td width="88" class="style5" >Servicio:</td>
    <td width="812">
        <select id="SER" name="SER" width="100px"  />
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
    </tr>
    <tr>
    <td class="Estilo11" >Fec_Fac:</td>
    <td><input name="emb" id="emb" onFocus="showCalendarControl(this);" type="text"></td>
    <td class="Estilo11" >Fac_Taller:</td>
    <td width="195"><input name="fexp" id="fexp" class="INPUTS" type="text" ></td>
    <td class="Estilo11" >Ord_Serv:</td>
    <td width="195"><input name="serv" id="serv" class="INPUTS" type="text" ></td>
    <td ><input type="button" value="Genera" onClick="llamame()"></td>
    <td colspan="1"><input type="button" value="BORRA" onClick="borra()"></td>
</tr>
</table>

<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="0" height="100" 
align="middle" onload="calcHeight()" ></iframe>
</form>
</body>
</html>

