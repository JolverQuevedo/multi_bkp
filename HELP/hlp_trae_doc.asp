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
alm	= Request.QueryString("alm") 
tip	= Request.QueryString("tip") 
doc	= Request.QueryString("doc") 
tbl = "RSFACCAR..AL"+CIA+"MOVC"

cad =    " select count(*) as nume from "&tbl&" WHERE C5_CALMA='"& alm & "' AND C5_CTD='" & tip & "'     " & _
         " AND C5_CNUMDOC='" & doc & "' AND C5_CSITUA<>'A' "
    
'RESPONSE.Write(CAD)
'response.end
	RS.Open CAD, Cnn
	CONT = 1
	RS.MOVEFIRST
    if rs("nume") > 0 then
    %>
    <script type="text/jscript" language="jscript">
         var si
	    {si = top.window.confirm("El documento ya existe \nDesea actualizar la información?")}
	    if (si == true) {
	        alm = '<%=alm%>'
            tip = '<%=tip%>'
            doc = '<%=doc%>'
            cad = '../comun/trae_doc.asp?alm=' + alm + '&tip='+ tip + '&doc=' + doc
        window.location.replace (cad)
        
        }
    </script>
	<%
    else%>
    <script type="text/jscript" language="jscript">
        top.window.alert("Documento no encontrado")
    </script>
	<%END IF 
' Nro de columnas regresadas por el objeto RECORDSET	
	columnas = rs.Fields.Count-1
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY >
</BODY>
</HTML>

     