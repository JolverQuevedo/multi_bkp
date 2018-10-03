<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../includes/Cnn.inc"-->
<%Session.CodePage="850" %>
<% 
    menu = request.querystring("menu")
    cad = "select * from multi.dbo.submenu where menu="&menu&"" 
    rs.open cad,cnn
    %>
<table name="TABLA" id="TABLA">
    <tr class="cabecera">
        <td>ID</td>
        <td>Descripcion</td>
        <td>Programa</td>
        <td>Estado</td>
    </tr>

        <% i=0 %>
        <% if rs.recordcount > 0 then %>
        
        <%RS.MOVEFIRST%>
        <%DO WHILE NOT rs.EOF%>
            <tr onclick="dd(<%=i %>)" id="fila<%=i %>"  name="fila<%=i %>"  
                bgcolor="<% if i mod 2  = 0 THEN 
                response.write(Application("color2"))
                else
	            response.write(Application("color1"))
	            end IF%>">
                <td><%=rs(1) %></td>
                <td><%=rs(2) %></td>
                <td><%=rs(3) %></td>
                <td>
                    <%=rs(4)%>
                </td>
            </tr>
            <% i=i+1 %>
        <%rs.MOVENEXT%>
        <%LOOP%>
        <% end if %>

</table>