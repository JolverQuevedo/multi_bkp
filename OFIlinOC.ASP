<%@ Language=VBScript%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>
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
<%	oc = Request.QueryString("Oc")
    LIN = Request.QueryString("LIN")
    if trim(oc)= "" then oc = "AUTO"
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
    ' NOMBRE DEL CLIENTE
   
    cad = " EXEC OC_LIN_OFI '"&OC&"', '"&LIN&"' "  
    TBL1 = "RSFACCAR.dbo.CO"+CIA+"MOVD"
    cad = " SELECT ISNULL(vd.SUB_IT,'01') AS SUB_IT, ISNULL(vd.OFI,'OLD_REAL') AS OFI,      " & _
	      " ISNULL(vd.CANTIDAD,oc_ncanord) AS CAN,                                          " & _
	      " ISNULL(vo.NOM,'ANTIGUOS') AS NOM, vd.OC_CNUMORD, vd.OC_CITEM                    " & _
          " from ((SELECT DISTINCT                                                          " & _        
          " MOV.OC_CNUMORD, MOV.OC_CITEM, OCD.NUMORD, OCD.ITEM, OCD.SUB_IT, OCD.OFI,        " & _
          " OCD.CODIGO, OCD.CANTIDAD, OCD.USUARIO, OCD.FECHA, OCD.ESTADO, MOV.OC_CCODPRO,   " & _
          " MOV.OC_CCODIGO, MOV.OC_CCODREF, MOV.OC_CDESREF, MOV.OC_CUNIPRO, MOV.OC_CDEUNPR, " & _
          " MOV.OC_CUNIDAD, MOV.OC_NCANORD, MOV.OC_NPREUNI, MOV.OC_NPREUN2, MOV.OC_NDSCPFI, " & _
          " MOV.OC_NDESCFI, MOV.OC_NDSCPIT, MOV.OC_NDESCIT, MOV.OC_NDSCPAD, MOV.OC_NDESCAD, " & _
          " MOV.OC_NDSCPOR, MOV.OC_NDESCTO, MOV.OC_NIGV, MOV.OC_NIGVPOR, MOV.OC_NISC,       " & _
          " MOV.OC_NISCPOR, MOV.OC_NCANTEN, MOV.OC_NCANSAL, MOV.OC_NTOTUS, MOV.OC_NTOTMN,   " & _
          " MOV.OC_COMENTA, MOV.OC_CESTADO, MOV.OC_FUNICOM, MOV.OC_NCANREF, MOV.OC_CSERIE,  " & _
          " MOV.OC_NANCHO, MOV.OC_NCORTE, MOV.OC_DFECDOC, MOV.OC_CTIPORD, MOV.OC_CCENCOS,   " & _
          " MOV.OC_CNUMREQ, MOV.OC_CSOLICI, MOV.OC_CITEREQ, MOV.OC_CREFCOD, MOV.OC_CPEDINT, " & _
          " MOV.OC_CITEINT, MOV.OC_CREFCOM, MOV.OC_CNOMFAB, MOV.OC_NCANEMB, MOV.OC_DFECENT, " & _
          " MOV.OC_CITMPOR, MOV.OC_CDSCPOR, MOV.OC_CIGVPOR, MOV.OC_CISCPOR, MOV.OC_NTOTMO,  " & _
          " MOV.OC_NUNXENV, MOV.OC_NNUMENV, MOV.OC_NCANFAC FROM  modelador.dbo.ORDENCOMPRA  " & _
          " AS OCD RIGHT OUTER JOIN "&TBL1&" AS MOV ON OCD.ITEM                             " & _
          " COLLATE Modern_Spanish_CI_AS = MOV.OC_CITEM AND                                 " & _
          " OCD.NUMORD COLLATE Modern_Spanish_CI_AI = MOV.OC_CNUMORD ) VD                   " & _
          " left outer join MODELADOR..view_ofis vo on vo.ofi = vd.ofi                      " & _
          " ) WHERE vd.OC_CNUMORD = '"&OC&"' AND vd.OC_CITEM ='"&LIN&"'                     " & _
          "   ORDER BY vd.SUB_IT                                                            " 

	 '  response.Write(cAD)
	rs.open cad, cnn
	IF RS.RecordCount > 0 THEN
		RS.MOVEFIRST
    else
        oc =   request.QueryString("oc") 
        lin =  request.QueryString("lin")  
        ofi =  ""       
        IF  LEN(TRIM(request.QueryString("can"))) = 0 THEN CAN= 0 ELSE can =  request.QueryString("can") 
        CAD = "SELECT '01' AS SUB_IT, '' AS OFI, 0 AS CAN, '' AS NOM, '"&OC&"' AS OC_CNUMORD, '"&LIN&"' AS OC_CITEM " 
        RS.CLOSE
        RS.OPEN CAD, CNN
        RS.MOVEFIRST
	END IF
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title>FICHA O/C</title>
</head>
<body style="margin-left:0px; margin-top:0px; margin-right:0px;">
<form id="thisForm" method="post" name="thisForm" action="">

<table border="0" cellpadding="0" cellspacing="0" width="100%" >
	<tr valign="center" > 
		  <td width="20%"><img src="images/OK.PNG" style="cursor:pointer;" onClick="graba()" /></td>	
          
          <td align = "center" class="TALASBLUE" width="60%">
            <table cellpadding="22" cellspacing="0" border="0" align="center" width="100%" bordercolorlight="#f7d975">
		        <tr><td align="center" class="estilo2">DETALLE OFIS</td></tr>
		    </table> 
         </td>
         <td id="grab" align="center" width="10%">&nbsp;    
	     </td>
         <td  width="20%" align="right"><img src="images/close.png" border="0"  alt="" id="GRABA" style="cursor:pointer"  onClick="top.window.close()"  /></td>
    </tr>
</table>  

<table align="center" bordercolor="<%=application("color1")%>" bgcolor="<%=application("color2")%>" cellpadding="1" style="border-style:hidden; width:100%" cellspacing="1" border="1">
   <tr>
       <td colspan="4"> 
        <table cellpadding="2" cellspacing="0" border="0" bgcolor='#7c9f39' bordercolor='<%=APPLICATION("COLOR2") %>' width="100%">
    <tr align="left" class="MICRO_WHITE" > <td width="10%">Id</td>
    <td width="20%">OFI</td><td width="20%">Cant</td><td width="50%">CLIENTE</td></tr></table>
       </td>
   </tr>
   <%rec=1%>
   <%DO  WHILE NOT RS.EOF %>
        <tr id="LIN<%=rec%>" style="display:block   ">
            <td width="10%">
                <input id="LDET<%=rec%>" name="LDET<%=rec%>" class="MICRO" style="width:100%; text-align:center" readonly tabindex="-1" value='<%=right("00"+ltrim(rtrim(cstr(rec))),2) %>'/>
            </td>
            <td width="20%">
                <input id="OFI<%=rec%>" name="OFI<%=rec%>" class="MICRO" style="width:100%;" value="<%=rs("ofi")%>" onchange="BAKEOFI('<%=rec%>')"/>
            </td>
            <td width="20%">
                <input id="CAN<%=rec%>" name="CAN<%=rec%>" class="MICRO" onchange="suma()" style="width:100%;text-align:right;padding-right:5px;" value="<%=formatnumber(rs("can"),3,,true)%>"/>
            </td>
            <td width="50%">
                <input id="CLI<%=rec%>" name="CLI<%=rec%>" class="MICRO" value="<%=rs("nom") %>" style="width:100%;" readonly tabindex="-1"/>
            </td>
        </tr> 
        <%RS.MOVENEXT%>
        <%rec= rec+1%>
    <%LOOP %>
    <tr id="LIN<%=REC%>" style="display:BLOCK ;">
        <td width="10%"><input id="LDET<%=REC%>" name="LDET<%=REC%>" class="MICRO" style="width:100%;text-align:center" readonly tabindex="-1" value='<%=right("00"+ltrim(rtrim(cstr(REC))),2) %>'/></td>
        <td width="20%"><input id="OFI<%=REC%>" name="OFI<%=REC%>" class="MICRO" onchange="BAKEOFI('<%=rec%>')" style="width:100%;"/></td>
        <td width="20%"><input id="CAN<%=REC%>" name="CAN<%=REC%>" class="MICRO" onchange="suma()" value="0.000" style="width:100%;  text-align:right; padding-right:5px;"/></td>
        <td width="50%"><input id="CLI<%=REC%>" name="CLI<%=REC%>" value='<%=rec%>' class="MICRO" style="width:100%;" readonly tabindex="-1"/></td>
    </tr> 
    <%for i= rec+1 to rec+20%>
    <tr id="LIN<%=i%>" style="display:none    ;">
        <td width="10%"><input id="LDET<%=i%>" name="LDET<%=i%>" class="MICRO" style="width:100%;text-align:center" readonly tabindex="-1" value='<%=right("00"+ltrim(rtrim(cstr(i))),2) %>'/></td>
        <td width="20%"><input id="OFI<%=i%>" name="OFI<%=i%>" class="MICRO"   style="width:100%;" onchange="BAKEOFI('<%=i%>')" /></td>
        <td width="20%"><input id="CAN<%=i%>" name="CAN<%=i%>" class="MICRO" onchange="suma()" value="0.000" style="width:100%; text-align:right; padding-right:5px;" /></td>
        <td width="50%"><input id="CLI<%=i%>" name="CLI<%=i%>" value='<%=i%>' class="MICRO" style="width:100%;" readonly tabindex="-1"/></td>
    </tr> 
    <%next%>
<tr style="background-color:'#7c9f39'">
    <td  width="30%" colspan="2" class="MICRO_WHITE" align="right">CANTIDAD TOTAL : &nbsp;&nbsp;</td>
        
        <td width="20%"><input id="TOTAL" name="TOTAL" class="MICRO" style="width:100%; text-align:right; padding-right:5px;" value="0.000" readonly tabindex="-1" /></td>
        <td width="50%">&nbsp;</td>
    </tr> 
</table> 
<table cellpadding="0" cellspacing="0" border="1" style="border-color:'<%=APPLICATION("COLOR2") %>'; width:100%" align="center" >
  
</table>

<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table width="100%">
  <tr><td style=" height:1px"></td></tr></table>
<iframe  width="300px" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>
<input id="verif" name="verif" value="0" />
<script type="text/jscript" language="jscript">
  suma()
function BAKEOFI(op) {
op = parseInt(op,10)
ofi = strzero(toInt(eval("document.all.OFI"+op+".value")),8)
eval("document.all.OFI"+op+".value=ofi")
cad = 'bake/bakeOCofi.asp?pos=' + ofi +'&op='+ op
/*
document.all.body10.style.display = 'block'
document.all.body10.height = "350"
document.all.body10.width = "100%"
*/
document.all.body10.src = cad
OP = op+1
eval("document.all.LIN" + OP + ".style.display='block'")
}
function suma() 
{   maxi = parseInt('<%=i-1%>',10)

    tot = 0
    for (pi = 1; pi <= maxi; pi++) {
        if (eval("document.all.LIN" + pi + ".style.display") == 'block') {
            tt = parseFloat(toInt(eval("document.all.CAN" + pi + ".value")));

            FF = addCommas(cerea(FormatNumber(toInt(redondea(tt, 3)), 3, false, false, true, true), 3))
            eval("document.all.CAN" + pi + ".value=FF")
            //alert(tt);
            tot += tt;
        }
    }
    dd = addCommas(redondea(tot, 3))
    document.all.TOTAL.value = dd
    kko = trim(top.window.izquierdo.document.all.COD.value)
    ddo = trim(top.window.izquierdo.document.all.DES.value)
    lnn = trim(top.window.izquierdo.document.all.LIN.value)
    top.window.opener.window.updates(dd, kko, ddo, lnn)
    top.window.izquierdo.document.all.PED.value = dd

}

function graba() {
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=no,left=100,top=20,height=600,width=900";
    
    df = top.window.izquierdo.grabar()
    if (df == false)
    { return false; }
    kad  = '&lin=' + trim(top.window.izquierdo.document.all.LIN.value)
    kad += '&DES=' + ltrim(top.window.izquierdo.document.all.DES.value)
    kad += '&cod=' + ltrim(top.window.izquierdo.document.all.COD.value)
    kad += '&COM=' + Left(toAlpha(top.window.izquierdo.document.all.COME.value,250))
    kad += '&UNI=' + trim(top.window.izquierdo.document.all.UNI.value)
    kad += '&PAR=' + trim(top.window.izquierdo.document.all.PAR.value)
    kad += '&ARA=' + trim(top.window.izquierdo.document.all.ARA.value)
    kad += '&ENT=' + trim(top.window.izquierdo.document.all.ENT.value)
    kad += '&PED=' + trim(toInt(top.window.izquierdo.document.all.PED.value))
    kad += '&PRE=' + trim(toInt(top.window.izquierdo.document.all.PRE.value))
    kad += '&sol=' + trim(top.window.izquierdo.document.all.SOLI.value)
    kad += '&cto=' + trim(top.window.izquierdo.document.all.CCTO.value)
    kad += '&FIN=' + trim(toInt(top.window.izquierdo.document.all.FINA.value))
    kad += '&DCT=' + trim(toInt(top.window.izquierdo.document.all.DITE.value))
    kad += '&ADI=' + trim(toInt(top.window.izquierdo.document.all.DADI.value))
    kad += '&IGV=' + trim(toInt(top.window.izquierdo.document.all.IIGV.value))
    kad += '&ISC=' + trim(toInt(top.window.izquierdo.document.all.IISC.value))
    kad += '&ch1=' + trim(top.window.izquierdo.document.all.CHK1.value)
    kad += '&ch2=' + trim(top.window.izquierdo.document.all.CHK2.value)
    kad += '&ch3=' + trim(top.window.izquierdo.document.all.CHK3.value)
    kad += '&ch4=' + trim(top.window.izquierdo.document.all.CHK4.value)
    kad += '&ref=' + trim(top.window.izquierdo.document.all.KOD.value)
    
    var aOfi = new Array()
    var aCan = new Array()
    maxix = parseInt('<%=i-1%>',10)
    bidi = 0
    for (pix = 1; pix < maxix; pix++) 
    {
        if (eval("document.all.LIN" + pix + ".style.display") == 'block' &&  parseFloat(eval("document.all.CAN" + pix + ".value")) > 0 ) 
            {   aCan[bidi] = parseFloat(toInt(eval("document.all.CAN" + pix + ".value")));
                aOfi[bidi++] = trim(eval("document.all.OFI" + pix + ".value"));
            }
    }
    //alert(acan)

    kad += '&acan=' + aCan
    kad += '&aofi=' + aOfi

/*alert(kad)
document.all.body10.style.display = 'block'
document.all.body10.height = "350"
document.all.body10.width = "100%"
*/

cad = 'comun/inserOCLIN.asp?OC=' + trim('<%=trim(oc)%>')
document.all.body10.style.display='block'
document.all.body10.src = cad + kad

 document.all.verif.value = '1'
  thisForm.action = top.window.close()
  thisForm.submit()
 
}

window.onbeforeunload = confirmExit;




function confirmExit() {

    if (document.all.verif.value == '1')
    return window.close()
else
    return "Si sale sin grabar perderá todos los cambios...";
}

</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>