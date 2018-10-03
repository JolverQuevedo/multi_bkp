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
po	= Request.QueryString("po") 

    CAD =	" SELECT UBI,COLOR                      " & _
            " FROM   MODELADOR..[po-deta] AS PP     " & _
            " where  PP.po = '"&po&"'               " 
'RESPONSE.Write(CAD)



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
    ubi = t.rows(ff).cells(0).innerText;
    col = t.rows(ff).cells(1).innerText;
    window.opener.document.all.UBI.value = ubi
    window.opener.document.all.COL.value = col
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
	<%FOR I=0 TO 1 %>
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