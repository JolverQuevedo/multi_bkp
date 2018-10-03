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
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
oc	= Request.QueryString("oc") 
pro	= Request.QueryString("pro") 

TBL = "RSCONCAR..CP" + CIA + "CART"
CAD =	" SELECT CP_CNUMDOC FROM "&tbl&" WHERE CP_CVANEXO='P'   " & _
        " AND CP_CCODIGO='"&PRO&"' AND CP_CNDOCRE='"&OC&"'      " & _
        " ORDER BY 1                                            " 
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
</HEAD>
<BODY >



<table id="TABLA" align="center"  bordercolor="<%=application("color2")%>" bgcolor="<%=application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" with="100%">
    <tr bgcolor="#A3B87A" align="center" class="Estilo8" width="100%">
                <td colspan="2">Asignar Factura</td>
    </tr>
    <tr>    
        <td class="estilo5" align="center" width="40%">
            Factura:
        </td>         
		 <td class="estilo5" align="center" width="60%">   
             <select class="Estilo5" id="factu" name="factu">
                <option value=""></option>
                 <%IF not RS.EOF THEN %>
                    <%DO WHILE NOT RS.EOF%>
                        <option value="<%=rs.fields.item(0)%>"><%=rs.fields.item(0)%></option>
                        <%RS.MOVENEXT%>
	                <%loop%>
                <%end if %>	
            </select>
        </td> 
  </tr>
  <tr>
  <td align="center" colspan="2"><img src="../IMAGES/go1.png" border="0" onclick="manda()" onmouseover="this.src='../images/go2.png'" id="pima" name="pima"
      onmouseout="this.src='../images/go1.png'" style="cursor:pointer"/></td>

  </table>
<iframe  width="100%"  style="display:none" src="" id="actualiza" name="actualiza"  scrolling="yes" frameborder="1" height="100" align="middle"></iframe>
 
<script language="javascript">

    function manda() {
       
            cad = '../comun/asigna_fact.asp'
            cad += '?alm=' + trim(window.opener.document.all.almacen.value)
            cad += '&tip=' + trim(window.opener.document.all.tipoes.value)
            cad += '&doc=' + trim(window.opener.document.all.pentr.value)
            cad += '&num=' + trim(document.all.factu.value)
            document.all.actualiza.src = cad


    }


</script>   

    </BODY>
</HTML>