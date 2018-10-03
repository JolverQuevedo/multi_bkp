<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<link REL="stylesheet" TYPE="text/css" HREF="../MULTISTY.CSS" >
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
est	= Request.QueryString("est") 
ruc	= Request.QueryString("ruc") 
COL	= Request.QueryString("COL")
CAN	= Request.QueryString("CAN") 
POS	= Request.QueryString("POS") 
idd	= Request.QueryString("idd") 
ser	= Request.QueryString("ser") 
kor	= Request.QueryString("kor") 
if trim(ser) = "04" then codtip = "A" else codtip ="C"
ACAN= SPLIT(CAN,",")
aCol = split(col,",")
aPos = split(pos,",")
aIdd = split(idd,",")
aKor = split(kor,",")
letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
alet = "ZYXWVUTSRQPONMLKJIHGFEDCBA"

Set RS2 = Server.CreateObject("ADODB.Recordset")
RS2.CursorLocation   = 3
RS2.CursorType       = 3    
RS2.LockType         = 1 	
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY >
<%
tbl = "RSCONCAR..CP"+cia+"MAES"
cad =   " Select AC_CCODIGO as Cod, AC_CNOMBRE as nombre,   " & _
        " ac_cdirecc   as DIRECCION                         " & _
        " From "&tbl&" Where AC_CVANEXO='P'                 " & _ 
        " AND AC_CCODIGO = '"&ruc&"'                      "
rs.open cad, cnn 
%>
<form name="thisForm" METHOD="post" action="" >
<table width="100%" align="left" border="0" >
<tr>
    <td>
        <table width="100%" align="left" border="0">
            <tr>
    	        <td>
                    <table border="0" align="left" cellpadding="0"cellspacing="0" width="100%">
                        <!-- ESPACIO DE SEPARACION ENTRE EL BORDE DEL PAPEL Y LA CABECERA -->
                        <tr height="150px" id="separa" style="display:none"><td colspan="5"> </td></tr>
                         <tr>
                            <td width="100px"> </td> 
                            <td align="left" width="480px;" class="estilo5" colspan="2"><%=left(trim(RS("NOMBRE")),65) %></td>
                            <%nom = left(trim(RS("NOMBRE")),65) %>
                            <td  align="right"  class="estilo5"><%=RS("cod") %></td>
                            <td align="right" >&nbsp;</td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td align="left" class="estilo5" colspan="2" ><%=LEFT(TRIM(RS("DIRECCION")),65) %></td>
                             <%dir = left(trim(RS("DIRECCION")),65) %>
                            <td align="center">&nbsp;</td>
                            <td align="right" >&nbsp;</td>
                        </tr>
                        <tr valign="bottom" height="8px">
                            <td>&nbsp;</td>
                            <td align="left"  style="font-size:11px" colspan="2"><input id="emi" name="emi" value="<%=FORMATDATETIME(NOW(),2) %>" class="inputs"/></td>
                            <td align="left">&nbsp;</td>
                            <td align="center">&nbsp;</td>
                        </tr>
                        <tr valign="bottom" height="8px">
                            <td><input type="text" value="Transportista" id="ttr" readonly tabindex="-1" class="data2" /></td>
                            <td width="100px"><input type="text" value="" id="tra" class="bakes" onchange="baketra()" ondblclick="hlptra()" /></td>
                            <td align="left" width="300px"><input type="text" value="" id="dtr"  class="bakes" ondblclick="hlptra()"/></td>
                            <td align="center">&nbsp;</td>
                            <td align="center">&nbsp;</td>
                        </tr>
                         <tr valign="bottom" height="8px"  id="agencia" name = "agencia">
                            <td ><input type="text" value="Agencia" id="agenc" readonly tabindex="-1" class="data2" /></td>
                            <td colspan="2"><input type="text" value="" id="agen" class="bakes" maxlength="24"  /></td>
                          
                            <td align="center">&nbsp;</td>
                            <td align="center">&nbsp;</td>
                        </tr>
                    </table>
              </td>
          </tr>        
          </table>
          <%rs.close %>
    </td>
</tr>
<tr>
    <td>
        <table  border="0" cellspacing="1" cellpadding="1" align="left" width="100%">
            <tr class="estilo5" id="tit" name="tit">
                <td width="5%">Chk</td>
                <td width="10%">Articulo</td>
                <td width="10%">Cant</td>
                <td width="5%">UNI</td>
                <td width="60%">Descripcion</td>
                <td width="5%">Corte</td>
                <td width="5%">PO</td>
                <td width="5%">Color</td>
            </tr>
            <%LIN = 0 ' contador del numero de lineas totales a imprimir 
              mm = 0  ' contador de lineas de la guia
             %>
            <tr name="lin<%=mm%>" id="lin<%=mm%>">
                <td><input id="ch<%=mm%>"  name="ch<%=mm%>"  type="checkbox" style="display:none" /></td>
                <td><input id="cod<%=mm%>" name="cod<%=mm%>" value="."   style="display:none" /></td>
                <td><input id="con<%=mm%>" name="con<%=mm%>" value="0.000"  style="display:none" /></td>
                <td><input id="uni<%=mm%>" name="uni<%=mm%>" value='' class="data2"  style="display:none"/></td>
                <td><input id="des<%=mm%>" name="des<%=mm%>" value='.. SEGUN DETALLE ..' class="microLeft" readonly tabindex="-1" /></td>
                <td><input id="Kor<%=mm%>" name="Kor<%=mm%>" value='..' class="microLeft" readonly tabindex="-1" /></td>
                <td><input id="Pos<%=mm%>" name="Pos<%=mm%>" value='<%=aPos(0)%>' class="microLeft" readonly tabindex="-1" /></td>
                <td><input id="Col<%=mm%>" name="Col<%=mm%>" value='<%=aCol(0)%>' class="microLeft" readonly tabindex="-1" /></td>
                <%lin = lin +1 
                mm = mm + 1%>
               
            </tr>    
            <!-- KNT = GRAN TOTAL DE PRENDA A INGRESAR A STOCK -->
            <!-- KANTI = ACUMULA LAS PO'S DEL MISMO COLOR -->
            <%KNT = 0
              KANTI = 0
              kolo = aCol(0) %>
            <tr  height="20px" style="vertical-align:bottom" name="lin<%=mm%>" id="lin<%=mm%>">
                  <td><input id="ch<%=mm%>"   name="ch<%=mm%>"  type="checkbox" style="display:none" /></td>
                  <td><input id="cod<%=mm%>" name="cod<%=mm%>" value="."   style="display:none" /></td>
                  <td><input id="con<%=mm%>" name="con<%=mm%>" value="0.000"  style="display:none" /></td>
                  <td><input id="uni<%=mm%>" name="uni<%=mm%>" value='' class="data2"  style="display:none"/></td>
                  <td><input id="des<%=mm%>" name="des<%=mm%>" value='ESTILO-<%=ucase(trim(est))%>  COLOR-><%=aCol(0)%>' class="microLeft" readonly tabindex="-1" /></td>
                  <td><input id="Kor<%=mm%>" name="Kor<%=mm%>" value='<%=aKor(0)%>' class="microLeft" readonly tabindex="-1" /></td>
                  <td><input id="Pos<%=mm%>" name="Pos<%=mm%>" value='<%=aPos(0)%>' class="microLeft" readonly tabindex="-1" /></td>
                  <td><input id="Col<%=mm%>" name="Col<%=mm%>" value='<%=aCol(0)%>' class="microLeft" readonly tabindex="-1" /></td>
                  <%lin = lin +1 
                  mm = mm + 1%>
            </tr>      
            <%FOR  M=0 TO UBOUND(aCol)%>             
              <%if aCol(m) = kolo  then %>
                     <% CAD =	" exec po_color_guia_tallas  '"&est&"' , '"&ruc&"', '"&ser&"', '"&apos(m)&"', '"&aCol(m)&"', '"&aIdd(m)&"' "      
                        
                        'RESPONSE.WRITE(CAD)
                        RS.Open CAD, Cnn
	                    IF NOT RS.EOF OR NOT RS.BOF THEN 
                            RS.MOVEFIRST
                        ELSE
                            response.Write("no hay registros")
                            response.end
                        END IF %>
                    <tr name="lin<%=mm%>" id="lin<%=mm%>">
                        <td            ><input id="ch<%=mm%>"  name="ch<%=mm%>"  type="checkbox" style="display:none" /></td>
                        <td width="10%"><input id="cod<%=mm%>" name="cod<%=mm%>" value="<%=request.querystring("pda")%>" class="microLeft" readonly tabindex="-1"  /></td>
                        <td width="10%"><input id="con<%=mm%>" name="con<%=mm%>" value="<%=aCan(m)%>" class="microLeft" style="text-align:right; 
                                            padding-right:10px;" readonly tabindex="-1" /></td>
                        <td            ><input id="uni<%=mm%>" name="uni<%=mm%>" value='UND' class="data2"  style="display:none"/></td>
                        <%cad = "PO " + trim(rs("po")) + "-" 
                        FOR I = 0 TO 9
                            can = "c"&i 
                            ccc = CDBL(rs(can))
                            ttt = "t"&i 
                            if ccc > 0 then 
                            cad = cad + rs(TTT)+ "/"+ LTRIM(RTRIM(CSTR(ccc))) + "_"
                            END IF
                        NEXT  
                        knt = knt + aCan(m) %>
                        <td><input id="des<%=mm%>" name="des<%=mm%>" value='<%=cad%>' class="microLeft" readonly tabindex="-1" /></td>
                        <td><input id="Kor<%=mm%>" name="Kor<%=mm%>" value='<%=aKor(m)%>' class="microLeft" readonly tabindex="-1" /></td>
                        <td><input id="Pos<%=mm%>" name="Pos<%=mm%>" value='<%=aPos(m)%>' class="microLeft" readonly tabindex="-1" /></td>
                        <td><input id="Col<%=mm%>" name="Col<%=mm%>" value='<%=aCol(m)%>' class="microLeft" readonly tabindex="-1" /></td>
                        <%lin = lin +1 
                            mm = mm + 1 %>
                    </tr>
                    <%kanti = kanti + cdbl(aCan(m)) 
                    %>
              <%else%>
                   <%CAD = "EXEC AVIOS_PO_GUIA '"&aPos(m)&"', '"&kanti&"', '"&codtip&"' "
                    RS.OPEN CAD, CNN
                    if rs.recordcount <= 0 then response.end %>
                    <!-- ***************************************************************************   -->
                    <!-- El while barre los avios de las PO's anteiores                                -->
                    <!-- ***************************************************************************   -->
                    <%do while not rs.eof %>  
                    <tr class="data" name="lin<%=mm%>" id="lin<%=mm%>">
                        <td><input id="ch<%=mm%>"  name="ch<%=mm%>" type="checkbox" tabindex="-1" onclick="borra('<%=mm%>')"/></td>
                        <td><input id="cod<%=mm%>" name="cod<%=mm%>" value="<%=rs("codigo")%>" class="BAKES"  /></td>
                        <td><input id="con<%=mm%>" name="con<%=mm%>" value="<%=rs("consumo")%>" style="text-align:right; padding-right:10px; 
                                width:100%;" onblur="this.value=toInt(this.value)"/></td>
                        <td><input id="uni<%=mm%>" name="uni<%=mm%>" value='<%=trim(rs("coduni")) %>' class="data2" readonly tabindex="-1" /></td>
                        <td><input id="des<%=mm%>" name="des<%=mm%>" value='<%=ucase(ltrim(rtrim(rs("descri"))))%>-<%=ucase(ltrim(rtrim(rs("adic")))) %>'
                         class="data2"  /></td>
                        <td><input id="Kor<%=mm%>" name="Kor<%=mm%>" value='<%=aKor(m-1)%>' class="microLeft" readonly tabindex="-1" /></td>
                        <td><input id="Pos<%=mm%>" name="Pos<%=mm%>" value='<%=aPos(m-1)%>' class="microLeft" readonly tabindex="-1" /></td>
                        <td><input id="Col<%=mm%>" name="Col<%=mm%>" value='<%=aCol(m-1)%>' class="microLeft" readonly tabindex="-1" /></td>
                        <%lin = lin +1 %>
                    </tr>
                    <%RS.MOVENEXT%>
                    <%mm = mm + 1 %>
                    <%if aCan(m) = 0 then exit do %>
                <%LOOP%>
                <%rs.close %>
                <%kanti = aCan(m) 
                kolo = aCol(m)%>
                 <tr  height="20px" style="vertical-align:bottom" name="lin<%=mm%>" id="lin<%=mm%>">
                  <td><input id="ch<%=mm%>"   name="ch<%=mm%>"  type="checkbox" style="display:none" /></td>
                  <td><input id="cod<%=mm%>" name="cod<%=mm%>" value="."   style="display:none" /></td>
                  <td><input id="con<%=mm%>" name="con<%=mm%>" value="0.000"  style="display:none" /></td>
                  <td><input id="uni<%=mm%>" name="uni<%=mm%>" value='' class="data2"  style="display:none"/></td>
                  <td><input id="des<%=mm%>" name="des<%=mm%>" value='ESTILO-<%=ucase(trim(est))%> _COLOR-><%=aCol(m)%>' class="microLeft" readonly tabindex="-1" /></td>
                  <td><input id="Kor<%=mm%>" name="Kor<%=mm%>" value='<%=aKor(m)%>' class="microLeft" readonly tabindex="-1" /></td>
                  <td><input id="Pos<%=mm%>" name="Pos<%=mm%>" value='<%=aPos(m)%>' class="microLeft" readonly tabindex="-1" /></td>
                  <td><input id="Col<%=mm%>" name="Col<%=mm%>" value='<%=aCol(m)%>' class="microLeft" readonly tabindex="-1" /></td>
                  <%lin = lin +1 
                  mm = mm + 1%>
            </tr>    
            <% CAD =	" exec po_color_guia_tallas  '"&est&"' , '"&ruc&"', '"&ser&"', '"&apos(m)&"', '"&aCol(m)&"', '"&aIdd(m)&"' "      
                        RS.Open CAD, Cnn
	                    IF NOT RS.EOF OR NOT RS.BOF THEN 
                            RS.MOVEFIRST
                        ELSE
                            response.Write("no hay registros")
                            response.end
                        END IF %>
 
                    <tr name="lin<%=mm%>" id="lin<%=mm%>">
                        <td            ><input id="ch<%=mm%>"  name="ch<%=mm%>"  type="checkbox" style="display:none" /></td>
                        <td width="10%"><input id="cod<%=mm%>" name="cod<%=mm%>" value="<%=request.querystring("pda")%>" class="microLeft" readonly tabindex="-1"  /></td>
                        <td width="10%"><input id="con<%=mm%>" name="con<%=mm%>" value="<%=aCan(m)%>" class="microLeft" style="text-align:right; 
                                            padding-right:10px;" readonly tabindex="-1" /></td>
                        <td            ><input id="uni<%=mm%>" name="uni<%=mm%>" value='UND' class="data2"  style="display:none"/></td>
                        <%cad = "PO " + trim(rs("po")) + "-" 
                        FOR I = 0 TO 9
                            can = "c"&i 
                            ccc = formatnumber(cdbl(rs(can)),0,,true)
                            ttt = "t"&i 
                            if ccc > 0 then 
                            cad = cad + rs(TTT)+ "/"+ ccc + "_"
                            END IF
                        NEXT  
                        knt = knt + aCan(m) %>
                        <td><input id="des<%=mm%>" name="des<%=mm%>" value='<%=cad%>' class="microLeft" readonly tabindex="-1" /></td>
                        <td><input id="Kor<%=mm%>" name="Kor<%=mm%>" value='<%=aKor(m)%>' class="microLeft" readonly tabindex="-1" /></td>
                        <td><input id="Pos<%=mm%>" name="Pos<%=mm%>" value='<%=aPos(m)%>' class="microLeft" readonly tabindex="-1" /></td>
                        <td><input id="Col<%=mm%>" name="Col<%=mm%>" value='<%=aCol(m)%>' class="microLeft" readonly tabindex="-1" /></td>
                        <%lin = lin +1 
                            mm = mm + 1 %>
                    </tr>
                    <%'kanti = kanti + cdbl(aCan(m)) %>
            <%end if %>
            <%rs.close%>
        <%next   ' del for M (aCol) %>


         <%CAD = "EXEC AVIOS_PO_GUIA '"&aPos(m-1)&"', '"&kanti&"', '"&codtip&"' "
        ' response.write(cad)
                    RS.OPEN CAD, CNN
                    if rs.recordcount <= 0 then response.end %>
                    <!-- ***************************************************************************   -->
                    <!-- El while barre los avios de las PO's anteiores                                -->
                    <!-- ***************************************************************************   -->
                    <%do while not rs.eof %>  
                    <tr class="data" name="lin<%=mm%>" id="lin<%=mm%>">
                        <td><input id="ch<%=mm%>"  name="ch<%=mm%>" type="checkbox" tabindex="-1" onclick="borra('<%=mm%>')"/></td>
                        <td><input id="cod<%=mm%>" name="cod<%=mm%>" value="<%=rs("codigo")%>" class="BAKES"  /></td>
                        <td><input id="con<%=mm%>" name="con<%=mm%>" value="<%=rs("consumo")%>" style="text-align:right; padding-right:10px; 
                                width:100%;" onblur="this.value=toInt(this.value)"/></td>
                        <td><input id="uni<%=mm%>" name="uni<%=mm%>" value='<%=trim(rs("coduni")) %>' class="data2" readonly tabindex="-1" /></td>
                        <td><input id="des<%=mm%>" name="des<%=mm%>" value='<%=trim(ucase(ltrim(rtrim(rs("descri")))))%>-<%=trim(ucase(ltrim(rtrim(rs("adic"))))) %>' class="data2"  tabindex="-1" /></td>
                        <td><input id="Kor<%=mm%>" name="Kor<%=mm%>" value='<%=aKor(m-1)%>' class="microLeft" readonly tabindex="-1" /></td>
                        <td><input id="Pos<%=mm%>" name="Pos<%=mm%>" value='<%=aPos(m-1)%>' class="microLeft" readonly tabindex="-1" /></td>
                        <td><input id="Col<%=mm%>" name="Col<%=mm%>" value='<%=aCol(m-1)%>' class="microLeft" readonly tabindex="-1" /></td>
                        <%lin = lin +1 %>
                    </tr>
                    <%RS.MOVENEXT%>
                    <%mm = mm + 1 %>
                    <%if aCan(m-1) = 0 then exit do %>
                <%LOOP%>
                <%rs.close %>

        <%	SET RS  = NOTHING
	        Cnn.Close
	        SET Cnn = NOTHING%>
      
        <tr><td colspan="6" align="center"><img src="../IMAGES/PRINT.png" style="cursor:pointer" id="prn" name="prn" onclick="Printa()"/></td></tr>
        <tr><td colspan="6" align="center">
            <iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="0" height="400" align="middle" style="display:block" ></iframe></td>
        </tr>
     </table>   
  </td></tr>
</table>


</form>  
<script language="jscript" type="text/jscript">
function borra(ln) { 
eval("document.all.lin"+ln+".style.display='none'")    
    }

function Printa() {

    var GUIA = prompt("Ingrese el nuemero de Guia 001-", "");
    if (GUIA == null) {
        alert("NO HA INGRESADO EL NUMERO DE GUIA A IMPRIMIR")
        return true
    }
    else {
        if (parseInt(GUIA) > 999999) {
            alert("Numero de GUIA INVALIDO")
            return true
        }
    }

if(trim(document.all.tra.value)=='')
{   alert("Favor indicar el transportista")
    return true;
}
document.all.ttr.style.display = 'none';
document.all.tra.className = 'data2';
document.all.dtr.className = 'data2';


document.all.tra.style.fontSize='11px'
document.all.dtr.style.fontSize='11px'

document.all.separa.style.display='block'

if(trim(document.all.agen.value)=='')
{   alert("Favor indicar la Agencia/Documento")
    return true;
}
else 
    document.all.agen.value = toAlpha(document.all.agen.value)

document.all.agencia.style.display = 'none';



// mm es el contador de lineas de la guia

fin = parseInt('<%=mm%>', 10)
lineas = parseInt('<%=lin%>',10)
//alert(fin)
aCan = new Array()
aCod = new Array()
aDes = new Array()
aKor = new Array()
    for (u = 0; u < fin; u++) {
        eval("document.all.con" + u + ".className='data2'")
        eval("document.all.ch" + u + ".style.display='none'")
        eval("document.all.cod" + u + ".className='data2'")
        eval("document.all.cod" + u + ".readOnly='true'")
        eval("document.all.con" + u + ".readOnly='true'")
        if (trim(eval("document.all.con" + u + ".value")) == '') {
            eval("document.all.ch" + u + ".checked='true'")
            eval("document.all.lin" + u + ".style.display='none'")   
        }
       if (eval("document.all.ch" + u + ".checked")== false)
       {    aCod[aCod.length++] = trim(eval("document.all.cod" + u + ".value"))
            aCan[aCan.length++] = trim(eval("document.all.con" + u + ".value"))
            aKor[aKor.length++] = trim(eval("document.all.Kor" + u + ".value"))

            veri = trim(eval("document.all.cod" + u + ".value"))
            if ((trim(eval("document.all.cod" + u + ".value")) == '.') || veri.length == 10 )
                aDes[aDes.length++] = Left(ltrim(eval("document.all.des" + u + ".value")),50)
            else
                aDes[aDes.length++] = ''
       }
    }
    document.all.tit.style.display = 'none'
    document.all.prn.style.display ='none'

cad  = '?ruc=' + trim('<%=ruc%>')
cad += '&pda=' + trim('<%=request.querystring("pda")%>')
cad += '&KNT=' + trim('<%=KNT%>')
cad += '&EST=' + trim('<%=est%>')
cad += '&ser=' + trim('<%=ser%>')
cad += '&Cod=' + aCod
cad += '&Can=' + aCan
cad += '&des=' + aDes
cad += '&age=' + ltrim(document.all.agen.value)
cad += '&nom=' + ltrim('<%=nom%>')
cad += '&dir=' + ltrim('<%=dir%>')
cad += '&POS=' + '<%=POS%>'
cad += '&TRA=' + trim(document.all.tra.value)
cad += '&DTR=' + ltrim(document.all.dtr.value)
cad += '&emi=' + trim(document.all.emi.value)
cad += '&idd=' + '<%=idd %>'
cad += '&GUI=' + GUIA



document.all.body0.src ='../comun/emiteguia.asp' + cad

 }
function baketra() {
    /*document.all.body0.style.display = 'block'
    document.all.body0.height = "350"
    document.all.body0.width = "100%"
    */
        document.all.body0.src = "../BAKE/jala_tra.asp?RUC=" + trim(document.all.tra.value);
    }
//  parent.window.document.all.ENVI.style.display='none'

function hlptra()
{   window.open("../help/HLPtranspor.asp?ruc="+trim(document.all.tra.value) + '&nom='+ ltrim(document.all.dtr.value))

}
</script>
    </BODY>
</HTML>