<%@  language="VBScript" %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Response.CodePage = 65001
    Response.CharSet = "UTF-8" %>
<!--#include file="includes/Cnn.inc"-->
<%	
    pos = request.querystring("pos")
    if pos = undefined THEN
        pos =""
    end if
    cad = "select top (10) * from  usuarios where usuario>='"&pos&"' order by 1"
    RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN	RS.MOVEFIRST%>
<table id="TABLA" align="center" bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>" cellpadding="2" cellspacing="1" border="1">

            <%'**************************%>
            <%'LINEA DE CABECERA STANDAR %>
            <%'**************************%>
            <tr bgcolor="#006699" style="color:#fff">
                <%		LIMITE =  rs.fields.count - 1	%>
                <%for I=0 to LIMITE %>
                <td align="center" class="Estilo8">
                    <%=RS.FIELDS(I).NAME%>
                </td>
                <%next%>
            </tr>
            <%'*****************************%>
            <%' MUESTRA EL GRID (2 COLORES) %>
            <%'*****************************%>
            <%IF NOT RS.EOF THEN%>
            <%DO WHILE NOT RS.EOF%>

            <tr bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color2"))
                else
	            response.write(Application("color1"))
	            end IF%>"
                onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>">

                <%FOR i=0 TO LIMITE%>
                <td align="center" class="estilo5">
                    <%=RS.FIELDS.ITEM(I)%>
                </td>
                <%NEXT%>
            </tr>
            <%RS.MOVENEXT%>
            <%CONT = CONT + 1%>
            <%LOOP%>
            <%rs.movelast%>
    </td>
  </tr>
        </table>
        <% end if%>