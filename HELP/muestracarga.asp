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
col	= Request.QueryString("col") 
aCol = split(col, ",")
idd	= Request.cookies("multi")("fichas") 
aIdd = split(idd,",")
response.Write(idd)

response.write("<br>")

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
</script>
</HEAD>
<BODY >

<form name="thisForm" METHOD="post" action="" onsubmit="filtra()    " >

<table id="TABLA" align="center"  bordercolor="<%=application("color2")%>" bgcolor="<%=application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" with="100%">

<TR bgcolor="<%=APPLICATION("TITULO")%>" >
    <td class="estilo8" align="center" width="30%">Ficha&nbsp;</td>
    <td class="estilo8" align="center" width="30%">Color&nbsp;</td>
</TR>
	<%FOR I=0 TO ubound(aidd)%>
    		
        <tr  bgcolor="<% if i mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>">       
	    
		 <td class="estilo5" align="center" width="30%"><%=aIdd(i)%>&nbsp;</td>
         <td class="estilo5" align="left"   width="70%"><%=aCol(i)%>&nbsp;</td>
	  
	    
        </tr>
	<%NEXT%>
	
  </table>

</form>

    </BODY>
</HTML>