<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>

<!--#include file="./includes/Cnn.inc"-->
<%Session.CodePage="850" %>

        <%	
        
            usr=request.QueryString("usr")
            cad="select USUARIO,a.CIA,NOMBRE from [USR-CIA] as a inner join VIEW_CIAS as b on a.cia=b.CIA collate Modern_Spanish_CI_AS  where USUARIO='"+usr+"'"
            'response.Write(cad)
            RS.Open CAD, Cnn
        %>
    <%		LIMITE =  rs.fields.count - 1	
                CONT=1
            %>
        <table id="TABLA" align="center"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" >
        <tr  bgcolor=#294052  >
        
        <%for I=0 to LIMITE %>
	        <td align="center" style="color:#fff;padding:5PX 5PX" class="Estilo8">
		        <%=RS.FIELDS(I).NAME%>
	        </td>
        <%next%>	
        </tr>

        <% DO WHILE NOT RS.EOF%>
		<tr bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>">

            <td><%=RS(0) %></td>
            <td><%=RS(1) %></td>
            <td><%=RS(2) %></td>
            


		</tr>
	    <%RS.MOVENEXT %>
        <%CONT = CONT + 1%>
        <%LOOP %>

	
    </table>
    