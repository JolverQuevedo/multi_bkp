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



menus = "select MENU,DESMENU from multi.dbo.menu"
'Response.Write(menus)
rs.open menus,cnn



%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Submenus</title>
    <script src="./includes/jquery.js"></script>
    <style>
        table{
            width: 500px;font-family: sans-serif;text-align: center;
        }
        .cabecera{
             background: #294052;
             color:#fff;
             font-size:12px
        }

    </style>
    <script src="/multi/includes/jquery.js"></script>
</head>
<body>
    <table align="center" >
        <tr><td colspan="2" style="background: #294052;color:#fff;font-size: 10px;padding:0px;"><h1>Mantenimiento de Submenus</h1></td></tr>
            <tr class="cabecera">
                <td>
                    Menu
                </td>
                <td>
                    <select name="menu" id="menu">
                        <option value=""></option>
                        <% i=0 %>
                            <% if rs.recordcount > 0 then %>
                            
                            <%RS.MOVEFIRST%>
                                <%DO WHILE NOT rs.EOF%>
                                <option value="<%=rs(0) %>"><%=rs(1) %></option>
                                <% i=i+1 %>
                            <%rs.MOVENEXT%>
                                <%LOOP%>
                        <% end if %>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="padding:0;margin:0">
                    <div id="subcontent" style="padding:0;margin:0"></div>
                    <table align="center">
                        <tr>
                            
                            <td><img style="cursor:pointer" alt="NUEVO"  title="NUEVO" onclick="nuevo()" src="/multi/images/new.png"/></td>
                            <td><img style="cursor:pointer" alt="ATRAS"  title="ATRAS" onclick="atras()" src="/multi/images/prev.png"/></td>
                            <td><img style="cursor:pointer" alt="ADELANTE"  title="ADELANTE" onclick="adelante()" src="/multi/images/next.png"/></td>
                        </tr>
                    </table>
                    <table align="center" style="background:#EC781C">
                        <tr>
                            <td style="color:#fff">CODIGO</td>
                            <td><input type="type"  style="width: 90%" id="COD" name="COD" value="" disabled /></td>
                        </tr>
                        <tr>
                            <td style="color:#fff">Descripcion</td>
                            <td><input type="type"  style="width: 90%" id="DES" name="DES" value="" /></td>
                        </tr>
                        <tr>
                            <td style="color:#fff">Programa</td>
                            <td><input type="type"  style="width: 90%" id="PRG" name="PRG" value="" /></td>
                        </tr>
                        <tr>
                            <td style="color:#fff">Estado</td>
                            <td>
                                <select name="EST" id="EST" style="width: 90%">
                                    <option value="A">Activo</option>
                                    <option value="E">Eliminado</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <img style="cursor:pointer" alt="GRABA"  title="GRABA" onclick="graba()" src="/multi/images/ok.png"/>  
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
    </table>
    <script>
        var oldrow=-1
        $(document).ready(function(){
            var menu=$("#menu");
            menu.on("change",function(){
                getsubmenu(menu.val());
            });
        });
         function getsubmenu(menu){
            $.ajax({
                type: "get",
                url: "/multi/comun/buscasubmenu.asp?menu="+menu,
                cache:false,
                success: function (response) {
                    $("#subcontent").html(response);
                    $("#COD").val("");
                    $("#DES").val("");
                    $("#PRG").val("");
                    dd(oldrow);
                       
                }
            });
        }
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
	        $("#COD").val($.trim(t.rows[pos+1].cells[0].innerText ));
	        $("#DES").val($.trim(t.rows[pos+1].cells[1].innerText));
            $("#PRG").val($.trim(t.rows[pos+1].cells[2].innerText));

            var estado = $.trim($("#TABLA")[0].rows[pos+1].cells[3].innerText.toUpperCase())
            $("#EST").val(estado);
	        $("#COD").attr("readonly","true")
            $("#DES").removeAttr("readonly")
            $("#eliminar").css("display","block")
	        oldrow=pos

            
	        return true;
        }
        function adelante(){
            if(oldrow+1 < $("#TABLA")[0].rows.length-1){
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
            $("#PRG").val("");
            $("#DES").removeAttr("readonly");
            $("#eliminar").css("display","none")
            $("#DES").focus();
        }
        function graba(){
            var menu=$("#menu").val();
            var cod=$("#COD").val();
            var des=$("#DES").val();
            var prg=$("#PRG").val();
            var est=$("#EST").val();
            if(valida(menu,cod,des,prg,est)){
                var cad="/multi/comun/opesubmenu.asp?";
                cad+="menu="+menu;
                cad+="&COD="+cod;
                cad+="&DESC="+des;
                cad+="&PROG="+prg;
                cad+="&EST="+est;
                $.ajax({
                    url:cad,
                    success:function(res){
                        console.log(res);
                        getsubmenu($("#menu").val())
                    }
                })
            }
            

        }
        function valida(menu,cod,des,prg,est){
            if(menu == ""||cod == ""||des == ""||prg == ""||est == ""){
                alert("rellena los datos correctamente");
                return false;
            }else{
                return true;
            }
            
        }
    </script>
</body>
</html>