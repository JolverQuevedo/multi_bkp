<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
     
Session.LCID=2057
    %>
<html>
<head>
<title>Edicion de Documentos</title>
<link href="multisty.css" rel="stylesheet" type="text/css">
<link href="multisty.css" rel="stylesheet" type="text/css">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNqry.ASP"-->

<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<%'****************************************************
ALMa = request.QueryString("ALMa")	 ' este el almacen de la cabecera (para lo nuevo)
ini = request.QueryString("fini")
linea = request.QueryString("op")
nro =  request.QueryString("nro")
can = request.QueryString("can")
cod = request.QueryString("cod")
id  = request.QueryString("id")
ALM = request.QueryString("ALM")	' este es el almacen del movimiento (en caso de ser una modificacion)

if len(ltrim(rtrim(alm))) > 0 then almac = alm else almac = alma
%>
    <style type="text/css">
        .style1
        {   width: 100px;
            font-family:Arial;   font-size:12px; 
            color:#000000; font-weight:300; padding: 0.0em 0.0em;
            background-color:#A3B87A; border-style:hidden; 
        }
        .style2
        {
            font-family: Arial;
            font-size: 12px;
            color: #000000;
            font-weight: 300;
            width: 114px;
            border-style: hidden;
            padding: 0.0em;
            background-color: #A3B87A;
        }
        .style3
        {
            width: 315px;
        }
        .style5
        {
            width: 127px;
        }
        .style6
        {
            font-family: Arial;
            font-size: 12px;
            color: #000000;
            font-weight: 300;
            width: 100px;
            border-style: hidden;
            padding: 0.0em;
            background-color: #A3B87A;
        }
    </style>
</head>

<body style="margin-top:0; margin-left:0; margin-right:0; background-color:#A3B87A" >
<form name="thisForm" METHOD="post" >
<table  border="0" cellspacing="1" cellpadding="0" align="center" width="100%" style="background-color:#A3B87A" >
    <tr valign="middle">
       <td colspan="1"   align="right"  class="style6">&nbsp;Entrada :&nbsp;</td>
        <td width="168" colspan="1"><input  class="Estilo1" id="ent" name="ent" value="E"  readonly tabindex="-1"></td>
        
        <%tt1 = "RSFACCAR..AL"+cia+"ALMA"
        cad = "Select A1_CDESCRI as descri From "&tt1&"  Where A1_CALMA='"&almac&"' "
        rs.open cad, cnn
        if rs.recordcount > 0 then rs.movefirst %>
        <td colspan="7" class="data" align="left" width="612"> <%=ucase(trim(rs("descri"))) %></td>
        <%RS.CLOSE %>
    </tr>

    <tr>
    <td colspan="1" align="right"  class="style6">&nbsp; Movimiento :&nbsp;</td>
    <td colspan="5">
        <%tt1 = "RSFACCAR..AL"+cia+"TABM"
        cad =   " Select tm_ccodmov ,tm_cdescri From "&tt1&" Where TM_CTIPMOV='E' ORDER BY TM_CCODMOV " 
        RS.OPEN CAD, CNN     
       ' response.write(cad)          
      '  response.end
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
            <select  class="INPUTS" id="mov" name="mov"  value="" >
                <option value=""></option>
                <%DO WHILE NOT RS.EOF %>
                    <option value="<%=RS.FIELDS.ITEM(0)%>"><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                    <%RS.MOVENEXT %>
                <%LOOP%>
                <%rs.close%>
            </select> 
        </td>
        <td colspan="1">&nbsp;</td>
    </tr>
    <tr valign="middle">
        <td align="right" class="style6" > Doc Num:&nbsp;</td>
        <%if (len(ltrim(rtrim(nro)))) = 0 then 
            tt1 = "RSFACCAR..AL"+cia+"ALMA"
            cad = "Select A1_NNUMENT From "&tt1&" Where A1_CALMA='"&almac&"'  "
            rs.open cad, cnn
            rs.movefirst
            nume = right("0000000000000"+cdbl(rs("a1_nnument"))+1,11)
            rs.close
        else
            nume = nro  
         end if   %>

        <td colspan="1" ><input type="text" class="data" id="nro" name="nro" value ="<%=nume %>" readonly tabindex="-1" style="background-color:#A3B87A"/></td>
        <td colspan="6" align="left"><input id="idd" name="idd" readonly tabindex="-1"  style="background-color:#A3B87A; border:0" /></td>
        
        <td  align="right" class="estilo55"> Fecha :&nbsp;</td>
        <td  colspan="1" class="data" ><input  class="Estilo1" id="fec" name="fec" value="<%if len(trim(ini))> 0 then response.write(formatdatetime(ini,2)) %>" readonly tabindex="-1"></td>
       
  </tr>
   <tr>  
        <td align="right" class="style6"  > Moneda :&nbsp;</td>
        <td colspan="5">
        <%tt1 = "RSFACCAR..AL"+cia+"tabl"
        cad =   " Select tg_cclave, tg_cdescri From "&tt1&" Where TG_CCOD='03' Order by TG_CCLAVE    " 
        RS.OPEN CAD, CNN     
       ' response.write(cad)          
      '  response.end
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
            <select  class="INPUTS" id="mon" name="mon"  value="" >
                <option value=""></option>
                <%DO WHILE NOT RS.EOF %>
                    <option value="<%=RS.FIELDS.ITEM(0)%>"><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                    <%RS.MOVENEXT %>
                <%LOOP%>
                <%rs.close%>
            </select> 
        </td>
        <td colspan="5">&nbsp;</td>
    </tr>
   <tr>  
        <td colspan="1"  align="right" class="style6">&nbsp;Conversion :&nbsp;</td>
        <td colspan="3">
        <%tt1 = "RSFACCAR..AL"+cia+"tabl"
        cad =   " Select tg_cclave, tg_cdescri From "&tt1&" Where TG_CCOD='37' Order by TG_CCLAVE    " 
        RS.OPEN CAD, CNN     
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
            <select  class="INPUTS" id="con" name="con"  value="" >
                <option value=""></option>
                <%DO WHILE NOT RS.EOF %>
                    <option value="<%=RS.FIELDS.ITEM(0)%>"><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                    <%RS.MOVENEXT %>
                <%LOOP%>
                <%rs.close%>
            </select> 
        </td>
        <td colspan="3">&nbsp;</td>
        <td colspan="2" align="right" class="estilo55" >Fec_Camb :</td>
        <td colspan="1" class="data" ><input  class="Estilo1" id="cam" name="cam" value="<%if len(trim(ini))> 0 then response.write(formatdatetime(ini,2)) %>" readonly tabindex="-1"></td>

    </tr>
<tr valign="middle">
       <td colspan="1" align="right"  class="style6">&nbsp;Tipo_Cambio :&nbsp;</td>
       <%cad = "Select XCODMON,XMEIMP,XMEIMP2 From RSCONCAR..CTCAMB Where XCODMON='US' And CONVERT(DATETIME,XFECCAM2,103)=Convert(datetime,'"&ini&"',103)  "
        rs.open cad, cnn
        'response.write(cad)
        if rs.recordcount > 0 then 
            rs.movefirst 
            'tcm =replace(rs("XMEIMP2"),",",".")
            tcm =rs("XMEIMP2")
        else
            tcm = 0
        end if%>
        <td colspan="2"><input class="estilo1" value="<%=tcm%>" id="tcm" name="tcm"/></td>
        <%RS.CLOSE %>
  <%'response.end %>
    </tr>
<tr><td colspan="10"><hr></td></tr>
 <tr valign="middle">
        <td align="right" class="style6"  > Proveedor :&nbsp;</td>
        <td colspan="1"  width="168px" ><input type="text" class="INPUTS" id="ruc" name="ruc" value="20100174911" onBlur="jala_ruc()"/></td>
        <td  align="left" width="38px"><img src="IMAGES/lupa.png" border="0" onClick="buscapr()" id="img1" name="img1" style="cursor:pointer"/></td>
        <td  colspan="6" class="data" align="left" width="612"><input type="text" class="data" id="pr" name="pr" value="" style="background-color:#A3B87A"/>      </td> 
</tr>
<tr><td colspan="10"><hr></td></tr>
</table>

<table  border="0" cellspacing="1" cellpadding="0" align="center" width="100%" style="background-color:#A3B87A" >

<tr>
<td align="right"  class="style1">&nbsp;Tip Doc 1 :&nbsp;</td>
    <td colspan="1" class="style3" >
        <%tt1 = "RSFACCAR..AL"+cia+"tabl"
        cad =   " Select TG_CCLAVE, TG_CDESCRI From "&tt1&" Where TG_CCOD='04'  " 
        RS.OPEN CAD, CNN     
       ' response.write(cad)          
      '  response.end
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
            <select  class="INPUTS" id="dc1" name="dc1"  value="" >
                <option value=""></option>
                <%DO WHILE NOT RS.EOF %>
                    <option value="<%=RS.FIELDS.ITEM(0)%>"><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                    <%RS.MOVENEXT %>
                <%LOOP%>
                <%rs.close%>
            </select> 
        </td>

        <td align="right" class="estilo55" > Doc Num:&nbsp;</td>
        <td colspan="1"><input type="text" class="INPUTS" id="nr1" name="nr1"  /></td>
</tr>
<tr>
<td align="right"  class="style1">&nbsp;Tip Doc 2 :&nbsp;</td>
    <td colspan="1" class="style3" >
        <%tt1 = "RSFACCAR..AL"+cia+"tabl"
        cad =   " Select TG_CCLAVE, TG_CDESCRI From "&tt1&" Where TG_CCOD='04'  " 
        RS.OPEN CAD, CNN     
       ' response.write(cad)          
      '  response.end
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
            <select  class="INPUTS" id="dc2" name="dc2"  value="" >
                <option value=""></option>
                <%DO WHILE NOT RS.EOF %>
                    <option value="<%=RS.FIELDS.ITEM(0)%>"><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                    <%RS.MOVENEXT %>
                <%LOOP%>
                <%rs.close%>
            </select> 
        </td>
       
        <td align="right" class="estilo55" > Doc Num:&nbsp;</td>
        <td colspan="1" ><input type="text" class="INPUTS" id="nr2" name="nr2"  /></td>
</tr>

 <tr>  
        <td colspan="1"  align="right" class="style1">&nbsp;Ord Compra :&nbsp;</td>
        <td colspan="1" class="style3">
        <%cad =   " Select AC_CCIA,AC_CNOMCIA From RSFACCAR..ALCIAS Order by AC_CCIA " 
        RS.OPEN CAD, CNN     
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
            <select  class="INPUTS" id="emp" name="emp"  value="" >
                <option value=""></option>
                <%DO WHILE NOT RS.EOF %>
                    <option value="<%=RS.FIELDS.ITEM(0)%>"><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                    <%RS.MOVENEXT %>
                <%LOOP%>
                <%rs.close%>
            </select> 
        </td>
       	
        <td colspan="1" width="10%"><input type="text" class="inputs" id="occ" name="occ"  /></td>
    </tr>

<tr>
   <td align="right" class="style1" > Ord Trabajo:&nbsp;</td>
        <td colspan="1" class="style3" ><input type="text" class="inputs" id="ofi" name="ofi"  /></td>
</tr>
<tr>  
        <td colspan="1"  align="right" class="style1">&nbsp;Solicitante :&nbsp;</td>
        <td colspan="1" class="style3">
        <%tt1 = "RSFACCAR..AL"+cia+"tabl"
        cad =   " Select TG_CCLAVE, TG_CDESCRI From "&tt1&" Where TG_CCOD='12' " 
        RS.OPEN CAD, CNN     
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
            <select  class="INPUTS" id="sol" name="sol"  value="" >
                <option value=""></option>
                <%DO WHILE NOT RS.EOF %>
                    <option value="<%=RS.FIELDS.ITEM(0)%>"><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                    <%RS.MOVENEXT %>
                <%LOOP%>
                <%rs.close%>
            </select> 
        </td>
       <td colspan="2"></td>
    </tr>
<tr>  
        <td colspan="1"  align="right" class="style1">&nbsp;Cen Costo :&nbsp;</td>
        <td colspan="1" class="style3">
        <%tt1 = "RSFACCAR..AL"+cia+"tabl"
        cad =   " Select TG_CCLAVE, TG_CDESCRI From "&tt1&" Where TG_CCOD='10' " 
        RS.OPEN CAD, CNN     
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
            <select  class="INPUTS" id="cto" name="cto"  value="" >
                <option value=""></option>
                <%DO WHILE NOT RS.EOF %>
                    <option value="<%=RS.FIELDS.ITEM(0)%>"><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                    <%RS.MOVENEXT %>
                <%LOOP%>
                <%rs.close%>
            </select> 
        </td>
       <td colspan="2"></td>
    </tr>
    <tr>
        <td align="right" class="style1" > Glosa 1:&nbsp;</td>
        <td colspan="3" ><input type="text" class="INPUTS" id="gl1" name="gl1" maxlength="30" /></td>
    </tr>
     <tr>
        <td align="right" class="style1" > Glosa 2:&nbsp;</td>
        <td colspan="3" ><input type="text" class="INPUTS" id="gl2" name="gl2" maxlength="30" /></td>
    </tr>
     <tr>
        <td align="right" class="style1" > Glosa 3:&nbsp;</td>
        <td colspan="3"><input type="text" class="INPUTS" id="gl3" name="gl3" maxlength="30" /></td>
    </tr>

    <tr>
     <td align="right" class="style1" > Alm. Ref :&nbsp;</td>
        <td colspan="3">
<%  TBL1 = "RSFACCAR..AL" + CIA + "ALMA"
    TBL2 = "MULTI..RS_USUALM" + CIA 
cad =   " select a1_calma, a1_calma+space(5)+a1_cdescri as descri from "&tbl1&"  A " & _
        " INNER JOIN "&TBL2&" B ON (A1_CALMA COLLATE Modern_Spanish_CI_AS =CALMA) AND B.CUSUARIO='"&usr&"' order by 1 " 
        'response.write(cad)
rs.open cad,cnn                %>
            <select  class="INPUTS" id="al2" name="al2" value="" >
                <option value=""></option>
                <%if rs.recordcount > 0 then %>
                <%rs.movefirst%>
                <%do while not rs.eof%>
                    <option value='<%=rs("a1_calma")%>'><%=rs("descri")%></option>
                    <%RS.MOVENEXT%>
                <%loop%>
                <%end if%>
                <%rs.close%>
            </select> 
        </td>
    </tr>
  <tr>
     <td align="right" class="style1" > Cliente :&nbsp;</td>
        <td colspan="3">
<%  tt1 = "RSFACCAR..FT"+cia+"CLIE"
cad =   "Select * From "&tt1&" where cl_cestado = 'v' and cl_ccodcli like'%e%' and cl_czonvta = '0003' order by cl_cnomcli" 
        'response.write(cad)
rs.open cad,cnn                %>
            <select  class="INPUTS" id="cli" name="cli" value="" >
                <option value=""></option>
                <%if rs.recordcount > 0 then %>
                <%rs.movefirst%>
                <%do while not rs.eof%>
                    <option value='<%=rs("CL_CCODCLI")%>'><%=rs("CL_CNOMCLI")%></option>
                    <%RS.MOVENEXT%>
                <%loop%>
                <%end if%>
                <%rs.close%>
            </select> 
        </td>
    </tr>
    <tr>  
        <td colspan="1"  align="right" class="style1">&nbsp;Tip/Cod/Anexo :&nbsp;</td>
        <td colspan="1" class="style3">
        <%TBL5 = "RSCONCAR..CT"+cia +"TAGE "
        cad =   " Select * From "&tbl5&" Where TCOD='07' Order by TCLAVE" 
        RS.OPEN CAD, CNN     
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
            <select  class="INPUTS" id="tam" name="tam"  value="" >
                <option value=""></option>
                <%DO WHILE NOT RS.EOF %>
                    <option value="<%=RS.FIELDS.ITEM(1)%>"><%=RS.FIELDS.ITEM(1)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(2)%></option>
                    <%RS.MOVENEXT %>
                <%LOOP%>
                <%rs.close%>
            </select> 
        </td>   
        <td colspan="1" widtg="10%"><input type="text" class="Estilo1" id="ane" name="ane"  /></td>
    </tr>
</table>

<center>
    <input type="button" value="Continuar" id="ok" name="ok" onClick="envia(1)" />  <input type="button" value="Cancelar" id="no" name="no" onClick="envia(0)" />
</center>

<iframe  width="100%" style="display:none; width:100%;" src="" id="body0" name="body0" scrolling="yes" frameborder="0" ></iframe>
<input type="text" id="posi" name="posi" value ='<%=linea%>' style="display:none">
<script language="jscript" type="text/jscript">
    lin = parseInt('<%=linea%>', 10)
    function jala_ruc() {
        if (trim(document.all.ruc.value) != '') {
            cad = 'bake/jala_ruc.asp?ruc=' + trim(document.all.ruc.value)
            document.all.body0.src = cad
        }
    }
</script>
<%TBL1 = "RSFACCAR..AL" + cia + "MOVC"
cad =   " select * from "&tbl1&"  where " & _
        " C5_CALMA = '"&almac&"' and  C5_CTD = 'PE' and c5_cnumdoc = '"&nro&"' "
'response.write(cad)
rs.open cad,cnn
if rs.recordcount > 0 then
    movi = rs("c5_ccodmov")
    mone = rs("c5_ccodmon")
    situ = rs("c5_CsituA")
    doc1 = rs("c5_crftdoc")
    USUA = RS("C5_CSOLI")
    cost = RS("C5_CCENCOS")
    nr1  = rs("C5_CRFNDOC")
    cci  = rs("C5_CCIAS")
    occ  = rs("C5_CNUMORD")
    dc2  = rs("C5_CRFTDO2")
    nr2  = rs("C5_CRFNDO2")
    gl1  = rs("C5_CGLOSA1")
    gl2  = rs("C5_CGLOSA2")
    gl3  = rs("C5_CGLOSA3")
    alr  = rs("C5_CRFALMA")
    tam  = rs("C5_CtipANE")
    ane  = rs("c5_ccodane")
    ini  = rs("c5_dfecdoc")
    tcm  = formatnumber(rs("c5_ntipcam"),3,,true)
    MARKA = 1
else 
    movi = "EP"
    mone = "US"
    situ = "V"
    doc1 = "PO"
    USUA = "CH"
    COST = "20000"
    MARKA = 0
    gl1 = "PRODUCCION EXPORTACION"

end if  %>

<script language="jscript" type="text/jscript">

    var subcadena = '<%=trim(movi)%>'
    //alert(subcadena)
    var elemento = document.all.mov;
    document.all.mov.selectedIndex = seleindice(subcadena, elemento);
    subcadena = '<%=trim(mone)%>'
    elemento = document.all.mon;
    document.all.mon.selectedIndex = seleindice(subcadena, elemento);
    subcadena = '<%=trim(situ) %>'
    elemento = document.all.con;
    document.all.con.selectedIndex = seleindice(subcadena, elemento);
    subcadena = '<%=trim(doc1) %>'
    elemento = document.all.dc1;
    document.all.dc1.selectedIndex = seleindice(subcadena, elemento);
    subcadena = '<%=TRIM(USUA)%>'
    elemento = document.all.sol;
    document.all.sol.selectedIndex = seleindice(subcadena, elemento);
    subcadena = '<%=TRIM(COST)%>'
    elemento = document.all.cto;
    document.all.cto.selectedIndex = seleindice(subcadena, elemento);
    document.all.idd.value = eval("window.opener.document.all.ID" + lin + ".value")
    //document.all.gl1.value = 'PRODUCCION '
    //alert(window.opener.document.all.POS1.value)
    document.all.nr1.value = eval("window.opener.document.all.POS"+lin+".value")
    document.all.ofi.value = eval("window.opener.document.all.EST" + lin + ".value")
    jala_ruc()
    subcadena = eval("window.opener.document.all.RUC" + lin + ".value")
    elemento = document.all.cli;
    document.all.cli.selectedIndex = seleindice(subcadena, elemento);
    //alert('<%=cia %>')
    MARK = parseInt('<%=MARKA%>',10)
    if (MARK == 1 )
    {   document.all.mov.disabled = true
        document.all.nr1.disabled = true
        document.all.ofi.disabled = true
        document.all.nr1.value = '<%=nr1%>'
        subcadena = '<%=cci%>'
        elemento = document.all.emp;
        document.all.emp.selectedIndex = seleindice(subcadena, elemento);
        document.all.occ.value = '<%=occ%>'
        subcadena = '<%=dc2%>'
        elemento = document.all.dc2;
        document.all.dc2.selectedIndex = seleindice(subcadena, elemento);
        subcadena = '<%=alr%>'
        elemento = document.all.al2;
        document.all.al2.selectedIndex = seleindice(subcadena, elemento);
        subcadena = '<%=tam%>'
        elemento = document.all.tam;
        document.all.tam.selectedIndex = seleindice(subcadena, elemento);
        document.all.nr2.value = '<%=nr2%>'
        document.all.ane.value = '<%=ane%>'
        document.all.gl1.value = '<%=trim(ucase(gl1))%>'
        document.all.gl2.value = '<%=trim(ucase(gl2))%>'
        document.all.gl3.value = '<%=trim(ucase(gl3))%>'
        document.all.cam.value = '<%=formatdatetime(ini,2)%>'
        document.all.fec.value = '<%=formatdatetime(ini,2)%>'
       //document.all.tcm.value = cerea('<%=tcm%>',2)
    }
    document.all.gl1.value = '<%=trim(ucase(gl1))%>'


    function buscapr() {
        window.open('HELP/busca_prov_oc.ASP?NOM=' + ltrim(document.all.pr.value))
        return true;
    }

    function envia(op) {
        if (op == '0') {
            this.window.close()
            return false
        }

        if (trim(document.all.mov.value) == "") {
        alert("Debe seleccionar el tipo de movimiento")
        document.all.mov.focus()
        return false
        }

        if (trim(document.all.mon.value) == "") {
        alert("Debe seleccionar el tipo de moneda")
        document.all.mon.focus()
        return false
        }

        if (trim(document.all.con.value) == "") {
        alert("Debe seleccionar el tipo de conversion a usar")
        document.all.con.focus()
        return false
        }

    if (trim(document.all.ruc.value) == "") {
        alert("Debe seleccionar el RUC del Proveedor")
        document.all.ruc.focus()
        return false
    }
    if (trim(document.all.dc1.value) == "") {
        alert("Debe seleccionar el tipo de documento")
        document.all.dc1.focus()
        return false
    }
    if (trim(document.all.nr1.value) == "") {
        alert("Debe indicar el número de documento 1")
        document.all.nr1.focus()
        return false
    }
    if (trim(document.all.ofi.value) == "") {
        alert("Debe indicar el codigo de estilo")
        document.all.ofi.focus()
        return false
    }
    if (trim(document.all.sol.value) == "") {
        alert("Debe indicar el nombre del solicitante")
        document.all.sol.focus()
        return false
    }
    if (trim(document.all.cto.value) == "") {
        alert("Debe indicar el número del centro de costo")
        document.all.cto.focus()
        return false
    }
    if (trim(document.all.cli.value) == "") {
        alert("Debe indicar el cliente")
        document.all.cli.focus()
        return false
    }

    // alert()
    almac = '<%=trim(ucase(almac))%>'
    //alert(alm)
    document.all.body0.style.display = 'block'
    cad = 'comun/inserPE_head.asp'
    cad += '?alm=' + almac
    cad += '&mov=' + document.all.mov.value
    cad += '&fec=' + document.all.fec.value
    cad += '&RUC=' + document.all.ruc.value
    cad += '&dc1=' + document.all.dc1.value
    cad += '&dc2=' + document.all.dc2.value
    cad += '&nr1=' + document.all.nr1.value
    cad += '&nr2=' + document.all.nr2.value
    cad += '&emp=' + document.all.emp.value
    cad += '&occ=' + document.all.occ.value
    cad += '&ofi=' + document.all.ofi.value
    cad += '&sol=' + document.all.sol.value
    cad += '&cto=' + document.all.cto.value
    cad += '&al2=' + document.all.al2.value
    cad += '&cli=' + document.all.cli.value
    cad += '&tam=' + document.all.tam.value
    cad += '&ane=' + document.all.ane.value
    cad += '&gl1=' + document.all.gl1.value
    cad += '&gl2=' + document.all.gl2.value
    cad += '&gl3=' + document.all.gl3.value
    cad += '&pr=' + document.all.pr.value
    cad += '&mon=' + document.all.mon.value
    cad += '&con=' + document.all.con.value
    cad += '&tcm=' + document.all.tcm.value
    cad += '&ncl=' + document.all.cli.options(document.all.cli.selectedIndex).text
    cad += '&idd=' + document.all.idd.value
    cad += '&UPD=' + '<%=TRIM(MARKA)%>'
    cad += '&nro=' + '<%=TRIM(nume)%>'
    cad += '&can=' + '<%=TRIM(can)%>'
    cad += '&cod=' + '<%=TRIM(cod)%>'
   // alert(cad) 
    document.all.body0.src = cad
    return true
    //correlativo--> nro

}  


</script>

</form><%
 '   response.write("<p>")
 '    response.write("Default LCID is: " & Session.LCID & "<br>")
 '    response.write("Date format is: " & date() & "<br>")
 '    response.write("Currency format is: " & FormatCurrency(350))
 '    response.write("</p>")
 '    
 '   Session.LCID=1036
 '    
 '   response.write("<p>")
 '    response.write("LCID is now: " & Session.LCID & "<br>")
 '    response.write("Date format is: " & date() & "<br>")
 '    response.write("Currency format is: " & FormatCurrency(350))
 '    response.write("</p>")
 '    
 '   Session.LCID=3079
 '    
 '   response.write("<p>")
 '    response.write("LCID is now: " & Session.LCID & "<br>")
 '    response.write("Date format is: " & date() & "<br>")
 '    response.write("Currency format is: " & FormatCurrency(350))
 '    response.write("</p>")
 '    
 '   Session.LCID=2057
 '    
 '   response.write("<p>")
 '    response.write("LCID is now: " & Session.LCID & "<br>")
 '    response.write("Date format is: " & date() & "<br>")
 '    response.write("Currency format is: " & FormatCurrency(350))
 '    response.write("</p>")
 %>
</body>
</html>