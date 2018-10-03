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
<script language="jscript" type="text/jscript">
    oldrow = 1
    function llena(t, pos) {
        return true
    }
</script>

<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
cli	= Request.QueryString("cli") 
cod	= Request.QueryString("cod") 
sku	= Request.QueryString("sku") 
ano	= Request.QueryString("ano") 

TBL1 = "RSFACCAR..AL" + CIA + "CODA"
TBL2 = "RSFACCAR..AL" + CIA + "ARTI"
TBL3 = "RSFACCAR..ft" + CIA + "clie"
TBL4 = "RSFACCAR..ft" + CIA + "ACUD"

CAD =   " SELECT distinct AT_CCODIGO as CODIGO, AR_CDESCRI AS       " & _
        " DESCRIPCION, AT_CCODCLI AS COD_CLI, CL_CNOMCLI AS         " & _
        " CLIENTE, AT_CCODAL AS SKU, f6_ncantid AS CANT,            " & _
        " f6_nprecio AS PVP, F6_CNUMSER AS SERIE, F6_CNUMDOC AS     " & _
        " DOCUMWNTO, F6_DFECDOC AS FECHA                            " & _
        " FROM "&TBL1&", "&TBL2&" , "&TBL3&", "&TBL4&"              " & _
        " WHERE AT_CCODIGO = AR_CCODIGO AND AT_CCODIGO = F6_CCODIGO " & _
        " AND AT_CCODCLI = CL_CCODCLI and f6_ctd = 'FT'             " & _
        " AND AT_CCODCLI = '"&CLI&"' AND AT_CCODAL = '"&SKU&"'      " & _
        " and AT_CCODIGO = '"&cod&"'                                "
IF LEN(LTRIM(RTRIM(ANO))) > 0 THEN CAD= CAD + " AND YEAR(F6_DFECDOC) = "&ANO&" "


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

</HEAD>
<BODY >



<table id="TABLA" align="center"  bordercolor="<%=application("color2")%>" bgcolor="<%=application("color2")%>"  cellpadding="2"  cellspacing="3"  border="1" with="100%">
<%	'**************************
	'LINEA DE CABECERA STANDAR 
	'**************************
	cont=1%>
<TR bgcolor="<%=APPLICATION("TITULO")%>" >
	<%FOR I=0 TO COLUMNAS %>
		<TD align="center" class="estilo8" ><%=trim(RS.FIELDS(I).NAME)%></TD>
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
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" >       
	   <%FOR I=0 TO COLUMNAS %> 
		 <td class="estilo5" align="center" ><%=trim(RS.FIELDS.ITEM(I))%>&nbsp;</td>
         <%NEXT %>
	    <%RS.MOVENEXT%>
	    <%CONT = CONT + 1%>
  </tr>
	<%loop%>
    <%end if %>
  </table>

  </BODY>
    
<script language="javascript" type="text/jscript">

    function llena() {
        return true;
    }

    function dd2(ff) {	// LLENA TEXTBOX ADICIONALES AL COMUN
        // LOS DEL COMUN SON CODIGO Y DESCRIPCION
        var t = document.all.TABLA;
        var pos = parseInt(ff);
        dd(ff);
    }
    tota = '<%=rs.recordcount%>'
    tota = parseInt(tota, 10)
    if (tota > 0)
    dd('1')
</script>


<%
	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
  
</HTML>