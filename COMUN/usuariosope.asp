<%@  language="VBScript" %>
<!--#include file="../includes/Cnn.inc"-->

<%Response.Buffer = TRUE %>
<html>
<head>
    <meta name="GENERATOR" content="Microsoft Visual Studio 6.0">
</head>
<body>

    <%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************

OPE = ucase(TRIM(Request.QueryString("OPE")))

if ope = "E" then
    cod = TRIM(Request.QueryString("COD"))
    CAD = "delete from multi.dbo.usuarios where USUARIO = '"+cod+"'"
    response.Write(cad)
    Cnn.Execute(CAD)
    RESPONSE.Write("<script language='javascript' type='text/jscript'>alert('eliminado');parent.location.replace = 'http://intranet/multi/usuarios.asp';</script>")
else 
    if ope = "I" then
        cod = TRIM(Request.QueryString("COD"))
        des = ucase(TRIM(Request.QueryString("DES")))
        nom = ucase(TRIM(Request.QueryString("NOM")))
        CAD = "insert into multi.dbo.usuarios values('"+cod+"','"+des+"','"+nom+"')"
        response.Write(cad)
        Cnn.Execute(CAD)
        RESPONSE.Write("<script language='javascript' type='text/jscript'>alert('insertado');parent.location.replace = 'http://intranet/multi/usuarios.asp';</script>")
    end if
    if ope = "A" then
        cod = TRIM(Request.QueryString("COD"))
        des = ucase(TRIM(Request.QueryString("DES")))
        nom = ucase(TRIM(Request.QueryString("NOM")))
        CAD = "UPDATE multi.dbo.usuarios SET clave='"+des+"',nombres='"+nom+"' WHERE usuario='"+cod+"'"
        response.Write(cad)
        Cnn.Execute(CAD)        
        RESPONSE.Write("<script language='javascript' type='text/jscript'>alert('insertado');parent.location.replace = 'http://intranet/multi/usuarios.asp';</script>")
    end if
end if
    


'Cnn.close

    %>
</body>
</html>
