<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>
<script type="text/jscript">
var chk = ''
var marca = 0
var oldrow = 1
var url = '../DETAacatemp.asp?'
var alias = 'VIEW_POS_movi'
var TBL = 'VIEW_POS_movi'
var PK = 'ID'
var DS = 'PO'
var pagesize = 20
var oldrow = 1
var olddata = ''
var chk = ''
var ficha = 'fichaPOSMOVItem.asp?po='
mm=-1
function fBuscar(color)
{   var cad  = "SEARCH/buscaDOR.asp?pos="+color
        cad += '&tbl=POS'
        cad += '&col=POS'
        cad += '&col2=cliente'
        cad += '&msg=NO EXISTEN POS PARA ESTE CLIENTE'
        cad += '&pos2=' + '<%=trim(request.QueryString("POS"))%>'
        cad += '&url=../DETAacatemp.asp?POS=' + '<%=trim(request.QueryString("POS"))%>' + '&tem=' + '<%=trim(request.QueryString("tem"))%>'
    document.all.bake.src=cad
}
function fReporte() {
    cad = 'REPORTES/prnTBL.asp?tbl='+ alias
    window.open(cad)
}

</script>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/COMUNdetaACAtem.ASP"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<%Dim pageSize 

if len(request.QueryString("pag")) > 0 then pageSize  = cint(request.QueryString("pag")) else pageSize = 20

'****************************************
' Definir el NOMBRE de la Tabla base
Dim ALIAS
alias = "VIEW_POS_movi"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
Dim indice
indice = "ID"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
Dim urlBase
urlBase = "DETAacabados.asp"
'*********************************************
' Definir el nombre del Primary Key
Dim pk
pk = "ID"
'*********************************************
' Definir nombre de la columna descriptor
Dim ds
ds = "PO"

' Captura la posición inicial del browse
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if
CLIENTE= POS
PO = Request.QueryString("po")
if po = "" or isnull(po)  or po = " " then
	po = ""
end if
ubi = Request.QueryString("ubi")
if ubi = "" or isnull(ubi)  or ubi = " " then
	ubi = ""
end if
id = Request.QueryString("id")
if id = "" or isnull(id)  or id = " " then
	id = ""
end if
'****************************************************
' si viene del buscador hay que ver si existe la PO
' sino, se manda mensaje y se pone en la primera PO
'****************************************************
cad = "select po from MODELADOR..pos where po = '"&po&"' and cliente = '"&pos&"'  "
rs.open cad, cnn
if rs.recordcount <=0 then po = ""
rs.close

'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
dato = ltrim(rtrim(po))&ltrim(rtrim(ubi))&ltrim(rtrim(id))
tem  = trim(request.QueryString("tem"))

CAD =	" SELECT TOP "&PAGESIZE&" [ID] , PO, CORTE, UBI, " & _
        " ESTCLI, ESTILO, TEMPO, COLOR,MOV, GUIA, GUIA2 ,       " & _
        "  NOMPRO AS TALLER,  DESSER,                    " & _
        " (C0+C1+C2+C3+C4+C5+C6+C7+C8+C9) AS TOT         " & _
        " FROM VIEW_POS_movi AS T1                       " & _
		" WHERE CODCLI  = '"&POS&"'  and                 " & _
        " tempo = '"&trim(request.QueryString("tem"))&"'  and "

if len(trim(request.QueryString("FILTROS"))) > 0 then
filtros = trim(request.QueryString("FILTROS"))
    CAD = CAD + " ltrim(rtrim(id)) = '"&FILTROS&"' "                    
    cad = cad +  " order by id "
elseif len(trim(request.QueryString("FILTROpo"))) > 0 then
    filtroPO = trim(request.QueryString("FILTROPO"))
    CAD = CAD + " ltrim(rtrim(PO)) = '"&FILTROPO&"' "                    
    cad = cad +  " order by PO "
elseif len(trim(request.QueryString("FILTROGUI"))) > 0 then
    filtroGUI = trim(request.QueryString("FILTROGUI"))
    CAD = CAD + " ltrim(rtrim(GUIA)) = '"&FILTROGUI&"' "                    
    cad = cad +  " order by GUIA "
elseif len(trim(request.QueryString("FILTROcor"))) > 0 then
    filtrocor = trim(request.QueryString("FILTROcor"))
    CAD = CAD + " ltrim(rtrim(corte)) = '"&FILTROcor&"' "                    
    cad = cad +  " order by corte "
else
    CAD = CAD +     " id  >= '"&dato&"'  " 
    CAD = CAD +     " order by id " 
end if

' " and T1.ESTADO = 'A'                           " & _
'response.Write(cad)
' abre recordset	
	RS.Open CAD, Cnn
' contador de lineas
	CONT = 1
IF RS.RECORDCOUNT > 0 THEN 
	RS.MOVEFIRST%>
<%else%>
    <script type="text/jscript">
	    marca = 1	
    </script>
<%END IF%>
<script type="text/jscript">
    mm = '<%=rs.recordcount%>'
    var funcionalidad = ''
</script>
<%' Nro de columnas regresadas por el objeto RECORDSET	
LIMITE = rs.Fields.Count-1
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<link rel="stylesheet" type="text/css" href="MULTISTY.CSS" />
<html xmlns="http://www.w3.org/1999/xhtml">
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<html>
<head>
<title></title>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" >
<form name="thisForm" method="post" action="">
<table id="TABLA" align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr class="Estilo55">
<%for I=0 to LIMITE %>
	<td align="center">
		<%=RS.FIELDS(I).NAME%>
	</td>
<%next%>	
</tr>
<%'*****************************%>
<%' MUESTRA EL GRid (2 colorES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE NOT RS.EOF%>
    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color2"))
                else
	            response.write(Application("color1"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" ondblclick="ficha('<%=cont%>')" >    
	<%for i=0 to LIMITE%>
		<td>
			<font face="Arial, Helvetica, sans-serif" color="MidnightBlue" size="1">
			<b><%=trim(RS.FIELDS.ITEM(I))%></b>&nbsp;
			</font>
		</td>
	  <%NEXT%>	
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
  </tr>
	<%loop%>
</table>
<table border="0" align="center"  cellspacing="5">
	<tr valign="top">
		<td > 
			<img src="images/primera.png" style="cursor:pointer;"
			onclick="primera('<%=urlBase%>')" 
			alt="PRIMERA PAGINA" />
		</td>
		<td >
			<img src="IMAGES/PREV.png" alt="PAGINA ANTERIOR"
				onclick="atras(alias, '<%=indice%>')" 
				style="cursor:pointer" /> 
		</td>
		<td >
			<img src= "images/up.png" alt="REGISTRO ANTERIOR"
				onclick="retrocede()" style="cursor:pointer" /> 
		</td>
		<td >
			<img src="images/down.PNG" alt="REGISTRO SIGUIENTE"
				onclick="avanza()"  style="cursor:pointer" /> 
			
		</td>
		<td>
			<img src="images/next.PNG" alt="PAGINA SIGUIENTE"
				onclick="pagina('<%=urlBase%>'+'?pos=')" 
				style="cursor:pointer" /> 
		</td>
		<%  ' PARA LA FUNCION ULTIMA : 
			' enviar el nombre de la página de retorno
			' el nombre de la tabla 
			' el nombre de la columna de primary key%>
		<td>
			<img src= "images/last.png" alt="ULTIMA PAGINA"
			 onclick="ultima('<%=urlBase%>','<%=ALIAS%>',
			'<%=RS.Fields.Item(0).Name%>')" 
			style="cursor:pointer;" /> 
		</td>
	<td>		
		<img src="images/PRINT.png" alt="IMPRESION" onclick="imprime()"	style="cursor:pointer;" />	
	</td>
     <td>		
		<img src="images/PRINT2.png" alt="Resumen" onclick="resumen()" width="28"	style="cursor:pointer;" />	
	</td>
     <td>		
		<img src="images/suma.png" alt="Resumen" onclick="acumula()" width="28"	style="cursor:pointer;" />	
	</td>
    <td><img src="images/LUPA.PNG" onClick="document.all.seeker.style.display='block'" alt="BUSCAR" style="cursor:pointer;" /></td>
	<td id="seeker" name="seeker" style="display:none">
	<table align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="0"  cellspacing="1"  border="1" >
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><%=pk%></b></font></td>
		<td><input id="kod" name="kod" value="" /> </td>    
	  </tr>
      <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>PO</b></font></td>
		<td><input id="OP" name="OP" value="" /> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>GUIA</b></font></td>
		<td><input id="GUI" name="GUI" value="" /> </td>    
	  </tr>
      <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>CORTE #</b></font></td>
		<td><input id="COR" name="COR" value="" /> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>' align="center" style="cursor:pointer" onClick="document.all.seeker.style.display='none'">
	        <font face="arial" color="red" size="1">
		    <b><u>(X) Cerrar</u></b></font></td>
		<td  bgcolor='<%=Application("COLOR2")%>' align="center" style="cursor:pointer" onClick="BUSCA('<%=trim(request.QueryString("POS"))%>')">
		<font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><U>FILTRAR</U></b></font></td>
	  </tr>
	 </table> 
	</td>	
	</tr>
	</table>
<%end if%>


<table border="0" align="center"  cellspacing="3">
    <tr>
        <td><img src="images/NEW.PNG"  alt="REGISTRO EN BLANCO" onClick="NUEVO()" style="cursor:pointer;" /></td>

        <td><img src="images/DEL.PNG" alt="ELIMIAR REGISTRO" onClick="elimina()" style="cursor:pointer;" /></td>
        <td>&nbsp;</td>		
        <td><img src="images/home.png" style="cursor:pointer;" border="0" onclick="primera('<%=urlBase%>')" alt="PRIMERA PAGINA" /></td>
        <td>&nbsp;</td>		
        <td><img src="images/guia.PNG" alt="Prepara Guia" onClick="guia()" style="cursor:pointer;" /></td>
        <td><img src="images/edit.PNG" alt="INGRESO POR ESTILO-PROVEEDOR" onClick="salida()" style="cursor:pointer;" />S/Guia</td>
        <td><img src="images/go.PNG"   alt="INGRESO CON GUIA MODELADOR" onClick="salida2()"  style="cursor:pointer;" />Con guia MOD</td>
    </tr>
</table>
<input id="PO" name="PO" style="display:none">
<input id="UBI" name="UBI" style="display:none">
<input id="ID" name="ID" style="display:none">
<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe>
<%rs.close%>

<script language="jscript" type="text/jscript">
if (marca == 0)
    dd('1');
else
    NUEVO()

top.window.AGRANDA()

function NUEVO() {
    window.open('fichaPOSmoviTEM.asp?PO=AUTO&cli=' + '<%=pos%>' + '&TEM=' + '<%=trim(request.QueryString("tem"))%>', 'Ficha_Acabados', opc)
    return true;
}
function salida() {
    window.open('fichasaleposmovi_TEMPORADA.asp?PO=AUTO&cli=' + '<%=pos%>' + '&TEM=' + trim('<%=trim(request.QueryString("tem"))%>'), 'Ficha_Acabados', opc)
    return true;
}
function salida2() {
    window.open('fichasaleposmovi2.asp?PO=AUTO&cli=' + '<%=pos%>', 'Ficha_Acabados', opc)
    return true;
}
function elimina(ff) {
    var t = document.all.TABLA;
    var pos = parseInt(oldrow, 10)
    dd = trim(t.rows[pos].cells[0].innerText);

    var si
    si = confirm("¿ Confirma la Eliminación del Parte " + dd + " ? "); 
    if (si == false)
    { return false; }
 /*     
    document.all.body0.style.display = 'block'
    document.all.body0.height = "350"
    document.all.body0.width = "100%"
*/
    cad = "comun/delepoMOVI.asp?id=" + dd + '&cli=' + '<%=pos%>'
    cad += '&gui=' + ltrim(t.rows[pos].cells[7].innerText)
   // alert(cad)
    document.all.body0.src = cad
 
    return true;
}
function ficha(ff)
{ var t = document.all.TABLA;
    var pos = parseInt(ff,10)
    cod = ltrim(t.rows[pos].cells[0].innerText);
    window.open('fichaPOSMOVItem.asp?cod=' + cod + '&cli=' + '<%=pos%>'+ '&tem='+ '<%=trim(tem) %>',"Ficha_Acabados", opc)
    return true;
}
function guia() {
    window.open('FichaGuiaMOVItem_temporada.asp?cli=' + '<%=pos%>' + '&tem=' +   '<%=trim(request.QueryString("tem"))%>', "Guia_Acabados", opc)
    return true;
}
function resumen() {
    var opc2 = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc2 += "menubar=no,resizable=yes,scrollbars=yes,left=400,top=0,height=550,width=400";

    window.open('reportes/resumenpo.asp?cli=' + '<%=trim(request.QueryString("POS"))%>', '', opc2)
}
function acumula() {
    var opc2 = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc2 += "menubar=no,resizable=yes,scrollbars=yes,left=400,top=0,height=550,width=400";

    window.open('reportes/acumulaPOmovim.asp?cli=' + '<%=trim(request.QueryString("POS"))%>', '', opc2)
}
//pagina de inicio
pag = 'DETAacatemp.asp?pos=' + '<%=trim(request.QueryString("pos"))%>'
</script>    
<%SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING  %>
</form>
</body>
</html>
