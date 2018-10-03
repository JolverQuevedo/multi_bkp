<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>

<script type="text/jscript" language="jscript">
oldrow = 1
function llena(t, pos) {
    // ACA ES DONDE SE PASAN LOS DATOS DE LOS PARTES DE E/S AL GRID SUPERIOR PARA ASIGNAR FACTURAS POR PARTE
    alma = ltrim(t.rows(pos).cells(0).innerText);
    PARTE = ltrim(t.rows(pos).cells(3).innerText);
    tip = ltrim(t.rows(pos).cells(2).innerText);
    parent.window.document.all.almacen.value = alma
    parent.window.document.all.pentr.value = PARTE
    parent.window.document.all.tipoes.value = tip
    return true
}
function dd2(ff) {	// LLENA TEXTBOX ADICIONALES AL COMUN
    // LOS DEL COMUN SON CODIGO Y DESCRIPCION
    var t = document.all.TABLA;
    var pos = parseInt(ff);
    dd(ff);
}
</script>
<link href="../multisty.css" rel="stylesheet" type="text/css">
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<%'****************************************************
doc = request.QueryString("doc")	


TBL1 = "RSFACCAR..AL" + CIA + "MOVC"
TBL2 = "MULTI..RS_ALMOVC" + CIA 

KAD = "EXEC BuscaPE_OC_Contra  '"&DOC&"', '"&TBL1&"', '"&TBL2&"' "
'response.Write(kad)
Set RS4 = Server.CreateObject("ADODB.Recordset")
	RS4.ActiveConnection = Cnn
	RS4.CursorType       = 3 'CONST adOpenStatic = 3
	RS4.LockType         = 1 'CONST adReadOnly = 1
	RS4.CursorLocation   = 3 'CONST adUseClient = 3

	RS4.Open KAD, Cnn
	CONT = 1
   ' RESPONSE.WRITE(RS4.RECORDCOUNT)

	IF RS4.RECORDCOUNT>0 THEN	RS4.MOVEFIRST%>

<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = RS4.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ><HTML>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body style="margin-top:0; margin-left:0; margin-right:0;">
<%'*********************************************************************%>
        <table id="TABLA" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
        <%'**************************%>
        <%'LINEA DE CABECERA STANDAR %>
        <%'**************************%>
        <%LIMITE =  RS4.fields.count - 1	%>
        <tr bgcolor=#006699 >
            <%for I=0 to LIMITE %>
	            <td align="center" class="Estilo8"><%=RS4.FIELDS(I).NAME%></td>
            <%next%>	
        </tr>
        <%IF  RS4.EOF THEN response.end%>
        <%DO WHILE NOT RS4.EOF%>
	        <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color2"))
                else
	            response.write(Application("color1"))
	            end IF%>" 
                onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
                 ondblclick="show('<%=(cont)%>')">
	            <%FOR i=0 TO LIMITE%>
		            <td align="center" class="estilo5"><%=RS4.FIELDS.ITEM(I)%></td>
	            <%NEXT%>
	        </tr>
	        <%RS4.MOVENEXT%>
	        <%CONT = CONT + 1%>
	        <%LOOP%>
        </table>

    </td>
</tr>
</table>

</form>
<script type="text/jscript" language="jscript">
    REC = '<%=RS4.RECORDCOUNT %>'
if (parseInt(REC,10) > 0)
    dd2('1');

function show(ff) {
    var t = document.all.TABLA;
    var pos = parseInt(ff, 10)
    alm = trim(t.rows(pos).cells(0).innerText);
    tip = trim(t.rows(pos).cells(2).innerText);
    doc = trim(t.rows(pos).cells(3).innerText);
    cad =  'show_deta_parte_ocMHD.asp?alm=' + alm + '&tip=' + tip
    cad += '&nro='   + doc
    //alert(datos)
    var opc = "directories=no, height=400, hotkeys=no, location=no,";
    opc += "menubar=no, resizable=YES, left=200, top=200,scrollbars=yes,";
    opc += "status=no, titlebar=no, toolbar=no, width=800";
    window.open(cad, '', opc)
    return true;
}
</script>  
</BODY>
</HTML>
