<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<script type="text/jscript" language="jscript">
    var aConcepto = Array("", "Estilo", "PO", "Color", "Movimiento", "Guia", "Taller", "Defecto", "Pieza", "Servicio", "Condicion", "Fec_Mov", "Fec_Exp", "Fac_Exp", "Fec_Tall", "Fac_Tall", "Ord_Ser", "Ord_Cor", "Tallas", "Cant. PO", "Cant. MOV")
    var aDat = Array("", "ESTCLI", "PO", "COLOR", "MOV", "GUIA", "RUC",    "CODDEF", "CODPZA", "CODSER", "CODCON",                  "FECDOC",  "FECEMB",  "FACEXP",  "FECPRO",   "FACPRO" , "NUMSER", "CORTE",  "T", "Q", "C")
    var aDet = Array("", "ESTILO",  "",  "",      "",    "",     "NOMPRO", "DESDEF", "DESPZA", "DESSER", "DESCON", "", "","","","","", "",  "",  "",  "")
    var aInputs = Array("", "ECL", "POS", "ccc", "mov", "GUI", "RUC", "DEF", "PZA", "SER", "CON", "INI", "FEMB", "FACE", "FPRO", "FACP", "SERV", "CORTE",  "", "", "")
    var aMsg = Array("", "el Estilo del Cilente", "la PO", "el Color", "el tipo de Movimiento", "la Guia deseada", "el Ruc del Proveedor", "el Defecto", "el tipo de Pieza", "el tipo de servicio", "la condicion", "las fechas del intervalo", "",  "", "", "", "")
    var aFil = Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    var aSub = Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    var aOrd = Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
    var aUbi = Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 97, 98, 99)
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
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
    ' NOMBRE DEL CLIENTE
  '  rs.open "select nombre  from modelador..cliente where codigo = '"&cli&"' ", cnn
  '  rs.movefirst
  '  descli = rs("nombre")
  '  rs.close
    'response.write(descli)
    'response.end
	
    ' DATOS DE CABECERA DE LA PO
    CAD =	" exec FICHAposmovi '"&COD&"'" 
    
	'response.Write(cAD)
    TITULO = "OPCIONES"
	rs.open cad , cnn
	IF RS.RecordCount > 0 THEN
		RS.MOVEFIRST
		TITULO = TITULO + ucase(trim(DESCLI))

	END IF
    'RESPONSE.END
    'response.write(rs("fecdoc"))
' *****************************************************************
'  si se añade algo aca, hay que hacerlo en el jscript tambien!!!
' *****************************************************************
concepto = ",Estilo, PO, Color, Movimiento, Guia, Taller, Defecto, Pieza, Servicio, Condicion, Fec_Mov, Fec_Exp, Fac_exp, Fec_tall, Fac_tall, Ord_ser, Ord_Corte, Tallas, Cant. PO, Cant. MOV"
tbls = ",est,po,col,mob,gui,pro,def,pie,SRV,KON,FCH,femb,face,fpro,facp,serv,corte,,,"
atbl = split(tbls,",")
aConcepto = split(concepto, ",")
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="../multisty.CSS" />
</head>
<style>
.botonimagen{
  background-image:url('../images/EDIT.PNG');
  background-repeat: no-repeat;
  background-position: left center;
  cursor:pointer;
  width:35px;
  height:35px;
}
.botonimagen2{
  background-image:url('../images/ok.PNG');
  background-repeat: no-repeat;
  background-position: left center;
  cursor:pointer;
  width:35px;
  height:35px;
}
.botonimagen3{
  background-image:url('../images/xl1.PNG');
  background-repeat: no-repeat;
  background-position: left center;
  cursor:pointer;
  width:40px;
  height:40px;
}
</style>

<body >
<form id="thisForm" method="post" name="thisForm" action="">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
        <td align = "center" class="Estilo2" style="color:Gray" width="50%">Seleccione sus Opciones</td>  
    </tr>
</table>  
<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>
<input id="veri" name="veri" value="0" style="display:none">
<table width="100%" border="1" bordercolordark="<%=application("color2")%>"  cellpadding="0" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td >&nbsp;</td>	
	</tr>

</table>


<table border="1" cellpadding="1" cellspacing="1" bgcolor="<%=(Application("color2"))%>" bordercolordark="<%=(Application("borde"))%>" 
       bordercolorlight="<%=(Application("COLOR1"))%>" align="center">    
    <tr valign="middle">
        <td class="Estilo8" colspan="2">Concepto</td>
        <td class="Estilo8" style="display:none">Sub-Total</td>
        <td class="Estilo8" colspan="2">Orden PRN</td>
        <td class="Estilo8" Colspan="2">Posicion</td>
        <td class="Estilo8" Colspan="1">Filtro</td>
    </tr>
    <tr>
        <td colspan="6"></td>
    <!-- ********************************************** -->
    <!-- aca van todas las tablas de los filtros ocultas-->
    <!-- ********************************************** -->
    <td width="50%" rowspan="<%=ubound(aconcepto)+1%>" valign="top" align="left">
        <table border="0"  cellpadding="0" cellspacing="0" width="100%"> 
            <tr>
                <td style="height:25px;">
                    <table border="0" id="est" name ="est"  style="display:none"  cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td width="30%"><input type="text" id="ECL" name="ECL" value="<%=rs("ESTCLI")%>" class="inputs" onchange="bakeest()" /></td>
                            <td width="60%" ><input type="text" id="DES" name="DES" value="<%=rs("ESTILO")%>" class="DATA" readonly tabindex="-1"/></td>  
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height:25px;">
                    <table border="0" id="po" name ="po"  style="display:none" cellpadding="0" cellspacing="0" width="100%">
                        <tr><td width="100%"><input type="text" id="POS" name="POS" value="<%=rs("po")%>" class="inputs"/></td>           
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height:25px;">
                    <table border="0" id="col" name ="col"  style="display:none" cellpadding="0" cellspacing="0" width="100%">
                        <tr><td width="100%"><input type="text" id="ccc" name="ccc" value="" class="inputs" /></td></tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height:25px;">
                    <table border="0" id="mob" name ="mob"  style="display:none"  cellpadding="0" cellspacing="0" width="100%">
                        <tr><td width="50%"><select id="mov" name="mov" class="INPUTS">
                                <option value=""></option>
                                <option value="I">Ingresos</option>
                                <option value="S">Salidas</option>
                            </select></td><td width="20%"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height:25px;">       
                    <table border="0" id="gui" name ="gui"  style="display:none"  cellpadding="0" cellspacing="0"  width="100%">
                        <tr><td><input type="text" id="GUI" name="GUI" value="<%=rs("GUIA") %>" class="inputs" /></td></tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height:25px;">        
                    <table border="0" id="pro" name ="pro"  style="display:none"  cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td  width="20%"><input type="text" id="RUC" name="RUC" value="<%=rs("RUC") %>" class="BAKES" onblur="BAKEtaller()"  onDblClick="helpPRO()"  /></td>
                            <td width="50%" ><input type="text" id="NOM" name="NOM" value="<%=rs("NOMPRO") %>" class="Bakes" onDblClick="helpPRO()"  /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height:25px;">       
                    <table border="0" id="def" name ="def"  style="display:none"  cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td width="50%">
                                <select id="DEF" name="DEF" class="inputs"  />
                                    <option value=""></option>
                                        <% rs2.open "select * from defectos ORDER BY 2", cnn %>
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
                             <td width="20%"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height:25px;">       
                    <table border="0" id="pie" name ="pie"  style="display:none" width="100%" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td width="50%">
                                <select id="PZA" name="PZA" class="inputs"  />
                                    <option value=""></option>
                                    <% rs2.open "select * from PIEZAS ORDER BY 2", cnn %>
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
                            <td width="20%"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height:25px;">
                    <table border="0" id="SRV" name ="SRV"  style="display:none" width="100%" cellpadding="0" cellspacing="0" width="100%">
                        <tr><td width="50%">
                            <select id="SER" name="SER" class="inputs"  />
                                <option value=""></option>
                                <% rs2.open "select * from SERVICIOS ORDER BY 2", cnn %>
                                <%if rs2.recordcount > 0 then %>
                                    <%RS2.MOVEFIRST %>
                                    <%DO WHILE NOT RS2.EOF %>
                                        <option value="<%=RS2("CODIGO")%>"><%=LTRIM(RTRIM(RS2("DESCRIPCION")))%></option>
                                        <%RS2.MOVENEXT %>
                                    <%LOOP %>
                                <%end if %>
                                <%RS2.CLOSE%>
	                    </select>
       	                    </td><td width="20%"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height:25px;">      
                    <table border="0" id="KON" name ="KON"  style="display:none" width="100%" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td width="50%">
                                <select id="CON" name="CON" class="inputs"  />
                                    <option value=""></option>
                                    <% rs2.open "select * from CONDICIONES ORDER BY 2", cnn %>
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
                            <td width="20%"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height:25px;">
                    <table border="0" id="FCH" name ="FCH"  style="display:none" width="100%" cellpadding="0" cellspacing="0" width="100%">
                        <tr><td class="Estilo8" width="10%"> Inicio</td>
                            <td width="1%" align="center"><A href="javascript:showCal('Calendar1')"><img height=16 
				                    src="../images/cal.gif" width=16 border=0></A></td>
                            <td ><input type="text" id="INI" name="INI" value="<%=formatdatetime("01/01/2014",2)%>" class="inputs" style="text-align:center" /></td>
                            <td class="Estilo8" width="10%"> Fin</td>
                            <td width="1%" align="center"><A href="javascript:showCal('Calendar2')"><img height=16 
				                            src="../images/cal.gif" width=16 border=0></A></td>
                            <td ><input type="text" id="FIN" name="FIN" value="<%=formatdatetime(now(),2)%>" class="inputs" style="text-align:center" readonly tabindex="-1"/></td>
                            <td width="20%"></td>
                        </tr>
                    </table>
  
                </td>
            </tr>
            <tr>
                <td style="height:25px;">        
                    <table border="0" id="femb" name ="femb"  style="display:none"  cellpadding="0" cellspacing="0" width="100%">
                        <tr><td width="1%" align="center"><A href="javascript:showCal('Calendar3')"><img height=16 	src="../images/cal.gif" width=16 border=0></A></td>
                            <td ><input type="text" id="FEMB" name="FEMB" value="" class="inputs" style="text-align:center" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height:25px;">        
                    <table border="0" id="face" name ="face"  style="display:none"  cellpadding="0" cellspacing="0" width="100%">
                        <tr><td  width="100%"><input type="text" id="FACE" name="FACE" value="" class="INPUTS" /></td>    </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height:25px;">        
                    <table border="0" id="fpro" name ="fpro"  style="display:none"  cellpadding="0" cellspacing="0" width="100%">
                        <tr><td  width="100%"><input type="text" id="FPRO" name="FPRO" value="" class="INPUTS" /></td></tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height:25px;">        
                    <table border="0" id="facp" name ="facp"  style="display:none"  cellpadding="0" cellspacing="0" width="100%">
                        <tr><td  width="20%"><input type="text" id="FACP" name="FACP" value="" class="INPUTS" /></td> </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height:25px;">        
                    <table border="0" id="serv" name ="serv"  style="display:none"  cellpadding="0" cellspacing="0" width="100%">
                        <tr><td  width="100%"><input type="text" id="SERV" name="SERV" value="" class="INPUTS" /></td></tr>
                    </table>

                </td>
            </tr>   
            <tr>
                <td style="height:25px;">        
                    <table border="0" id="corte" name ="corte"  style="display:none"  cellpadding="0" cellspacing="0" width="100%">
                        <tr><td  width="100%"><input type="text" id="CORTE" name="CORTE" value="" class="INPUTS" /></td></tr>
                    </table>

                </td>
            </tr>   
            <tr>
                <td style="height:25px;">
                    <table border="0" id="IDD" name ="IDD"  style="display:none" width="100%" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td class="Estilo8" width="10%"> Inicio</td>       
                            <td ><input type="text" id="ID2" name="ID1" value="" class="inputs" onchange="this.value=toInt(this.value)" /></td>
                            <td class="Estilo8" width="10%"> Fin</td>                          
                            <td ><input type="text" id="ID2" name="ID2" value="" class="inputs" onchange="this.value=toInt(this.value)" /></td>
                            <td width="20%"></td>
                        </tr>
                    </table>
  
                </td>
            </tr>
        </table>
    </td>
    </tr>
<%for i=1 to ubound(aconcepto)-3 %>
    <tr valign="middle">
        <td class="repor"><%=AConcepto(i)%></td>
        <td class="Estilo1">                <input type="checkbox" id="fil<%=i%>" name="fil<%=i%>" value="0" onClick="filtro(this,'<%=atbl(i)%>')" /></td>
        <td class="Estilo1" align="center"  style="display:none"> <input type="checkbox" id="sub<%=i%>" name="sub<%=i%>" value="0" onClick="filo(this)"/></td>
        <td class="Estilo1">                <input type="checkbox" id="ind<%=i%>" name="ind<%=i%>" value="0" onClick="orden(this,'<%=i%>')"/></td>
        <td width="30px"   >                <input type="text"     id="ord<%=i%>" name="ord<%=i%>" value=""  class="data" /></td>
        <td class="Estilo1">                <input type="checkbox" id="col<%=i%>" name="col<%=i%>" value="0" onClick="columna(this,'<%=i%>')"/></td>
        <td width="30px">                   <input type="text"     id="ubi<%=i%>" name="ubi<%=i%>" value="" class="data" /></td>
    </tr>
<%next%>
<tr valign="middle">
        <td class="repor">ID #</td>
        <td class="Estilo1">                <input type="checkbox" id="Checkbox5" name="fil<%=i%>" value="0" onClick="filtro(this,'IDD')" /></td>
        <td class="Estilo1" align="center"  style="display:none"> <input type="checkbox" id="Checkbox6" name="sub<%=i%>" value="0" onClick="filo(this)"/></td>
        <td class="Estilo1">                </td>
        <td width="30px"   >               </td>
        <td class="Estilo1">                </td>
        <td width="30px">                   </td>
    </tr>

<%for j=i to ubound(Aconcepto) %>
<tr style="display:none"><td class="repor"><%=aConcepto(j)%></td><td colspan="4"></td>
    <td style="display:none" class="Estilo1"><input type="checkbox" id="fil<%=j%>"   name="fil<%=j%>" value="0" onClick="filtro(this,'<%=atbl(j)%>')"/></td>
    <td style="display:none" align="center"> <input type="checkbox" id="sub<%=j%>"   name="sub<%=j%>" value="0" onClick="filo(this)"/></td>
    <td style="display:none">                <input type="checkbox" id="ind<%=j%>"   name="ind<%=j%>" value="0" onClick="orden(this,'<%=j%>')"/></td>
    <td style="display:none">                <input type="text"     id="ord<%=i%>"   name="ord<%=i%>" value=""  class="data" /></td>
    <!-- le estoy sumando 50 a j para que su valor siempre vaya al final -->
    <td class="Estilo1">                     <input type="checkbox" id="col<%=j%>"   name="col<%=j%>" value="<%=j+50%>" onClick="columna(this,'<%=j%>')"/></td>
    <td width="30px">                        <input type="text"     id="ubi<%=j%>"   name="ubi<%=j%>" value=""  class="data" /></td>
</tr>
<%next %>
<tr style="display:none"><td class="repor">ID #</td><td colspan="4"></td>
    <td style="display:none" class="Estilo1"><input type="checkbox" id="Checkbox1"   name="Checkbox1" value="0" onClick="filtro(this,'IDD')"/></td>
    <td style="display:none" align="center"> <input type="checkbox" id="Checkbox2"   name="Checkbox2" value="0" onClick="filo(this)"/></td>
    <td style="display:none">                <input type="checkbox" id="Checkbox3"   name="Checkbox3" value="0" onClick="orden(this,'<%=j%>')"/></td>
    <td style="display:none">                <input type="text"     id="Text1"       name="Text1"     value=""  class="data" /></td>
    <!-- le estoy sumando 50 a j para que su valor siempre vaya al final -->
    <td class="Estilo1">                     <input type="checkbox" id="Checkbox4"   name="Checkbox4" value="" onClick="columna(this,'<%=j%>')"/></td>
    <td width="30px">                        <input type="text"     id="Text2"   name="Text2" value=""  class="data" /></td>
</tr>

</table>
 <p></p>
<table  border="0" cellspacing="10" cellpadding="1" align="center">
  <tr>
    <td align="center" valign="middle" height="40px">
    <input type="button" value="" class="botonimagen2" onClick="emite()">
   
    <td align="center" valign="middle" height="40px">
    <input type="reset" value="" class="botonimagen" ></td>

     <td align="center" valign="middle" height="60px">
    <input type="buuton" value="" class="botonimagen3" onClick="emite(1)"></td>


    <td width="1px"><input type="text" id="EST" name="EST" value="<%=rs("CODEST") %>"  readonly tabindex="-1" disabled style="display:none"/></td>
  </tr>
</table>
<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe>
<script language="javascript" src="../includes/cal.js"></script>
<script type="text/jscript" language="jscript">


    addCalendar("Calendar1", "Elija una fecha", "INI", "thisForm")
    addCalendar("Calendar2", "Elija una fecha", "FIN", "thisForm")
    addCalendar("Calendar3", "Elija una fecha", "FEMB", "thisForm")
var opc  = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no," ;
	opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900" ;
	ubica = 1
	indice = 1
    
function filtro(obj, op) {
    if (obj.checked == true) {
        obj.value = '1'
        eval("document.all." + op + ".style.display = 'block'")
    }
    else {
        obj.value = '0'
        eval("document.all." + op + ".style.display = 'none'")
    }   
}

function filo(obj) {
    if (obj.checked == true)
    { obj.value = '1' }
    else
    { obj.value = '0' }
  
}
function orden(obj, op) {
    op = parseInt(op, 10)
    if (obj.checked == true) {
        obj.value = '1'
        eval("document.all.ord" + op + ".value=indice++")
    }
    else {
        obj.value = '0'
        eval("document.all.ord" + op + ".value=''")
    }
}
function columna(obj, op) {
    op = parseInt(op, 10)
    if (obj.checked == true) {
        obj.value = '1'
        eval("document.all.ubi" + op + ".value=ubica++")
    }
    else {
        obj.value = '0'
        eval("document.all.ubi" + op + ".value=''")
    }
}

function bakeest() {
cad = '../bake/bk_estilo2.asp?ecl=' + trim(thisForm.ECL.value) +  '&cli=' + '<%=cli%>'
/*  document.all.body10.style.display = 'block'
    document.all.body10.height = "150"
    document.all.body10.width = "100%"
*/    
document.all.body0.src=cad
}

function helpPRO() {
    if (trim(document.all.RUC.value) == '' && trim(document.all.NOM.value) == '') {
        alert("Por favor informe el RUC o Nombre del proveedor")
        return false;
    }
    cad = '../help/HLPproveedor.asp?ruc=' + trim(document.all.RUC.value) + '&nom=' + ltrim(document.all.NOM.value)
    window.open(cad, '', opc)
}

function BAKEtaller() {
  /*document.all.body10.style.display = 'block'
    document.all.body10.height = "350"
    document.all.body10.width = "100%"
    */
    document.all.body10.src = "../BAKE/TALLER_REAL.asp?RUC=" + trim(document.all.RUC.value) + '&NOM=' + ltrim(document.all.NOM.value);
}

function valida(){ 
   maximo = parseInt('<%=ubound(aconcepto)%>',10)
   ninguno = 0
   ninguno2 = 0

 
// llena arrays con los casilleros marcados
    for (d = 1; d <= maximo; d++) 
    {   // columnas a mostrar
        if (trim(eval("document.all.col" + d + ".value")) == '1') 
        {   aUbi[d] = eval("document.all.ubi" + d + ".value")
            ninguno++
        }
        // indexado por ....
        if (trim(eval("document.all.ind" + d + ".value")) == '1') 
            aOrd[d] = eval("document.all.ord" + d + ".value")
        // subtotales en .... 
         if (trim(eval("document.all.sub" + d + ".value")) == '1') 
            aSub[d] = eval("document.all.sub" + d + ".value")
         // filtros por ....
         if (trim(eval("document.all.fil" + d + ".value")) == '1') 
         {  aFil[d] = eval("document.all.fil" + d + ".value")
            if (trim(eval("document.all." + aInputs[d] + ".value")) == '') 
            {   if (aMsg[d].length > 0) 
                {    alert("Debe informar " + aMsg[d])
                     return false;
                 }
             }
             else
                 ninguno2++
         } 
                    
    }
    if (ninguno == 0) {
        alert("No ha seleccionado ninguna columna para el reporte")
        return false;
    }
    if (ninguno2 == 0) {
        alert("Por favor se requiere al menos un filtro para el reporte")
        return false;
    }
    // validacion para colocar el numero de inicio /fin de registro
    if (trim(document.all.IDD1.value) != '' && trim(document.all.IDD2.value) == '')
    {   alert("Debe informar el numero final")
        return false;
    }
    if (parseInt(trim(document.all.IDD1.value),10) < parseInt(trim(document.all.IDD2.value),10) ) {
        alert("El numero Inicial debe ser mayor que el numero final")
        return false;
    }


return true;
}
function emite(op) {
    if (valida() == false)
        return false;
    CAD  = '?cli=' + '<%=cli%>'
    CAD += '&EMP=' + '<%=cia%>'
    CAD += '&dcl=' + '<%=descli%>'
    CAD += '&EXCEL=' + op
    CAD += '&fil=' + aFil
    CAD += '&sbt=' + aSub
    CAD += '&Ord=' + aOrd
    CAD += '&Ubi=' + aUbi
    CAD += '&dat=' + aDat
    CAD += '&det=' + aDet
    CAD += '&ini=' + document.all.INI.value
    CAD += '&fin=' + document.all.FIN.value
    CAD += '&id1=' + trim(document.all.ID1.value)
    CAD += '&id2=' + trim(document.all.ID2.value)
    bala = ',' 
    for (m=1; m< aInputs.length-3; m++)
    bala += trim(eval("document.all." + aInputs[m] + ".value")) + ','
    CAD += '&val=' + bala + ',,,'
    window.open('MULTIREP2.ASP'+ CAD,"MultiReporte",opc)
 }
</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>

