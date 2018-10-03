 <%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<link href="../multisty.css" rel="stylesheet" type="text/css">

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNqry2.ASP"-->


<%
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	

POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if

cli = Request.QueryString("cli")
if cli = "" or isnull(cli)  or cli = " " then
	cli = ""
end if
EST = Request.QueryString("EST")
if EST = "" or isnull(EST)  or EST = " " then
	EST = ""
end if

MOV = Request.QueryString("MOV")
if MOV = "" or isnull(MOV)  or MOV = " " then
	MOV = ""
end if

SER = Request.QueryString("SER")
if SER = "" or isnull(SER)  or SER = " " then
	SER = ""
end if


if len(trim(EST)) + len(trim(pos)) +len(trim(mov)) +len(trim(ser)) +len(trim(ruc)) =  0 then
    cad = "select space(1) "
else

    CAD =   " SELECT ESTCLI,PO,  DESSER,  MOV,   " & _
	        " SUM(C0+C1+C2+C3+C4+C5+C6+C7+C8+C9) AS TOTAL , CODSER         " & _
	        " FROM view_pos_movi WHERE CODCLI= '"&cli&"'           " 

    if len(trim(EST)) > 0 then CAD = CAD + " and estcli  ='"&EST&"'  "
    if len(trim(POs)) > 0 then CAD = CAD + " and po      ='"&POs&"'  "
    if len(trim(MOV)) > 0 then CAD = CAD + " and mov     ='"&MOV&"'  "
    if len(trim(SER)) > 0 then CAD = CAD + " and codser  ='"&SER&"'  "
    if len(trim(ruc)) > 0 then CAD = CAD + " and ruc     ='"&ruc&"'  "

    CAD = CAD + " GROUP BY PO, MOV, DESSER,  estcli,codser " & _
	            " ORDER BY 3,2,4 ;                                 "
end if
   ' response.Write(cad)
    rs.open cad,cnn
	CONT = 1
    'RESPONSE.WRITE(RS.RECORDCOUNT)
    marca = -1
	IF rs.recordcount > 0 THEN	
        RS.MOVEFIRST
        marca = rs.recordcount
    end if
' Nro de columnas regresadas por el objeto RECORDSET	
columnas = RS.Fields.Count%>

<title>Detalle OC <%=oc%></title>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
 <style type="text/css">
     .style1
     {
         font-family: Tahoma;
         font-size: 12px;
         color: #ffffff;
         font-weight: 300;
         background-color: #294052;
         width: 46px;
     }
     .style2
     {
         font-family: Tahoma;
         font-size: 12px;
         color: #ffffff;
         font-weight: 300;
         background-color: #294052;
         width: 60px;
     }
     .style4
     {
         width: 60px;
     }
     .style5
     {
         font-family: Tahoma;
         font-size: 12px;
         color: #ffffff;
         font-weight: 300;
         background-color: #294052;
         width: 48px;
     }
     .style6
     {
         width: 64px;
     }
 </style>
<form name="thisForm" METHOD="post" >
<HTML>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body style="margin-top:0; margin-left:0; margin-right:0;" >

<table id="TABLA1" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
    <tr>
     <td class="style1" >Mov:</td>
     <td class="style4">
    	<select id="MOV" name="MOV" class="INPUTS" width="50px">
            <option value=""></option>
            <option value="I">Ingresos</option>
            <option value="S">Salidas</option>
        </select></td>
    <td class="style2">Taller:</td>
  
    <td class="style6"><input type="text" id="RUC" name="RUC" value="" class="BAKES"  onDblClick="helpPRO()" onChange="bakepro()"  /></td>
    <td colspan="2"><input type="text" id="NOM" name="NOM" value="" class="Bakes" onDblClick="helpPRO()"  /></td>
    </tr>
  <tr>
    <td class="style1" >Estilo:</td>
    <td class="style4"><input type="text" id="ECL" name="ECL" value="" class="inputs"  />
    </td>  
    <td class="style2">PO #:</td>
    <td class="style6" ><input type="text" id="POS" name="POS" value="" class="inputs"  /></td>
    <td class="style5" >Servicio:</td>
    <td>
        <select id="SER" name="SER"   />
        <option value=""></option>
        <% rs2.open "select * from SERVICIOS ORDER BY 2", cnn %>
        <%if rs2.recordcount > 0 then %>
            <%RS2.MOVEFIRST %>
            <%DO WHILE NOT RS2.EOF %>
                <option value="<%=RS2("CODIGO")%>"><%=LTRIM(RTRIM(RS2("DESCRIPCION")))%></option>
                <%RS2.MOVENEXT %>
            <%LOOP %>
        <%end if %>
        <%RS2.CLOSE%>
	    </select>
    </td>
</tr>
<tr>
    <td colspan="6"><input type="button" value="Procesa" onclick="llamame()"></td>
</tr>
<tr>
    <td colspan="6"><iframe  width="100%" src="" id="body10" name="body10" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe></td>
</tr>
<tr>



    <td colspan="6">
        <table id="TABLA" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
        <%'**************************%>
        <%'LINEA DE CABECERA STANDAR %>
        <%'**************************%>
        <%LIMITE =  RS.fields.count - 1	%>
        <tr bgcolor=#006699 >
            <%for I=0 to rs.fields.count-2 %>
	            <td align="center" class="Estilo8"><%=RS.FIELDS(I).NAME%></td>
            <%next%>	
        </tr>
        <%'IF  RS.EOF THEN response.end%>
        <%CONT=1%>
        <%DO WHILE NOT RS.EOF%>
            <%idd = "fila"&trim(cont)%>

	         <tr onclick="dd('<%=(cont)%>')" id="<%=idd%>" name="<%=idd%>" ondblclick="ficha('<%=CONT%>')"
              bgcolor="<%if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	             >    
	            <%FOR i=0 TO rs.fields.count -2%>
		            <td class="estilo5"><%=rs.fields.item(i) %></td>
	            <%NEXT%>
               <td class="estilo5" style="display:none"><%=rs.fields.item(i) %></td>
	        </tr>
	        <%RS.MOVENEXT%>
	        <%CONT = CONT + 1%>
	        <%LOOP%>
        </table>

    </td>
</tr>  
</table>

<script  type="text/jscript">
    marca = parseInt('<%=marca%>', 10)

if (marca >= 0)
    dd('1')
</script>
<script language="jscript" type="text/jscript">
var marca = 0
function llamame() {
    cadena = trim(document.all.ECL.value) + trim(document.all.MOV.value)
    cadena += trim(document.all.SER.value) + trim(document.all.POS.value)
    cadena += trim(document.all.RUC.value)
    if (cadena.length == 0) {
        alert("Favor Colocar algun Criterio de filtro")
        return true;
    }
    dd = 'acumuladospo.asp?cli=' + '<%=Request.QueryString("cli")%>'
    dd += '&est=' + document.all.ECL.value
    dd += '&mov=' + document.all.MOV.value
    dd += '&ser=' + document.all.SER.value
    dd += '&pos=' + document.all.POS.value
    dd += '&ruc=' + document.all.RUC.value
    //alert(dd)
    window.open(dd)
}


function ficha(cn) {
    var t = document.all.TABLA;
    pos = parseInt(cn, 10)
    CAD = 'prndetacum.asp?ecl=' + ltrim(t.rows(pos).cells(0).innerText);
    CAD += '&PO=' + trim(t.rows(pos).cells(1).innerText);
    CAD += '&SER=' + trim(t.rows(pos).cells(5).innerText);
    CAD += '&MOV=' + trim(t.rows(pos).cells(3).innerText);
    CAD += '&cli=' + '<%=Request.QueryString("cli")%>'
    window.open(CAD)
}	

</script>



</form>
</BODY>
</HTML>
