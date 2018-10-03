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

<html>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<script type="text/jscript" language="jscript">
var aCod = Array()
top.window.parent.window.calcHeight()
</script>
<%  anio= Request.QueryString("anio")
    tip = Request.QueryString("TIP") 
TITULO =" REPORTE ANUAL DE PRODUCTOS TERMINADOS --> " + anio +"   " + ucase(cianame)	
%>


<% IF TIP = "E" THEN
    archivo = "%temp%"+"prod_" + trim(anio)+ ".xls"
    Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo  
END IF%>
<title><%=titulo%></title>

   
</head>
<body style="margin-top:0PX">

<table id="Table1" align="center"  bordercolor="lightgrey"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
	<tr><td align="center" class="Estilo4"><%=titulo%></td></tr>
</table> 
<table id="TABLA" align="center"  bordercolor="lightgrey" style="border-color:lightgrey"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
    <tr valign="top" class="estilo8" ><b>
        <td align="left">CODIGO</td> 
        <td align="left">DESCRIPCION</td>          
        <td align="center">GPO</td>
        <td align="center">FAM</td>
        <td align="center">ALM</td>
        <td align="center">MON</td>
      <!--  <td align="right">P. UNI</td> -->
        <td align="right" colspan="2">ENE</td>
        <td align="right" colspan="2">FEB</td>
        <td align="right" colspan="2">MAR</td>
        <td align="right" colspan="2">ABR</td>
        <td align="right" colspan="2">MAY</td>
        <td align="right" colspan="2">JUN</td>
        <td align="right" colspan="2">JUL</td>
        <td align="right" colspan="2">AGO</td>
        <td align="right" colspan="2">SEP</td>
        <td align="right" colspan="2">OCT</td>
        <td align="right" colspan="2">NOV</td>
        <td align="right" colspan="2">DIC</td>
        <td align="right">TOTAL</td></b>
    </tr>
          
<!-------------------------------------------------->
<%Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.ActiveConnection = Cnn
	RS2.CursorType       = 3 'CONST adOpenStatic = 3
	RS2.LockType         = 1 'CONST adReadOnly = 1
	RS2.CursorLocation   = 3 'CONST adUseClient = 3

  TBL1 = "rsfaccar..AL"+CIA+"MOVD"
  TBL2 = "RSFACCAR.dbo.AL"+cia+"ARTI"
  TBL3 = "RSFACCAR.dbo.AL"+cia+"TABL"
  TBL4 = "RSFACCAR_historico.dbo.AL"+CIA+"MOVD"
  if cint(anio) > 2017  then   
      CAD = " SELECT top 100 percent MONTH(C6_DFECDOC) AS MES,  LEFT(C6_CCODIGO,5) AS CODIGO, SUM(C6_NCANTID) AS CANT,      " & _
            " AVG(C6_Nmnprun) AS UNIT, 'MN' AS MON, C6_CALMA AS ALM , YEAR (C6_DFECDOC) as anio into #partes FROM "&tbl1&"  " & _
            " WHERE C6_CTD = 'PE' AND C6_CCODMOV IN ('EP','PR') AND C6_CALMA IN ('00T1', '00T2','00R1')  and year(c6_dfecdoc) =    " & _
            " '"&anio&"' GROUP BY LEFT(C6_CCODIGO,5), MONTH(C6_DFECDOC), C6_CALMA, YEAR (C6_DFECDOC) ORDER BY 2,1 ;         "        
   else   
      CAD = " SELECT top 100 percent MONTH(C6_DFECDOC) AS MES,  LEFT(C6_CCODIGO,5) AS CODIGO, SUM(C6_NCANTID) AS CANT,      " & _
            " AVG(C6_Nmnprun) AS UNIT, 'MN' AS MON, C6_CALMA AS ALM , YEAR (C6_DFECDOC) as anio into #partes FROM "&tbl4&"  " & _
            " WHERE C6_CTD = 'PE' AND C6_CCODMOV IN ('EP','PR') AND C6_CALMA IN ('00T1', '00T2','00R1')  and year(c6_dfecdoc) =    " & _
            " '"&anio&"' GROUP BY LEFT(C6_CCODIGO,5), MONTH(C6_DFECDOC), C6_CALMA, YEAR (C6_DFECDOC) ORDER BY 2,1 ;         "          
  end if
  RS2.open CAD, cnn      

  cad = " select A1.*, A2.TG_CDESCRI AS DESCRI, ARTI.AR_cgrupo as GPO,  ARTI.AR_CFAMILI AS FAM from #PARTES AS A1       " & _
        " LEFT OUTER JOIN "&tbl3&" AS A2  ON '39' + LEFT(A1.CODIGO, 5) = LTRIM(RTRIM(A2.TG_CCOD)) + A2.TG_CCLAVE        " & _
        " COLLATE Modern_Spanish_CI_AI  LEFT OUTER JOIN "&tbl2&" as arti ON ARTI.AR_CCODIGO COLLATE                     " & _
        "Modern_Spanish_CI_AI = (A1.CODIGO)+ '00000' ORDER BY 2,1                                                       "
	rs.open cad,cnn
'response.write(RS.recordcount) 

        IF RS.RECORDCOUNT > 0 THEN
		    RS.MOVEFIRST
    	END IF
          
        cont = 0
        dim AMES(13) 
        dim APUN(13) %>
        <%do while not RS.eof %>
            <%cod = RS("codigo")
            for i = 0 to 12
                ames(i) = 0
                APUN(I) = 0
            next
            %>
                <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>" class="estilo5" > 
                <td><%=trim(RS("codigo"))%></td>
                <td><%=trim(RS("DESCRI"))%>&nbsp;</td>
                <td align="center"><%=trim(RS("gpo"))%>&nbsp;</td>
                <td align="center"><%=trim(RS("FAM"))%>&nbsp;</td>
                <td align="center"><%=trim(RS("alm"))%></td>
                <td align="center"><%=trim(RS("mon"))%></td>
           
            <%DO WHILE NOT RS.EOF AND RS("codigo") = cod%>   
            <%  aMes(cint(rs("mes"))) = cdbl(rs("cant"))
                ApUN(cint(rs("mes"))) = cdbl(rs("UNIT"))
                aMes(0) = aMes(0) + cdbl(rs("cant"))
                rs.movenext
                IF RS.EOF THEN EXIT DO
                loop %>
                <%FOR I = 1 TO 12%>
                    <td align="right">
                        <%if aMes(i) > 0 then 
                            ccc = formatnumber(aMes(i),0,,true) 
                            ppp = formatnumber(cdbl(APUN(I)),2,,true)
                         else 
                            ccc = "-"
                            PPP =""  
                         
                         end if%>
                            <%=ccc%></td>    
                    <td align="right"><%=PPP%></td>
                <%NEXT%>

                    <td align="right"><%=formatnumber(aMes(0),0,,,true)%></td>
                </tr>
               <%cont =cont + 1 %>
            <%IF RS.EOF THEN EXIT DO %>
        <%LOOP %>
         
    
</table>





<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>