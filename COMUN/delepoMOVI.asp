<%@ Language=VBScript %>
<%Response.Buffer = TRUE %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<% 
id = request.querystring("id") 
cli = request.querystring("cli") 
gui = request.querystring("gui") 

TBL2 = "rsfaccar..al"+CIA+"movc"
paf =   " select c5_csitgui, c5_cnompro from "&TBL2&" where c5_ctd = 'gs' and c5_calma = '00m2'  " & _
        " and c5_cnumdoc = '"&gui&"' "
        response.write (paf)
rs.open paf, cnn
if rs.recordcount > 0 then %>
<script language="jscript" type="text/jscript">
    msg = " La Guia # " + '<%=gui%>' + " \npara el proveedor "
    msg += '<%=rs("c5_cnompro") %>' +' existe en el SoftCom '
    msg += ' y tiene estado = '+  '<%=rs("c5_csitgui") %>'
    msg += '\nNO SE PUEDE ELIMINAR EL REGISTRO'
    alert(msg)
    cad = '../detaacabados.asp?pos=' + '<%=cli %>' + '&filtros=' + '<%=id%>'
    parent.window.location.replace(cad)
</script>
<%
response.end
end if
TBL1 = "multi..po_movi"
CAD =   " DELETE "&tbl1&" WHERE id = '"&id&"' ;   " 
       
response.write(cad)
Cnn.Execute(CAD)
%>
<script language="jscript" type="text/jscript">
    cad = '../detaacabados.asp?pos=' + '<%=cli %>'+ '&filtros=' + '<%=id%>'
    parent.window.location.replace(cad)
</script>
</BODY>
</HTML>
