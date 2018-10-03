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
var url = '../DETAacabados.asp?'
var alias = 'VIEW_POS_movi'
var TBL = 'VIEW_POS_movi'
var PK = 'ID'
var DS = 'PO'
var pagesize = 20
var oldrow = 1
var olddata = ''
var chk = ''
var ficha = 'fichaPOSMOVI.asp?po='
mm=-1
function fBuscar(color)
{   var cad  = "SEARCH/buscaDOR.asp?pos="+color
        cad += '&tbl=POS'
        cad += '&col=POS'
        cad += '&col2=cliente'
        cad += '&msg=NO EXISTEN POS PARA ESTE CLIENTE'
        cad += '&pos2=' + '<%=trim(request.QueryString("POS"))%>'
        cad += '&url=../DETAacabados.asp?POS=' + '<%=trim(request.QueryString("POS"))%>'
    document.all.bake.src=cad
}
function fReporte() {
    cad = 'REPORTES/prnTBL.asp?tbl='+ alias
    window.open(cad)
}

</script>
<!--#include file="includes/Cnn.inc"-->

<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<%
' Captura la posición inicial del browse
POS = Request.QueryString("oc")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if

'****************************************************
' si viene del buscador hay que ver si existe la PO
' sino, se manda mensaje y se pone en la primera PO
'****************************************************
cad =   " Select OC_CITEM, OC_CCODIGO, OC_CDESREF, OC_CUNIDAD, CONVERT(NUMERIC(13,3),OC_NCANORD) AS OC_NCANORD, " & _
        " OC_NPREUNI, CONVERT(NUMERIC(13,3),OC_NCANTEN) AS OC_NCANTEN, CONVERT(NUMERIC(13,3),                   " & _
        " OC_NCANSAL-OC_NCANTEN) AS PORATENDER,  OC_NCANSAL, OC_NANCHO, OC_NCORTE, OC_CESTADO, OC_NPREUN2,      " & _
        " OC_CNUMORD, OC_NIGVPOR From RSFACCAR..CO0001MOVD Where  OC_CNUMORD= '"&pos&"' ;                       "
rs.open cad, cnn
if rs.recordcount <=0 then po = ""
rs.close
	
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
        
        <td>&nbsp;</td>		
        <td><img src="images/guia.PNG" alt="Prepara Guia" onClick="guia()" style="cursor:pointer;" /></td>
        <td><img src="images/edit.PNG" alt="SALIDAS" onClick="salida()" style="cursor:pointer;" /></td>
        <td><img src="images/go.PNG"   alt="SALIDAS_NUEVO" onClick="salida2()"  style="cursor:pointer;" /></td>
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
    window.open('fichaposmovi.asp?PO=AUTO&cli=' + '<%=pos%>','Ficha_Acabados', opc )
    return true;
}

</script>    
<%SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING  %>
</form>
</body>
</html>
