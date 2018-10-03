<%@ Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="multisty.CSS" />
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<script type="text/jscript" language="jscript">
// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES idENTITY
var auto=1;
var url = '../PIEZAS.asp?'
var pag = 'PIEZAS.asp?pos='
var alias = 'PIEZAS'
var pagesize = 20
var TBL = 'PIEZAS'
var PK  = 'CODIGO'
var DS  = 'DESCRIPCION'
var largo = 2  // es el largo del PK (se usa en el dataentry)
var largo2 = 50  // es el largo del descriptor
var oldrow =1
var olddata =''
var chk = ''
</script>
<%' indicar el submenu desde donde es llamado
submenu = "SUBMENU.ASP?TIPO=3"
'****************************************
' Definir el tamaño de la pagina
Dim pagesize 
if nivel = 1 then	pagesize = 10 else pagesize =20
'****************************************
' Definir el NOMBRE de la Tabla base
Dim ALIAS
alias = "PIEZAS"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
Dim indice
indice = "CODIGO"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
Dim urlBase
urlBase = "PIEZAS.asp"
'*********************************************
' Definir el nombre del Primary Key
Dim pk
pk = "CODIGO"
'*********************************************
' Definir nombre de la columna descriptor
Dim ds
ds = "DESCRIPCION"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
Dim TITULO
TITULO = "PIEZAS"
%>
<script type="text/jscript" language="jscript">
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'comun/INSERTBL.asp?'

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
</head>
<body>
<table id="Table1" align="center"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="1"  cellspacing="2"  border="0" ><tr>
<td class="Estilo2"><%=titulo%></td>
</tr>
</table>
<form name="thisForm" id="thisForm" method="post" action="PIEZAS.asp">
<%
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if
des = Request.QueryString("des")
if des = "" or isnull(des)  or des = " " then
	des = ""
end if
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT top  "&pagesize&"  " & _
		" "&pk&","&ds&", USUARIO, FECHA, ESTADO AS EDO " & _
		" from "&ALIAS&"  WHERE " & _
        " ESTADO = 'A' and "
        if len(TRIM(DES))>0 then
            cad = cad + " "&DS&" >= '"&DES&"' " & _
            "  ORDER BY "& ds &"  " 
        else
            cad = cad+  " "&indice&" >= '"& POS &"'" & _
            " ORDER BY "& indice &"  " 
        end if
	   
		'response.Write(cad)
%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNTBL.ASP"-->
<%	RS.Open CAD, Cnn
    SINDATOS =1
	CONT = 1
	IF  RS.RECORDCOUNT > 0 THEN 	
		RS.MOVEFIRST
	ELSE
		RESPONSE.Write("TABLA SIN DATOS")	
		SINDATOS =0
		'RESPONSE.End()
	END IF	
%>

<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count %>
<%'*********************************************************************%>
<table id="TABLA" align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor="olive" >
<%	IF NIVEL > 1 THEN LIMITE =  rs.fields.count - 3 ELSE  LIMITE =  rs.fields.count - 1%>
<%for I=0 to LIMITE %>
	<td align="center">
		<font face="arial" color="IVORY" size="1">
		<b><%=RS.FIELDS(I).NAME%></b>
		</font>
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
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" >

		
        
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
		<img src="images/PRINT.png" alt="IMPRESION"
			onclick="imprime()"
			style="cursor:pointer;" />	
	</td>
  	</tr>
	</table>
<%END IF %>
<iframe frameborder="1" style="visibility:hidden" height="1" width="10" id="ACTIV" name="ACTIV"></iframe>
<table	width="100%" border="0" id="DATAENTRY" cellpadding="0" cellspacing="0"  >
   <tr>
   		<td>
            <table	align="center" width="100%" bgcolor="WHITE" border="0" cellpadding="2" cellspacing="0">
              <tr valign="middle"> 
                <td width="5%" bgcolor="<%=(Application("barra"))%>" align= "right">
                 <font face="arial" size="1" color="MidnightBlue"><b>CODIGO :</b></font>
                 </td>
                <td bgcolor="WHITE" width="5%" valign="middle"><input type="text" id="COD" name="COD" class="DATOSGRANDE" tabindex="-1" readonly="readonly" /></td>
                <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT"> 
                	<font face="arial" size="1" color="#000066"><b>DESCRIPCION :</b></font> </td>
                <td bgcolor="#FFFFFF" WIDTH="30%"><input type="text" id="DES" name="DES"  style="width:100%"  /></td>
  
        </tr>
 </table>       
<table border="0" align="center"  cellspacing="3">
    <tr>
        <td>
            <img src="images/NEW.png"  alt="REGISTRO EN BLANCO"
                onclick="NUEVO_onclick()" style="cursor:pointer;" />	
        </td>
        <td>		
            <img src="images/ok.png" alt="GRABAR"
                onclick="GRABAR_onclick()" 
                style="cursor:pointer;" />	
        </td>		
        <td>		
            <img src="images/DEL.png" alt="ELIMIAR REGISTRO"
                onclick="elimina()" style="cursor:pointer;" />	
        </td>		
    </tr>
</table>


<script type="text/jscript" language="jscript">
rec = parseInt('<%=rs.recordcount%>', 10)
   
if (rec > 0) 
    dd2('1');
   
eval("DATAENTRY.style.display='block'");
thisForm.COD.maxLength = largo
thisForm.DES.maxLength = largo2
if (rec <= 0) {
    NUEVO_onclick()
    SS = trim('<%=SINDATOS%>')
    if (SS == "1") {
        thisForm.kod.maxLength = largo
        thisForm.ds.maxLength = largo2
    }
}
</script>

<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
</form>
</body>
</html>
