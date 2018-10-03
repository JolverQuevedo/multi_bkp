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
cod	= Request.QueryString("cod") + "%"
op  =  Request.QueryString("op") 
TBL = "RSFACCAR..AL" + CIA + "ARTI"

CAD =	" select  AR_CCODIGO as COD, AR_CDESCRI AS DESCri, ar_cunidad FROM "&TBL&" " & _
        " WHERE AR_CCODIGO LIKE '"&cod&"'" 

'RESPONSE.Write(CAD)



	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
		RS.MOVEFIRST
    else
        response.write("<center>")
        response.write("Articulo de la PO no existe en el SoftCom-REAL")
        response.write("<BR>")
        response.write("<BR>")
        response.write("<BR>")
        response.write("<a href='javascript:this.window.close()' >")
        response.write("CERRAR")
        response.write("</a>")
        response.end
	END IF 
' Nro de columnas regresadas por el objeto RECORDSET	
	columnas = rs.Fields.Count-1
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">

<script language="javascript" type="text/jscript">
op = parseInt('<%=op%>',10)
oldrow = 1
function enter() {
    if (event.keyCode == 13) {
        document.all.ENVI.onclick
    }
}
function redir(ff) {
    var t = document.all.TABLA;
    ff = parseInt(ff, 10);
    COD = t.rows(ff).cells(0).innerText;
    DES = t.rows(ff).cells(1).innerText;
    uni = t.rows(ff).cells(2).innerText;
    eval("window.opener.document.all.COD"+op+".value=COD");
    eval("window.opener.document.all.DES" + op + ".value=DES");
    eval("window.opener.document.all.UNI" + op + ".value=uni");
    window.close();
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
<BODY onkeyup="enter()">

<form name="thisForm" METHOD="post" action="" onsubmit="filtra()    " >

<table id="TABLA" align="center"  bordercolor="<%=application("color2")%>" bgcolor="<%=application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" with="100%">
<%	'**************************
	'LINEA DE CABECERA STANDAR 
	'**************************
	cont=1%>
<TR bgcolor="<%=APPLICATION("TITULO")%>" >
	<%FOR I=0 TO 2 %>
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
	    
		 <td class="estilo5" align="center" width="10%"><%=trim(RS.FIELDS.ITEM(0))%>&nbsp;</td>
         <td class="estilo5" align="left"   width="70%"><%=trim(RS.FIELDS.ITEM(1))%>&nbsp;</td>
	     <td class="estilo5" align="left"   width="20%"><%=trim(RS.FIELDS.ITEM(2))%>&nbsp;</td>
	  
	    <%RS.MOVENEXT%>
	    <%CONT = CONT + 1%>
  </tr>
	<%loop%>
    <%end if %>
  </table>

<script language="javascript">
red ='<%=rs.recordcount %>'


if (parseInt(red,10) > 0)
    dd2('1');



</script>    
</form>
<%
	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
    </BODY>
</HTML>