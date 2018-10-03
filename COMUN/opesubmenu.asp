<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->

<%Response.Buffer = TRUE %>
<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
MENU = TRIM(Request.QueryString("MENU"))
COD = TRIM(Request.QueryString("COD"))
DESC = ucase(TRIM(Request.QueryString("DESC")))
PROG = ucase(TRIM(Request.QueryString("PROG")))
ESTADO = ucase(TRIM(Request.QueryString("EST")))
CAD = ""
if COD = "AUTO" then
    CAD = "INSERT INTO SUBMENU (MENU,SUBMENU,DESCRIPCION,PROGRAMA,ESTADO) select top 1 '"+MENU+"',RIGHT('00'+''+RTRIM(LTRIM(SUBMENU+1)),2),'"+DESC+"','"+PROG+"','"+ESTADO+"' from SUBMENU where menu ='"+MENU+"' order by SUBMENU desc"
    response.Write(cad)
else
    CAD = "update MULTI..SUBMENU set DESCRIPCION='"+DESC+"',PROGRAMA='"+PROG+"',estado='"+ESTADO+"' where MENU='"+MENU+"' and SUBMENU='"+COD+"'"
    response.Write(cad)
end if
    

Cnn.Execute(CAD)
Cnn.close

%>