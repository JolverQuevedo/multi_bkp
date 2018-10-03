<%@ Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="multisty.CSS" />
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>

<!--#include file="../includes/Cnn.inc"-->
<%
tbl	=	Request.QueryString("tbl") 
CAD =	" SELECT  " & _
		" * " & _
		" from "&TBL&" " & _
		" ORDER BY 2 " 
		RS.OPEN CAD ,Cnn
		
If rs.eof or rs.bof then
	Response.Write("Tabla  Vacía")		
	Response.End
end if	
	IF NIVEL > 1 THEN
		LIMITE =  rs.fields.count - 3
	ELSE 
		LIMITE =  rs.fields.count - 1
	END IF	
rs.movefirst
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="../multisty.CSS" />

</head>

<body topmargin="0" leftmargin="0" rightmargin="0" border="0">

<table width="100%">
	<tr>
	    <td width="5%">&nbsp;</td>
		<td  align="center" class="Estilo2"><%=ucase(tbl)%></td>
		<td  align="right" width="5%"> 
		  	<img src="../images/logo.jpg" alt="" border="0" />
		  </td>
        </tr>
	<tr><td  colspan="3"><hr /></td></tr>
</table>
<table id="TABLA" align="center" width="100%" cellpadding="0" cellspacing="0" bordercolor='<%=application("color2") %>' border="0" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>

<%cont = 0%>
<tr >
	<%for I=0 to LIMITE %>
		<td class="Estilo3"><%=trim(RS.FIELDS(I).name)%>&nbsp;</td>
	<%next%>	
</tr>

<%do while not rs.eof%>
<tr bgcolor="<%IF CONT MOD 2 = 0 THEN RESPONSE.WRITE(application("color1")) ELSE RESPONSE.WRITE(application("color2"))%>">
	<%FOR i=0 TO limite%>
		<td class="Estilo5">
		    <%if UCASE(rs.fields(i).name) = "FECHA" THEN
		        RESPONSE.Write(LEFT(trim(RS.FIELDS.ITEM(I)),10))
		      ELSE
		        RESponse.Write(trim(rs.fields.item(i)))
		      end if%>
		</td>
	<%NEXT%>
</tr>
    <%RS.MOVENEXT%>
	<%if rs.eof then exit do%>
    <%CONT = CONT + 1%>
    <%if  cont mod 60 = 0 then%>	
    <tr>
	    <td  colspan="<%=LIMITE+1%>">
	        <table width="100%" style="page-break-before:always">
	            <tr>
	                <td  align="right" width="5%">&nbsp;</td>
		            <td  align="center" class="talasblue"><%=titulo%></td>
		            <td  align="right" width="5%"><img src="../imagenes/logo.GIF"  alt="" /></td>
	            </tr>
	            <tr>
	                <td  colspan="3"><hr /></td>
	            </tr>
            </table>
	    </td>
	</tr>
	<tr bgcolor="<%=application("titulo") %>">
	    <%for I=0 to LIMITE %>
		    <td  align="center" class="DESCRIPTORnavy"><%=trim(RS.FIELDS(I).name)%></td>
	    <%next%>	
    </tr>
    <%end if %>
 
<%loop%>
</table>
</body>
</html>
