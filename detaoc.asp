<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>
<link href="multisty.css" rel="stylesheet" type="text/css">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNoc.ASP"-->
<script type="text/jscript" language="jscript">
var oldrow =1
var olddata =''
var chk = ''
</script>

<script type="text/jscript" language="jscript">
var funcionalidad = 'comun/INSERoc.asp?'	//  Indica el nombre de la página donde se realizan los cambios 
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
</script>

<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>
<title><%=titulo%></title>
</head>


<body>
<form name="thisForm" id="thisForm" method="post" action="">

<%fecha = Request.QueryString("fecha")
fecha = Request.QueryString("fecha")
if fecha = "" or isnull(fecha)  or fecha = " " then
	fecha = ""
end if
if right(left(fecha,2),1) = "/" then mes =left(fecha,1) else mes = cint(left(fecha,2))
anio =  cint(right(fecha,4))
edo = Request.QueryString("edo")
if EDO = "" or isnull(EDO)  or EDO = " " then
	EDO = ""
end if
tip = Request.QueryString("tip")
if tip = "" or isnull(tip)  or tip = " " then
	tip = ""
end if
pro = Request.QueryString("pro")
if pro = "" or isnull(pro)  or pro = " " then
	pro = ""
end if

'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
tbl1 = "RSFACCAR..AL"+cia+"TABL" 
tbl2 = "RSFACCAR..CO"+cia+"MOVC "
CAD =	" SET DATEFORMAT DMY;                                                       " & _
        " select oc_cnumord as NRO_DOC, Convert(VARCHAR,OC_DFECDOC,103) as FECHA,   " & _
        " oc_crazsoc as PROVEEDOR,oc_ccodmon as Mnd, IMPORTE = CASE WHEN            " & _
        " oc_ccodmon = 'MN' THEN oc_nimpMN ELSE oc_nimpus END, (Select TG_CDESCRI   " & _
        " From "&tbl1&" Where TG_CCOD='31' AND OC_CSITORD = TG_CCLAVE)  " & _
        " AS EDO, OC_CTIPORD AS TIP, OC_CCOTIZA AS COT, OC_CSITORD as SIT      " & _
        " from "&tbl2&" WHERE                                           " & _
        " Month(OC_DFECDOC)="&mes&" and year(OC_DFECDOC)="&anio&"                   " 
        if len(trim(pro)) > 0 then cad = cad +  " and OC_CCODPRO = '"&pro&"'        "
        if len(trim(tip)) > 0 then cad = cad +  " and OC_CTIPORD = '"&tip&"'        "
        if len(trim(edo)) > 0 then cad = cad +  " and OC_CSITORD = '"&edo&"'        "
        cad = cad +  " ORDER BY 1 DESC ;                                   "
		'response.Write(Cad)

	RS.Open CAD, Cnn
    SINDATOS =1
	CONT = 1
	IF  RS.RECORDCOUNT > 0 THEN 	
		RS.MOVEFIRST
	ELSE
		RESPONSE.Write("TABLA SIN DATOS")	
		SINDATOS =0
		'RESPONSE.End()
	END IF	
' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count %>
<%'*********************************************************************%>
<table id="TABLA" align="center"  bordercolor="#FFFFFF" bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor='<%=Application("Titulo")%>' >
    <%LIMITE =  rs.fields.count - 1%>
    <%for I=0 to LIMITE %>
	    <td align="center" class="micro_white">
		    <%=trim(RS.FIELDS(I).NAME)%>
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
	            end IF%>" onKeyUp="baja()" onDblClick="edita()"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" >
	   
		<td class="micro" style="text-align:left" ><%=trim(RS.FIELDS.ITEM(0))%></td>
        <td class="micro" style="text-align:left" ><%=trim(RS.FIELDS.ITEM(1))%></td>
        <td class="micro" style="text-align:left" width="50%"><%=trim(RS.FIELDS.ITEM(2))%></td>
        <td class="micro" style="text-align:left" ><%=trim(RS.FIELDS.ITEM(3))%></td>
        <td style="text-align:right;" CLASS="micro" ><%=(FORMATNUMBER(RS.FIELDS.ITEM(4),2,,,TRUE))%>&nbsp;</td>
		<%FOR I = 5 TO LIMITE %>
		    <td class="micro" style="text-align:left"><%=RS.FIELDS.ITEM(I)%>&nbsp;</td>
        <%NEXT%>

	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
  </tr>
	<%loop%>
</table>

<%END IF %>
<iframe frameborder="1" style="visibility:hidden" height="1" width="10" id="ACTIV" name="ACTIV"></iframe>
 
<script type="text/jscript" language="jscript">
rec = parseInt('<%=rs.recordcount%>',10)
if (rec > 0 )
    dd2('1');

function baja() {

    if (event.keyCode == 40)
    // flecha abajo
    //alert("avanza")
        avanza()    
    if (event.keyCode == 38)
    // flecha arriba
        atrasa()
}

function atrasa() {
    var t = document.all.TABLA;
    var ff = 1;
    if (oldrow > 1)
        dd(oldrow - 1);

}
function avanza() {
    var t = document.all.TABLA;
    var ff = 1;

    var max
    ff = oldrow + 1
    max = t.rows.length - 1;
    
    if (ff <= max)
    { dd(ff); }
}		
		  
</script>

<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

</form>
</body>
</html>
