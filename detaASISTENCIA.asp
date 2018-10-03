<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<%

INI = Request.QueryString("INI")
if INI = "" or isnull(INI)  or INI = " " then
	INI = ""
end if

FIN = Request.QueryString("FIN")
if fIN = "" or isnull(fIN)  or fIN = " " then
	fIN = ""
end if

cad =   " exec PLANILLAS..sp_SCA_Report_DiarioAsistencia @cod_empresa='0001',@cod_sucursal='001',@cod_tipo_planilla='02', " &_
        " @c_costos='100111111,100111112,100111122,100111123,100111128,100111132,100114110,100121150,100121160,100121250,100121251,100121270," & _
        " 100122100,100122270,200211111,200211112,200211118,200211119,200211122,200211123,200211124,200211125,200211134,200211136,200211137, " & _
        " 200211170,200212111,200212112,200212118,200212122,200212124,200212134,200212136,200212137,200221150,200221160,200221250,200221251,200221270, " & _
        " 200222270,300321200,300321300,300322200,300322300,300323100,300323300,400421300,400422300,400423300,400424200,400424300',          " & _
        " @cod_grupo_menu='1002',@cod_usuario='a',@filtro='0',@orden='2',@tip_codigo='1',@tipo='1',@fecha_inicio='"&INI&"',                  " & _
        " @fecha_final='"&FIN&"'  "


	RS.Open CAD, Cnn
' contador de lineas
	CONT = 1
IF RS.RECORDCOUNT > 0 THEN 
	RS.MOVEFIRST%>
    <script type="text/jscript">
        marca = 0	
    </script>
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
<link href="reportes/CalendarControl.css"   rel="stylesheet" type="text/css">
<script src="reportes/CalendarControl2.js"     language="javascript"></script>
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
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            id="fila<%=Trim(Cstr(cont))%>" >    
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
<%end if%>

<%rs.close%>
<%SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING  %>
</form>
</body>
</html>
