<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../includes/Cnn.inc"-->


        <%	
            
            menu=request.QueryString("menu")
            usr=request.QueryString("usr")
            cad="SELECT DISTINCT T1.SUBMENU AS ID, T1.DESCRIPCION, PERFIL = (SELECT PERFIL FROM [USR-OPC] T3 WHERE USUARIO = '"+usr+"' AND T3.MENU=T1.MENU AND T3.SUBMENU = T1.SUBMENU),t1.MENU,t1.SUBMENU  FROM SUBMENU T1, [USR-OPC] T2 WHERE (T1.MENU = '"+menu+"') ORDER BY 1 "
            'response.Write(cad)
            RS.Open CAD, Cnn
        %>
    <%		LIMITE =  rs.fields.count - 1	
                CONT=1
            %>
        <table id="TABLA" cellspacing="0" cellpadding="0" align="center"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" >
        <tr  bgcolor=#294052  >
        
        <%for I=0 to LIMITE-2 %>
	        <td align="center" style="color:#fff;padding:5PX 5PX" class="Estilo8">
		        <%=RS.FIELDS(I).NAME%>
	        </td>
        <%next%>	
        </tr>

        <% DO WHILE NOT RS.EOF%>
		<tr bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color2"))
                else
	            response.write(Application("color1"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>">

            <td><%=RS(0) %></td>
            <td><%=RS(1) %></td>
            <td>
                
                <SELECT id="PER<%=cont%>" class=datos onchange="cambiaestado('<%=usr%>','<%=RS(3)%>','<%=RS(4)%>',this.value)"> 
                    <OPTION value=0 <%if 0=RS(2) then  %>selected<% end if %>></OPTION>
                    <OPTION value=1 <%if 1=RS(2) then  %>selected<% end if %>>UPDATER</OPTION>
                    <OPTION value=2 <%if 2=RS(2) then  %>selected<% end if %>>READONLY</OPTION>
                    <OPTION value=3 <%if 3=RS(2) then  %>selected<% end if %>>WEB</OPTION>
                </SELECT>
            </td>
            


		</tr>
	    <%RS.MOVENEXT %>
        <%CONT = CONT + 1%>
        <%LOOP %>

        </table>