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

<script language="jscript" type="text/jscript">
    oldrow = 1
   
</script>

<%
PO  = Request.QueryString("po")
cli = Request.QueryString("cli")
EST = Request.QueryString("ECL")
MOV = Request.QueryString("MOV")
SER = Request.QueryString("SER")

    CAD =   " SELECT id, MOV, ESTCLI,PO, COLOR, DESSER,RUC,NOMPRO,  " & _
	        " GUIA, (C0+C1+C2+C3+C4+C5+C6+C7+C8+C9) AS TOTAL        " & _
	        " FROM view_pos_movi WHERE CODCLI= '"&cli&"'            " & _
            " and estcli ='"&EST&"' and po ='"&PO&"'                " & _
            " and mov ='"&MOV&"' and codser  ='"&SER&"'             " & _
            " ORDER BY color, guia, id ;                                    "

    'response.Write(cad)
    rs.open cad,cnn
	CONT = 1
    'RESPONSE.WRITE(RS.RECORDCOUNT)

	IF rs.recordcount > 0 THEN	RS.MOVEFIRST
    
' Nro de columnas regresadas por el objeto RECORDSET	
columnas = RS.Fields.Count%>

<title>Detalle OC <%=oc%></title>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
 <style type="text/css">
     .style1
     {
         font-family: Tahoma;
         font-size: 12px;
         color: #ffffff;
         font-weight: 300;
         background-color: #294052;
         width: 46px;
     }
     .style2
     {
         font-family: Tahoma;
         font-size: 12px;
         color: #ffffff;
         font-weight: 300;
         background-color: #294052;
         width: 60px;
     }
     .style4
     {
         width: 60px;
     }
     .style5
     {
         font-family: Tahoma;
         font-size: 12px;
         color: #ffffff;
         font-weight: 300;
         background-color: #294052;
         width: 48px;
     }
     .style6
     {
         width: 64px;
     }
 </style>
<HTML>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body style="margin-top:0; margin-left:0; margin-right:0;" >

        <table id="TABLA" align="left"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" width="100%">
        <%'**************************%>
        <%'LINEA DE CABECERA STANDAR %>
        <%'**************************%>
        <%LIMITE =  RS.fields.count - 1	%>
        <tr bgcolor=#006699 >
            <%for I=0 to rs.fields.count-1 %>
	            <td align="center" class="Estilo8"><%=RS.FIELDS(I).NAME%></td>
            <%next%>	
        </tr>
        <%'IF  RS.EOF THEN response.end%>
        <%tot =  0 %>
        <%DO WHILE NOT RS.EOF%>
	        <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color2"))
                else
	            response.write(Application("color1"))
	            end IF%>"    >
	            <%FOR i=0 TO rs.fields.count -1%>
		            <td class="estilo5" align="center"><%=rs.fields.item(i) %></td>
	            <%NEXT%>
              
	        </tr>
            <%tot= tot + cdbl(rs.fields.item(9) ) %>
	        <%RS.MOVENEXT%>
	        <%CONT = CONT + 1%>
	        <%LOOP%>
        <tr bgcolor='navy' >
           <td class="Estilo8" colspan="9">Total</td>
           <td class="Estilo8" align="right" ><%=tot%></td>
        </tr>
        </table>

</BODY>
</HTML>
