<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<link REL="stylesheet" TYPE="text/css" HREF="../MULTISTY.CSS" >
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
est	= Request.QueryString("est") 
cli	= Request.QueryString("cli") 
mov = Request.QueryString("mov") 
ruc = Request.QueryString("ruc") 

if mov = "S" then 
    CAD =	" SELECT PP.PO, ES.ESTCLI, es.DESCRIPCION       " & _
            " FROM   MODELADOR..POS AS PP           " & _
            " INNER JOIN MODELADOR..CLIENTE AS CL   " & _
            " ON PP.CLIENTE = CL.CODIGO             " & _
            " INNER JOIN MODELADOR..ESTILOS AS ES   " & _
            " ON pp.CLIENTE = ES.CLIENTE            " & _
            " AND pp.codest = ES.CODEST             " & _
            " where  PP.ESTADO = 'a'                " & _
            " and pp.cliente = '"&cli&"'            " & _
            " AND ES.ESTCLI = '"&est&"'             " 
'RESPONSE.Write(CAD)
else
    cad =   " select PO, ESTCLI, ESTILO, COLOR,             " & _
            " sum(c0+c1+c2+c3+c4+c5+c6+c7+c8+c9) as SALIDA  " & _
            " from view_pos_movi where estcli = '"&est&"'   " & _
            " and mov ='s' and ruc = '"&ruc&"'              " & _
            " group by po,color, estcli, ESTILO             "
end if
	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
		RS.MOVEFIRST
	END IF 
' Nro de columnas regresadas por el objeto RECORDSET	
	columnas = rs.Fields.Count-1
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">

<script language="javascript" type="text/jscript">
oldrow = 1
function enter() {
    if (event.keyCode == 13) {
        document.all.ENVI.onclick
    }
}
function redir(ff) {
    var t = document.all.TABLA;
    ff = parseInt(ff, 10);
    po = t.rows(ff).cells(0).innerText;
    est = t.rows(ff).cells(2).innerText;
    window.opener.document.all.POS.value = po
    window.opener.document.all.DES.value = est
    OPP = trim('<%=TRIM(RUC)%>')
    if (OPP =='')
        window.opener.window.BAKE('1')
    this.window.close();
}
function llena() {
    return true;
}

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}

</script>
</HEAD>
<BODY >

<form name="thisForm" METHOD="post" action="" onsubmit="filtra()    " >

<table id="TABLA" align="center"  bordercolor="<%=application("color2")%>" bgcolor="<%=application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" with="100%">
<%	'**************************
	'LINEA DE CABECERA STANDAR 
	'**************************
	cont=1%>
<TR bgcolor="<%=APPLICATION("TITULO")%>" >
	<%FOR I=0 TO rs.fields.count-1 %>
		<TD align="center" class="estilo8" width="1%"><%=trim(RS.FIELDS(I).NAME)%></TD>
	<%NEXT%>
</TR>
<%	'*****************************
	' MUESTRA EL GRID (2 COLORES) 
	'*****************************	%>
  <%' MUESTRA EL GRid (2 colorES) %>
    <%IF not RS.EOF THEN %>
    <%DO WHILE NOT RS.EOF%>
    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" onDblClick="redir('<%=(cont)%>')" >       
	    <%FOR I=0 TO rs.fields.count-1 %>
		 <td class="estilo5" ><%=trim(RS.FIELDS.ITEM(i))%>&nbsp;</td>
        <%NEXT%>
	  
	    <%RS.MOVENEXT%>
	    <%CONT = CONT + 1%>
  </tr>
	<%loop%>
    <%else %>
    <tr>       
		 <td class="estilo5" colspan="2" style="color:Red" align="center">No existen registros del estilo <%=ucase(est)%> para el Cliente/Taller Seleccionado</td>
  </tr>
    <tr style="height:80px; vertical-align:middle">       
		 <td class="estilo5" colspan="2" style="color:Navy; cursor:pointer" onclick="javascript: window.close()" align="center"> << C E R R A R >></td>
  </tr>
    <%end if %>
  </table>

<script language="javascript">
red ='<%=rs.recordcount %>'


if (parseInt(red,10) > 0)
    dd2('1');

function filtra() {
    if (trim(document.all.DATO.value) != '') {
        cad = 'BUSCA_articulos.asp?NOM=' + ltrim(document.all.DATO.value)
        thisForm.action = cad
        thisForm.submit   
    }
}


</script>    
</form>
<%
	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
    </BODY>
</HTML>