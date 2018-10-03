<%@ Language=VBScript %>
<% Response.Buffer = true %>
<!--#include file="../includes/Cnn.inc"-->
<%

opc			= Request.QueryString("op") 
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************

MON	= Request.QueryString("MON") 


CAD =	" Select top 100 percent CODIGO,  DESCRIPCION,              " & _
        " UNI, PRECIO, MONEDA as MON , isnull(stock,0) as STK, isnull(DENSI,1) AS FACT  " & _
        "  FROM QUIMICOS                                            " & _
        " WHERE ESTADO ='A' AND MONEDA = '"&MON&"'                  " 
dato = Request.QueryString("dato") 

if len(trim(dato)) > 0 then cad = cad + " and DESCRIPCION LIKE '%"&DATO&"%'  "
cad = cad + " order by descripcion                                           "        
       'RESPONSE.Write(CAD)
       ' RESPONSE.END 
	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
		RS.MOVEFIRST
	END IF 
' Nro de columnas regresadas por el objeto RECORDSET	
	columnas = rs.Fields.Count
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<!--#include file="../COMUN/COMUNqry.ASP"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<link REL="stylesheet" TYPE="text/css" HREF="../TINTOCSS.CSS" >
<script language="javascript" type="text/jscript">
oldrow=1
function redir(ff) {
    var t = document.all.TABLA;
    op = parseInt('<%=request.QueryString("op")%>', 10);
    ff = parseInt(ff, 10);
    COD = t.rows(ff).cells(0).innerText;
    DES = t.rows(ff).cells(1).innerText;
    UNI = t.rows(ff).cells(2).innerText;
    BRU = t.rows(ff).cells(3).innerText;
    STK = toInt(t.rows(ff).cells(5).innerText);
    FAC = t.rows(ff).cells(6).innerText;
    
    eval("window.opener.document.all.COD" + op + ".value=COD");
    eval("window.opener.document.all.DES" + op + ".value=DES");
    eval("window.opener.document.all.UNI" + op + ".value=UNI");
    eval("window.opener.document.all.BRU" + op + ".value=BRU");
    eval("window.opener.document.all.STK" + op + ".value=STK");
    eval("window.opener.document.all.FAC" + op + ".value=FAC");
    
  //  alert(eval("window.opener.document.all.BRU" + op + ".value"))
    window.close();
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
<BODY topmargin=0 leftmargin=10 rightmargin=10 onkeyup="enter()">

<form name="thisForm" METHOD="post" action="" onsubmit="filtra()    " >
<table align="center" cellpadding="3" cellspacing="1"  bordercolor="#FFFFFF"  border="1">
    <tr><td align="center" class="ETIQUETA" width="20%">QUIMICOS</td>
    <td width="70%"><input type="text" class="INPUTS" id="DATO" name="DATO"/></td>
    <td style="width:10%;" ><input type="submit" id="ENVI" name="ENVI" value="BUSCAR" onclick="filtra()" style="cursor:pointer" /></td>  
    </tr>
</table>
<hr />
<table id="TABLA" align="center"  bordercolor="<%=application("color2")%>" bgcolor="<%=application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" with="100%">
<%	'**************************
	'LINEA DE CABECERA STANDAR 
	'**************************
	cont=1%>
<TR bgcolor="<%=APPLICATION("TITULO")%>" >
	<%FOR I=0 TO 6 %>
		<TD align="center" class="recordhead_CHICO" width="1%"><%=trim(RS.FIELDS(I).NAME)%></TD>
	<%NEXT%>
</TR>
<%	'*****************************
	' MUESTRA EL GRID (2 COLORES) 
	'*****************************	%>
  <%' MUESTRA EL GRid (2 colorES) %>
    <%IF NOT RS.EOF THEN%>
    <%DO WHILE NOT RS.EOF%>
    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" onDblClick="redir('<%=(cont)%>')" >       
	    
		 <td class="recordeta" align="center" width="10%"><%=trim(RS.FIELDS.ITEM(0))%>&nbsp;</td>
         <td class="recordeta" align="left"   width="70%"><%=trim(RS.FIELDS.ITEM(1))%>&nbsp;</td>
	     <td class="recordeta" align="center" width="5%"><%=trim(RS.FIELDS.ITEM(2))%>&nbsp;</td>
         <td class="recordeta" align="right"  width="10%"><%=formatnumber(RS.FIELDS.ITEM(3),2,,true)%>&nbsp;&nbsp;&nbsp;</td>
         <td class="recordeta" align="center" width="5%"><%=trim(RS.FIELDS.ITEM(4))%>&nbsp;</td>
         <td class="recordeta" align="center" width="5%"><%=formatnumber(RS.FIELDS.ITEM(5),6,,true)%>&nbsp;</td>
         <td class="recordeta" align="center" width="5%"><%=formatnumber(RS.FIELDS.ITEM(6),3,,true)%>&nbsp;</td>
	    <%RS.MOVENEXT%>
	    <%CONT = CONT + 1%>
  </tr>
	<%loop%>
    <%end if%>
    </table>

<script language="javascript">
red ='<%=rs.recordcount %>'
document.all.DATO.focus();
if (parseInt(red,10) > 0)
    dd2('1');

function filtra() {
    if (trim(document.all.DATO.value) != '') {
        cad = 'hlpquimicos.asp?dato=' + ltrim(document.all.DATO.value)
        cad += '&mon=' + '<%=mon %>' + '&op=' + '<%=opc %>'
        thisForm.action = cad
        thisForm.submit   
    }
}
function enter() {
    if (event.keyCode == 13) {
        document.all.ENVI.onclick
    }
    // enter
}
function llena() {
    return true;
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