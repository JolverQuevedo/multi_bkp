<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<script>
// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES IDENTITY
var auto=0;
var url = '../USUARIOS.asp?pos='
var alias = 'USUARIOS'
var TBL = 'USUARIOS'
var PK  = 'USUARIO'
var DS  = 'NOMBRES'
var pag = 'usuarios.asp'
var chk = ''
var marca = 0
var oldrow = 1
var largo = 4  // es el largo del PK (se usa en el dataentry)
var largo2 = 10  // es el largo del descriptor
var oldrow = 1
var olddata = ''
var funcionalidad = 'comun/inserusu.asp?pos='
mm = -1
// necesito la misma variable en jscript y vbscript para la navegacion
var pagesize = 10

function mas(t, pos) {
    thisForm.NOM.value = ltrim(t.rows(pos).cells(2).innerText);
    return true;
}
function newrec() {
    thisForm.NOM.value = ''
}

</script>
<%Dim pageSize 
pageSize = 10
'****************************************
' Definir el NOMBRE de la Tabla base
'****************************************
Dim ALIAS
alias = "USUARIOS"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = "USUARIO"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
'*********************************************
Dim urlBase
urlBase = "USUARIOS.asp"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
'*********************************************
Dim TITULO
TITULO = "MANTENIMIENTO DE USUARIOS"
%>
<script>
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'comun/INSERUSU.asp?'

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	
	dd(ff);
}
</script>
<%
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = "0"
end if
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT top  "&pageSize&"  " & _
		" * " & _ 
		" from "&ALIAS&" " & _
		" where "&indice&" >= '"& POS &"'" & _
		" ORDER BY "& indice &"  " 
%>
<link href="multisty.css" rel="stylesheet" type="text/css">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNtbl.ASP"-->
<%	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN	RS.MOVEFIRST%>

<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ><HTML>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body topmargin=10 leftmargin=20 rightmargin=20 border=0 text="#000000">
<table align="center"  bordercolor="#FFFFFF"  cellpadding="2"  cellspacing="1"  border="1" >
	<tr><td align="center" class="Estilo4"><%=titulo%></td></tr>
</table>

<%'*********************************************************************%>
<table id="TABLA" align="center"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" >

<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor=#006699 >
<%		LIMITE =  rs.fields.count - 1	%>
<%for I=0 to LIMITE %>
	<td align="center" class="Estilo8">
		<%=RS.FIELDS(I).NAME%>
	</td>
<%next%>	
</tr>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE NOT RS.EOF%>

		 <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" >

	<%FOR i=0 TO LIMITE%>
		<td align="center" class="estilo5">
		<%=RS.FIELDS.ITEM(I)%>
	</td>
	<%NEXT%>
	</tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
	<%rs.movelast%>
    </td>
  </tr>
</table>
<table border=0 align=center  cellspacing=5>
	<tr>
		<td > 
			<img src="images/primera.png" style="cursor:pointer;" onclick="primera()" alt="PRIMERA PAGINA">
		</td>
		<td >
			<img src="IMAGES/PREV.png" alt="PAGINA ANTERIOR" onclick="atras()" style="cursor:pointer;"> 
		</td>
		<td >
			<img src= "images/up.png" alt="REGISTRO ANTERIOR" onclick="retrocede()" style="cursor:pointer;"> 
		</td>
		<td >
			<img src="images/down.png" alt="REGISTRO SIGUIENTE" onclick="avanza()"  style="cursor:pointer;"> 
		</td>
		<td>
			<img src="images/next.png" alt="PAGINA SIGUIENTE" onclick="pagina()" style="cursor:pointer;"> 
		</td>
		<td>
			<img src= "images/last.png" alt="ULTIMA PAGINA" onclick="ultima()" style="cursor:pointer;"> 
		</td>
		<td>		
		<img src="images/PRINT.PNG" alt="IMPRESION" onclick="imprime()" style="cursor:pointer;">	
	</td>
    <td>		
		<img src="images/lupa.PNG" alt="Busca" onClick="document.all.seeker.style.display='block'" style="cursor:pointer;">	
	</td>
    <td id="seeker" name="seeker" style="display:none">
	<table align="center"  width="100%" bordercolor="#FFFFFF" bgcolor="lightgrey"  cellpadding="0"  cellspacing="1"  border="1" >
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>Usuario</b></font></td>
		<td><input id="cd" name="cd" value=""/> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>Nombre</b></font></td>
		<td><input id="ds" name="ds" value="" /> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>' align="center" style="cursor:pointer" onClick="document.all.seeker.style.display='none'">
	        <font face="arial" color="red" size="1">
		    <b><u>(X) Cerrar</u></b></font></td>
		<td  bgcolor='<%=Application("COLOR2")%>' align="CENTER" style="cursor:pointer" onClick="BUSCA('<%=urlBase%>','<%=alias%>')">
		<font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><U>FILTRAR</U></b></font></td>
	  </tr>
	 </table> 
	</td>			
	</tr>
</table>
<%END IF %>
<table	width="100%" border="0" id="DATAENTRY" name=DATAENTRY style="display:block;">
<tr><td>
        <table	align="center" cellpadding="2" cellspacing="1"  bgcolor='<%=(Application("color1"))%>' border="1">
          <tr valign="middle"> 
            <td width="10%" class="Estilo8" align="right">
              USUARIO :
             </td>
            <td bgcolor=WHITE WIDTH=20% valign=middle> 
              <input type="text" id="COD" name="COD" style="width:70%" valign=middle maxlength=10	tabindex="-1" readonly maxlength="4">
            </td>

           <td width="10%" class="Estilo8" align="right"> 
              PASSWORD :
            <td bgcolor=WHITE > 
              <input type="text" id="DES" name="DES" STYLE="WIDTH:100%"
              MAXLENGTH=10>
            </td>
          </tr>
           <tr > 
           <td width="10%" class="Estilo8" align="right">
              NOMBRES :
            <td BGCOLOR=WHITE COLSPAN=5> 
              <input type="text" id="NOM" name="NOM" STYLE="WIDTH:100%"
              MAXLENGTH=50>
            </td>
          </tr>
        </table>
<table border=0 align=center  cellspacing=3>
<tr>
		<td>
		<img src="images/NEW.png"  alt="REGISTRO EN BLANCO" onclick="NUEVO_onclick()" style="cursor:pointer;">	
	</td>
	<td>		
		<img src="images/ok.png" alt="GRABAR" onclick="GRABAR_onclick()" style="cursor:pointer;">	
	</td>			
	<td>		
		<img src="images/DEL.png" alt="ELIMIAR REGISTRO"
			onclick="elimina()" style="cursor:pointer;">	
	</td>		
</tr>
</table>
</tr></td>
</table>
<iframe  width="100%" src="" id="ACTIV" name="ACTIV" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe>
<script>
dd2('1');
</script>  
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

</form>
<script language="jscript" type="text/jscript">


</script>

</BODY>
</HTML>
