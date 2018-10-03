<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<link href="../multisty.css" rel="stylesheet" type="text/css">
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->

<script language="jscript" type="text/jscript">
oldrow = 1
function llena(t, pos) {
    return true
}

function bakepro() {

    /*  document.all.body10.style.display = 'block'
    document.all.body10.height = "350"
    document.all.body10.width = "100%"
    */
    document.all.body10.src = "../BAKE/jala_pro.asp?RUC=" + trim(document.all.RUC.value);
}

function MARCA(obj) {
    if (obj.checked == true)
        obj.value = '1'
    else
    obj.value = ''
}

    function llamame() {
        cadena  = trim(document.all.ECL.value) + trim(document.all.MOV.value)
        cadena += trim(document.all.SER.value) + trim(document.all.POS.value)
        cadena += trim(document.all.RUC.value) + trim(document.all.GUI.value)
        cadena += trim(document.all.G1.value)  + trim(document.all.G2.value)
        if (cadena.length == 0) {
            alert("Favor Colocar algun Criterio de filtro")
            return true;
        }
        dd = 'resumenpo.asp?cli=' + '<%=Request.QueryString("cli")%>'
        dd += '&est=' + document.all.ECL.value
        dd += '&mov=' + document.all.MOV.value
        dd += '&ser=' + document.all.SER.value
        dd += '&pos=' + document.all.POS.value
        dd += '&ruc=' + document.all.RUC.value
        dd += '&gui=' + document.all.GUI.value
        dd += '&g1=' + document.all.G1.value
        dd += '&g2=' + document.all.G2.value
       //    alert(dd)
        window.location.replace = dd
    }


    function helpPRO() {
        if (trim(document.all.RUC.value) == '' && trim(document.all.NOM.value) == '') {
            alert("Por favor informe el RUC o Nombre del proveedor")
            return false;
        }
        cad = '../help/HLPproveedor.asp?ruc=' + trim(document.all.RUC.value) + '&nom=' + ltrim(document.all.NOM.value)
        window.open(cad, '', opc)
    }
</script>

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

Ruc = Request.QueryString("ruc")
if Ruc = "" or isnull(ruc)  or ruc = " " then
	Ruc = ""
end if
gui = Request.QueryString("gui")
if gui = "" or isnull(gui)  or gui = " " then
	gui = ""
end if
g1 = Request.QueryString("g1")
if g1 = "" or isnull(g1)  or g1 = " " then
	g1 = ""
end if

g2 = Request.QueryString("g2")
if g2 = "" or isnull(g2)  or g2 = " " then
	g2 = ""
end if


if len(trim(EST)) + len(trim(pos)) +len(trim(mov)) +len(trim(ser)) +len(trim(ruc))+LEN(trim(GUI))+ len(trim(g1))+len(trim(g2)) =  0 then
    cad = "select space(1) "
else

    CAD =   " SELECT MOV,  ESTCLI,PO, COLOR, DESSER,  RUC,NOMPRO,  " & _
	        " SUM(C0+C1+C2+C3+C4+C5+C6+C7+C8+C9) AS TOTAL, GUIA    " & _
	        " FROM view_pos_movi WHERE CODCLI= '"&cli&"'           " 

    if len(trim(EST)) > 0 then CAD = CAD + " and estcli     ='"&EST&"'  "
    if len(trim(POs)) > 0 then CAD = CAD + " and po         ='"&POs&"'  "
    if len(trim(MOV)) > 0 then CAD = CAD + " and mov        ='"&MOV&"'  "
    if len(trim(SER)) > 0 then CAD = CAD + " and codser     ='"&SER&"'  "
    if len(trim(ruc)) > 0 then CAD = CAD + " and ruc        ='"&ruc&"'  "
    if len(trim(gui)) > 0 then CAD = CAD + " and guia   like'%"&gui&"%' "
    IF len(trim(G1))  > 0 then CAD = CAD + " and LEN(RTRIM(LTRIM(ISNULL(guia,'')))) > 0 "
    IF len(trim(G2))  > 0 then CAD = CAD + " and LEN(RTRIM(LTRIM(ISNULL(guia,'')))) <= 0 "



    CAD = CAD + " GROUP BY PO, COLOR,MOV, DESSER, NOMPRO, estcli,ruc, " & _
	            " GUIA ORDER BY 1,2,3,4 ;                             "
end if
   ' response.Write(cad)
    rs.open cad,cnn
	CONT = 1
    'RESPONSE.WRITE(RS.RECORDCOUNT)

	IF rs.recordcount > 0 THEN	RS.MOVEFIRST
    
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
         width: 10%;
     }
    
 </style>
<form name="thisForm" METHOD="post" ><HTML>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body style="margin-top:0; margin-left:0; margin-right:0;" >

<table id="TABLA" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
    <tr>
     <td class="style1" >Mov:</td>
     <td class="style4">
    	<select id="MOV" name="MOV" class="INPUTS" width="50px">
            <option value=""></option>
            <option value="I">Ingresos</option>
            <option value="S">Salidas</option>
        </select></td>
    <td class="style1">Taller:</td>
  
    <td class="style6"><input type="text" id="RUC" name="RUC" value="" class="BAKES"  onDblClick="helpPRO()" onChange="bakepro()"  /></td>
    <td colspan="6"><input type="text" id="NOM" name="NOM" value="" class="Bakes" onDblClick="helpPRO()"  /></td>
    </tr>
  <tr>
    <td class="style1" >Estilo:</td>
    <td ><input type="text" id="ECL" name="ECL" value="" class="inputs"  />
    </td>  
    <td class="style1">PO #:</td>
    <td ><input type="text" id="POS" name="POS" value="" class="inputs"  /></td>
    <td class="style1" >Servicio:</td>
    <td>
        <select id="SER" name="SER"  class="INPUTS" />
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
    <td class="style1">GUIA #:</td>
    <td ><input type="text" id="GUI" name="GUI" value="" class="inputs"  /></td>
</tr>
<tr>
    <td class="style1">GUIA :</td>
    <td valign="middle" class="Estilo1">SI<input type="checkbox" id="G1" name="G1" value="" class="Estilo1" onclick="MARCA(this)" /></td>
    <td valign="middle" class="Estilo1">NO<input type="checkbox" id="G2" name="G2" value="" class="estilo1" onclick="MARCA(this)" /></td>
    <td colspan="3" align="right"><input type="button" value="Procesa" onclick="llamame()"></td>
</tr>
<tr>
    <td colspan="6"><iframe  width="100%" src="" id="body10" name="body10" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe></td>
</tr>
<tr>



    <td colspan="8">
        <table id="Table1" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
        <%'**************************%>
        <%'LINEA DE CABECERA STANDAR %>
        <%'**************************%>
        <%LIMITE =  RS.fields.count - 1	%>
        <tr bgcolor=#006699 >
            <%for I=0 to rs.fields.count-1 %>
	            <td align="center" class="Estilo8"><%=RS.FIELDS(I).NAME%></td>
            <%next%>	
        </tr>
        <%'IF  RS.EOF THEN response.end%>
      
        <%DO WHILE NOT RS.EOF%>
	        <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"    >
	            <%FOR i=0 TO rs.fields.count -1%>
		            <td class="estilo5"><%=rs.fields.item(i) %></td>
	            <%NEXT%>
              
	        </tr>
	        <%RS.MOVENEXT%>
	        <%CONT = CONT + 1%>
	        <%LOOP%>
        </table>

    </td>
</tr>
        
</table>

</form>

</BODY>
</HTML>
