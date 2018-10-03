<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%%>
<!--#include file="includes/Cnn.inc"-->
<%	usr     = Request.Cookies("multi")("USR")
nombre  = Request.Cookies("multi")("usrname")
cia     = Request.Cookies("multi")("cia")
cianame = Request.Cookies("multi")("cianame")


if request.querystring("pos") = undefined then
	pos = 0
else
	pos = request.querystring("pos")
end if
items=10
menus = "select top("&items&") MENU,DESMENU from multi.dbo.menu where MENU > "&pos


'Response.Write(menus)
rs.open menus,cnn

%>

<!doctype html>
<html lang="es">
<head>
<meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
   <meta http-equiv="X-UA-Compatible" content="ie=edge">
   <title>Menus</title>
    <style>
        table{
            width: 300px;font-family: sans-serif;text-align: center;
        }
    </style>
    <script src="./includes/jquery.js"></script>
</head>
<body id="bb">
    <table align="center"  id="TABLA" name="TABLA">
        <tr><td colspan="2" style="background: #294052;color:#fff;font-size: 10px;padding:0px;"><h1>Mantenimiento de Menu</h1></td></tr>
        <tr>
            <td style="background:#294052;color:#fff;font-size:08px"><h2>Menu</h2></td>
            <td style="background:#294052;color:#fff;font-size:08px"><h2>Descripcion</h2></td>
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
                <td><%=rs(0) %></td>
                <td><%=rs(1) %></td>
            </tr>
            <% i=i+1 %>
        <%rs.MOVENEXT%>
        <%LOOP%>
        <% end if %>

    </table>
    <table align="center">
        <tr>
            
            <td><img style="cursor:pointer" alt="NUEVO"  title="NUEVO" onclick="nuevo()" src="/multi/images/new.png"/></td>
            <td><img style="cursor:pointer" alt="primero"  title="primero" onclick="primero()" src="/multi/images/primera.png"/></td>
            <td><img style="cursor:pointer" alt="ATRAS"  title="ATRAS" onclick="atras()" src="/multi/images/prev.png"/></td>
            <td><img style="cursor:pointer" alt="ADELANTE"  title="ADELANTE" onclick="adelante()" src="/multi/images/next.png"/></td>
            <td><img style="cursor:pointer" alt="siguiente"  title="siguiente" onclick="siguiente()" src="/multi/images/last.png"/></td>
        </tr>
    </table>
    <form name="thisForm" name="thisForm">
        <table align="center" style="background:#EC781C">
            <tr>
                <td style="color:#fff">CODIGO</td>
                <td><input type="type" id="COD" name="COD" value="" /></td>
            </tr>
            <tr>
                <td style="color:#fff">Descripcion</td>
                <td><input type="type" id="DES" name="DES" value="" /></td>
            </tr>
            
        </table>
        <table  align="center">
            <tr>
                <td >
                    <img style="cursor:pointer;width:32px;height:32px" alt="GUARDAR"  title="GUARDAR" onclick="guardar()" src="/multi/images/go1.png"/>
                    </td>
                <td >
                    <img style="cursor:pointer;width:32px;height:32px"  onclick="del()" src="/multi/images/del.png"/>
                    </td>
                
            </tr>
        </table>
    </form>
    <iframe src="" id="miiframe" style="display:none"></iframe>
    <script>
        
        var oldrow=0;
         $(document).ready(function(){
             dd(oldrow);
         });
        function dd(ff) 
        {	
            var pos = parseInt(ff,10);
	        var t = $("#TABLA")[0];
	        if ((oldrow%2) ==0){
                $("#fila"+oldrow).css("backgroundColor",'<%=(Application("color2"))%>')
            }
	        else{
		        $("#fila"+oldrow).css("backgroundColor",'<%=(Application("color1"))%>')
            }
            $("#fila"+ff).css("backgroundColor",'<%=(Application("barra"))%>')
	        $("#COD").val($.trim(t.rows[pos+2].cells[0].innerText ));
	        $("#DES").val($.trim(t.rows[pos+2].cells[1].innerText));
	        $("#COD").attr("readonly","true")
            $("#DES").removeAttr("readonly")
            $("#eliminar").css("display","block")
	        oldrow=pos

            
	        return true;
        }
        function adelante(){
            if(oldrow+1 < <%=i %>){
                dd(oldrow+1);
            }
        }
        function atras(){
            if(oldrow > 0){
                dd(oldrow-1);
            }
        }
        function nuevo(){
            $("#COD").attr("readonly","true");
            $("#COD").val("AUTO");
            $("#DES").val("");
            $("#DES").removeAttr("readonly");
            $("#eliminar").css("display","none")
            $("#DES").focus();
        }
        function guardar(){
            var cod=$("#COD").val();
            var des=$("#DES").val();
            $("#miiframe")[0].src=("/multi/comun/inserMENU.asp?cod="+cod+"&des="+des);
        }
        function recargar(){
            this.location.reload();
        }
        function del(){
            var cod=$("#COD").val();
            $("#miiframe")[0].src=("/multi/comun/delMENU.asp?cod="+cod);
        }
        function siguiente(){
            this.location.replace("/multi/menus.asp?pos=<%=pos+items%>");
        }
        function primero(){
            this.location.replace('/multi/menus.asp?pos=<%=pos-items%>')
        }
        dd(oldrow);

    </script>
</body>
</html>
