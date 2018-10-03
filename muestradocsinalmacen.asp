<!--#include file="includes/Cnn.inc"-->
<%        
ctd=Request.QueryString("ctd")
doc=Request.QueryString("doc")
cad =   " select C5_CALMA almacen,C5_CTD tipo_doc,C5_CNUMDOC num_doc,C5_DFECDOC fecha,C5_CCODMOV codigo_movimiento from RSFACCAR..AL0001movc where C5_CTD='"&ctd&"' and C5_CNUMDOC='"&doc&"'" 
response.write(cad)
rs.open cad,cnn
%>
<table id="TABLA" align="center" bordercolor="#FFFFFF" cellpadding="2" cellspacing="1" border="1">

  
            <tr bgcolor="#006699" style="color:#fff">
                <%		LIMITE =  rs.fields.count - 1	%>
                <%for I=0 to LIMITE %>
                <td align="center" class="Estilo8">
                    <%=RS.FIELDS(I).NAME%>
                </td>
                <%next%>
            </tr>
            <%IF NOT RS.EOF THEN%>
            <%DO WHILE NOT RS.EOF%>
            <tr ondblclick="pasaalm('<%=RS.FIELDS.ITEM(0)%>')">
                <%FOR i=0 TO LIMITE%>
					<td align="center" class="estilo5">
						<%=RS.FIELDS.ITEM(i)%>
					</td>
                <%NEXT%>
            </tr>
            <%RS.MOVENEXT%>
            <%LOOP%>
            <%rs.movelast%>
			<%END IF%>
        </table>
		<script>
			function pasaalm(a){
				window.opener.document.all.alm.value=a;
				window.opener.document.all.olvidealmacen.checked=false;
				window.close();
			}
		</script>