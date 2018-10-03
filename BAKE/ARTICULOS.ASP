<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>
<html>
<head>
<title>Edicion de Documentos</title>
<link href="multisty.css" rel="stylesheet" type="text/css">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNqry.ASP"-->
<SCRIPT language="javascript" src="includes/cal.js"></SCRIPT>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">

<% ' por si acaso he incluido una fila en bñanco a todas las tablas de articulos para porder tener de regerso SIEMPRE
   ' aunque sea una linea y que no falle el dataentry
 Set RS2 = Server.CreateObject("ADODB.Recordset")
      RS2.ActiveConnection = Cnn
      RS2.CursorType       = 3 'CONST adOpenStatic = 3
      RS2.LockType         = 1 'CONST adReadOnly = 1
      RS2.CursorLocation   = 3 'CONST adUseClient = 3

cod = (ltrim(rtrim(request.QueryString("cod")))) 
tbl222 = " RSFACCAR..AL" + cia + "ARTI "
cad =   " Select * From "&tbl222&" Where AR_CCODIGO='"&cod&"' " & _
        " union Select * From RSFACCAR..AL0001ARTI Where AR_CCODIGO=' ' " & _
        " order by ar_ccodigo desc                                      "
'response.write (cad)
rs2.open cad,cnn
rs2.movefirst

 %>
</head>

<body style="margin-top:0; margin-left:0; margin-right:0">
<form name="thisForm" METHOD="post" >
<table  border="0" cellspacing="0" cellpadding="0" align="center" width="100%" >
<tr><td>

<table  border="0" cellspacing="2" cellpadding="0" align="center" width="100%" >
<tr width="100%"><td class="Estilo3">Generales:</td>
</tr>
</table>
</td></tr>
<!--------------------------------------------------------------------->
<tr><td>
<table  border="0" cellspacing="0" cellpadding="0" align="center" width="100%" class="Estilo55" >
     <tr>
      <td align="left" class="Estilo55" width="100px" >Art&iacute;culo :</td>
      <td width="000px"><input type="text" class="BAKES" id="cart" name="cart" style="text-align:center" onBlur="BAKE()" onDblClick="hlpART()" value="<%=rs2("AR_CCODIGO")%>"/></td>
      <td ><input type="text" class="INPUTS" id="dart" name="dart" style="text-align:left; width:100%" value="<%=rs2("AR_CDESCRI")%>"/></td>
      <td align="left" class="Estilo55" width="100px" > Unidad :</td>
        <td width="100px">
           <%tt1 = "RSFACCAR..AL"+cia+"tabl"
            cad =   " Select tg_cclave, tg_cdescri From "&tt1&" Where TG_CCOD='05' Order by TG_CCLAVE    " 
            RS.OPEN CAD, CNN     
           ' response.write(cad)          
          '  response.end
            IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
                <select  class="INPUTS" id="uni" name="uni" >
                    <option value=""></option>
                    <%DO WHILE NOT RS.EOF %>
                        <option value="<%=RS.FIELDS.ITEM(0)%>"
                        <%if TRIM(rs2("AR_CUNIDAD")) = TRIM(rs.fields.item(0)) then%> selected <%end if%>
                        ><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                        <%RS.MOVENEXT %>
                    <%LOOP%>
                    <%rs.close%>
                </select> 
          </td>
  </tr>
  <tr>
        <td align="left" class="Estilo55" width="110px" > Adicional :</td>
        <td colspan="2"><input type="text" class="INPUTS" id="dart2" name="dart2" style="text-align:left; width:100%"  value="<%=rs2("AR_CDESCR2")%>"/></td>
 
        
          <td align="left" class="Estilo55" width="100px" > Codigo Ref: :</td>
          <td width="100px" ><input type="text" class="INPUTS" id="cart2" name="cart2" style="text-align:left; width:100%" value="<%=RS2("AR_CCODIG2")%>"/></td>
  </tr>
</table>
</td></tr>
<!--------------------------------------------------------------------->
<tr><td>
<table  border="0" cellspacing="2" cellpadding="0" align="center" width="100%" >
    <tr width="100%"><td class="Estilo3">Clasificacion:</td></tr>
</table>
</td></tr>
<!--------------------------------------------------------------------->
<tr><td>
<table  border="0" cellspacing="0" cellpadding="0" align="center" width="100%"  class="Estilo55">
     <tr>
        <td align="left" class="Estilo55" width="150px" > Cuenta :</td>
        <td width="200px" >
           <%tt1 = "RSFACCAR..ft"+cia+"ctae"
            cad =   " Select TC_CEXISTE,TC_CDESCRI From "&tt1&" Order by TC_CEXISTE    " 
             
            'response.write(cad) 
              RS.OPEN CAD, CNN           
          '  response.end
            IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
                <select  class="INPUTS" id="cta" name="cta"  value="" >
                    <option value=""></option>
                    <%DO WHILE NOT RS.EOF %>
                        <option value="<%=RS.FIELDS.ITEM(0)%>"
                         <%if TRIM(rs2("AR_CCUENTA")) = TRIM(rs.fields.item(0)) then%> selected <%end if%>>
                        <%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                        <%RS.MOVENEXT %>
                    <%LOOP%>
                    <%rs.close%>
                </select> 
          </td>
          <td align="left" class="Estilo55" width="150px" > Tipo Articulo :</td>
          <td width="300px" > 
           <%tt1 = "RSFACCAR..AL"+cia+"tabl"
            cad =   " Select tg_cclave, tg_cdescri From "&tt1&" Where TG_CCOD='08' Order by TG_CCLAVE    " 
            RS.OPEN CAD, CNN     
           ' response.write(cad)          
          '  response.end
            IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
                <select  class="INPUTS" id="tip" name="tip" >
                    <option value=""></option>
                    <%DO WHILE NOT RS.EOF %>
                        <option value="<%=RS.FIELDS.ITEM(0)%>"
                        <%if TRIM(rs2("AR_CTIPO")) = TRIM(rs.fields.item(0)) then%> selected <%end if%>
                        ><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                        <%RS.MOVENEXT %>
                    <%LOOP%>
                    <%rs.close%>
                </select> 
          </td>
  </tr>
  <tr>
      <td align="left" class="Estilo55" width="150px" > Linea :</td>
          <td width="300px" > 
           <%tt1 = "RSFACCAR..ft" + cia + "line"
            cad =   " Select * From RSFACCAR..FT0001LINE Order by 2    " 
            RS.OPEN CAD, CNN     
           ' response.write(cad)          
          '  response.end
            IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
                <select  class="INPUTS" id="lin" name="lin" >
                    <option value=""></option>
                    <%DO WHILE NOT RS.EOF %>
                        <option value="<%=RS.FIELDS.ITEM(0)%>"
                        <%if TRIM(rs2("AR_CLINEA")) = TRIM(rs.fields.item(0)) then%> selected <%end if%>>
                        <%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                        <%RS.MOVENEXT %>
                    <%LOOP%>
                    <%rs.close%>
                </select> 
          </td>
          
      <td align="left" class="Estilo55" width="150px" > Grupo :</td>
          <td width="300px" > 
           <%tt1 = "RSFACCAR..AL"+cia+"tabl"
            cad =   " Select tg_cclave, tg_cdescri From "&tt1&" Where TG_CCOD='06' Order by TG_CCLAVE    " 
            RS.OPEN CAD, CNN     
           ' response.write(cad)          
          '  response.end
            IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
                <select  class="INPUTS" id="gru" name="gru" >
                    <option value=""></option>
                    <%DO WHILE NOT RS.EOF %>
                        <option value="<%=RS.FIELDS.ITEM(0)%>"
                        <%if TRIM(rs2("AR_CGRUPO")) = TRIM(rs.fields.item(0)) then%> selected <%end if%>>
                        <%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                        <%RS.MOVENEXT %>
                    <%LOOP%>
                    <%rs.close%>
                </select> 
          </td>
  </tr>
  <tr>
      <td align="left" class="Estilo55" width="150px" > Marca :</td>
          <td width="300px" > 
           <%tt1 = "RSFACCAR..AL"+cia+"tabl"
            cad =   " Select tg_cclave, tg_cdescri From "&tt1&" Where TG_CCOD='V7' Order by TG_CCLAVE    " 
            RS.OPEN CAD, CNN     
           ' response.write(cad)          
          '  response.end
            IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
                <select  class="INPUTS" id="mar" name="mar" >
                    <option value=""></option>
                    <%DO WHILE NOT RS.EOF %>
                        <option value="<%=RS.FIELDS.ITEM(0)%>"
                        <%if TRIM(rs2("AR_CMARCA")) = TRIM(rs.fields.item(0)) then%> selected <%end if%>
                        ><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                        <%RS.MOVENEXT %>
                    <%LOOP%>
                    <%rs.close%>
                </select> 
          </td>
          <td align="left" class="Estilo55" width="150px" > Modelo :</td>
          <td width="300px" > 
           <%tt1 = "RSFACCAR..AL"+cia+"tabl"
            cad =   " Select tg_cclave, tg_cdescri From "&tt1&" Where TG_CCOD='39' Order by TG_CCLAVE    " 
            RS.OPEN CAD, CNN     
           ' response.write(cad)          
          '  response.end
            IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
                <select  class="INPUTS" id="mdl" name="mdl" >
                    <option value=""></option>
                    <%DO WHILE NOT RS.EOF %>
                        <option value="<%=RS.FIELDS.ITEM(0)%>"
                        <%if TRIM(rs2("AR_CMODELO")) = TRIM(rs.fields.item(0)) then%> selected <%end if%>
                        ><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                        <%RS.MOVENEXT %>
                    <%LOOP%>
                    <%rs.close%>
                </select> 
          </td>
  </tr>
  <tr>
 <td align="left" class="Estilo55" width="150px" > Familia :</td>
          <td width="300px" > 
           <%tt1 = "RSFACCAR..AL"+cia+"tabl"
            cad =   " Select tg_cclave, tg_cdescri From "&tt1&" Where TG_CCOD='38' Order by TG_CCLAVE    " 
            RS.OPEN CAD, CNN     
           ' response.write(cad)          
          '  response.end
            IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
                <select  class="INPUTS" id="fam" name="fam" >
                    <option value=""></option>
                    <%DO WHILE NOT RS.EOF %>
                        <option value="<%=RS.FIELDS.ITEM(0)%>"
                         <%if TRIM(rs2("AR_CFAMILI")) = TRIM(rs.fields.item(0)) then%> selected <%end if%>
                        ><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                        <%RS.MOVENEXT %>
                    <%LOOP%>
                    <%rs.close%>
                </select> 
          </td> 
  
  <td align="left" class="Estilo55" width="150px" > Lugar Origen :</td>
          <td width="300px" > 
           <%tt1 = "RSFACCAR..AL"+cia+"tabl"
            cad =   " Select tg_cclave, tg_cdescri From "&tt1&" Where TG_CCOD='02' Order by TG_CCLAVE    " 
            RS.OPEN CAD, CNN     
           ' response.write(cad)          
          '  response.end
            IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
                <select  class="INPUTS" id="ori" name="ori" >
                    <option value=""></option>
                    <%DO WHILE NOT RS.EOF %>
                        <option value="<%=RS.FIELDS.ITEM(0)%>"
                         <%if TRIM(rs2("AR_CLUGORI")) = TRIM(rs.fields.item(0)) then%> selected <%end if%>
                        ><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                        <%RS.MOVENEXT %>
                    <%LOOP%>
                    <%rs.close%>
                </select> 
          </td>
  </tr>
  <tr>
    <td align="left" class="Estilo55" width="150px" > Tipo Sunat :</td>
          <td width="300px" > 
           <%tt1 = "RSFACCAR..AL"+cia+"tabl"
            cad =   " Select tg_cclave, tg_cdescri From "&tt1&" Where TG_CCOD='t1' Order by TG_CCLAVE    " 
            RS.OPEN CAD, CNN     
           ' response.write(cad)          
          '  response.end
            IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
                <select  class="INPUTS" id="sun" name="sun" >
                    <option value=""></option>
                    <%DO WHILE NOT RS.EOF %>
                        <option value="<%=RS.FIELDS.ITEM(0)%>"
                        <%if TRIM(rs2("AR_CTIPEXI")) = TRIM(rs.fields.item(0)) then%> selected <%end if%>
                        ><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                        <%RS.MOVENEXT %>
                    <%LOOP%>
                    <%rs.close%>
                </select> 
          </td>
          <td align="left" class="Estilo55" width="150px" > A&ntilde;o Fabricacion :</td>
          <td width="300px" > 
           <input type="text" class="INPUTS" id="ano" name="ano" style="text-align:left; width:100%" value="<%=rs2("AR_CANOFAB")%>"/>
          </td>
  </tr>
</table>
</td></tr>
<!--------------------------------------------------------------------->
<tr><td>
<table  border="0" cellspacing="2" cellpadding="0" align="center" width="100%" >
    <tr width="100%"><td class="Estilo3">Flags Generales :</td></tr>
</table>
<table  border="0" cellspacing="0" cellpadding="0" align="left" class="Estilo55">
     <tr>
        <td align="left">Sin costeo :</td><td><input type="checkbox" id="sct" name="sct" <%if trim(rs2("AR_CTIPOI"))= "N" then %>checked<%end if%>></td>
        <td align="left">Decimal :</td><td><input type="checkbox" id="dcm" name="dcm" <%if rs2("AR_CFDECI")= "S" then %>checked<%end if%>></td>
        <td align="left">Serie :</td><td><input type="checkbox" id="sre" name="sre" onChange="habilita()" <%if rs2("AR_CFSERIE")= "S" then %>checked<%end if%>></td>
        <td align="left" style="display:none" id="lon" name="lon"> longitud :</td>
        <td width="20px" ><input type="text" id="lng" name="lng" style="display:none" class="INPUTS" value="<%=rs2("AR_NLONSER") %>" maxlength="2"></td>
        <td align="left">Lote :</td><td><input type="checkbox" id="lte" name="lte" <%if rs2("AR_CFLOTE")= "S" then %>checked<%end if%>></td>
        <td align="left">Control Stock :</td><td><input type="checkbox" id="cst" name="cst" <%if rs2("AR_CFSTOCK")= "S" then %>checked<%end if%>></td>
        <td align="left">Precio Libre Vta :</td><td><input type="checkbox" id="plv" name="plv" <%if rs2("AR_CFPRELI")= "S" then %>checked<%end if%>></td>
        <td align="left">Dcto Importe :</td><td><input type="checkbox" id="dci" name="dci" <%if rs2("AR_CFRESTA")= "S" then %>checked<%end if%>></td>
        <td align="left">Recargo Consumo :</td><td><input type="checkbox" id="are" name="are" onChange="reca()" <%if rs2("AR_CFLGRCN")= "S" then %>checked<%end if%>></td>
        <td align="left" style="display:none" id="rcc" name="rcc">% Recargo:</td><td width="20px"><input type="text" id="rec" name="rec" style="display:none" class="INPUTS"  maxlenght="2" value="<%=RS2("AR_NTASRCN") %>"></td>
       
        
        <td align="left" class="Estilo55" >Estado :</td>
        <td width="100px"> 
           <%tt1 = "RSFACCAR..AL"+cia+"tabl"
            cad =   " Select tg_cclave, tg_cdescri From "&tt1&" Where TG_CCOD='15' Order by TG_CCLAVE    " 
            RS.OPEN CAD, CNN     
           ' response.write(cad)          
          '  response.end
            IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
                <select  class="INPUTS" id="edo" name="edo" >
                    <option value=""></option>
                    <%DO WHILE NOT RS.EOF %>
                        <option value="<%=RS.FIELDS.ITEM(0)%>"
                        <%if TRIM(rs2("AR_CESTADO")) = TRIM(rs.fields.item(0)) then%> selected <%end if%>
                        ><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                        <%RS.MOVENEXT %>
                    <%LOOP%>
                    <%rs.close%>
                </select> 
          </td>
         
</tr>
</table>
</td></tr>
<!--------------------------------------------------------------------->
<tr><td>
<table  border="0" cellspacing="2" cellpadding="0" align="center" width="100%" >
    <tr width="100%"><td class="Estilo3">Datos de Compras:</td></tr>
</table>
</td></tr>
<!--------------------------------------------------------------------->
<tr><td>

<table  border="0" cellspacing="0" cellpadding="0" align="center" width="100%" class="Estilo55" >
<tr>
  <td align="left" class="Estilo55" width="150px" >Proveedor :</td>
      <td width="200px" class="Estilo55"><input type="text" class="bakes" id="ruc" name="ruc" style="text-align:center;" 
      onChange="bakeprv()" ondblclick="buscapr()" value="<%=rs2("AR_CCODPRO") %>" /></td>
      <%pr = rs2("AR_CCODPRO") 
      cad = "Select AC_CNOMBRE From RSCONCAR..CP0001MAES Where AC_CVANEXO='P' AND AC_CCODIGO='"&pr&"'"
      rs.open cad, cnn 
      if rs.recordcount >0 then pr = rs.fields.item(0) else pr = "" %>
      <td><input type="text" class="INPUTS" id="pr" name="pr" style="text-align:left" value="<%=pr%>"/></td>
      <%rs.close %>
    </tr>
</table>
</td></tr>
<!--------------------------------------------------------------------->
<tr><td>
<table  border="0" cellspacing="0" cellpadding="0" align="center"  width="100%" class="Estilo55">
    <tr>
        <td align="left" class="Estilo55" width="150px"> Moneda Compra:&nbsp;</td>
        <td width="200px">
        <%tt1 = "RSFACCAR..AL"+cia+"tabl"
        cad =   " Select tg_cclave, tg_cdescri From "&tt1&" Where TG_CCOD='03' Order by TG_CCLAVE    " 
        RS.OPEN CAD, CNN     
       ' response.write(cad)          
      '  response.end
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
            <select  class="INPUTS" id="mnc" name="mnc"  value="" >
                <option value=""></option>
                <%DO WHILE NOT RS.EOF %>
                    <option value="<%=RS.FIELDS.ITEM(0)%>"
                    <%if TRIM(rs2("AR_CMONCOM")) = TRIM(rs.fields.item(0)) then%> selected <%end if%>
                    ><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                    <%RS.MOVENEXT %>
                <%LOOP%>
                <%rs.close%>
            </select> 
        </td>
         <td align="left" class="Estilo55" > % IGV :</td>
         <td width="60px" ><input type="text" class="INPUTS" id="igv" name="igv" style="text-align:left; width:100%" value="<%=RS2("AR_NIGVCPR") %>"/></td>
         <td align="left" class="Estilo55"  > Precio Compra :</td>
         <td width="100px" ><input type="text" class="INPUTS" id="cmp" name="cmp" style="text-align:left; width:100%" value="<%=RS2("AR_NPRECOM")%>"/></td>
          <td align="left" class="Estilo55" > Fecha : <A href="javascript:showCal('Calendar1')"><img height="16" src="images/cal.gif" width="16" border="0"></A></td>
        <td width="100px"><input type="text" class="INPUTS" id="fec" name="fec" style="text-align:center" readonly tabindex="-1" value="<%=RS2("AR_DFECCOM")%>"/>
        
         <td align="left" class="Estilo55" width="100px"> Cat Arancel:&nbsp;</td>
        <td>
        <%tt1 = "RSFACCAR..AL"+cia+"tabl"
        cad =   " Select tg_cclave, tg_cdescri From "&tt1&" Where TG_CCOD='V6' Order by TG_CCLAVE    " 
        RS.OPEN CAD, CNN     
       ' response.write(cad)          
      '  response.end
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
            <select  class="INPUTS" id="cat" name="cat"  value="" >
                <option value=""></option>
                <%DO WHILE NOT RS.EOF %>
                    <option value="<%=RS.FIELDS.ITEM(0)%>"
                    <%if TRIM(rs2("AR_CCATEGO")) = TRIM(rs.fields.item(0)) then%> selected <%end if%>
                    ><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                    <%RS.MOVENEXT %>
                <%LOOP%>
                <%rs.close%>
            </select> 
        </td>
    </tr>

     <tr>
     
     <td align="left" class="Estilo55"> Moneda FOB:&nbsp;</td>
        <td>
        <%tt1 = "RSFACCAR..AL"+cia+"tabl"
        cad =   " Select tg_cclave, tg_cdescri From "&tt1&" Where TG_CCOD='03' Order by TG_CCLAVE" 
        RS.OPEN CAD, CNN     
       ' response.write(cad)          
       ' response.end
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST%>
            <select  class="INPUTS" id="mnf" name="mnf" >
                <option value=""></option>
                <%DO WHILE NOT RS.EOF%>
                    <option value="<%=RS.FIELDS.ITEM(0)%>"
                     <%if TRIM(rs2("AR_CMONFOB")) = TRIM(rs.fields.item(0)) then%> selected <%end if%>
                    ><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                    <%RS.MOVENEXT%>
                <%LOOP%>
                <%rs.close%>
            </select> 
        </td>
         <td align="left" class="Estilo55" > Precio FOB :</td>
         <td width="100px"><input type="text" class="INPUTS" id="fob" name="fob" style="text-align:left" value="<%=RS2("AR_NPREFOB") %>"/></td>
         <td align="left" class="Estilo55"> Moneda Costo:&nbsp;</td>
        <td>
        <%tt1 = "RSFACCAR..AL"+cia+"tabl"
        cad =   " Select tg_cclave, tg_cdescri From "&tt1&" Where TG_CCOD='03' Order by TG_CCLAVE    " 
        RS.OPEN CAD, CNN     
       ' response.write(cad)          
      '  response.end
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
            <select  class="INPUTS" id="mnk" name="mnk"  value="" >
                <option value=""></option>
                <%DO WHILE NOT RS.EOF %>
                    <option value="<%=RS.FIELDS.ITEM(0)%>"
                    <%if TRIM(rs2("AR_CMONCOS")) = TRIM(rs.fields.item(0)) then%> selected <%end if%>
                    ><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                    <%RS.MOVENEXT %>
                <%LOOP%>
                <%rs.close%>
            </select> 
        </td>
         <td align="left" class="Estilo55" > Precio Costo :</td>
         <td width="100px" ><input type="text" class="INPUTS" id="cto" name="cto" style="text-align:left; width:100%" value="<%=RS2("AR_NPRECOS") %>"/></td>
         <td align="left" class="Estilo55" >Partida :</td>
         <td width="80px" ><input type="text" class="INPUTS" id="par" name="par" style="text-align:left; width:100%" maxlenght="15" value="<%=RS2("AR_CPARARA") %>"/></td>
</tr>
</table>
</td></tr>

<!--------------------------------------------------------------------->
<tr><td>
    
    <table  border="0" cellspacing="2" cellpadding="0" align="center" width="100%" >
        <tr width="100%"><td class="Estilo3">Datos de Ventas:</td></tr>
    </table>
</td></tr>
<!--------------------------------------------------------------------->
<tr><td>

    <table  border="0" cellspacing="0" cellpadding="0" align="center" width="100%" class="Estilo55" >
    <tr>
       <td align="left" class="Estilo55" width="150px"> Moneda Venta:&nbsp;</td>
        <td width="200px">
        <%tt1 = "RSFACCAR..AL"+cia+"tabl"
        cad =   " Select tg_cclave, tg_cdescri From "&tt1&" Where TG_CCOD='03' Order by TG_CCLAVE    " 
        RS.OPEN CAD, CNN     
       ' response.write(cad)          
      '  response.end
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
            <select  class="INPUTS" id="mnv" name="mnv" >
                <option value=""></option>
                <%DO WHILE NOT RS.EOF %>
                    <option value="<%=RS.FIELDS.ITEM(0)%>"
                    <%if TRIM(rs2("AR_CMONVTA")) = TRIM(rs.fields.item(0)) then%> selected <%end if%>
                    ><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                    <%RS.MOVENEXT %>
                <%LOOP%>
                <%rs.close%>
            </select> 
        </td>
             <td align="left" class="Estilo55" > % IGV :</td>
             <td width="60px" ><input type="text" class="INPUTS" id="pig" name="pig" style="text-align:left; width:100%" value="<%=RS2("AR_NIGVPOR") %>"/></td>
             <td align="left" class="Estilo55" > % ISC :</td>
             <td width="60px" ><input type="text" class="INPUTS" id="pis" name="pis" style="text-align:left; width:100%" value="<%=RS2("AR_NISCPOR")%>"/></td>
             <td align="left" class="Estilo55" > % Detraccion :</td>
	         <td width="60px" ><input type="text" class="INPUTS" id="ped" name="ped" style="text-align:left; width:100%" value="<%=RS2("AR_NDETRA")%>"/></td>
         	 <td align="left" class="Estilo55" > % Percep1 :</td>
         	 <td width="60px" ><input type="text" class="INPUTS" id="pp1" name="pp1" style="text-align:left; width:100%" value="<%=RS2("AR_NPERC1")%>"/></td>
         	 <td align="left" class="Estilo55" > % Percep2 :</td>
         	 <td width="60px" ><input type="text" class="INPUTS" id="pp2" name="pp2" style="text-align:left; width:100%" value="<%=RS2("AR_NPERC2")%>"/></td>
        </tr>
        <tr>
             <td align="left" class="Estilo55" > Precio Publico :</td>
             <td width="60px" ><input type="text" class="INPUTS" id="pr1" name="pr1" style="text-align:left; width:100%" value="<%=RS2("AR_NPRECI1")%>"/></td>
             <td align="left" class="Estilo55" > Precio Dist :</td>
             <td width="60px" ><input type="text" class="INPUTS" id="pr2" name="pr2" style="text-align:left; width:100%" value="<%=RS2("AR_NPRECI2")%>"/></td>
             <td align="left" class="Estilo55" > Precio 3 :</td>
	         <td width="60px" ><input type="text" class="INPUTS" id="pr3" name="pr3" style="text-align:left; width:100%" value="<%=RS2("AR_NPRECI3")%>"/></td>
         	 <td align="left" class="Estilo55" >Precio 4 :</td>
         	 <td width="60px" ><input type="text" class="INPUTS" id="pr4" name="pr4" style="text-align:left; width:100%" value="<%=RS2("AR_NPRECI4")%>"/></td>
         	 <td align="left" class="Estilo55" > Precio 5 :</td>
         	 <td width="60px" ><input type="text" class="INPUTS" id="pr5" name="pr5" style="text-align:left; width:100%" value="<%=RS2("AR_NPRECI5")%>"/></td>
         	 <td align="left" class="Estilo55" > Precio 6 :</td>
         	 <td width="60px" ><input type="text" class="INPUTS" id="pr6" name="pr6" style="text-align:left; width:100%" value="<%=RS2("AR_NPRECI6")%>"/></td>             
        </tr>
                <tr>
             <td align="left" class="Estilo55" > % Comision :</td>
             <td width="60px" ><input type="text" class="INPUTS" id="pcm" name="pcm" style="text-align:left; width:100%" value="<%=RS2("AR_NPCOM")%>" maxlength="2"/></td>
             <td align="left" class="Estilo55" > % Distrib :</td>
             <td width="60px" ><input type="text" class="INPUTS" id="pds" name="pds" style="text-align:left; width:100%" value="<%=RS2("AR_NPDIS")%>" maxlength="2"/></td>
             <td align="left" class="Estilo55" > % Descuento :</td>
	         <td width="60px" ><input type="text" class="INPUTS" id="dct" name="dct" style="text-align:left; width:100%" value="<%=RS2("AR_NDESCTO")%>" maxlength="2"/></td>
         	 <td align="left" class="Estilo55" >Tipo Dcto :</td>
         	 <td width="60px" ><%tt1 = "RSFACCAR..AL"+cia+"tabl"
        cad =   " Select tg_cclave, tg_cdescri From "&tt1&" Where TG_CCOD='46' Order by TG_CCLAVE    " 
        RS.OPEN CAD, CNN     
       ' response.write(cad)          
      '  response.end
        IF RS.RECORDCOUNT > 0 THEN RS.MOVEFIRST %>
            <select  class="INPUTS" id="tdc" name="tdc" >
                <option value=""></option>
                <%DO WHILE NOT RS.EOF %>
                    <option value="<%=RS.FIELDS.ITEM(0)%>"
                     <%if TRIM(rs2("AR_CTIPDES")) = TRIM(rs.fields.item(0)) then%> selected <%end if%>
                    ><%=RS.FIELDS.ITEM(0)%>&nbsp;-&nbsp;<%=RS.FIELDS.ITEM(1)%></option>
                    <%RS.MOVENEXT %>
                <%LOOP%>
                <%rs.close%>
            </select> </td>
         	 <td align="left" class="Estilo55" > Margen Precio Venta:</td>
         	 <td width="60px" ><input type="text" class="INPUTS" id="mrg" name="mrg" style="text-align:left; width:100%" value="<%=RS2("AR_NMARVTA")%>" maxlength="2"/></td>
         	 <td align="left" class="Estilo55" colspan="2"	> </td>             
        </tr>
    </table>
    
 </td></tr>

 
<!--------------------------------------------------------------------->
<tr><td  class="Estilo55" height="10px"></td> </tr>
<tr><td class="Estilo55">
     <table  border="0" cellspacing="0" cellpadding="0" align="center" class="Estilo55" >
        
        <tr align="center">
        <td><input type="button" value="GRABA" id="ok" name="ok" onClick="envia(1)" /></td>
        <td width="50px"></td>
        <td><input type="button" value="RESET" id="no" name="no" onClick="envia(0)" /></td>
    </tr>
    </table>
</td></tr>
<tr><td  class="Estilo55" height="10px"></td> </tr>
</table>
<!--------------------------------------------------------------------->
<iframe  width="100%" style="display:block; width:100%;" src="blanco.htm" id="body0" name="body0" scrolling="yes" frameborder="0" ></iframe>

</form>
</body>


<script language="jscript" type="text/jscript">
   addCalendar("Calendar1", "Elija una fecha", "fec", "thisForm")
    habilita()
    reca()
   

function buscapr() {

    window.open('HELP/busca_prov_oc.ASP?NOM=' + ltrim(document.all.pr.value) + '&ruc=' + trim(document.all.ruc.value))
    return true;
}


function habilita() {
    if (document.all.sre.checked == true) {
        document.all.lng.style.display = 'block'
        document.all.lon.style.display = 'block'
    }
    else {
        document.all.lng.style.display = 'none'
        document.all.lon.style.display = 'none'
    }

}
function reca() {
    if (document.all.are.checked == true) {
        document.all.rcc.style.display = 'block'
        document.all.rec.style.display = 'block'
    }
    else {
        document.all.rcc.style.display = 'none'
        document.all.rec.style.display = 'none'
    }
}

function unir() {
    if (document.all.unr.checked == true) {
        document.all.un2.style.display = 'block'
        document.all.fac.style.display = 'block'
        document.all.fc1.style.display = 'block'
    }
    else {
        document.all.un2.style.display = 'none'
        document.all.fac.style.display = 'none'
        document.all.fc1.style.display = 'none'
    }

}
function BAKE() {
  //document.all.body0.style.display = 'block'
    CAD = ltrim(document.all.cart.value) 
    document.all.body0.src = "bake/bake_articulo.asp?pos=" + CAD;    
    return true;
}
function bakeprv() {
    //document.all.body0.style.display = 'block'
    CAD = ltrim(document.all.ruc.value)
    document.all.body0.src = "bake/jala_ruc.asp?ruc=" + CAD;
    return true;
}

function hlpART() {
    window.open('HELP/busca_ARTICULOS.ASP?NOM=' + ltrim(document.all.dart.value) + '&cod=' + trim(document.all.cart.value))
    return true;
}

function envia(op) {

    if (op == '0') {
        window.location.replace('articulos.asp?cod=')
        return false;
    }
    //  cad += '&dart=' + document.all.cli.options(document.all.cli.selectedIndex).text
    if (document.all.sct.checked == true) { document.all.sct.value = 'N' } else { document.all.sct.value = 'S' }
    if (document.all.dcm.checked == true) { document.all.dcm.value = 'S' } else { document.all.dcm.value = 'N' }
    if (document.all.sre.checked == true) { document.all.sre.value = 'S' } else { document.all.sre.value = 'N' }
    if (document.all.lte.checked == true) { document.all.lte.value = 'S' } else { document.all.lte.value = 'N' }
    if (document.all.cst.checked == true) { document.all.cst.value = 'S' } else { document.all.cst.value = 'N' }
    if (document.all.plv.checked == true) { document.all.plv.value = 'S' } else { document.all.plv.value = 'N' }
    if (document.all.dci.checked == true) { document.all.dci.value = 'S' } else { document.all.dci.value = 'N' }
    if (document.all.are.checked == true) { document.all.are.value = 'S' } else { document.all.are.value = 'N' }
   //alert(document.all.sct.value)
    cad = 'comun/modi_articulos.asp'
    cad += '?cart=' + trim(document.all.cart.value)
    cad += '&dart=' + ltrim(document.all.dart.value)
    cad += '&cart2=' + trim(document.all.cart2.value)
    cad += '&dart2=' + ltrim(document.all.dart2.value)
    cad += '&uni=' + trim(document.all.uni.value)
    cad += '&cta=' + ltrim(document.all.cta.value)
    cad += '&tip=' + ltrim(document.all.tip.value)
    cad += '&lin=' + ltrim(document.all.lin.value)
    cad += '&gru=' + ltrim(document.all.gru.value)
    cad += '&mar=' + ltrim(document.all.mar.value)
    cad += '&mdl=' + ltrim(document.all.mdl.value)
    cad += '&fam=' + ltrim(document.all.fam.value)
    cad += '&ori=' + ltrim(document.all.ori.value)
    cad += '&sun=' + ltrim(document.all.sun.value)
    cad += '&ano=' + ltrim(document.all.ano.value)
    cad += '&sct=' + trim(document.all.sct.value)
    cad += '&dcm=' + trim(document.all.dcm.value)
    cad += '&sre=' + trim(document.all.sre.value)
    cad += '&lng=' + trim(document.all.lng.value)
    cad += '&lte=' + trim(document.all.lte.value)
    cad += '&cst=' + trim(document.all.cst.value)
    cad += '&plv=' + trim(document.all.plv.value)
    cad += '&dci=' + trim(document.all.dci.value)
    cad += '&are=' + ltrim(document.all.are.value)
    cad += '&rec=' + ltrim(document.all.rec.value)
    cad += '&edo=' + ltrim(document.all.edo.value)
    cad += '&ruc=' + ltrim(document.all.ruc.value)
    cad += '&mnc=' + ltrim(document.all.mnc.value)
    cad += '&igv=' + ltrim(document.all.igv.value)
    cad += '&cmp=' + ltrim(document.all.cmp.value)
    cad += '&fec=' + ltrim(document.all.fec.value)
    cad += '&cat=' + ltrim(document.all.cat.value)
    cad += '&mnf=' + ltrim(document.all.mnf.value)
    cad += '&fob=' + ltrim(document.all.fob.value)
    cad += '&mnk=' + ltrim(document.all.mnk.value)
    cad += '&cto=' + ltrim(document.all.cto.value)
    cad += '&par=' + ltrim(document.all.par.value)
    cad += '&mnv=' + ltrim(document.all.mnv.value)
    cad += '&pig=' + ltrim(document.all.pig.value)
    cad += '&pis=' + ltrim(document.all.pis.value)
    cad += '&ped=' + ltrim(document.all.ped.value)
    cad += '&pp1=' + ltrim(document.all.pp1.value)
    cad += '&pp2=' + ltrim(document.all.pp2.value)
    cad += '&pr1=' + ltrim(document.all.pr1.value)
    cad += '&pr2=' + ltrim(document.all.pr2.value)
    cad += '&pr3=' + ltrim(document.all.pr3.value)
    cad += '&pr4=' + ltrim(document.all.pr4.value)
    cad += '&pr5=' + ltrim(document.all.pr5.value)
    cad += '&pr6=' + ltrim(document.all.pr6.value)
    cad += '&pds=' + ltrim(document.all.pds.value)
    cad += '&pcm=' + ltrim(document.all.pcm.value)
    cad += '&dct=' + ltrim(document.all.dct.value)
    cad += '&tdc=' + ltrim(document.all.tdc.value)
    cad += '&mrg=' + ltrim(document.all.mrg.value)


    document.all.body0.style.display = 'none'

    //alert(trim(document.all.cart.value))
    document.all.body0.src = cad
    return true
}
</script>

</html>