<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<script type="text/jscript" language="jscript">

    function calcHeight() {
        //find the height of the internal page
        var the_height =
    document.getElementById('body0').contentWindow.
    document.body.scrollHeight + 25;
        //change the height of the iframe
        document.getElementById('body0').height =
      the_height;
    }

</script>
<%	COD = Request.QueryString("cod")
    CLI = Request.QueryString("cli")
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
    ' NOMBRE DEL CLIENTE
    rs.open "select nombre  from modelador..cliente where codigo = '"&cli&"' ", cnn
    rs.movefirst
    descli = rs("nombre")
    rs.close
    'response.write(descli)
    'response.end
	
    ' DATOS DE CABECERA DE LA PO
    CAD =	" exec FICHAposmovi '"&COD&"'" 
    
	'response.Write(cAD)
	rs.open cad , cnn
	IF RS.RecordCount > 0 THEN
		RS.MOVEFIRST
		TITULO = ucase(trim(DESCLI))

	END IF
    'RESPONSE.END
    'response.write(rs("fecdoc"))
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="multisty.CSS" />
</head>
<body onLoad="document.all.ECL.focus()">
<form id="thisForm" method="post" name="thisForm" action="comun/inserposMOVI.asp">

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center"> 
	    <td width="10%"><img src="images/logo_ch.png" border="0" alt="" id="GRABA" /></td>	
        <td align = "center" class="Estilo2" width="50%"> <%=titulo%> - Ingreso Estilo</td>
        <td class="Estilo2" width="15%" align="right">Ficha Nº</td>
        <td  width="8%" align="right"><input type="text" id="id" name="id" value='<%=rs("id")%>' class="data" maxlength="10" readonly tabindex="-1" disabled /></td>
        <td align="right"><img src="images/close.png" style="cursor:pointer;" onClick="window.close()" /></td>
    </tr>
</table>  

<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>
<input id="veri" name="veri" value="0" style="display:none">
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="0" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975" style="height:1px;"></td>	
	</tr>
</table>
<table border="0" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" 
       bordercolorlight="<%=(Application("COLOR1"))%>">
    <tr valign="middle">
        <td class="Estilo8" width="5%">Taller:</td>
        <td width="15%"><input type="text" id="RUC" name="RUC" value="<%=rs("RUC") %>" class="BAKES"  onDblClick="helpPRO()" onChange="bakepro()"  /></td>
        <td colspan="3" width="80%"><input type="text" id="NOM" name="NOM" value="<%=rs("NOMPRO") %>" class="Bakes" onDblClick="helpPRO()"  /></td>
    </tr>        
     <tr>   
        <td class="Estilo8" width="5%">Estilo:</td>
        <td width="15%"><input type="text" id="ECL" name="ECL" value="<%=rs("ESTCLI") %>" class="inputs"  /></td>
        <td width="60%"><input type="text" id="DES" name="DES" value="<%=rs("ESTILO") %>" class="data" readonly tabindex="-1"/></td>
         <td class="Estilo8" width="10%">Servicio:</td>
        <td width="10%" ><select id="SER" name="SER" class="inputs"  />
                <option value=""></option>
                <% rs2.open "select * from SERVICIOS where estado = 'a' ORDER BY 2", cnn %>
                <%if rs2.recordcount > 0 then %>
                    <%RS2.MOVEFIRST %>
                    <%DO WHILE NOT RS2.EOF %>
                        <option value="<%=RS2("CODIGO")%>"><%=LTRIM(RTRIM(RS2("DESCRIPCION")))%></option>
                        <%RS2.MOVENEXT %>
                    <%LOOP %>
                <%end if %>
                <%RS2.CLOSE%>
	        </select>
        </td>
    </tr>
    <tr> <td colspan="5" align="center"><img id="ENVI" name="ENVI" alt="GRABA CAMBIOS" style="cursor:pointer;display:block " onClick="help()" src="images/ok.png" /></td>
    </tr>
</table>         


<div style="display:none">
<input type="text" id="GUI" name="GUI" value="" class="inputs" /></td>
<input type="text" id="EST" name="EST" value="<%=rs("CODEST") %>" class="INPUTS" readonly tabindex="-1" disabled/>
</div>

<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="0" height="400" align="middle" style="display:block" ></iframe>

<script type="text/jscript" language="jscript">
 

    function help() {
        if (trim(document.all.ECL.value) == '') {
            alert("Por favor informe el Estilo del Cliente")
            return false;
        }
        if (trim(document.all.RUC.value) == '') {
            alert("Por favor informe el Taller")
            return false;
        }

        if (trim(document.all.SER.value) == '') {
            alert("Por favor informe el Servicio de Destino")
            return false;
        }

        document.all.ENVI.style.display = 'none'
        
        cad = 'help/HLP_guia_estilos.asp?est=' + trim(document.all.ECL.value) + '&ruc=' + trim(document.all.RUC.value)
        cad += '&cli=' + '<%=cli%>' + '&SER=' + trim(document.all.SER.value)
        

        document.all.body0.src = cad
    }

    function helpPRO() {
        if (trim(document.all.RUC.value) == '' && trim(document.all.NOM.value) == '') {
            alert("Por favor informe el RUC o Nombre del proveedor")
            return false;
        }
        cad = 'help/HLPproveedor.asp?ruc=' + trim(document.all.RUC.value) + '&nom=' + ltrim(document.all.NOM.value)
        window.open(cad)
    }

    function bakepro() {
        /*document.all.body10.style.display = 'block'
        document.all.body10.height = "350"
        document.all.body10.width = "100%"
        */
        document.all.body10.src = "BAKE/jala_pro.asp?RUC=" + trim(document.all.RUC.value);
    }


</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>