<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<link REL="stylesheet" TYPE="text/css" HREF="../MULTISTY.CSS" >
<%
response.cookies("multi")("fichas") = ""
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
po	= Request.QueryString("po") 
cli	= Request.QueryString("cli")
    CAD =	" SELECT UBI,COLOR, t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,  " & _
            " ceiling(can0*1.05) as can0,ceiling(can1*1.05) as can1,ceiling(can2*1.05) as can2, " & _
            " ceiling(can3*1.05) as can3,ceiling(can4*1.05) as can4,ceiling(can5*1.05) as can5, " & _
            " ceiling(can6*1.05) as can6,ceiling(can7*1.05) as can7,ceiling(can8*1.05) as can8,ceiling(can9*1.05) as can9 " & _
            " FROM   MODELADOR..[po-deta] AS PP                 " & _
            " where  PP.po = '"&po&"'                           " 
'RESPONSE.Write(CAD)



	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
		RS.MOVEFIRST
	END IF 
' Nro de columnas regresadas por el objeto RECORDSET	
	columnas = rs.Fields.Count-1
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">

<script language="javascript" type="text/jscript">
oldrow = 1
function enter() {
    if (event.keyCode == 13) {
        document.all.ENVI.onclick
    }
}
function redir(ff) {
    var t = document.all.TABLA;
    ff = parseInt(ff, 10);
    ubi = t.rows(ff).cells(0).innerText;
    col = t.rows(ff).cells(1).innerText;

    window.opener.document.all.UBI.value = ubi
    window.opener.document.all.COL.value = col
    for (u = 2; u < 12; u++) {
        eval("window.opener.document.all.T" + (u - 2) + ".value = t.rows(ff).cells(u).innerText")
    }
    TTT = 0
    for (u = 12; u < 22; u++) {
        eval("window.opener.document.all.Q" + (u - 12) + ".value = t.rows(ff).cells(u).innerText")
        TTT = Math.floor(TTT)
        TTT += parseInt(t.rows(ff).cells(u).innerText, 10)
        eval("window.opener.document.all.C" + (u - 12) + ".value = 0")

        if (parseInt(t.rows(ff).cells(u).innerText, 10) == 0) {
            //alert(t.rows(ff).cells(u).innerText)
            eval("window.opener.document.all.C" + (u - 12) + ".disabled=true")
            eval("window.opener.document.all.Q" + (u - 12) + ".value=''")
        }
        else {
            eval("window.opener.document.all.C" + (u - 12) + ".disabled=false")
            eval("window.opener.document.all.C" + (u - 12) + ".value = t.rows(ff).cells(u).innerText")
        }
    }

 
    window.opener.document.all.TOTPO.value = TTT
    this.window.close();
}
function llena() {
    return true;
}

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}

</script>
</HEAD>
<BODY >

<form name="thisForm" METHOD="post" action="" onsubmit="filtra()    " >
<center>
<span class="estilo2" align="center">Cantidades al 105% <br /></span>
</center>
<table id="TABLA" align="center"  bordercolor="<%=application("color2")%>" bgcolor="<%=application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" with="100%">


<%	'**************************
	'LINEA DE CABECERA STANDAR 
	'**************************
	cont=1%>
<TR bgcolor="<%=APPLICATION("TITULO")%>" >
	<%FOR I=0 TO 1 %>
		<TD align="center" class="estilo8" width="1%"><%=trim(RS.FIELDS(I).NAME)%></TD>
	<%NEXT%>
    <%for i = 2 to 21 %>
	     <td style="display:none"><%=trim(RS.FIELDS.ITEM(i))%>&nbsp;</td>
    <%next %>
    <TD align="center" class="estilo8" width="1%"></TD>
</TR>
<%	'*****************************
	' MUESTRA EL GRID (2 COLORES) 
	'*****************************	%>
  <%' MUESTRA EL GRid (2 colorES) %>
    <%IF not RS.EOF THEN %>
    <%DO WHILE NOT RS.EOF%>
    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" onDblClick="redir('<%=(cont)%>')" >       
	    
		 <td class="estilo5" align="center" width="10%"><%=trim(RS.FIELDS.ITEM(0))%>&nbsp;</td>
         <td class="estilo5" align="left"   width="68%"><%=trim(RS.FIELDS.ITEM(1))%>&nbsp;</td>
         
         <%for i = 2 to 21 %>
	     <td style="display:none"><%=trim(RS.FIELDS.ITEM(i))%>&nbsp;</td>
         <%next %>
         <td class="estilo5" align="left"   width="2%"><input id="ch<%=cont%>" name="ch<%=cont%>" type="checkbox" onclick="marcas(this.checked)"/></td>
	    <%RS.MOVENEXT%>
	    <%CONT = CONT + 1%>
  </tr>
	<%loop%>
    <%end if %>
  </table>
  <center>
  <input id="env" name="env" type="button" value="Generacion Masiva" onclick="envia()" />
   <input id="fic" name="fic" type="text" value=""/>
  </center>
  
<iframe  width="100%" src="" id="body10" name="body10" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe>
<script language="javascript">
red ='<%=rs.recordcount %>'
var marcador = 0
if (parseInt(red,10) > 0)
    dd2('1');

function marcas(dato) { 
if (dato == true)
    marcador++
else 
    marcador--
}

function calcula(ff) {
    var t = document.all.TABLA;
    ff = parseInt(ff, 10);
    ubi = t.rows(ff).cells(0).innerText;
    col = t.rows(ff).cells(1).innerText;

    window.opener.document.all.UBI.value = ubi
    window.opener.document.all.COL.value = col
   
    for (u = 12; u < 22; u++)
       eval("window.opener.document.all.C" + (u - 12) + ".value = t.rows(ff).cells(u).innerText")

}

function envia() {
    if (marcador <= 0) {
        alert("No ha seleccionado ningun color")
        return true
        }
     
    if (window.opener.window.valida('1') == true) {
        rec = '<%=rs.recordcount %>'
        aCol = new Array()
        aIdd = new Array()
        go = 0
        for (g = 1; g <= parseInt(rec, 10); g++) {
            if( eval("window.document.all.ch" + g + ".checked")== true)
             {   // jala los datos de la cabecera que se repertiran para todos los colores
                CAD = '?id='   + trim(window.opener.window.document.all.id.value)
                CAD += '&po='  + trim(window.opener.window.document.all.POS.value)      
                CAD += '&EMP=' + '<%=cia%>'
                CAD += '&mov=' + trim(window.opener.window.document.all.mov.value)
                CAD += '&GUI=' + trim(window.opener.window.document.all.GUI.value)
                CAD += '&GUI2=' + trim(window.opener.window.document.all.GUI2.value)
                CAD += '&COR=' + trim(window.opener.window.document.all.CORT.value)
                CAD += '&RUC=' + toInt(window.opener.window.document.all.RUC.value)
                CAD += '&DEF=' + trim(window.opener.window.document.all.DEF.value)
                CAD += '&pza=' + trim(window.opener.window.document.all.PZA.value)
                CAD += '&SER=' + trim(window.opener.window.document.all.SER.value)
                CAD += '&CON=' + trim(window.opener.window.document.all.CON.value)    
                CAD += '&FEC=' + trim(window.opener.window.document.all.FEC.value)
                CAD += '&cli=' + '<%=cli%>'
                CAD += '&BOL=' + trim(window.opener.window.document.all.BOL.value)
                CAD += '&LIN=' + trim(window.opener.window.document.all.LIN.value)
                CAD += '&MOT=' + trim(window.opener.window.document.all.MOT.value)
                calcula(g)
                CAD += '&UBI=' + trim(window.opener.window.document.all.UBI.value)
                CAD += '&C0='  + trim(window.opener.window.document.all.C0.value)
                CAD += '&C1='  + trim(window.opener.window.document.all.C1.value)
                CAD += '&C2='  + trim(window.opener.window.document.all.C2.value)
                CAD += '&C3='  + trim(window.opener.window.document.all.C3.value)
                CAD += '&C4='  + trim(window.opener.window.document.all.C4.value)
                CAD += '&C5='  + trim(window.opener.window.document.all.C5.value)
                CAD += '&C6='  + trim(window.opener.window.document.all.C6.value)
                CAD += '&C7='  + trim(window.opener.window.document.all.C7.value)
                CAD += '&C8='  + trim(window.opener.window.document.all.C8.value)
                CAD += '&C9='  + trim(window.opener.window.document.all.C9.value)
                CAD += '&multi=1';
                //alert(CAD)
                document.all.body10.style.display = 'block'
                document.all.body10.height = "350"
                document.all.body10.width = "100%"
                document.all.body10.src = "../comun/inserPOSmovi.asp" + CAD 
                aCol[go++] = window.opener.document.all.COL.value
                alert(aCol[go-1])
            }
        }     
        document.all.body10.src = "muestracarga.asp?ficha=" + aIdd + '&Col=' + aCol     
    }
    else { 
        alert("faltan datos")
    }   
    return true;
}
</script>    
</form>
<%
	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
    </BODY>
</HTML>