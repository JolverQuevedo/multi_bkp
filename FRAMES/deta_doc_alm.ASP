<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>

<script type="text/jscript" language="jscript">
oldrow = 1
function llena(t, pos) {
    // ACA ES DONDE SE PASAN LOS DATOS DEL DETALLE DE LA O/C AL GRID SUPERIOR 
    //arti = ltrim(t.rows(pos).cells(0).innerText);
    //parent.window.document.all.artic.value = arti

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
alm = request.QueryString("alm")	
CTD = REQUEST.QueryString("CTD")
DOC = REQUEST.QueryString("DOC")
opc = REQUEST.QueryString("OPC")
TBL1 = "RSFACCAR..AL" + CIA + "ARTI"
TBL2 = "RSFACCAR..AL" + CIA + "MOVD"

KAD =   " Select  A.C6_CITEM as IT , A.C6_CCODIGO AS COD ,      " & _
        " A.C6_CDESCRI AS DESCRI, A.C6_CCODMON AS MON,          " & _
        " A.C6_NPREUNI AS PRECIO, B.AR_CUNIDAD AS UNI ,         " & _
        " A.C6_NCANTID AS CANT , A.c6_cnumdoc,A.c6_calma                              " & _
        " From "&TBL2&" A                                       " & _
        " LEFT JOIN "&TBL1&" B ON B.AR_CCODIGO=A.C6_CCODIGO     " & _
        " Where C6_CALMA='"&ALM&"' AND C6_CTD='"&CTD&"'         " & _
        " AND C6_CNUMDOC LIKE '%"&DOC&"'                        " & _
        " Order by C6_CALMA,C6_CTD,C6_CNUMDOC,C6_CITEM          "
'response.Write(kad)

	RS.Open KAD, Cnn
	CONT = 1
   ' RESPONSE.WRITE(RS.RECORDCOUNT)

	IF RS.RECORDCOUNT>0 THEN RS.MOVEFIRST%>

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
        <%LIMITE =  RS.fields.count - 3	%>
        <tr bgcolor=#006699 >
            
            
            
            <%for I=0 to LIMITE %>
	            <td align="center" class="Estilo8"><%=RS.FIELDS(I).NAME%></td>
            <%next%>
           
            <% if TRIM(nombre) = "SISTEMAS" or TRIM(nombre) = "Marisa Hinojo" or ucase(trim(usr)) = "RBEN" THEN %>
            <td  ></td> 
            <% end if %>	
        </tr>
        <%IF  RS.EOF THEN response.end%>
        <%DO WHILE NOT RS.EOF%>
	        <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color2"))
                else
	            response.write(Application("color1"))
	            end IF%>" 
                onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
                ondblclick="show('<%=(cont)%>')">
                
                
	            <%FOR i=0 TO LIMITE%>
		            <td align="center" class="estilo5"><%=RS.FIELDS.ITEM(I)%></td>
                <%NEXT%>
                <% if TRIM(nombre) = "SISTEMAS" or TRIM(nombre) = "Marisa Hinojo"  or ucase(trim(usr)) = "RBEN"  THEN %>
            <td width="50"><button style="background:tomato;border:none;cursor:pointer;padding:8px 12px" onclick="eliminadetalle('<%=RS.FIELDS.ITEM(RS.fields.count - 2)%>','<%=RS.FIELDS.ITEM(1)%>','<%=RS.FIELDS.ITEM(0)%>','<%=RS.FIELDS.ITEM(RS.fields.count - 1)%>')">E</button></td>
            <% end if %>
	        </tr>
	        <%RS.MOVENEXT%>
	        <%CONT = CONT + 1%>
	        <%LOOP%>
        </table>

    </td>
</tr>
</table>

</form>
<script type="text/jscript" language="jscript">
    
    REC = '<%=RS.RECORDCOUNT %>'
    OPC = parseInt('<%=opc %>',10)
if (parseInt(REC,10) > 0)
    dd2('1');

function eliminadetalle(numdoc, producto, linea,almacen) {
    
    cad = 'eliminadetallemov.asp?numdoc=' + myTrim(numdoc) + '&producto=' + myTrim(producto) + '&linea=' + myTrim(linea)+'&almacen='+myTrim(almacen)
    var opc = "directories=no,";
    opc = opc + "hotkeys=no,location=no,";
    opc = opc + "menubar=no,resizable=yes, height=250,width=450,";
    opc = opc + "left=500,top=400,scrollbars=no,";
    opc = opc + "status=no,titlebar=no,toolbar=no";
    
    var veri = confirm("seguro que quieres eliminar el producto " + producto + " del documento " + numdoc + " del almacen " + almacen)
    if (veri) {
        window.open(cad, '', opc)
    } else {
        
    }
    
    //eliminadetallemov.asp
}
function myTrim(x) {
    return x.replace(/^\s+|\s+$/gm, '');
}
function show(ff) {
    if (OPC == 0) {
        alert("documento anulado")
        return false;
    }
    var t = document.all.TABLA;
    var pos = parseInt(ff, 10)
    LIN = trim(t.rows(pos).cells(0).innerText);
    doc = '<%=doc%>'
    cad = 'EDIT_DOC_ALM.asp?LIN='+LIN+'&ALM='+'<%=ALM%>'+'&CTD='+'<%=CTD%>'+'&DOC='+'<%=DOC%>'
    //alert(datos)
    var opc = "directories=no,";
    opc = opc + "hotkeys=no,location=no,";
    opc = opc + "menubar=no,resizable=yes, height=250,width=450,";
    opc = opc + "left=500,top=400,scrollbars=no,";
    opc = opc + "status=no,titlebar=no,toolbar=no";

    window.open(cad, '', opc)
    return true;
}
</script>  
</BODY>
</HTML>
