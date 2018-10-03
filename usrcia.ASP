<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="includes/Cnn.inc"-->
<%
CAD ="select USUARIO,NOMBRES from usuarios"
RS.Open CAD, Cnn
CONT = 1
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.ActiveConnection = Cnn
	
	RS2.CursorType       = 3 
	RS2.LockType         = 1
	RS2.CursorLocation   = 3 


IF NOT RS.EOF OR NOT RS.BOF THEN	RS.MOVEFIRST
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        table{
            width: 600px;font-family: sans-serif;text-align: center;
        }
    </style>
    <script src="includes/jquery.js"></script>
</head>
<body>
        <table  bgcolor='<%=(Application("color1"))%>' align="center" width="70%">
                <tr>
                    <td colspan="2" style="background: #294052;color:#fff;font-size: 10px;padding:0px;">
                        <h1>Mantenimiento de Cias por Usuario</h1>
                    </td>
                </tr>
                <tr>
                    <td class="Estilo8"}>Seleccione Usuario</td>
                    <td>
                        <select id="MENU" class="DATOSGRANDE"  onChange="cambia()">
                            <option value="NULL"></option>
                            <% DO WHILE NOT RS.EOF%>
                            <option value='<%=RS("usuario") %>'><%=RS("usuario")%>-<%=RS("nombres") %></option>
                            <%RS.MOVENEXT %>
                            <%LOOP %>
                        </select> 
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div id="contenedor-cias"></div>
                        <table align="center" style="background:#EC781C">
                            <tr>
                                <td style="color:#fff">CODIGO</td>
                                <td><input  style="width:150px;padding:0;margin:0;" type="type" id="COD" name="COD" value="" /></td>
                            </tr>
                            <tr>
                                <td  style="color:#fff">Descripcion</td>
                                <% 
                                    kd="select * from multi.dbo.VIEW_CIAS" 
                                    rs2.open kd, cnn
                                %>
                                <td>
                                    <select style="width:150px;padding:0;margin:0;"  id="DES" class="DATOSGRANDE">
                                        <option value="NULL"></option>
                                        <% DO WHILE NOT RS2.EOF%>
                                            <option value='<%=RS2("CIA") %>'><%=RS2("nombre") %></option>
                                        <%RS2.MOVENEXT %>
                                        <%LOOP %>
                                    </select> 
                                </td>
                            </tr>
                            
                        </table>
                        <table  align="center">
                            <tr>
                                <td >
                                    <img style="cursor:pointer;width:32px;height:32px" alt="GUARDAR"  title="GUARDAR" onclick="nuevo()" src="/multi/images/new.png"/>
                                    <img style="cursor:pointer;width:32px;height:32px" alt="GUARDAR"  title="GUARDAR" onclick="guardar()" src="/multi/images/go1.png"/>
                                </td>
                                <td >
                                    <img style="cursor:pointer;width:32px;height:32px"  onclick="del()" src="/multi/images/del.png"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
        </table>
        <script>
            var menu=$('#MENU');
            var oldrow=0;
            function cambia(){
                $("#contenedor-cias").html("cargando...");
                $.ajax({
                    url:'/multi/buscausrcia.asp',
                    data:{usr:menu.val()},
                    cache:false,
                    success:function(data){
                        $("#contenedor-cias").html(data);
                        $("#COD").val($('#MENU').val());
                        $("#DES").val("");
                        
                    }
                });
            }
            function dd(ff) 
            {	
                var pos = parseInt(ff,10)
                var t = $("#TABLA")[0];
                if ((oldrow%2) == 0){
                    $("#fila"+oldrow).css("background-color","<%=(Application("color1"))%>");
                }
                else{
                    $("#fila"+oldrow).css("background-color","<%=(Application("color2"))%>");
                }
                $("#fila"+ff).css("background-color","<%=(Application("BARRA"))%>");
                $("#COD").val($.trim(t.rows[pos].cells[0].innerText ));
                $("#DES").val($.trim(t.rows[pos].cells[1].innerText ));
                $("#COD").attr("disabled","disabled");
                $("#DES").attr("disabled","disabled");
                oldrow=pos
                return true;
            }
            function nuevo(){
                $("#COD").removeAttr("disabled");
                $("#DES").removeAttr("disabled");
                $("#DES").val("");
            }
            function guardar(){
                $.ajax({
                    type: "get",
                    url: "/multi/comun/opeusrcia.asp",
                    data: {ope:"I",cod:$("#COD").val(),des:$("#DES").val()},
                    success: function (response) {
                        alert(response);
                        cambia()
                    }
                });
            }
            function del(){
                $.ajax({
                    type: "get",
                    url: "/multi/comun/opeusrcia.asp",
                    data: {ope:"E",cod:$("#COD").val(),des:$("#DES").val()},
                    success: function (response) {
                        alert(response);
                        cambia()
                    }
                });
            }
        </script>
</body>
</html>