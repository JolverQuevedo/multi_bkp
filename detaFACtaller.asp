<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>
<script type="text/jscript">
var oldrow = 1
var url = '../DETAacaFAC.asp?'
var pagesize = 20
var oldrow = 1
var olddata = ''
</script>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/COMUNqry.ASP"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<%
POS = Request.QueryString("po")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if

cli = Request.QueryString("cli")
if cli = "" or isnull(cli)  or cli = " " then
	cli = ""
end if
col = Request.QueryString("col")
if col = "" or isnull(col)  or col = " " then
	col = ""
end if

SER = Request.QueryString("SER")
if SER = "" or isnull(SER)  or SER = " " then
	SER = ""
end if
fec = Request.QueryString("fec")
if fec = "" or isnull(fec)  or fec = " " then
	fec = ""
end if
fexp = Request.QueryString("fexp")
if fexp = "" or isnull(fexp)  or fexp = " " then
	fexp = ""
end if
serv = Request.QueryString("serv")
if serv = "" or isnull(serv)  or serv = " " then
	serv = ""
end if

if trim(request.QueryString("borra"))= "1" then

    TBL1 = "multi..po_movi "
    kAD =   " update "&tbl1&" set FECPRO = null, FACPRO = null, numser = null "
    Kad = kad + " WHERE  [id] in (select  [ID] FROM view_pos_movi WHERE CODCLI= '"&cli&"' and mov = 'i' " 
    col= replace(col, " ", "")
    if len(trim(col))  > 0 then kAD = kAD + " and color   ='"&col&"'  "
    if len(trim(POs))  > 0 then kAD = kAD + " and guia    ='"&POs&"'  "
    if len(trim(SER))  > 0 then kAD = kAD + " and codser  ='"&SER&"'  "
    if len(trim(SERv)) > 0 then kAD = kAD + " and numser  ='"&SERv&"' "
            kad = kad + "  )"
   'response.write(kad)
    cnn.execute kad
else
    if len(fec) > 0 then 
        kad =   " update po_movi set                  "
        kad = kad + " FECPRO = CASE WHEN FECPRO IS NULL THEN '"&fec&"' ELSE FECPRO END "
        Kad = kad + " WHERE  [id] in (select  [ID] FROM view_pos_movi WHERE CODCLI= '"&cli&"' and mov = 'i' " 
        col= replace(col, " ", "")
        if len(trim(col))  > 0 then kAD = kAD + " and color   ='"&col&"'  "
        if len(trim(POs))  > 0 then kAD = kAD + " and guia    ='"&POs&"'  "
        if len(trim(SER))  > 0 then kAD = kAD + " and codser  ='"&SER&"'  "
        if len(trim(SERv)) > 0 then kAD = kAD + " and numser  ='"&SERv&"' "
                kad = kad + "  )"
 '   response.write(kad)
    cnn.execute kad
    end if

    if len(fexp) > 0 then        
        kad =   " update po_movi set                  "
        kad = kad + " FACPRO = isnull(FACPRO, '"&fexp&"') "
        Kad = kad + " WHERE  [id] in (select  [ID] FROM view_pos_movi WHERE CODCLI= '"&cli&"' and mov = 'i' " 
        col= replace(col, " ", "")
            if len(trim(col))  > 0 then kAD = kAD + " and color   ='"&col&"'  "
            if len(trim(POs))  > 0 then kAD = kAD + " and guia    ='"&POs&"'  "
            if len(trim(SER))  > 0 then kAD = kAD + " and codser  ='"&SER&"'  "
            if len(trim(SERv)) > 0 then kAD = kAD + " and numser  ='"&SERv&"' "
                    kad = kad + "  )"
     '   response.write(kad)
        cnn.execute kad
    end if
    if len(serv) > 0 then        
        kad =   " update po_movi set                  "
        kad = kad + " numser = isnull(numser, '"&serv&"') "
        Kad = kad + " WHERE  [id] in (select  [ID] FROM view_pos_movi WHERE CODCLI= '"&cli&"' and mov = 'i' " 
        col= replace(col, " ", "")
            if len(trim(col))  > 0 then kAD = kAD + " and color   ='"&col&"'  "
            if len(trim(POs))  > 0 then kAD = kAD + " and guia    ='"&POs&"'  "
            if len(trim(SER))  > 0 then kAD = kAD + " and codser  ='"&SER&"'  "
            if len(trim(SERv)) > 0 then kAD = kAD + " and numser  ='"&SERv&"' "
                    kad = kad + "  )"
     '   response.write(kad)
        cnn.execute kad
    end if
end if

'response.write(kad)

    CAD =   " SELECT ID, GUIA, ESTCLI,PO, COLOR, DESSER,  RUC,NOMPRO, " & _
	        "  (C0+C1+C2+C3+C4+C5+C6+C7+C8+C9) AS TOTAL,              " & _
            " isnull(FECPRO,'"&fec&"') as FECPRO,                     " & _
            " isnull(FACPRO,'"&fexp&"') as FACPRO,                    " & _
            " isnull(NUMSER,'"&SERV&"') as NUMSER  FROM               " & _
            " view_pos_movi WHERE CODCLI='"&cli&"' and mov='i'        " 
col= replace(col, " ", "")
    if len(trim(col))  > 0 then CAD = CAD + " and color   ='"&col&"'  "
    if len(trim(POs))  > 0 then CAD = CAD + " and guia    ='"&POs&"'  "
    if len(trim(SER))  > 0 then CAD = CAD + " and codser  ='"&SER&"'  "
    if len(trim(SERv)) > 0 then kAD = kAD + " and numser  ='"&SERv&"' "
    CAD = CAD +  " ORDER BY 1,2,3,4 ;                                 "
   


'response.write(cad)
Dim pageSize 
pageSize = 20

'****************************************
' Definir el NOMBRE de la Tabla base
Dim ALIAS
alias = "view_pos_movi"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
Dim indice
indice = "ID"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
Dim urlBase
urlBase = "DETAFACtaller.asp"
	
	RS.Open CAD, Cnn
' contador de lineas
	CONT = 1
IF RS.RECORDCOUNT > 0 THEN 
	RS.MOVEFIRST%>
    <script type="text/jscript">
        marca = 0	
    </script>
<%else%>
    <script type="text/jscript">
	    marca = 1	
    </script>
<%END IF%>
<script type="text/jscript">
    mm = '<%=rs.recordcount%>'
    var funcionalidad = ''
</script>
<%' Nro de columnas regresadas por el objeto RECORDSET	
LIMITE = rs.Fields.Count-1
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<head>
<title></title>
<link href="reportes/CalendarControl.css"   rel="stylesheet" type="text/css">
<script src="reportes/CalendarControl2.js"     language="javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<link rel="stylesheet" type="text/css" href="MULTISTY.CSS" />
<html xmlns="http://www.w3.org/1999/xhtml">
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<html>
<head>
<title></title>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" >
<form name="thisForm" method="post" action="">
<table id="TABLA" align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr class="Estilo55">
<%for I=0 to LIMITE %>
	<td align="center">
		<%=RS.FIELDS(I).NAME%>
	</td>
<%next%>	
</tr>
<%'*****************************%>
<%' MUESTRA EL GRid (2 colorES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE NOT RS.EOF%>
    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" >    
	<%for i=0 to LIMITE-3%>
		<td>
			<font face="Arial, Helvetica, sans-serif" color="MidnightBlue" size="1">
			<b><%=trim(RS.FIELDS.ITEM(I))%></b>&nbsp;
			</font>
		</td>
	  <%NEXT%>	
      <td><input name="emb<%=CONT%>" id="emb<%=cont%>" class="inputs" value="<%=RS("FECPRO") %>"  onfocus="showCalendarControl(this);" type="text"></td>
      <td><input name="exp<%=CONT%>" id="exp<%=cont%>" class="inputs" value="<%=RS("FACPRO") %>" onchange="graba(2, '<%=CONT%>')" onfocus="seleccionar(this)" maxlength="10" type="text"></td>
      <td><input name="SRV<%=CONT%>" id="SRV<%=CONT%>" class="inputs" value="<%=RS("NUMSER") %>" onchange="graba(3, '<%=CONT%>')" onfocus="seleccionar(this)" maxlength="10" type="text"></td>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
  </tr>
	<%loop%>
</table>
<%end if%>
<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe>
<%rs.close%>
<script language="jscript" type="text/jscript">
if (marca == 0)
    dd('1');

function llena() {
    return true;
}
function graba(op, opc) {
    var t = document.all.TABLA;
    if (op == '1')
        opc = oldrow
    var pos = parseInt(opc, 10)
 
    document.all.body0.style.display = 'block'
    document.all.body0.height = "350"
    document.all.body0.width = "100%"

    cad = "comun/EDITfacTALLER.asp?id=" + trim(t.rows(pos).cells(0).innerText);
    cad += '&fec=' + trim(eval("document.all.emb" + pos + ".value"))
    cad += '&fac=' + trim(eval("document.all.exp" + pos + ".value"))
    cad += '&SRV=' + trim(eval("document.all.SRV" + pos + ".value"))
    cad += '&op=' + op
 //   alert(cad)
    document.all.body0.src = cad
 
 //   return true;
}


</script>    
<%SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING  %>
</form>
</body>
</html>
