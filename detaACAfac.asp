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
POs = Request.QueryString("pos")
'pos = split(po, ",")
'response.write(pos)
'response.write("<br>")

cli = Request.QueryString("cli")
if cli = "" or isnull(cli)  or cli = " " then
	cli = ""
end if
tem = Request.QueryString("tem")
if tem = "" or isnull(tem)  or tem = " " then
	tem = ""
end if

est = Request.QueryString("est")
if est = "" or isnull(est)  or est = " " then
	est = ""
end if
fec = Request.QueryString("fec")
if fec = "" or isnull(fec)  or fec = " " then
	fec = ""
end if
fexp = Request.QueryString("fexp")
if fexp = "" or isnull(fexp)  or fexp = " " then
	fexp = ""
end if
kad = ""
if trim(request.QueryString("borra"))= "1" then

    TBL1 = "multi..po_movi "
    kAD = kad + " update "&tbl1&" set fecemb = null, facexp = null "
    Kad = kad + " WHERE  [id] in (select  [ID] FROM view_pos_movi WHERE CODCLI= '"&cli&"' and mov = 'i' " 
    if len(trim(tem)) > 0 then kAD = kAD + " and replace(tempo, ' ' , '') =  replace('"&tem&"', ' ', '') "
    if len(trim(est)) > 0 then kAD = kAD + " and replace(ESTCLI, ' ' , '') =  replace('"&EST&"', ' ', '') "
    if len(trim(pos)) > 0 then kAD = kAD + " and po in  ("&pos&")  "
            kad = kad + "  )"
 '  response.write(kad)
    
else
    if len(fec) > 0 then 
        kad = kad + " update po_movi set                  "
        kad = kad + " FECEMB = CASE WHEN FECEMB IS NULL THEN '"&fec&"' ELSE FECEMB END "
        Kad = kad + " WHERE  [id] in (select  [ID] FROM view_pos_movi WHERE CODCLI= '"&cli&"' and mov = 'i' " 
        if len(trim(tem)) > 0 then kAD = kAD + " and replace(tempo, ' ' , '') =  replace('"&tem&"', ' ', '') "
        if len(trim(est)) > 0 then kAD = kAD + " and replace(ESTCLI, ' ' , '') =  replace('"&EST&"', ' ', '') "
        if len(trim(pos)) > 0 then kAD = kAD + " and po in  ("&pos&")  "
            kad = kad + "  )"
   ' response.write(kad)
   
    end if

    if len(fexp) > 0 then        
        kad = kad +   " update po_movi set                  "
        kad = kad + " FACEXP = isnull(FACEXP, '"&fexp&"') "
        Kad = kad + " WHERE  [id] in (select  [ID] FROM view_pos_movi WHERE CODCLI= '"&cli&"' and mov = 'i' " 
        if len(trim(tem)) > 0 then kAD = kAD + " and replace(tempo, ' ' , '') =  replace('"&tem&"', ' ', '') "
        if len(trim(est)) > 0 then kAD = kAD + " and replace(ESTCLI, ' ' , '') =  replace('"&EST&"', ' ', '') "
        if len(trim(pos)) > 0 then kAD = kAD + " and po in  ("&pos&")  "
                    kad = kad + "  )"
       
      
    end if

end if 
'response.write(kad)
if len(trim(kad)) > 0 then
 cnn.execute kad
end if
    CAD =   " SELECT ID, ESTCLI,PO, TEMPO,   RUC,NOMPRO, " & _
	        "  (C0+C1+C2+C3+C4+C5+C6+C7+C8+C9) AS TOTAL,        " & _
            " isnull(FECEMB,'"&fec&"') as FECEMB,               " & _
            " isnull(FACEXP,'"&fexp&"') as FACEXP  FROM         " & _
            " view_pos_movi WHERE CODCLI='"&cli&"' and mov='i'  " 
    if len(trim(tem)) > 0 then cAD = cAD + " and replace(tempo, ' ' , '') =  replace('"&tem&"', ' ', '') "
    if len(trim(est)) > 0 then cAD = cAD + " and replace(ESTCLI, ' ' , '') =  replace('"&EST&"', ' ', '') "
    if len(trim(pos)) > 0 then cAD = cAD + " and po in  ("&pos&")  "
          
    CAD = CAD +  " ORDER BY 1,2,3,4 ;                                "


'response.write(cad)
Dim pageSize 
pageSize = 20
'response.end

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
urlBase = "DETAacaFAC.asp"
	
	RS.Open CAD, Cnn
' contador de lineas
	CONT = 1
IF RS.RECORDCOUNT > 0 THEN 
	RS.MOVEFIRST
    %>
    <script type="text/jscript">
        marca = 0	
    </script>
<%else
    RESPONSE.WRITE("Solo se muestran los registros de Ingresos")%>
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
	<%for i=0 to LIMITE-2%>
		<td>
			<font face="Arial, Helvetica, sans-serif" color="MidnightBlue" size="1">
			<b><%=trim(RS.FIELDS.ITEM(I))%></b>&nbsp;
			</font>
		</td>
	  <%NEXT%>	
      <td><input name="emb<%=CONT%>" id="emb<%=cont%>" class="inputs" value="<%=RS("FECEMB") %>" onkeypress="graba(1)" onfocus="showCalendarControl(this);" type="text"></td>
      <td><input name="exp<%=CONT%>" id="exp<%=cont%>" class="inputs" value="<%=RS("FaCExp") %>" onchange="graba(2)" onfocus="seleccionar(this)" maxlength="10" type="text"></td>

	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
  </tr>
	<%loop%>
</table>
<%end if%>
<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="400" 
align="middle" style="display:none" ></iframe>
<%rs.close%>
<script language="jscript" type="text/jscript">
if (marca == 0)
    dd('1');
else
    alert("Solo se muestran loss registros de Ingreso")
function llena() {
    return true;
}
function graba(op) {
    var t = document.all.TABLA;
    var pos = parseInt(oldrow, 10)
 
    document.all.body0.style.display = 'block'
    document.all.body0.height = "350"
    document.all.body0.width = "100%"

    cad = "comun/EDITfacaca.asp?id=" + trim(t.rows(pos).cells(0).innerText);
    cad += '&fec=' + trim(eval("document.all.emb"+pos+".value"))
    cad += '&fac=' + trim(eval("document.all.exp" + pos + ".value"))
    cad += '&op=' + op
//alert(cad)
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
