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
<!--#include file="COMUN/COMUNoclin.ASP"-->
<script type="text/jscript" language="jscript">
    var oldrow = 0
    var olddata = ''
    var chk = ''
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
function dd2(ff) {	// LLENA TEXTBOX ADICIONALES AL COMUN
    // LOS DEL COMUN SON CODIGO Y DESCRIPCION
    var t = document.all.TABLA;
    var pos = parseInt(ff);
    dd(ff);
}
</script>
<%	oc = Request.QueryString("Oc")
    if trim(oc)= "" then oc = "AUTO"
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
    ' NOMBRE DEL CLIENTE
   tbl1= " RSFACCAR.dbo.CO"+cia+"MOVD"
      cad = " SELECT oc_citem, isnull(sub_It,'') as sub_it, oc_ccodigo, oc_cdesref, oc_cunidad,                  " & _
            " isnull(ofi,'') as OFI,  replace(oc_ncanord,',','.') as oc_ncanord,                                 " & _
            " replace(isnull(cantidad,0),',','.') as cantidad, replace(oc_npreun2,',','.') as oc_npreun2,        " & _
            " oc_ndscpad, oc_ndscpit, oc_nigvpor, oc_niscpor, replace(oc_npreuni,',','.') as oc_npreuni,         " & _
            " oc_ndescto, oc_nigv, replace((oc_ncanord*oc_npreun2),',','.') as subt,                             " & _
            "  oc_ncanten, oc_ncansal, oc_dfecent, oc_comenta, oc_nisc, oc_csolici,                              " & _
            " oc_citmpor, oc_cdscpor, oc_cigvpor,oc_ciscpor, oc_ccencos,  oc_cestado                             " & _
            " FROM (SELECT DISTINCT                                                                              " & _
            " MOV.OC_CNUMORD, MOV.OC_CITEM, OCD.NUMORD, OCD.ITEM, OCD.SUB_IT, OCD.OFI, OCD.CODIGO, OCD.CANTIDAD, " & _
            " OCD.USUARIO, OCD.FECHA, OCD.ESTADO, MOV.OC_CCODPRO, MOV.OC_CCODIGO, MOV.OC_CCODREF, MOV.OC_CDESREF," & _
            " MOV.OC_CUNIPRO, MOV.OC_CDEUNPR, MOV.OC_CUNIDAD, MOV.OC_NCANORD, MOV.OC_NPREUNI, MOV.OC_NPREUN2,    " & _
            " MOV.OC_NDSCPFI, MOV.OC_NDESCFI, MOV.OC_NDSCPIT, MOV.OC_NDESCIT, MOV.OC_NDSCPAD, MOV.OC_NDESCAD,    " & _
            " MOV.OC_NDSCPOR, MOV.OC_NDESCTO, MOV.OC_NIGV, MOV.OC_NIGVPOR, MOV.OC_NISC, MOV.OC_NISCPOR,          " & _
            " MOV.OC_NCANTEN, MOV.OC_NCANSAL, MOV.OC_NTOTUS, MOV.OC_NTOTMN, MOV.OC_COMENTA, MOV.OC_CESTADO,      " & _
            " MOV.OC_FUNICOM, MOV.OC_NCANREF, MOV.OC_CSERIE, MOV.OC_NANCHO, MOV.OC_NCORTE, MOV.OC_DFECDOC,       " & _
            " MOV.OC_CTIPORD, MOV.OC_CCENCOS, MOV.OC_CNUMREQ, MOV.OC_CSOLICI, MOV.OC_CITEREQ, MOV.OC_CREFCOD,    " & _
            " MOV.OC_CPEDINT, MOV.OC_CITEINT, MOV.OC_CREFCOM, MOV.OC_CNOMFAB, MOV.OC_NCANEMB, MOV.OC_DFECENT,    " & _
            " MOV.OC_CITMPOR, MOV.OC_CDSCPOR, MOV.OC_CIGVPOR, MOV.OC_CISCPOR, MOV.OC_NTOTMO, MOV.OC_NUNXENV,     " & _
            " MOV.OC_NNUMENV, MOV.OC_NCANFAC FROM  modelador.dbo.ORDENCOMPRA AS OCD                              " & _
            " RIGHT OUTER JOIN "&tbl1&" AS MOV ON OCD.ITEM COLLATE Modern_Spanish_CI_AS = MOV.OC_CITEM AND       " & _
            " OCD.NUMORD COLLATE Modern_Spanish_CI_AI = MOV.OC_CNUMORD ) ppp                                     " & _
            " WHERE OC_CNUMORD = '"&oc&"' and (sub_it is null or sub_it = '00')                                  " & _
            " and oc_citem <> ''order by oc_citem, sub_it                                                        "  

'	 response.Write(cAD)
	rs.open cad, cnn
	
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title>FICHA O/C</title>

</head>
<body style="margin-top:0px; margin-left:0px; margin-right:0px;">
<form id="thisForm" method="post" name="thisForm" action="comun/inserFICHAoc.asp">

<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>


<table cellpadding="5" cellspacing="0" border="1" style="background-color:'#7c9f39';border-color:'<%=APPLICATION("COLOR2") %>';"  align="center" id="TABLA">
    <tr align="center" class="micro_white">
        <td>Item</td>
        <td>Id</td>
        <td>C&oacute;digo</td>
        <td>Desripci&oacute;n</td>
        <td>Und</td>
        <td>OFI</td>
        <td>Cant Ord</td>
        <td>Cant OFI</td>
        <td>Pre Orig</td>
        <td>% Dcto Adic</td>
        <td>% Dcto Itm</td>
        <td>%IGV</td>
        <td>% Isc</td>
        <td>Pre Final</td>
        <td>Tot Dsc</td>
        <td>Tot Igv</td>
        <td>Sub Total</td>
        <td>Cant Reci</td>
        <td>A Recibir</td>
        <td>Fec Entrega</td>
        <td>Observacion</td>
        <td>Tot Isc</td>
    </tr>
    <%IF RS.RECORDCOUNT > 0 THEN 
    IF RS.RecordCount > 0 and len(trim(rs("oc_citem"))) > 0  THEN
        for i=0 to rs.recordcount-1 %>
         <tr  bgcolor="<% if i mod 2  = 0 THEN 
                    response.write(Application("color1"))
                    else
	                response.write(Application("color2"))
	                end IF%>" class="micro" ondblclick="muestra()"
	                onclick="dd('<%=(i)%>')" id="fila<%=Trim(Cstr(i))%>" >
            <td><%=rs("oc_citem") %></td>
            <td><%=RS("SUB_IT")%>&nbsp;</td>
            <td><%=RS("OC_CCODIGO") %></td>
            <td><%=RS("OC_CDESREF")%></td>
            <td><%=RS("OC_CUNIDAD")%></td>
            <td><%=RS("OFI")%>&nbsp;</td>
            <td><%=formatnumber(RS("OC_NCANORD"),3,,true)%></td>
            <td><%=formatnumber(RS("cantidad"),3,,true)%></td>
            <td><%=formatnumber(RS("OC_NPREUN2"),3,,true)%></td>
            <td><%=formatnumber(RS("oc_ndscpad"),2,,true)%></td>      
            <td><%=formatnumber(RS("oc_ndscpit"),2,,true)%></td>
            <td><%=formatnumber(RS("oc_nigvpor"),2,,true)%></td>
            <td><%=formatnumber(RS("oc_niscpor"),2,,true)%></td>
            <td><%=formatnumber(RS("oc_npreuni"),3,,true)%></td>
            <td><%=formatnumber(RS("oc_ndescto"),3,,true)%></td>
            <td><%=formatnumber(RS("oc_nigv"),3,,true)%></td>
            <td><%=formatnumber(RS("subt"),3,,true)%></td>
            <td><%=formatnumber(RS("oc_ncanten"),3,,true)%></td>
            <td><%=formatnumber(RS("oc_ncansal"),3,,true)%></td>
            <td><%=RS("oc_dfecent")%></td>
            <td><%=left(RS("oc_comenta"),40)%>&nbsp;</td>
            <td><%=formatnumber(RS("oc_nisc"),3,,true)%></td>
        
        </tr>
        <%rs.movenext%>
        <%next%>

    <%else 
        i=0
    end if
    END IF
     %>
    <%for j=i to i+10 %>
     <tr  bgcolor="<% if J mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>" class="TEXTO" <%IF J > 0 THEN %>style="display:NONE" <%END IF %>
	            onclick="dd('<%=(J)%>')" id="fila<%=Trim(Cstr(J))%>" >

        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>

    <%next%>

</table> 


<input type="text" id="linea" name="linea" value="<%=i-1%>"    style="display:none" />
<input type="text" id="final" name="final" value="<%=j-1%>"    style="display:none" />   
<input type="text" id="pose"  name="pose"  value="<%=oldrow%>" style="display:none" />  
<!-------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------->
<script type="text/jscript" language="jscript">
//**********************************************************************************************
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=100,top=20,height=600,width=900";
    rec = parseInt('<%=rs.recordcount%>', 10)
    dd2('0');

function muestra() 
{    window.parent.abro() 
}   
</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>