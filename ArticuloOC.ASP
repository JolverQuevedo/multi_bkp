<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>
<head>
<link href="multisty.css" rel="stylesheet" type="text/css">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<script type="text/jscript" language="jscript">
var aCod = Array() 
function calcHeight()
{
  //find the height of the internal page
  var the_height=
    document.getElementById('body0').contentWindow.
      document.body.scrollHeight+25;
  //change the height of the iframe
  document.getElementById('body0').height=
      the_height;
}

</script>
<%	oc =  request.QueryString("oc") 
lin =  request.QueryString("lin") 
cod =  request.QueryString("cod") 
des =  request.QueryString("des") 
uni =  request.QueryString("uni") 
igv =  request.QueryString("igv") 
isc =  request.QueryString("isc") 
IF  LEN(TRIM(request.QueryString("can"))) = 0 THEN CAN= 0 ELSE can =  request.QueryString("can") 
if trim(request.QueryString("pre")) = "" then pre = 0 else pre =  request.QueryString("pre") 
com =  request.QueryString("com") 

   if trim(oc)= "" then oc = "AUTO"
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
    ' NOMBRE DEL CLIENTE
   
 
    tbl1 = "RSFACCAR..CO"+cia+"MOVd"

    cad =   " Select	SS.OC_CITEM AS LIN, SS.OC_CDESREF AS DESCRI, SS.OC_COMENTA AS COME, OC_CUNIDAD AS UNI, " & _
	        " '' AS PAR, '' AS ARAN, ISNULL(ss.oc_ncanord,0)  as PED, ISNULL(ss.oc_npreun2,0) as PRE ,         " & _
	        " SS.OC_Csolici as SOLI, SS.OC_CCENCOS AS CCTO, ISNULL(SS.OC_NDSCPFI,0) AS FINA, OC_CCODREF,       " & _
	        " ISNULL(SS.OC_CIGVPOR,0) AS CH3, ISNULL(SS.OC_CISCPOR,0) AS CH4, ISNULL(SS.OC_CITMPOR,0) AS CH1,  " & _
            " ISNULL(SS.OC_CDSCPOR,0) AS CH2, ISNULL(SS.OC_NIGVPOR,0) AS IIGV, ISNULL(SS.OC_NISCPOR,0) AS IISC," & _
            " ISNULL(SS.OC_NDSCPOR,0) AS DITE, ISNULL(OC_NDSCPAD,0) AS DADI  From "&tbl1&" ss                  " & _
	        " Where ss.OC_CNUMORD='"&oc&"' AND SS.OC_CITEM= '"&lin&"' AND SS.OC_CCODIGO= '"&cod&"'             " 
	'   response.Write(cAD)
	rs.open cad, cnn
	IF RS.RecordCount > 0 THEN 		
        RS.MOVEFIRST
    else
        cad = " SELECT	'' AS LIN, '' AS DESCRI, '' AS COME, '' AS UNI, '' AS PAR, '' AS ARAN, 0 AS PED, 0 AS PRE,  " & _
		      " '' AS SOLI, '' AS CCTO, 0 AS IIGV,	0 AS IISC, 0 AS FINA, 0 AS DITE, 0 AS DADI, 0 AS CH1, 	        " & _
              " 0 AS CH2, 0 AS CH3, 0 AS CH4 , '' as oc_ccodref"
        RS.CLOSE
        RS.OPEN CAD, CNN
        RS.MOVEFIRST    			 
	end if
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<CONTRASTE>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title>FICHA O/C</title>

</CONTRASTE>
<style type="text/css">
    .style1
    {
        width: 36%;
    }
    .style2
    {
        width: 25%;
    }
</style>
    </head>
<body style="margin-left:0px; margin-top:0px; margin-right:0px;" >
<form id="thisForm" method="post" name="thisForm" action="comun/inserFICHAoc.asp">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
    <td width="15%" align="right"><img src="images/CLOSE.PNg" style="cursor:pointer;" onClick="top.window.close()" /></td>	
    <td width="15%" align="right">&nbsp;</td>	
          <td align = "center" class="TALASBLUE" width="60%">   
            <table cellpadding="22" cellspacing="0" border="0" align="center" width="100%" bordercolorlight="#f7d975">
		        <tr><td align="center" class="estilo2">ARTICULO O/C</td></tr>
		    </table> 
    </tr>
</table>  
<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>
<table width="100%" border="1" border="<%=APPLICATION("COLOR2") %>" cellpadding="0" cellspacing="0" >   
	<tr valign="middle"><td bgcolor="#f7d975" style="height:1px;"></td></tr>
</table>
<table cellpadding="5" cellspacing="0" border="0" bgcolor='<%=APPLICATION("ETIQUETA")%>' bordercolor='<%=APPLICATION("COLOR2") %>' width="100%">
    <tr align="left" class="ESTILO4" ><td style="width:100%">DATOS DEL ARTICULO</td></tr></table>
<table border="1" cellpadding="1" width="100%" cellspacing="1" bgcolor="<%=(Application("COLOR1"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
    <tr valign="top">
        <td  class="TITULITOch" width="10%">C&oacute;digo Art&iacute;culo </td>
        <td width="20%" colspan="2"><input type="text" id="COD" name="COD" value="<%=COD%>"  class="BAKES" onChange="BAKECOD('')" onDblClick="helpCOD('')" maxlength="25"/></td>
        <td  class="TITULITOch" width="5%">Num Lin</td>
        <td width="20%"><input type="text" id="LIN" name="LIN" value="<%=LIN%>" style="width:100%; text-align:center" class="DATA"  tabindex="-1" readonly/></td>
  </tr>
   <tr>
    <td  class="TITULITOch">Descripcip&oacute;n</td>
    <td colspan="4"><input type="text" id="DES" name="DES" value="<%=rs("descri")%>" class="estilotextarea4" maxlength= "60" style="width:100%;text-align:left;" /></td>
    </tr>
    <tr>
    <td class="TITULITOch">Cod. REFERENCIA</td>
    <td colspan="2"><input type="text" id="KOD" name="KOD" value="<%=trim(RS("OC_CCODREF"))%>" class="bakes" onchange="BAKECOD('X')" ondblclick="helpCOD('K')" maxlength="25"/></td>
    <%solo = RS("OC_CCODREF")
    tbb =  "RSFACCAR..AL"+CIA+"arti"
    pop = "select AR_CDESCRI from "&tbb&" where ar_ccodigo = '"&solo&"'" 
    rs2.open pop,cnn
    if rs2.recordcount > 0 then 
        rs2.movefirst
        relacion = rs2("ar_cdescri")+ "333"
    else
        relacion = ""
    end if
    rs2.close
    %>
    <td   width="20%" colspan="2">
    <input type="text" id="DKOD" name="DKOD" value="<%=relacion%>"  class="TITULITOch" style="width:100%; text-align:left" tabindex="-1" readonly/></td>      
    </tr>
 
  <tr>
    <td  class="TITULITOch">Comentario </td>
    <td colspan="4"><textarea id="COME" name="COME" class="estilotextarea4"><%=trim(rs("COMe"))%></textarea></td>
  </tr>
  <tr>
    <td  class="TITULITOch">Unidad </td>
    <td WIDTH="10%"><input type="text" id="UNI" name="UNI" value="<%=rs("uni")%>" class="DATA" style="text-align:center" readonly tabindex="-1" /></td>
    <td >&nbsp;</td>
    <td  class="TITULITOch">F. Entrega </td>
    <td WIDTH="10%"><input type="text" id="ENT" name="ENT" value="<%=date()%>" class="INPUTS" style="text-align:center; width:100%"  /></td>
    </tr>
  <tr>
    <td  class="TITULITOch" >Part Arancelaria </td>
    <td><input id="PAR" name="PAR" class="DATA" readonly tabindex="-1" /></td>
        <td colspan="3"><input id="ARA" name="ARA" class="DATA" readonly tabindex="-1" style="width:100%" /></td>
    </tr> 
</table>
<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table border="1" cellpadding="0" width="100%" cellspacing="0" bgcolor="<%=(Application("COLOR1"))%>" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
    <tr valign="middle">
        <td  class="TITULITOch">Cantidad Pedida</td>
        <td  colspan="2" width="30%"><input type="text" id="PED" name="PED" value="<%=formatnumber(rs("ped"),5,,true)%>" class="DATA" style="width:100%; text-align:right; padding-right:5px" maxlength="10" tabindex="-1" readonly/></td>
        <td  class="MICRO" colspan="2" width="50%">&nbsp;</td>
  </tr>
  <tr valign="middle">
        <td  class="TITULITOch" >Precio Original </td>
      <td  colspan="2"><input type="text" id="PRE" name="PRE" value="<%=formatnumber(rs("PRE"),5,,true)%>" class="INPUTS" style="width:100%; text-align:right; padding-right:5px" maxlength="10" onkeyup="this.value=toInt(this.value)" /></td>
        <td  class="MICRO" colspan="2">&nbsp;</td>
</tr>
<tr valign="middle">
  <td  class="TITULITOch" >Solicitante</td>
  <td width="10%" ><input type="text" id="SOLI" name="SOLI" value="<%%>" class="INPUTS" style="width:100%; text-align:left" maxlength="3" value="<%=trim(rs("soli"))%>"/></td>
  <td colspan="3"  >&nbsp;</td>
</tr>
<tr valign="middle">
     <td  class="TITULITOch">C. Costo</td>
     <td colspan="4"><select id="CCTO" name="CCTO" class="DATA">
            <option value =""></option>
            <%TBL4 = "RSFACCAR..AL"+CIA+"TABL"
            CAD = "Select * From "&TBL4&" Where TG_CCOD='10' Order by TG_CCLAVE" 
            RS2.OPEN CAD, CNN
            IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE")%>'><%=RS2("TG_CCLAVE")%>&nbsp;&nbsp;<%=RS2("TG_CDESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP
            RS2.CLOSE%>
        </select>
     </td>
 </tr>
 <tr valign="middle">
  <td  class="TITULITOch" colspan="2">Dsct. Financiero</td>
  <td width="10%" ><input type="text" id="FINA" name="FINA" value="<%=formatnumber(rs("fina"),2,,true)%>" class="INPUTS" style="width:100%; text-align:right; padding-right:5px;"maxlength="3" onkeyup="this.value=toInt(this.value)" /></td>
  <td colspan="2"  class="TITULITOch" style="text-align:left">&nbsp;%</td>
</tr>
<tr valign="middle">
  <td  class="TITULITOch" colspan="1">Dct. Item</td>
  <td  ><input type="checkbox" id="CHK1" name="CHK1" value="0" class="INPUTS" style="width:100%; text-align:center;"/></td>
  <td width="10%" ><input type="text" id="DITE" name="DITE" value="<%=formatnumber(rs("DITE"),2,,true)%>" class="INPUTS" style="width:100%; text-align:right; padding-right:5px;"maxlength="5" onkeyup="this.value=toInt(this.value)" /></td>
  <td colspan="2"  class="MICRO" style="text-align:left">&nbsp;%</td>
</tr>
<tr valign="middle">
  <td  class="TITULITOch" colspan="1">Dct. Adic</td>
  <td  ><input type="checkbox" id="CHK2" name="CHK2" value="0" class="INPUTS" style="width:100%; text-align:center;"/></td>
  <td width="10%" ><input type="text" id="DADI" name="DADI" value="<%=formatnumber(rs("DADI"),2,,true)%>" class="INPUTS" style="width:100%; text-align:right; padding-right:5px;"maxlength="5" onkeyup="this.value=toInt(this.value)" /></td>
  <td colspan="2"  class="MICRO" style="text-align:left">&nbsp;%</td>
</tr>
<tr valign="middle">
  <td  class="TITULITOch" colspan="1">Incluye IGV</td>
  <td  ><input type="checkbox" id="CHK3" name="CHK3" value="0" class="INPUTS" style="width:100%; text-align:center;" onkeyup="this.value=toInt(this.value)" /></td>
  <td width="10%" ><input type="text" id="IIGV" name="IIGV" value="<%=forMATNUMBER(rs("Iigv"),2,,TRUE)%>" class="DATA" style="width:100%; text-align:right; padding-right:5px;" readonly tabindex="-1" /></td>
  <td colspan="2"  class="MICRO" style="text-align:left">&nbsp;%</td>
</tr>
<tr valign="middle">
  <td  class="TITULITOch" colspan="1">Incluye ISC</td>
  <td  ><input type="checkbox" id="CHK4" name="CHK4" value="0" class="INPUTS" style="width:100%; text-align:center;"/></td>
  <td width="10%" ><input type="text" id="IISC" name="IISC" value="<%=forMATNUMBER(rs("IiSC"),2,,TRUE)%>" class="DATA" style="width:100%; text-align:right; padding-right:5px;" readonly tabindex="-1"/></td>
  <td colspan="2"  class="MICRO" style="text-align:left">&nbsp;%</td>
</tr>
</table>
<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table width="100%">
  <tr><td style=" height:1px"></td></tr></table>

<script type="text/jscript" language="jscript">
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=100,top=20,height=600,width=900";


var subcadena = '<%=RS("CCTO")%>';
var elemento = document.all.CCTO;
document.all.CCTO.selectedIndex = seleindice(subcadena, elemento);

function BAKECOD(cop) {
    if (trim(cop) == '')
        cad = 'bake/bakeREALcod.asp?pos=' + trim(thisForm.COD.value) + '&opp=' + cop
    else
        cad = 'bake/bakeREALcod.asp?pos=' + trim(thisForm.KOD.value) + '&opp=' + cop
 
  /*
document.all.body10.style.display = 'block'
document.all.body10.height = "350"
document.all.body10.width = "100%"
*/
document.all.body10.src = cad
//document.all.body10.style.display = 'none'
}

function helpCOD(OP) {
    if (trim(OP) == '')
        cad = 'help/HLPartREAL.asp?pos=' + trim(document.all.COD.value) + '&opp=' + OP
    else
        cad = 'help/HLPartREAL.asp?pos=' + trim(document.all.KOD.value) + '&opp=' + OP

//alert(cad)
window.open(cad,'',opc)
}

function grabar() {
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=no,left=100,top=20,height=600,width=900";
    if (trim(document.all.COD.value) == '') {
        alert("Favor ingresar el codigo del articulo")
        document.all.COD.focus();
        return false;
    }
    if (trim(toInt(document.all.PRE.value)) == '') {
        alert("Favor ingresar el precio del articulo")
        document.all.PRE.focus();
        return false;
    }
    if (parseInt(trim(document.all.PED.value),10)== 0) {
        alert("No ha registrado cantidades para ninguna OFI")
        top.window.derecho.document.all.OFI1.focus();
        return false;
    }
    if (fecha(document.all.ENT.value) == false) {
        alert("Formato de Fecha incorrecto")
        return false;
    }
    return true;
}

</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>