 <%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<link href="../multisty.css" rel="stylesheet" type="text/css">
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<%'****************************************************
alm = request.QueryString("alm")	
tip = request.QueryString("tip")	
nro = request.QueryString("nro")	

TBL1 = "RS_ALMOVD_TALLA" + CIA
TBL2 = "RS_ALMOVD" + CIA 
TBL3 = "AL_TiposMov" + CIA 


KAD = "EXEC BuscaDetallePE  '"&ALM&"', '"&TIP&"', '"&NRO&"', '"&TBL1&"', '"&tbl2&"', '"&tbl3&"' "
response.Write(kad)
Set RS3 = Server.CreateObject("ADODB.Recordset")
	RS3.ActiveConnection = Cnn
	RS3.CursorType       = 3 'CONST adOpenStatic = 3
	RS3.LockType         = 1 'CONST adReadOnly = 1
	RS3.CursorLocation   = 3 'CONST adUseClient = 3

	RS3.Open KAD, Cnn
	CONT = 1
    'RESPONSE.WRITE(RS3.RECORDCOUNT)

	IF NOT RS3.EOF OR NOT RS3.BOF THEN	RS3.MOVEFIRST%>

<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = RS3.Fields.Count%>

<script language="jscript" type="text/jscript">
    oldrow = 1
function llena(t, pos) {
    return true
}

function dd2(ff) {	// LLENA TEXTBOX ADICIONALES AL COMUN
    // LOS DEL COMUN SON CODIGO Y DESCRIPCION
    var t = document.all.TABLA;
    var pos = parseInt(ff);
    dd(ff);
}
</script>
<title>Detalle OC <%=oc%></title>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ><HTML>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body style="margin-top:0; margin-left:0; margin-right:0;" >
<%'*********************************************************************%>
        <table id="TABLA" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
        <%'**************************%>
        <%'LINEA DE CABECERA STANDAR %>
        <%'**************************%>
        <%LIMITE =  RS3.fields.count - 1	%>
        <tr bgcolor=#006699 >
            <%for I=0 to LIMITE %>
	            <td align="center" class="Estilo8"><%=RS3.FIELDS(I).NAME%></td>
            <%next%>	
        </tr>
        <%IF  RS3.EOF THEN response.end%>
        <%DO WHILE NOT RS3.EOF%>
	        <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
                onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
	            id="fila<%=Trim(Cstr(cont))%>" >
	            <%FOR i=0 TO LIMITE%>
		            <td align="center" class="estilo5"><%=RS3.FIELDS.ITEM(I)%></td>
	            <%NEXT%>
	        </tr>
	        <%RS3.MOVENEXT%>
	        <%CONT = CONT + 1%>
	        <%LOOP%>
        </table>

    </td>
</tr>
</table>
<script language="jscript" type="text/jscript">
rec = parseInt('<%=rs3.recordcount%>',10)
if (rec > 0)
    dd2('1')
</script>
</form>

</BODY>
</HTML>
