<%@  language="VBScript" %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="includes/Cnn.inc"-->

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <style>
        table {
            width: 500px;
            font-family: sans-serif;
            text-align: center;
        }
    </style>
</head>

<body>
    <table align="center">
        <tr>
            <td colspan="2" style="background: #294052;color:#fff;font-size: 10px;padding:0px;">
                <h1>Mantenimiento de Submenus</h1>
            </td>
        </tr>
        <tr>
            <td style="display:block">
                <div id="contenedor-usuarios">
                    Cargando...
                </div>
                <div>
                    
                    <table align="center">
                        <tr>
                            
                            <td><img style="cursor:pointer" alt="NUEVO"  title="NUEVO" onclick="nuevo()" src="/multi/images/new.png"/></td>
                            <td><img style="cursor:pointer" alt="primero"  title="primero" onclick="primero()" src="/multi/images/primera.png"/></td>
                            <td><img style="cursor:pointer" alt="ATRAS"  title="ATRAS" onclick="atras()" src="/multi/images/prev.png"/></td>
                            <td><img style="cursor:pointer" alt="ADELANTE"  title="ADELANTE" onclick="adelante()" src="/multi/images/next.png"/></td>
                            <td><img style="cursor:pointer" alt="siguiente"  title="siguiente" onclick="siguiente()" src="/multi/images/last.png"/></td>
                        </tr>
                    </table>
                    <table align="center" style="background:#EC781C">
                            <tr>
                                <div ti></div>
                            </tr>
                            <tr>
                                <td style="color:#fff">Usuario</td>
                                <td><input type="type" id="COD" name="COD" maxlength="3" value="" /></td>
                            </tr>
                            <tr>
                                <td style="color:#fff">Clave</td>
                                <td><input type="type" id="DES" name="DES" value="" /></td>
                            </tr>
                            <tr>
                                    <td style="color:#fff">Nombre</td>
                                    <td><input type="type" id="NOMBRE" name="NOMBRE" value="" /></td>
                            </tr>
                            <tr>
                                <td>
                                    <img src="/multi/images/ok.png" onclick="guardar()" alt="guardar">
                                </td>
                                <td>
                                    <img src="/multi/images/del.png" onclick="del()" alt="guardar">
                                </td>
                            </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    <iframe  frameborder="0" id="miiframe" style="display:none"></iframe>
</body>
<script src="./includes/jquery.js"></script>
<script>
    var oldrow = 0;
    var estado="A";
    $(document).ready(function () {
        getUsuarios();
    });
    function getUsuarios(){
        $("#contenedor-usuarios").html("Cargando...");
        $.ajax({
            url:'buscausuarios.asp',
            data:'',
            cache:false,
            success:function(res){
                $("#contenedor-usuarios").html(res)
                dd(1);
            }
        });
    }
    function dd(ff) 
        {	
            estado="A";
            var pos = parseInt(ff,10);
	        var t = $("#TABLA")[0];
	        if ((oldrow%2) ==0){
                $("#fila"+oldrow).css("backgroundColor",'<%=(Application("color2"))%>')
            }
	        else{
		        $("#fila"+oldrow).css("backgroundColor",'<%=(Application("color1"))%>')
            }
            $("#fila"+ff).css("backgroundColor",'<%=(Application("barra"))%>')
	        $("#COD").val($.trim(t.rows[pos].cells[0].innerText ));
	        $("#DES").val($.trim(t.rows[pos].cells[1].innerText));
            $("#NOMBRE").val($.trim(t.rows[pos].cells[2].innerText));
	        $("#COD").attr("readonly","true")
            $("#DES").removeAttr("readonly")
            $("#eliminar").css("display","block")
	        oldrow=pos

            
	        return true;
        }
        function adelante(){
            if(oldrow+1 < $("#TABLA")[0].rows.length){
                dd(oldrow+1);
            }
        }
        function atras(){
            if(oldrow > 1){
                dd(oldrow-1);
            }
        }
        function nuevo(){
            estado="I";
            $("#COD").removeAttr("readonly");
            $("#COD").val("");
            $("#DES").val("");
            $("#NOMBRE").val("");
            $("#DES").focus();
        }
        function guardar(){
            var cod=$("#COD").val();
            var des=$("#DES").val();
            var nom=$("#NOMBRE").val();
            $.ajax({
                url:"/multi/comun/usuariosope.asp",
                data:{ope:estado,cod:cod,des:des,nom:nom},
                success:function(data){
                    alert(data);
                    getUsuarios();
                }
            });
        }
        function recargar(){
            this.location.reload();
        }
        function del(){
            var cod=$("#COD").val();
            if(confirm("Deseas eliminar el usuario "+cod)){
                $("#miiframe")[0].src=("/multi/comun/usuariosope.asp?cod="+cod+"&ope=E");
            }
            
        }
        function siguiente(){
            var tamaño=$("#TABLA")[0].rows.length-1;
            var ultimo=$("#TABLA")[0].rows[tamaño].cells[0].innerText
            
                $.ajax({
                    url:'buscausuarios.asp',
                    data:{pos:ultimo},
                    cache:false,
                    success:function(res){
                        $("#contenedor-usuarios").html(res)
                        dd(1);
                    }
                });
        }
        function primero(){
            $.ajax({
                    url:'buscausuarios.asp',
                    data:{pos:""},
                    cache:false,
                    success:function(res){
                        $("#contenedor-usuarios").html(res)
                        dd(1);
                    }
            });
        }
        dd(oldrow);
</script>

</html>