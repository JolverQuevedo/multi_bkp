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

RUC = Request.QueryString("RUC")
if RUC = "" or isnull(RUC)  or RUC = " " then
	RUC = ""
end if

cli = Request.QueryString("cli")
if cli = "" or isnull(cli)  or cli = " " then
	cli = ""
end if
ECL = Request.QueryString("ECL")
if ECL = "" or isnull(ECL)  or ECL = " " then
	ECL = ""
end if

MOV = Request.QueryString("MOV")
if MOV = "" or isnull(MOV)  or MOV = " " then
	MOV = ""
end if

SER = Request.QueryString("SER")
if SER = "" or isnull(SER)  or SER = " " then
	SER = ""
end if

TIP = Request.QueryString("TIP")
if TIP = "" or isnull(TIP)  or TIP = " " then
	TIP = ""
end if

COL = Request.QueryString("COL")
if COL = "" or isnull(COL)  or COL = " " then
	COL = ""
end if

GU1 = Request.QueryString("GU1")
if GU1 = "" or isnull(GU1)  or GU1 = " " then
	GU1 = ""
end if

GU2 = Request.QueryString("GU2")
if GU2 = "" or isnull(GU2)  or GU2 = " " then
	GU2 = ""
end if

CHK = Request.QueryString("CHK")
'response.write(chk)

if len(trim(ECL)) + len(trim(pos)) + len(trim(mov)) + len(trim(ser)) + len(trim(ruc)) + len(trim(CLI)) =  0 + len(trim(COL)) + len(trim(TIP)) then
    cad = "select space(1),0 "
else
    SELECT CASE TIP 
        CASE 1
            CAD = " select codcli, nomcli ,estcli, estilo,          " & _
                  " mov, codser,desser,                             " & _
                  " tot= sum(c0+c1+c2+c3+c4+c5+c6+c7+c8+c9)         " & _
                  " from view_pos_movi                              " & _
                  " where ESTADO = 'A'                              "
            cad = cad +completa()
            cad = cad + " group by estcli, estilo, mov, codcli,     " & _
                        " nomcli,codser,desser                      " & _
                        " order by codcli, estcli                   "
        CASE 2
            CAD =   " select codcli, nomcli ,estcli, estilo,        " & _
                    " mov, codser , desser, po,                     " & _
                    " tot = sum(c0+c1+c2+c3+c4+c5+c6+c7+c8+c9)      " & _
                    " from view_pos_movi where ESTADO ='A'          " & _
           cad = cad +completa()
            cad = cad + " group by estcli, estilo, mov, codcli,     " & _
                        " nomcli,codser,desser,po                   " & _
                        " order by codcli, estcli                   " 
        CASE 3        
            CAD =   " select codcli, nomcli ,estcli, estilo, mov,   " & _
                    " codser, desser, ofi, po, color,               " & _
                    " tot= sum(c0+c1+c2+c3+c4+c5+c6+c7+c8+c9)       " & _
                    " from view_pos_movi where estado ='a'          " 
            cad = cad +completa()
            cad = cad + " group by estcli, estilo, mov, codcli,     " & _
                        " nomcli,codser,desser,po, color,ofi        " & _
                        " order by codcli, estcli,po, color         " 

        CASE 4
            CAD =   " select codcli, nomcli ,estcli, estilo, mov,   " & _
                    " codser, desser, ofi, po, color, ruc, nompro,  " & _
                    " tot= sum(c0+c1+c2+c3+c4+c5+c6+c7+c8+c9)       " & _
                    " from view_pos_movi where ESTADO = 'A'         "
            cad = cad +completa()
            cad = cad + " group by estcli, estilo, mov, codcli,     " & _
                        " nomcli,codser,desser,po, color,ofi, ruc,  " & _
                        " nompro                                    " & _
                        " order by codcli, estcli,po, color         "
    END SELECT
end if
 '   response.Write(cad)
    rs.open cad,cnn
	CONT = 1
    'RESPONSE.WRITE(RS.RECORDCOUNT)
    marca = -1
	IF rs.recordcount > 0 THEN	
        RS.MOVEFIRST
        marca = rs.recordcount
    end if

 function completa()
    kad = ""
    if len(trim(ecl)) > 0 then kAD = kAD + " and estcli  ='"&ECL&"'  "
    if len(trim(POs)) > 0 then kAD = kAD + " and po      ='"&POs&"'  "
    if len(trim(MOV)) > 0 then kAD = kAD + " and mov     ='"&MOV&"'  "
    if len(trim(SER)) > 0 then kAD = kAD + " and codser  ='"&SER&"'  "
    if len(trim(ruc)) > 0 then kAD = kAD + " and ruc     ='"&ruc&"'  "
    if len(trim(CLI)) > 0 then kAD = kAD + " and CODCLI  ='"&CLI&"'  "
    if len(trim(COL)) > 0 then kAD = kAD + " and COLOR   ='"&COL&"'  "
    if CINT(CHK) = 1 then 
        kAD = kAD + " and GUIA    ='"&GU1&"'  "
    ELSE
        kAD = kAD + " and GUIA2   ='"&GU2&"'  "
    end if

    'response.write(kad)
    completa =  kad
end function

IF  cint(request.QueryString("prn")) = 2 THEN
    archivo = "c:\temp\acumula.xls"
    Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 
  
END IF

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
<iframe  width="100%" src="../BLANCO.HTM" id="body0" name="body0" scrolling="yes" frameborder="0" height="50" align="middle" style="display:none"></iframe>

<table id="TABLA1" name="TABLA1" align="left"  bordercolor="#ffffff" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
<tr>
     <td class="style1" width="15%">Cliente:</td>
     <td width="15%">
    	<select id="CLI" name="CLI" class="INPUTS" width="50px">
            <option value=""></option>
             <% rs2.open "select * from MODELADOR..CLIENTE WHERE ESTADO ='A' ORDER BY 2", cnn %>
        <%if rs2.recordcount > 0 then %>
            <%RS2.MOVEFIRST %>
            <%DO WHILE NOT RS2.EOF %>
                <option value="<%=RS2("CODIGO")%>"><%=LTRIM(RTRIM(RS2("NOMBRE")))%></option>
                <%RS2.MOVENEXT %>
            <%LOOP %>
        <%end if %>
        <%RS2.CLOSE%>
        </select></td>
   <td class="style1" width="10%">Estilo:</td>
    <td  width="15%"><input type="text" id="ECL" name="ECL" value="" class="bakes" ondblclick="hlpEST()" onChange="bakeEST();colores();"  /></td>
    <td  width="45%" colspan="4"><input type="text" id="DES" name="DES" value="" class="INPUTS" tabindex="-1" readonly  /></td>
    </tr>
    <tr>
     <td class="style1" >Mov:</td>
     <td >
    	<select id="MOV" name="MOV" class="INPUTS" width="50px">
            <option value=""></option>
            <option value="I">Ingresos</option>
            <option value="S">Salidas</option>
        </select></td>
    <td class="style2">Taller:</td>
    <td ><input type="text" id="RUC" name="RUC" value="" class="BAKES" onDblClick="helpPRO()" onChange="bakepro()"  /></td>
    <td colspan="4" ><input type="text" id="NOM" name="NOM" value="" class="Bakes" onDblClick="helpPRO()"  /></td>
    </tr>
  <tr>
    
    <td class="style2">PO #:</td>
    <td ><input type="text" id="POS" name="POS" value="" class="bakes" ondblclick="hlpPO()" onChange="bakePO();colores()" /></td>
    <td class="style5" >Servicio:</td>
    <td>
        <select id="SER" name="SER"  class="INPUTS">
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
    <td class="style2">Guia</td>
    <td align="leftr"><input type="radio" id="CHK" name="CHK" value="1" checked onclick="chk()" />Modelador</td>
    <td align="left"><input type="radio" id="CHK" name="CHK" value="0" onclick="chk()"/>Taller </td>
    <td width="20%"><input type="text" id="GU1" name="GU1" value="" style="display:block" class="INPUTS"/><input type="text" id="GU2" name="GU2" value="" style="display:none"  class="INPUTS"/></td>
</tr>
<tr>
   <td class="style1" >Color:</td>
   <td>
    <select id="COL" name="COL" class="INPUTS" width="50px">
        <option value=""></option>
    </select></td>
    <td class="style1" >Agrupado por:</td>
   <td>
    	<select id="TIP" name="TIP" class="INPUTS" width="50px">
            <option value="1">Estilo + Mov + Cliente + Servicio</option>
            <option value="2">Estilo + Mov + Cliente + Servicio + Po</option>
            <option value="3">Estilo + Mov + Cliente + Servicio + Po + Ofi + Color</option>
            <option value="4">Estilo + Mov + Cliente + Servicio + Po + Ofi + Color + Proveedor</option>
        </select></td>
     <td class="style2">Salida a :</td>
    <td align="left"><input type="radio" id="PRN" name="PRN" value="1" checked onclick="chk()" />Pantalla</td>
    <td><input type="radio" id="PRN" name="PRN" value="2" onclick="chk()"/>Excel </td>
    
    <td colspan="2" ></td>
</tr>

<tr>
    <td colspan="7" align="center"><input type="button" value="Procesa" onclick="llamame()"></td>
</tr>
<tr>
    <td colspan="7"><iframe  width="100%" src="" id="body10" name="body10" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe></td>
</tr>
<tr>

    <td colspan="7">
        <table id="TABLA" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
        <%'**************************%>
        <%'LINEA DE CABECERA STANDAR %>
        <%'**************************%>
        <%LIMITE =  RS.fields.count - 1	%>
        <tr bgcolor=#006699 >
            <%for I=0 to rs.fields.count-1 %>
	            <td align="center" class="Estilo8"><%=ucase(RS.FIELDS(I).NAME)%></td>
            <%next%>	
        </tr>
        <%'IF  RS.EOF THEN response.end%>
        <%CONT=1%>
        <%DO WHILE NOT RS.EOF%>
            <%idd = "fila"&trim(cont)%>

	         <tr id="<%=idd%>" name="<%=idd%>"
              bgcolor="<%if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	             >    
	            <%FOR i=0 TO rs.fields.count -2%>
		            <td class="estilo5"><%=ucase(rs.fields.item(i)) %></td>
	            <%NEXT%>
               <td class="estilo5" style="text-align:right; padding-right:10px;"><%if CDBL(rs.fields.item(i))>0 then response.write (formatnumber(rs.fields.item(i),0,,,true)) %></td>
	        </tr>
	        <%RS.MOVENEXT%>
	        <%CONT = CONT + 1%>
	        <%LOOP%>
        </table>

    </td>
</tr>  
</table>


<script language="jscript" type="text/jscript">

function llamame() 
{   dd = 'FILTROS_ACUMULA.asp'
    dd += '?ECL=' + document.all.ECL.value
    dd += '&mov=' + document.all.MOV.value
    dd += '&ser=' + document.all.SER.value
    dd += '&pos=' + document.all.POS.value
    dd += '&ruc=' + document.all.RUC.value
    dd += '&CLI=' + document.all.CLI.value
    dd += '&COL=' + document.all.COL.value
    dd += '&TIP=' + document.all.TIP.value
    dd += '&GU1=' + document.all.GU1.value
    dd += '&GU2=' + document.all.GU2.value
    if (document.all.CHK[0].checked == true) 
        { dd += '&CHK=' + document.all.CHK[0].value }
    else
        { dd += '&CHK=' + document.all.CHK[1].value }
    
    if (document.all.PRN[0].checked == true)
        { dd += '&PRN=' + document.all.PRN[0].value }
    else
        { dd += '&PRN=' + document.all.PRN[1].value }

    //alert(dd)
    window.location.replace(dd)
}

function chk() 
{   if (document.all.CHK[0].checked == true) 
    {
        document.all.GU1.style.display = 'block'
        document.all.GU2.style.display = 'none'
        document.all.GU2.value= ''
    }
    if (document.all.CHK[1].checked == true) 
    {
        document.all.GU2.style.display = 'block'
        document.all.GU1.style.display = 'none'
        document.all.GU1.value= ''
    }
   
}

function bakeEST() 
{ cad = '../bake/bk_estilo.asp?ecl='+ trim(document.getElementById('ECL').value) + '&cli=' + trim(document.getElementById('CLI').value)
  //  alert(cad)
  //  document.all.body0.style.display='block'
  document.all.body0.src = cad
}

function hlpEST() 
{   if (trim(document.getElementById('CLI').value) == '') 
    {   alert("Seleccione un Cliente por Favor")
        return true
    }
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=100,top=100,height=400,width=600";
    cad = '../help/HLPestilo.asp?cli=' + trim(document.all.CLI.value) + '&ecl=' + ltrim(document.all.ECL.value)
    window.open(cad, '', opc)
}

function hlpPO() 
{   if (trim(document.getElementById('ECL').value) == '') 
    {   alert("Seleccione un Estilo por Favor")
        return true
    }
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=100,top=100,height=400,width=600";
    cad = '../help/HLPPO.asp?ecl=' + trim(document.all.ECL.value)
    window.open(cad, '', opc)
}

function bakePO() 
{    document.all.body10.src = "../BAKE/jala_po.asp?pos=" + trim(document.all.POS.value) + '&ecl=' + trim(document.all.ECL.value);
}

function COL() 
{

    alert()
return true
/*
if (trim(document.getElementById('ECL').value) == '' && trim(document.getElementById('POS').value) == '') 
{   alert("Seleccione PO y/o Estilo ")
return true;
}

*/

}

 
function colores() 
{  document.all.body10.src = "../BAKE/BAKECOLORpo.asp?pos=" + trim(document.all.POS.value) + '&ecl=' + trim(document.all.ECL.value)+'&sele=COL';
}

function helpPRO() 
{   if (trim(document.all.RUC.value) == '' && trim(document.all.NOM.value) == '') 
    {   alert("Por favor informe el RUC o Nombre del proveedor")
        return false;
    }
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=100,top=100,height=400,width=600";
    cad = '../help/HLPproveedor.asp?ruc=' + trim(document.all.RUC.value) + '&nom=' + ltrim(document.all.NOM.value)
    window.open(cad, '', opc)
}

function bakepro() 
{    document.all.body10.src = "../BAKE/jala_pro.asp?RUC=" + trim(document.all.RUC.value);
}






</script>



</form>
</BODY>
</HTML>
