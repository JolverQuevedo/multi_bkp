<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<script>
// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES IDENTITY
    var auto=0;
    var url = '../menus.asp?pos='
    var alias = 'SUBMENU'
    var TBL = 'SUBMENU'
    var PK  = 'SUBMENU'
    var DS  = 'descripcion'
    var pag = 'SUBMENU.asp?POS='
    var chk = ''
    var marca = 0
    var oldrow = 1
    var largo = 4  // es el largo del PK (se usa en el dataentry)
    var largo2 = 10  // es el largo del descriptor
    var oldrow = 1
    var olddata = ''
    var funcionalidad = 'comun/insersubmenu.asp?pos='
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
alias = "submenu"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = "submenu"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
'*********************************************
Dim urlBase
urlBase = "submenu.asp"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
'*********************************************
Dim TITULO
TITULO = "MANTENIMIENTO DE Usr Cia"
%>
<script>
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'comun/insermenu.asp?'

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
CAD =	" select USUARIO,NOMBRES from usuarios " 
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
    <table  bgcolor='<%=(Application("color1"))%>' align="center" width="70%">
        <tr>
            <td class="Estilo8">Seleccione Usuario</td>
            <td>
                <select id="MENU" class="DATOSGRANDE"  onChange="cambia(document.getElementById('mm').value,document.getElementById('menu').value)">
		            <option value="NULL"></option>
		            <% DO WHILE NOT RS.EOF%>
		            <option value='<%=RS("usuario") %>'><%=RS("usuario")%>-<%=RS("nombres") %></option>
		            <%RS.MOVENEXT %>
		            <%LOOP %>
		            </select> 
                    
            </td>
        </tr>
        <tr>
            <%
                rs.close
                kad="select * from [VIEW_CIAS]"
                RS.Open kad, Cnn
                IF NOT RS.EOF OR NOT RS.BOF THEN	RS.MOVEFIRST
                %>
            <td class="Estilo8">Seleccione Almacen</td>
            <td>
                <select id="mm" class="DATOSGRANDE"  onChange="cambia(document.getElementById('mm').value,document.getElementById('menu').value)">
		            
		            <% DO WHILE NOT RS.EOF%>
		            <option value='<%=RS(0) %>'><%=RS(1)%></option>
		            <%RS.MOVENEXT %>
		            <%LOOP %>
		            </select> 
                    
            </td>
        </tr>
    </table>


    

    <iframe id="MIIFRAME" name="MIIFRAME" width="100%" height="500px"  frameborder="0"></iframe>









    


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
    

    function cambia(a, b) {
        var tabla = "RS_USUALM" + a;
        
        document.all.MIIFRAME.src = "http://intranet/multi/comun/buscausralm.asp?usr="+b+"&tabla="+tabla+"&cia="+a;
    }
    
</script>

</BODY>
</HTML>
