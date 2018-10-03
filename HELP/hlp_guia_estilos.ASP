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
ruc	= Request.QueryString("ruc") 
ser	= Request.QueryString("ser") 
cli	= Request.QueryString("cli")


cad = "select * from view_pos_movi where codcli = '"&cli&"' and replace(estcli,' ','') = '"&est&"' "
'response.write (cad)
rs.open cad, cnn

if rs.recordcount <= 0 then
%>
<table width="100%" border="0">
 <tr>       
		 <td class="estilo5" colspan="2" style="color:Red" align="center">No existe estilo <%=ucase(est)%> para el Cliente Seleccionado mmmm </td>
  </tr>
    <tr style="height:80px; vertical-align:middle">       
		 <td class="estilo5" colspan="2" style="color:Navy; cursor:pointer" onclick="javascript: parent.window.close()" align="center"> << C E R R A R >></td>
  </tr>
  </table>
  <script language="jscript" type="text/jscript">
    parent.window.parent.window.document.all.DES.value = ''

</script>
<%response.end
else 

des = rs("estilo")
end if
rs.close
%>
<script language="jscript" type="text/jscript">
    parent.window.parent.window.document.all.DES.value = '<%=ucase(trim(DES)) %>'
</script>
<%CAD =	" exec po_color_guia  '"&est&"' , '"&ruc&"', '"&ser&"' " 
 'RESPONSE.Write(CAD)
	RS.Open CAD, Cnn   
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
		RS.MOVEFIRST
        pda = right(rs("codart"),5) + "00000"
	END IF 
' Nro de columnas regresadas por el objeto RECORDSET	
	columnas = rs.Fields.Count-1
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY >
<form name="thisForm" METHOD="post" action="">
<table id="TABLA" align="center"  bordercolor="<%=application("color2")%>" bgcolor="<%=application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" >
<tr>
	<td align="center" class="Estilo2" colspan="7">DISPONIBLES ESTILO <%=trim(EST)%>&nbsp;&nbsp;&nbsp;<img id="ENVI" name="ENVI" alt="GRABA CAMBIOS" style="cursor:pointer; " onClick="graba()" src="../images/ok.png" /></td>
</tr>
<%	'**************************
	'LINEA DE CABECERA STANDAR 
	'**************************
	cont=1%>
<tr bgcolor="<%=APPLICATION("TITULO")%>" >
    <td align="center" class="estilo8">ID</td>
	<td align="center" class="estilo8" colspan="2">PRENDA</td>
	<td align="center" class="estilo8">COLOR</td>
    <td align="center" class="estilo8">PO</td>
    <td align="center" class="estilo8">CORTE</td>
    <td align="center" class="estilo8">CANT</td>
    <td align="center" class="estilo8">CHK</td>
</tr>
<%'*****************************
  ' MUESTRA EL GRID (2 COLORES) 
  '*****************************	%>
  <%' MUESTRA EL GRid (2 colorES) %>
    <%IF not RS.EOF THEN %>
    <%DO WHILE NOT RS.EOF%>
    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>" id="fila<%=Trim(Cstr(cont))%>">       
	    <td class="estilo5" align="left"> <input type="text" class="data2" id="i<%=cont%>" name="i<%=cont%>"  readonly tabindex="-1" value="<%=trim(RS.FIELDS.ITEM(4))%>" /></td>
		<td class="estilo5" align="left"><%=right(trim(RS.FIELDS.ITEM(1)),5)%>00000</td>
        <td class="estilo5" align="left"><%=trim(RS("descrip"))%></td>
        <td class="estilo5" align="right">
            <input type="text" class="data2" id="k<%=cont%>" name="k<%=cont%>"  readonly tabindex="-1" value="<%=trim(RS.FIELDS.ITEM(2))%>" /></td>
        <td class="estilo5" align="right" >
            <input type="text" class="data2" id="p<%=cont%>" name="p<%=cont%>"  readonly tabindex="-1" value="<%=trim(RS.FIELDS.ITEM(0))%>" /></td>
        
        <td class="estilo5" align="right" >            
            <input type="text" class="data2" id="w<%=cont%>"  name="w<%=cont%>" readonly tabindex="-1" value="<%=trim(RS.FIELDS.ITEM(6))%>" /></td>
	    <td class="estilo5" align="right" >
            <input type="text" class="data2" id="c<%=cont%>" name="c<%=cont%>"  readonly tabindex="-1" style="text-align:right" value="<%=trim(RS.FIELDS.ITEM(3))%>" /></td>
        <td class="estilo5" align="right"  >
            <input type="checkbox" class="DATA2" id="y<%=cont%>" name="y<%=cont%>" /></td>
	    <%RS.MOVENEXT%>
	    <%CONT = CONT + 1%>
  </tr>
	<%loop%>
<%else %>
    <tr>       
		 <td class="estilo5" colspan="4" style="color:Red" align="center">No existe estilo <%=ucase(est)%> para el PROVEEDOR Seleccionado</td>
  </tr>
    <tr style="height:80px; vertical-align:middle">       
		 <td class="estilo5" colspan="4" style="color:Navy; cursor:pointer" onclick="javascript: window.close()" align="center"> << C E R R A R >></td>
  </tr>
<%end if %>
</table>
    
<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="0" height="400" align="middle" style="display:block" ></iframe>
<script language="javascript">

function graba() {
    maxim = parseInt('<%=rs.recordcount %>', 10)

    aCan = Array()
    aCol = Array()
    aPos = Array()
    aIdd = Array()
    aKor = Array()
for (op = 1; op <= maxim; op++) {
    if (eval("document.all.y" + op + ".checked") == true) 
    {   aCan[aCan.length++] = parseFloat(eval("document.all.c" + op + ".value"))
        aCol[aCol.length++] = trim(eval("document.all.k" + op + ".value"))
        aPos[aPos.length++] = trim(eval("document.all.p" + op + ".value"))
        aIdd[aIdd.length++] = trim(eval("document.all.i" + op + ".value"))
        aKor[aKor.length++] = trim(eval("document.all.w" + op + ".value"))
     }
}

/*

for (i = 0; i < arr.length; i++) {
    for (j = i + 1; j < arr.length; j++) {
        if ((arr[i]) < (arr[j])) {
            x = arr[i]
            arr[i] = arr[j]
            arr[j] = x
        }
    }
}

*/
for (i = 0; i < aCol.length; i++) {
    for (j = i+1; j < aCol.length; j++) {
        if (aCol[i] < aCol[j]) {
            col = aCol[i]
            can = aCan[i]
            pos = aPos[i]
            idd = aIdd[i]
            kor = aKor[i]
            aCol[i] = aCol[j]
            aCan[i] = aCan[j]
            aPos[i] = aPos[j]
            aIdd[i] = aIdd[j]
            aKor[i] = aKor[j]
            aCol[j] = col
            aCan[j] = can
            aPos[j] = pos
            aIdd[j] = idd
            aKor[j] = kor
        }
    
    
    }

}





    cad = 'llenaguia.asp?can=' + aCan + '&col=' + aCol + '&POS=' + aPos
cad += '&est=' + '<%=est%>' + '&RUC=' + '<%=RUC%>' + '&SER=' + '<%=SER%>'
cad += '&pda=' + '<%=pda%>' + '&idd=' + aIdd + '&kor=' + aKor
//alert(cad)
   window.open(cad)
   
    //document.all.body0.src = cad 

  


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