<!--#include file="../includes/Cnn.inc"-->
<%
    usuario = request.querystring("usuario")
    menu    = request.querystring("menu")
    submenu = request.querystring("submenu")
    perfil  = request.querystring("perfil")
	cad ="exec sp_insert_update_usropc '"+usuario+"','"+menu+"','"+submenu+"','"+perfil+"'"
    'response.write(cad)
    cnn.execute(cad)
%>
se registro correctamente
