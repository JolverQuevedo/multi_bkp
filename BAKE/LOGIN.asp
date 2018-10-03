<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MULTI-TASKS</title>
</head>
<link href="multisty.css" rel="stylesheet" type="text/css">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<body style="background-image:url(IMAGES/fondo.png)" onkeyup="veri()">
<%usr = request.Form("txtusr")
  pwd = request.Form("txtpwd")

 %>
 <script language="jscript" type="text/jscript">
     msg = '<%=trim(msg) %>'
     if (msg.length > 0)
         alert(msg)
 </script>

<form action="index.asp" method="post" target="_self" id="frmIngreso" name="frmIngreso" >

<table  border="0" cellspacing="0" cellpadding="1" align="center">
  <tr><td colspan="3" height="200px">&nbsp;</td>  </tr>
  <tr align="LEFT">
    <td colspan="3"><img src="IMAGES/HEAD_LOGIN.PNG" border="0" /></td>
  </tr>
  <tr><td colspan="3" height="5 px"></td>  </tr>
  <tr>
    <td align="right" class="LOG_LABEL" width="100px">Usuario : &nbsp;</td>
    <td width="80px"><input type="text" class="INPUTS" id="txtusr" name="txtusr" maxlength="4" onblur="usuario()"  value='<%=request.form("txtusr") %>'/></td>
    <td id="nombre" name="nombre" style="width:290px"><input id="user" name="user" class="data" tabindex="-1" readonly/></td>
  </tr>
  <tr><td colspan="3" height="2px"></td>  </tr>
  <tr>
    <td align="right" class="LOG_LABEL">Password : &nbsp;</td>
    <td><input type="password" class="INPUTS" id="txtpwd" name="txtpwd" maxlength="10" onchange="valida()" value='<%=request.form("txtpwd") %>'/></td>
    <td><input  id="oks" name="oks" class="data" tabindex="-1" readonly/></td>
  </tr>
  <tr><td colspan="3" height="2px"></td>  </tr>
  <tr>
    <td align="right" class="LOG_LABEL">Empresa : &nbsp;</td>
    <td colspan="2"><select id="DESCIA" name="DESCIA" class="datos"  style="width:370px" />
                <option></option>
	        </select></td>
  </tr>
  <tr><td colspan="3" align="center" ><img src="IMAGES/LOG1.png" border="0" onclick="login()" onmouseover="this.src='images/log2.png'" onmouseout="this.src='images/log1.png'" style="cursor:pointer"/></td></tr>
</table>
</form>

<iframe  width="100%"  style="display:none" src="" id="body0" name="body0"  scrolling="yes" frameborder="0" height="200" align="middle"></iframe>

<script type="text/jscript" language="jscript">
    document.getElementById("txtusr").value=''
    document.getElementById("txtpwd").value = ''
    document.getElementById("txtusr").focus()

    function veri() {
        if (event.keyCode == 13)
            login()
    }

function login() {

    if (usuario() == true) {
        if (trim(document.all.frmIngreso.user.value) == '') {
            alert("Usuario no existe")
            document.all.frmIngreso.txtusr.focus()
            return false;
        }
        if (trim(document.all.frmIngreso.txtpwd.value) == '') {
            alert("Ingrese su clave")
            document.all.frmIngreso.txtpwd.focus()
            return false;
        }
        valida()
        if (trim(document.all.frmIngreso.oks.value) == 'PWD INCORRECTO') {
            alert("Revisar sus datos")
            document.all.frmIngreso.txtpwd.focus()
           return false;         
        }
    
        if (document.all.frmIngreso.DESCIA.selectedIndex <= 0) {
            alert("Seleccionar Empresa")
            document.all.frmIngreso.DESCIA.focus()
            return false;
        }
        if (trim(document.all.frmIngreso.oks.value) == 'OK' && document.all.frmIngreso.DESCIA.selectedIndex > 0) {
            cad = 'bake/bake_cookies.asp?us=' + document.getElementById("txtusr").value + '&pw=' + document.getElementById("txtpwd").value
            cad += '&cia=' + document.getElementById("DESCIA").value
            // document.all.body0.style.display = 'block'
            document.all.body0.src = cad
            var opc  = "menubar=no,left=0,top=0,height=6,width=1" ;
            window.open(cad,'',opc)
            window.location.replace('index.asp')
            return true;
        }
    }

}


function valida() {
    var _pwd = trim(document.all.frmIngreso.txtpwd.value)
    cad = 'bake/bake_PWD.asp?us=' + document.getElementById("txtusr").value + '&pw=' + document.getElementById("txtpwd").value 
   // document.all.body0.style.display = 'block'
    document.all.body0.src = cad
    return true;
}



function usuario() {
    var _user = trim(document.all.frmIngreso.txtusr.value)

    if (_user.length == 0) {
        alert("Debe ingresar su Usuario")
        //document.all.button1.style.display='none'
        document.getElementById("txtusr").focus()
        return false
    }
    else {
        cad = 'bake/bake_USR_CIA.asp?pos=' + document.getElementById("txtusr").value + '&sele=' + 'DESCIA'
        // document.all.body0.style.display = 'block'
        document.all.body0.src = cad
        return true;
    }
    return false;
}
</script>
</body>
</html>
