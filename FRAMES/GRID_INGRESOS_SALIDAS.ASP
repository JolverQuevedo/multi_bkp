<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<script type="text/jscript" language="jscript">
    oldrow = 1
function llena(t, pos) {

    parent.window.document.all.alma.value = trim(t.rows(pos).cells(0).innerText);
    parent.window.document.all.tipo.value = trim(t.rows(pos).cells(1).innerText);
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
<%'**********tri******************************************

alm = REQUEST.QueryString("alm")
gui = REQUEST.QueryString("gui")
ran = REQUEST.QueryString("ran")	
ini = request.QueryString("ini")	
fin = request.QueryString("fin")	
oc = request.QueryString("oc")	
mov = request.QueryString("mov")	
ruc = request.QueryString("ruc")	
lot = request.QueryString("lot")	
ser = request.QueryString("ser")	
cart = request.QueryString("cart")	
col = request.QueryString("col")	
doc = request.QueryString("doc")	

TBL1 = "RS_ALMOVD" + CIA 
TBL2 = "RS_ALMOVD_TALLA" + CIA 
TBL3 = "RS_ALMOV_UBICACION" + CIA 
TBL4 = "AL_TIPOSMOV" + CIA

KAD = "EXEC RS_MOV_S_ENT_SAL '"&alm&"', '"&gui&"', '"&ran&"', '"&ini&"', '"&fin&"', '"&oc&"', '"&mov&"', '"&ruc&"','"&lot&"', '"&ser&"', '"&cart&"', '"&col&"', '"&doc&"', '"&TBL1&"', '"&TBL2&"' , '"&TBL3&"', '"&TBL4&"' "
'response.Write(kad)
'RESPONSE.End
	RS.Open KAD, Cnn
	CONT = 1
  '  RESPONSE.WRITE(RS.RECORDCOUNT)

	IF NOT RS.EOF OR NOT RS.BOF THEN	RS.MOVEFIRST%>

<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = RS.Fields.Count%>
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
        <%LIMITE =  RS.fields.count - 1	%>
        <tr bgcolor=#006699 >
            <%for I=0 to LIMITE %>
	            <td align="center" class="Estilo8"><%=RS.FIELDS(I).NAME%></td>
            <%next%>	
        </tr>
        <%IF  RS.EOF THEN response.end%>
        <%DO WHILE NOT RS.EOF%>
	        <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
                ondblclick="show('<%=(cont)%>')">
	            <%FOR i=0 TO LIMITE%>
		            <td align="center" class="estilo5"><%=RS.FIELDS.ITEM(I)%></td>
	            <%NEXT%>
	        </tr>
	        <%RS.MOVENEXT%>
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
    cad = trim(t.rows(pos).cells(0).innerText);
    cad += '&ctd=' + trim(t.rows(pos).cells(1).innerText);
    cad += '&doc=' + trim(t.rows(pos).cells(2).innerText);
    cad += '&tip=' + trim(t.rows(pos).cells(7).innerText);
    cad += '&art=' + trim(t.rows(pos).cells(9).innerText);
    cad += '&des=' + ltrim(t.rows(pos).cells(10).innerText);
    cad += '&OC=' + ltrim(t.rows(pos).cells(15).innerText);
    cad += '&col=' + ltrim(t.rows(pos).cells(16).innerText);
    cad += '&lot=' + ltrim(t.rows(pos).cells(17).innerText);
    cad += '&bul=' + trim(t.rows(pos).cells(22).innerText);
    cad += '&con=' + trim(t.rows(pos).cells(23).innerText);
    cad += '&cnr=' + trim(t.rows(pos).cells(12).innerText);
    cad += '&itm=' + trim(t.rows(pos).cells(3).innerText);
    cad += '&ser=' + trim(t.rows(pos).cells(24).innerText);
    cad += '&ubi=' + ltrim(t.rows(pos).cells(30).innerText);
    cad += '&uni=' + trim(t.rows(pos).cells(14).innerText);
    cad += '&REF=' + trim(t.rows(pos).cells(6).innerText);

    //alert(trim(t.rows(pos).cells(7).innerText))
    var opc = "directories=no, height=400, hotkeys=no, location=no,";
    opc += "menubar=no, resizable=YES, left=200, top=200,scrollbars=yes,";
    opc += "status=no, titlebar=yes, toolbar=no, width=800";
    window.open('show_edit_ES.asp?alm=' + cad,'Edit_Doc',opc)
    return true;
}

</script>  
</form>
</BODY>
</HTML>
