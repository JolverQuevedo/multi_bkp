<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<script type="text/jscript" language="jscript">
    oldrow = 1
function llena(t, pos) {
    ruc = ltrim(t.rows(pos).cells(2).innerText);
    doc = ltrim(t.rows(pos).cells(0).innerText);
    fec = ltrim(t.rows(pos).cells(1).innerText);
    nom = ltrim(t.rows(pos).cells(3).innerText);
    mone = ltrim(t.rows(pos).cells(4).innerText);
    impor = ltrim(t.rows(pos).cells(5).innerText);
    nom = ltrim(t.rows(pos).cells(3).innerText);


    parent.window.document.all.factura.src = 'factura_oc_contra.asp?doc=' + doc + '&ruc=' + ruc
    parent.window.parent.window.parent.window.document.all.deta.src = 'frames/deta_oc_contra.asp?doc=' + doc + '&ruc=' + ruc
    parent.window.parent.window.parent.window.document.all.partes.src = 'frames/PARTES_deta_oc_contra.asp?doc=' + doc
    parent.window.parent.window.parent.window.document.all.rucid.value = ruc
    parent.window.parent.window.parent.window.document.all.compra.value = doc
    parent.window.parent.window.parent.window.document.all.fecdoc.value = fec
    parent.window.parent.window.parent.window.document.all.nombre.value = nom
    parent.window.parent.window.parent.window.document.all.montoc.value = impor
    parent.window.parent.window.parent.window.document.all.moneda.value = mone
    
    //alert(ruc)

    return true
}   

 
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
</script>
<link href="../multisty.css" rel="stylesheet" type="text/css">
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<%'****************************************************
oc = request.QueryString("oc")	
PRO = REQUEST.QueryString("PRO")
FAC = REQUEST.QueryString("FAC")

TBL1 = "RSFACCAR..CO" + CIA + "MOVC"
TBL2 = "RSFACCAR..AL" + CIA + "TABL"
TBL3 = "RSCONCAR..CP" + CIA + "CART"

KAD = "EXEC BuscaOC_Contralor '"&OC&"', '"&PRO&"', '"&FAC&"', '"&TBL1&"', '"&TBL2&"' , '"&TBL3&"' "
'response.Write(kad)
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.ActiveConnection = Cnn
	RS2.CursorType       = 3 'CONST adOpenStatic = 3
	RS2.LockType         = 1 'CONST adReadOnly = 1
	RS2.CursorLocation   = 3 'CONST adUseClient = 3

	RS2.Open KAD, Cnn
	CONT = 1
    'RESPONSE.WRITE(RS2.RECORDCOUNT)

	IF NOT RS2.EOF OR NOT RS2.BOF THEN	RS2.MOVEFIRST%>

<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs2.Fields.Count%>
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
        <%LIMITE =  RS2.fields.count - 1	%>
        <tr bgcolor=#006699 >
            <%for I=0 to LIMITE %>
	            <td align="center" class="Estilo8"><%=RS2.FIELDS(I).NAME%></td>
            <%next%>	
        </tr>
        <%IF  RS2.EOF THEN response.end%>
        <%DO WHILE NOT RS2.EOF%>
	        <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
                ondblclick="show('<%=(cont)%>')">
	            <%FOR i=0 TO LIMITE%>
		            <td align="center" class="estilo5"><%=RS2.FIELDS.ITEM(I)%></td>
	            <%NEXT%>
	        </tr>
	        <%RS2.MOVENEXT%>
	        <%CONT = CONT + 1%>
	        <%LOOP%>
        </table>

    </td>
</tr>
</table>
<script type="text/jscript" language="jscript">
    dd2('1');

function show(ff) {
    var t = document.all.TABLA;
    var pos = parseInt(ff, 10)
    oc = trim(t.rows(pos).cells(0).innerText);
    //alert(datos)
    var opc = "directories=no, height=400, hotkeys=no, location=no,";
    opc += "menubar=no, resizable=YES, left=200, top=200,scrollbars=yes,";
    opc += "status=no, titlebar=no, toolbar=no, width=800";
    window.open('show_oc_contra.asp?oc=' + oc,'',opc)
    return true;
}

</script>  
</form>
</BODY>
</HTML>
