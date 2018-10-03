<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="includes/Cnn.inc"-->
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    
    CAD ="select USUARIO,NOMBRES from usuarios"
    RS.Open CAD, Cnn
    CONT = 1

    Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.ActiveConnection = Cnn
	
	RS2.CursorType       = 3 
	RS2.LockType         = 1
	RS2.CursorLocation   = 3 
    kAD ="select menu,desmenu from multi..menu"
    RS2.Open kAD, Cnn


    IF NOT RS.EOF OR NOT RS.BOF THEN	RS.MOVEFIRST
    %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=10">
    <title>Page Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="/multi/includes/jquery.js"></script>
    <style>
        table{
            width: 600px;font-family: sans-serif;text-align: center;
        }
    </style>
</head>
<body>
    <table style="width:400px" cellspacing="0" align="center">
            <tr>
                <td colspan="2" style="background: #294052;color:#fff;font-size: 10px;padding:0px;text-align:center">
                    <h1>Mantenimiento de Usuario por Operaciones</h1>
                </td>
            </tr>
            <tr style="background: #294052;color:#fff">
                <td>Seleccione el Usuario</td>
                <td colspan="1" style="padding:5px;">
                    <select id="USR" class="DATOSGRANDE" style="width:150px"  onChange="cambia()">
                            <option value="NULL"></option>
                            <% DO WHILE NOT RS.EOF%>
                            <option value='<%=RS("usuario") %>'><%=RS("usuario")%>-<%=RS("nombres") %></option>
                            <%RS.MOVENEXT %>
                            <%LOOP %>
                    </select> 
                </td>
            </tr>
            <tr style="background: #294052;color:#fff">
                <td>Seleccione el Menu</td>
                <td colspan="1" style="padding:5px;">
                    <select id="MENU" class="DATOSGRANDE" style="width:150px"  onChange="cambia()">
                            <option value="NULL"></option>
                            <% DO WHILE NOT RS2.EOF%>
                            <option value='<%=RS2("menu") %>'><%=RS2("desmenu") %></option>
                            <%RS2.MOVENEXT %>
                            <%LOOP %>
                    </select> 
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="content-usropc"></div>
                </td>
            </tr>
    </table>    
    <script>
        var oldrow=0;
        var usr=$("#USR");
        var menu=$("#MENU");
        function cambia(){
            $.ajax({
                type: "get",
                url: "/multi/comun/buscausropc.asp",
                data: {menu:menu.val(),usr:usr.val()},
                cache:false,
                success: function (r) {
                    $("#content-usropc").html(r);
                }
            });
        }
        function cambiaestado(usr,menu,submenu,valor){
            $.ajax({
                type: "get",
                url: "/multi/comun/opeusropc.asp",
                data: {
                    menu:menu,
                    usuario:usr,
                    submenu:submenu,
                    perfil:valor
                },
                cache:false,
                success: function (r) {
                    alert(r)
                    cambia();
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
	        oldrow=pos
	        return true;
        }
    </script>
</body>
</html>