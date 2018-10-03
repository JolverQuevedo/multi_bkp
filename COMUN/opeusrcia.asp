<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->

<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************

OPE = ucase(TRIM(Request.QueryString("OPE")))
CAD = ""

if ope = "E" then
    cod = TRIM(Request.QueryString("COD"))
    des = ucase(TRIM(Request.QueryString("des")))
    CAD = "delete from MULTI..[USR-CIA] where USUARIO = '"+cod+"' and CIA='"+des+"'"
    'response.Write(cad)
    Cnn.Execute(CAD)
    RESPONSE.Write("eliminado")
else 
    cod = TRIM(Request.QueryString("COD"))
    des = ucase(TRIM(Request.QueryString("des")))
    CAD = "insert into MULTI..[USR-CIA] values('"+cod+"','"+des+"')"
    'response.Write(cad)
    Cnn.Execute(CAD)
    RESPONSE.Write("Registrado")
  
end if
    %>