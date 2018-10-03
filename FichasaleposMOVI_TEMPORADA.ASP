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

function calcHeight()
{
  //find the height of the internal page
  var the_height=
    document.getElementById('body0').contentWindow.
    document.body.scrollHeight+25;
  //change the height of the iframe
  document.getElementById('body0').height=
      the_height;
}

</script>
<%	COD = Request.QueryString("cod")
    CLI = Request.QueryString("cli")
    TEM = Request.QueryString("TEM")


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
        <td align = "center" class="Estilo2" width="50%"> <%=titulo%> - INGRESOS Estilo</td>
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
      
        <td width="8%"><input type="text" id="RUC" name="RUC" value="<%=rs("RUC") %>" class="BAKES"  onDblClick="helpPRO()" onChange="bakepro()"  /></td>
        <td colspan="5"><input type="text" id="NOM" name="NOM" value="<%=rs("NOMPRO") %>" class="Bakes" onDblClick="helpPRO()"  /></td>
    </tr>        
    
    <tr>
        <td class="Estilo8" width="8%">Servicio:</td>
        <td width="8%" colspan="1"><select id="SER" name="SER" class="inputs"  />
                <option value=""></option>
                <% rs2.open "select * from SERVICIOS where estado ='a' ORDER BY 2", cnn %>
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
         <td class="Estilo8" width="8%">Defecto:</td>
        <td colspan="1" width="10%"><select id="DEF" name="DEF" class="inputs"  />
                <option value=""></option>
                <% rs2.open "select * from defectos where estado ='a' ORDER BY 2", cnn %>
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
        <td class="Estilo8" width="8%" colspan="1">Observacion:</td>
        <td width="10%" colspan="2"><select id="CON" name="CON" class="inputs"  />
                <option value=""></option>
                <% rs2.open "select * from CONDICIONES where estado = 'a' ORDER BY 2", cnn %>
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
<tr>
 <td class="Estilo8" width="8%">Tipo Pza:</td>
       
        <td width="8%" colspan="1"><select id="PZA" name="PZA" class="inputs"  />
                <option value=""></option>
                <% rs2.open "select * from piezas where estado = 'a' ORDER BY 2", cnn %>
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
        <td class="Estilo8" width="5%">FecDoc:</td>
        <td width="1%" align="center"><A href="javascript:showCal('Calendar1')"><img height=16 
					    src="images/cal.gif" width=16 border=0></A></td>
        <td ><input type="text" id="FEC" name="FEC" value="<%=formatdatetime(rs("fecdoc"),2) %>" class="inputs" style="text-align:center" readonly tabindex="-1"/></td>  
        <td class="Estilo8" width="8%">Motivo:</td>
        <td width="10%" colspan="1"><select id="MOT" name="MOT" class="inputs"  />
                <option value=""></option>
                <% rs2.open "select * from MOTIVOS ORDER BY 2", cnn %>
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
        <tr>
        <td class="Estilo8" width="8%">Guia Modelador:</td>
        <td width="10%" colspan="1"><input id="GUI" name="GUI" class="inputs" value="<%=RS("guia") %>" maxlength="11"  /></td>      
        <td class="Estilo8" width="8%">Guia Taller:</td>
        <td width="10%" colspan="2"><input id="GUI2" name="GUI2" class="inputs" value="<%=RS("guia") %>" maxlength="11"  /></td>
	</tr>
    <tr>   
        <td class="Estilo8" width="5%">Estilo:</td>
        <td width="8%"><input type="text" id="ECL" name="ECL" value="<%=rs("ESTCLI") %>" class="inputs" onChange="help()"  /></td>
        <td width="70%" colspan="5"><input type="text" id="DES" name="DES" value="<%=rs("ESTILO") %>" class="inputs" readonly tabindex="-1"/></td>
    </tr>
    <tr><td class="Estilo8" width="8%">Destino:</td>
         <td width="10%" colspan="2"><select id="LIN" name="LIN" class="inputs"  />
                <% rs2.open "select * from LINEAS where estado = 'a' order BY 2", cnn %>
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
       <td class="Estilo8" width="8%">O/Serv. #:</td>
        <td width="10%" colspan="1"><input id="BOL" name="BOL" class="inputs" value="<%=RS("BOLSA") %>"  maxlength="12"  /></td>
        <td class="Estilo8" width="8%">Corte #:</td>
        <td width="10%" colspan="1"><input id="CORT" name="CORT" class="inputs" value="<%=RS("BOLSA") %>"  /></td>
    </tr>
    <tr> <td colspan="7" align="center"><img id="ENVI" name="ENVI" alt="GRABA CAMBIOS" style="cursor:pointer;display:block " onClick="help()" src="images/ok.png" /></td>
    </tr>
</table>         


<div style="display:none">
<select id="mov" name="mov" class="INPUTS"><option value="I" selected>Ingresos</option></select>

<input type="text" id="EST" name="EST" value="<%=rs("CODEST") %>" class="INPUTS" readonly tabindex="-1" disabled/>
</div>

<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="0" height="400" align="middle" style="display:block" ></iframe>

<script language="javascript" src="includes/cal.js"></script>
<script type="text/jscript" language="jscript">
addCalendar("Calendar1", "Elija una fecha", "FEC", "thisForm")

var opc  = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no," ;
	opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900" ;

// si tiene numero de guia YA NO SE PUEDE MODIFICARRRRRRRRRRR
//if (trim(document.all.GUI.value) != '')
 //   document.all.Img1.style.display='none'



var subcadena = '<%=RS("codser")%>';
if (trim(subcadena) == '')
   subcadena = '01'
    var elemento = document.all.SER;
    document.all.SER.selectedIndex = seleindice(subcadena, elemento);


var subcadena = '<%=RS("codcon")%>';
if (trim(subcadena) == '')
    document.all.CON.selectedIndex = 1
else {
    var elemento = document.all.CON;
    document.all.CON.selectedIndex = seleindice(subcadena, elemento);
}
var subcadena = '<%=TRIM(RS("codPZA"))%>';
if (trim(subcadena) == '')
    document.all.PZA.selectedIndex = 1
else {
    var elemento = document.all.PZA;
    document.all.PZA.selectedIndex = seleindice(subcadena, elemento);
}
var subcadena = '<%=TRIM(RS("codDEF"))%>';
if (trim(subcadena) == '')
    document.all.DEF.selectedIndex = 1
else {
    var elemento = document.all.DEF;
    document.all.DEF.selectedIndex = seleindice(subcadena, elemento);
}
var subcadena = '<%=TRIM(RS("codLIN"))%>';
var elemento = document.all.LIN;
document.all.LIN.selectedIndex = seleindice(subcadena, elemento);

var subcadena = '<%=TRIM(RS("codMOT"))%>';
if (trim(subcadena) == '')
    document.all.MOT.selectedIndex = 1
else {
    var elemento = document.all.MOT;
    document.all.MOT.selectedIndex = seleindice(subcadena, elemento);
}


function help() {
    if (trim(document.all.ECL.value) == '') {
        alert("Por favor informe el Estilo del Cliente")
        return false;
    }
    if (trim(document.all.RUC.value) == '') {
        alert("Por favor informe el Taller")
        return false;
    }
    document.all.ENVI.style.display='none'
    cad  = 'help/HLP_saldo_estilos_TEMPORADA.asp?est=' + trim(document.all.ECL.value) + '&ruc=' + trim(document.all.RUC.value)
    cad += '&ser=' + trim(document.all.SER.value)
    cad += '&CON=' + trim(document.all.CON.value)
    cad += '&DEF=' + trim(document.all.DEF.value)
    cad += '&PZA=' + trim(document.all.PZA.value)
    cad += '&FEC=' + trim(document.all.FEC.value)
    cad += '&LIN=' + trim(document.all.LIN.value)
    cad += '&MOT=' + trim(document.all.MOT.value)
    cad += '&BOL=' + trim(document.all.BOL.value)
    cad += '&gui=' + trim(document.all.GUI.value)
    cad += '&gui2=' + trim(document.all.GUI2.value)
    cad += '&cor=' + trim(document.all.CORT.value)
    cad += '&cli=' + '<%=cli%>'
    cad += '&TEM=' + trim('<%=TEM%>')
   // alert(cad)
    
   document.all.body0.src= cad
}

function helpPRO() {
    if (trim(document.all.RUC.value) == '' && trim(document.all.NOM.value) == '') {
        alert("Por favor informe el RUC o Nombre del proveedor")
        return false;
    }
    cad = 'help/HLPproveedor.asp?ruc=' + trim(document.all.RUC.value) + '&nom=' + ltrim(document.all.NOM.value)
    window.open(cad, '', opc)
}

function bakepro() {
  /*document.all.body10.style.display = 'block'
    document.all.body10.height = "350"
    document.all.body10.width = "100%"
    */
    document.all.body10.src = "BAKE/jala_pro.asp?RUC=" + trim(document.all.RUC.value) ;
}


</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>

</body>
</html>