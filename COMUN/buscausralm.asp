<%@  language="VBSCRIPT" codepage="65001" %>
<script>
var oldrow = 1
</script>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="./FUNCIONESCOMUNES.ASP"-->
<%Session.CodePage="850" %>
<%Dim pageSize 
pageSize = 6
'****************************************
' Definir el NOMBRE de la Tabla base
'****************************************
Dim ALIAS
alias = "calma"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = "calma"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
'*********************************************
Dim pos
pos=""
Dim urlBase
urlBase = "buscausralm.asp"
%><form name="thisForm" method="post">
    <html>

    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <script>
        

        </script>
        <style>
        </style>
    </head>
    <body>

        <%	
            
            usr=request.QueryString("usr")
            cia=request.QueryString("cia")
            tabla=request.QueryString("tabla")
            pos=request.QueryString("pos")
            cad="select top "&pagesize&" * from "+tabla+" where CUSUARIO='"+usr+"' and "&indice&" >= '"& POS &"' ORDER BY "& indice &""
            response.Write(cad)
			
			response.Write("</br>"+cia)
            RS.Open CAD, Cnn
        %>
        <%		LIMITE =  rs.fields.count - 1	
                CONT=1
        %>
        <table id="TABLA" align="center" 
            bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>" cellpadding="2" cellspacing="1" border="1">
            <tr bgcolor="#294052">

                <%for I=0 to LIMITE %>
                <td align="center" style="color: #fff; padding: 5PX 5PX" class="Estilo8">
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



            </tr>
            <%RS.MOVENEXT %>
            <%CONT = CONT + 1%>
            <%LOOP %>
        </table>
        <table border="0" align="center" cellspacing="5">
            <tr>
                <td>
                    <img src="../images/primera.png" style="cursor: pointer;" onclick="primera()" alt="PRIMERA PAGINA">
                </td>
                <td>
                    <img src="../IMAGES/PREV.png" alt="PAGINA ANTERIOR" onclick="atrasss()" style="cursor: pointer;">
                </td>
                <td>
                    <img src="../images/up.png" alt="REGISTRO ANTERIOR" onclick="retrocede()" style="cursor: pointer;">
                </td>
                <td>
                    <img src="../images/down.png" alt="REGISTRO SIGUIENTE" onclick="avanza()" style="cursor: pointer;">
                </td>
                <td>
                    <img src="../images/next.png" alt="PAGINA SIGUIENTE" onclick="pagina()" style="cursor: pointer;">
                </td>
                <td>
                    <img src="../images/last.png" alt="ULTIMA PAGINA" onclick="ultima()" style="cursor: pointer;">
                </td>
                <td>
                    <img src="../images/PRINT.PNG" alt="IMPRESION" onclick="imprime()" style="cursor: pointer;">
                </td>
                <td>
                    <img src="../images/lupa.PNG" alt="Busca" onclick="document.all.seeker.style.display='block'" style="cursor: pointer;">
                </td>
                <td id="seeker" name="seeker" style="display: none">
                    <table align="center" width="100%" bordercolor="#FFFFFF" bgcolor="lightgrey" cellpadding="0" cellspacing="1" border="1">
                        <tr>
                            <td bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>Usuario</b></font></td>
                            <td>
                                <input id="cd" name="cd" value="" />
                            </td>
                        </tr>
                        <tr>
                            <td bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>Nombre</b></font></td>
                            <td>
                                <input id="ds" name="ds" value="" />
                            </td>
                        </tr>
                        <tr>
                            <td bgcolor='<%=Application("COLOR2")%>' align="center" style="cursor: pointer" onclick="document.all.seeker.style.display='none'">
                                <font face="arial" color="red" size="1">
		    <b><u>(X) Cerrar</u></b></font></td>
                            <td bgcolor='<%=Application("COLOR2")%>' align="CENTER" style="cursor: pointer" onclick="BUSCA('<%=urlBase%>','<%=alias%>')">
                                <font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><U>FILTRAR</U></b></font></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>


        <table width="100%" border="0" id="DATAENTRY" name="DATAENTRY" style="display: block;">
            <tr>
                <td>
                    <table align="center" cellpadding="2" cellspacing="1" bgcolor='<%=(Application("color1"))%>' border="1">
                        <tr valign="middle">
                            <td width="10%" class="Estilo8" align="right">Usuario: 
                            </td>
                            <td bgcolor="WHITE" width="20%" valign="middle">
                                <input type="text" id="COD" name="COD" style="width: 100%" valign="middle" tabindex="-1" maxlength="4">
                            </td>

                            <td width="10%" class="Estilo8" align="right">Empresa:
                            </td>
                            <td bgcolor="WHITE">
                                <select id="DES" name="DES">
                                    <% CIAS = "Select A1_CALMA AS CALMA From RSFACCAR..AL"+cia+"ALMA" %>

                                    <% 
                        Rs.close
                        RS.Open CIAS, Cnn
                        
                        DO WHILE NOT RS.EOF%>
                                    <option value='<%=RS(0) %>'><%=RS(0) %></option>
                                    <%RS.MOVENEXT %>
                                    <%LOOP %>
                                </select>
                            </td>
                        </tr>
                    </table>

                    <table border="0" align="center" cellspacing="3">
                        <tr>
                            <td>
                                <img src="../images/NEW.png" alt="REGISTRO EN BLANCO" onclick="NUEVO_onclick();document.getElementById('DES').focus();" style="cursor: pointer;">
                            </td>
                            <td>
                                <img src="../images/ok.png" alt="GRABAR" onclick="grab()" style="cursor: pointer;">
                            </td>
                            <td>
                                <img src="../images/DEL.png" alt="ELIMIAR REGISTRO"
                                    onclick="elimina(document.getElementById('COD').value)" style="cursor: pointer;">
                            </td>
                        </tr>
                    </table>
                    <iframe src="" id="miiframe" style="width: 500px; height: 500px;display:none"></iframe>

                    <script>
        var auto=0;
        thisForm.COD.value = "<%=usr%>";
var oldrow = 1
var olddata = ''
        function dd2(ff) {
            var t = document.all.TABLA;
            var pos = parseInt(ff);
            dd(ff);
        }
        function dd(ff) 
        {	var pos = parseInt(ff,10)
	        var t = document.all.TABLA;
            
	        if ((oldrow % 2) == 1){
		        eval("document.all.fila" + oldrow + ".style.backgroundColor='#FFFFFF'");
            }
	        else{
		        eval("document.all.fila" + oldrow + ".style.backgroundColor='#dbe3cd'");
            }
	        eval("document.all.fila"+ff+".style.backgroundColor='#FFC9AE'");
	        
	        thisForm.COD.value = "<%=usr%>";
            
	        thisForm.DES.value=t.rows(pos).cells(1).innerText;
	        thisForm.DES.value=t.rows(pos).cells(0).innerText;

	        thisForm.COD.readOnly= false   ;
            thisForm.DES.readOnly= false;



            nuevo = 0;
	        oldrow = pos;
            
           


	        return true;
        }
        function NUEVO_onclick(){
        thisForm.COD.value="<%=usr%>";
	        thisForm.DES.value = "" ;
	        desantiguo = "" ;
        }
        function elimina( val ){
            var cod=document.getElementById('COD').value;
            var des=document.getElementById('DES').value;
            var tbl="<%=tabla%>"
            cad="http://intranet/multi/comun/opeusralm.asp?ope=E&cod="+cod+"&des="+des+"&tbl="+tbl;
            document.getElementById('miiframe').src=cad;
            
            
        }
        
        function grab(){
            var cod=document.getElementById('COD').value;
            var des=document.getElementById('DES').value;
            var tbl="<%=tabla%>"
            cad="http://intranet/multi/comun/opeusralm.asp?ope=I&cod="+cod+"&des="+des+"&tbl="+tbl+"&cia=<%=cia%>";
            
             alert(cad);
            document.getElementById('miiframe').src=cad;
        }
        function retrocede() 
{	var t = document.all.TABLA;
	var ff = 1;
	if (oldrow>1)
		dd(oldrow-1)
    else 
        dd(1)    ;
}

function avanza() 
{	var t = document.all.TABLA;
	var ff = 1;
	
  var max 
  ff =oldrow  + 1
  max =  t.rows.length -1;
  if (ff <= max)
   {dd(ff); }
}

        function imprime()
        {	cad = '../REPORTES/prnTBL.asp?tbl=' +TBL

	        document.getElementById('miiframe').src=cad;
        }
	
        dd2('1');
		function pagina() 
{	var t = document.all.TABLA;
	var i = t.rows.length -1;
	// captura el valor del último código mostrado en el GRID
	var cad = trim(t.rows(i).cells(0).innerText);
	var pag = "./buscausralm.asp?usr=<%=usr%>&tabla=<%=tabla%>&cia=<%=cia%>&pos="
	var cad2=pag +cad;
	alert(cad);
	window.location.replace( cad2)	;
}
function primera() 
{//	window.location.replace(pag  + pag2)	;
}
function atrasss() 
{	
	<%
		kkk="SELECT top 1 calma as ultimo from "+tabla+" where calma <= '"&pos&"' and CUSUARIO='"&usr&"'  order by calma asc"
		'response.write(kkk)
		dim ult
		Rs.close
        RS.Open kkk, Cnn
		DO WHILE NOT RS.EOF	
		RS.MOVENEXT
			ult=RS(0)
        LOOP 
		
	%>
	var t = document.all.TABLA;
	var cad = trim(t.rows(1).cells(0).innerText);
	var pag = "./buscausralm.asp?usr=<%=usr%>&tabla=<%=tabla%>&cia=<%=cia%>&pos=<%=ult%>"
	var cad2=pag +cad;
	alert(cad);
	window.location.replace( cad2)	;
}
                    </script>
    </body>
    </html>
</form>
