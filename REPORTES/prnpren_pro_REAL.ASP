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
TITULO =" REPORTE ANUAL DE PRENDAS EN PROCESO --> " + anio +"   " + ucase(cianame)	 + " al 81% del FOB"
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
        <td align="center">FOB</td>
        <td align="right">P. UNI</td>
        <td align="right">ENE</td>
        <td align="right">FEB</td>
        <td align="right">MAR</td>
        <td align="right">ABR</td>
        <td align="right">MAY</td>
        <td align="right">JUN</td>
        <td align="right">JUL</td>
        <td align="right">AGO</td>
        <td align="right">SEP</td>
        <td align="right">OCT</td>
        <td align="right">NOV</td>
        <td align="right">DIC</td>
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

  CAD = " SELECT top 100 percent MONTH(C6_DFECDOC) AS MES, LEFT(C6_CCODIGO,5) AS CODIGO, SUM(C6_NCANTID) AS CANT, " & _
        " MAX(AR_NPRECI1) as FOB, MAX(AR_NPRECI1)*0.81 AS UNIT, AR_CMONVTA AS MON, C6_CALMA AS ALM ,              " & _
        " YEAR (C6_DFECDOC) as anio into #partes                                                                  " & _
        " FROM "&TBL1&"                                                                                           " & _
        " inner join "&tbl2&" AS A1 ON LEFT(A1.AR_CCODIGO, 5) = LEFT(C6_CCODIGO,5)                                " & _
        " WHERE C6_CTD = 'PE' AND C6_CCODMOV IN ('PP') AND C6_CALMA IN ('00M2') and year(c6_dfecdoc) = '"&anio&"' " & _
        " GROUP BY LEFT(C6_CCODIGO,5), MONTH(C6_DFECDOC), C6_CALMA, YEAR (C6_DFECDOC), AR_CMONVTA ORDER BY 2,1 ;  " 
        
    ' response.write(CAD)    
              
  RS2.open CAD, cnn      
  cad = " select A1.*, A2.TG_CDESCRI AS DESCRI, ARTI.AR_cgrupo as GPO,  ARTI.AR_CFAMILI AS FAM from #PARTES AS A1       " & _
        " LEFT OUTER JOIN "&tbl3&" AS A2  ON '39' + LEFT(A1.CODIGO, 5) = LTRIM(RTRIM(A2.TG_CCOD)) + A2.TG_CCLAVE        " & _
        " COLLATE Modern_Spanish_CI_AI  LEFT OUTER JOIN "&tbl2&" as arti ON ARTI.AR_CCODIGO COLLATE                     " & _
        "Modern_Spanish_CI_AI = (A1.CODIGO)+ '00000' ORDER BY 2,1                                                       "
	rs.open cad,cnn
'response.write(CAD) 

        IF RS.RECORDCOUNT > 0 THEN
		    RS.MOVEFIRST
    	END IF
          
        cont = 0
        dim AMES(13) %>
        <%do while not RS.eof %>
            <%cod = RS("codigo")
            for i = 0 to 12
                ames(i) = 0
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
                 <td align="right"><%=formatnumber(cdbl(trim(RS("fob"))),2,,true)%></td>
                <td align="right"><%=formatnumber(cdbl(trim(RS("unit"))),2,,true)%></td>
            <%DO WHILE NOT RS.EOF AND RS("codigo") = cod%>   
            <%  aMes(cint(rs("mes"))) = cdbl(rs("cant"))
                aMes(0) = aMes(0) + cdbl(rs("cant"))
                rs.movenext
                IF RS.EOF THEN EXIT DO
                loop %>
                <%FOR I = 1 TO 12%>
                    <td align="right"><%if aMes(i) > 0 then ccc = formatnumber(aMes(i),0,,true) else ccc = "-"%>
                            <%=ccc%></td>    
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