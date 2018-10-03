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
tem = Request.QueryString("tem") 
cod = Request.QueryString("ID") 
po  = Request.QueryString("po") 
UBI = Request.QueryString("UBI")
EMP = Request.QueryString("EMP")
mov = Request.QueryString("mov")
GUI = Request.QueryString("GUI")
RUC = Request.QueryString("RUC")
DEF = Request.QueryString("DEF")
pza = Request.QueryString("pza")
SER = Request.QueryString("SER")
CON = Request.QueryString("CON")
BOL = Request.QueryString("BOL")
LIN = Request.QueryString("LIN")
MOT = Request.QueryString("MOT")
C0  = replace(Request.QueryString("C0"),",", "") 
C1  = replace(Request.QueryString("C1"),",", "") 
C2  = replace(Request.QueryString("C2"),",", "") 
C3  = replace(Request.QueryString("C3"),",", "")  
C4  = replace(Request.QueryString("C4"),",", "")     
C5  = replace(Request.QueryString("C5"),",", "") 
C6  = replace(Request.QueryString("C6"),",", "") 
C7  = replace(Request.QueryString("C7"),",", "") 
C8  = replace(Request.QueryString("C8"),",", "") 
C9  = replace(Request.QueryString("C9"),",", "") 
FEC = left(Request.QueryString("FEC"),10)
mul = trim(request.querystring("multi"))
GUI2 = Request.QueryString("GUI2")
COR = Request.QueryString("COR")
cli = Request.QueryString("Cli")
if ltrim(rtrim (mul)) = "" then mul = 0
'response.Write(def)
if cod = "AUTO" then
    cod =  " select isnull(RIGHT('0000000000'+(SELECT CONVERT(NUMERIC,MAX([ID])) + 1 FROM  MULTI..PO_MOVI ),10), '0000001000') "
   
    rs.open cod,cnn
    rs.movefirst
    cod = rs.fields.item(0)
     cod = right("0000000000"+ trim(cod),10)
    rs.close
    mul = 1 
end if


fich = request.Cookies("multi")("fichas")
if len(trim(fich)) > 0 then 
    response.Cookies("multi")("fichas") = fich + "," + cod
else
    response.Cookies("multi")("fichas") =  cod    
end if    

cad =   " delete MULTI..PO_MOVI where [id] = '"&cod&"';              " & _
        " INSERT INTO MULTI..PO_MOVI ( [id], po, ubi, empresa,       " & _
        " mov, guia, ruc, defecto, pieza, servicio, condicion,       " & _
        " can0, can1, can2, can3, can4, can5, can6, can7,can8,       " & _
        " can9, usuario, fecha, fecdoc,estado, BOLSA, MOTIVO,        " & _
        " LINEA, GUIA2, CORTE ) values (                             " & _
        " '"&cod&"',  '"&po&"', '"&ubi&"', '"&emp&"', '"&mov&"',     " & _
        " '"&gui&"', '"&ruc&"', '"&def&"', '"&pza&"', '"&ser&"',     " & _
        " '"&con&"', "&c0&", "&c1&", "&c2&", "&c3&", "&c4&",         " & _
        " "&c5&", "&c6&", "&c7&", "&c8&", "&c9&", '"&usr&"',         " & _
        " getdate(), Convert(datetime,'"&fec&"',103),'a',            " & _
        " '"&BOL&"', '"&MOT&"', '"&LIN&"', '"&GUI2&"', '"&COR&"');   "

response.write(cad)

Cnn.Execute(CAD)
'response.end
%>

<script language="jscript" type="text/jscript">
   //alert()

    mul = parseInt('<%=mul%>', 10)

    alert(mul)
if (mul != 0) {
    cad = '../fichaposMOVItem.asp?cod=' + '<%=cod%>' + '&cli=' + '<%=trim(request.querystring("cli"))%>' + '&tem=' + '<%=trim(tem)%>'
    //alert(cad)
    window.parent.window.location.replace(cad)
    kam = '../detaacaTEMP.asp?pos=' + '<%=trim(request.querystring("cli"))%>'
    kam += '&id=' + '<%=trim(cod)%>' + '&tem=' + '<%=trim(tem)%>'

    var si
    si = confirm(kam);
    if (si == true)
    { window.parent.opener.location.replace(kam) }
}
else {
   alert('Ficha: '+ '<%=cod%>')
   window.parent.window.document.all.id.value = '<%=cod%>'

}
</script>
</BODY>
</HTML>
