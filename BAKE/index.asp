<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MULTI-Tasks</title>
</head>
<link href="multisty.css" rel="stylesheet" type="text/css">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<script type="text/jscript" language="jscript">
function calcHeight() {
    //find the height of the internal page
    var the_height = document.getElementById('body0').contentWindow.document.body.scrollHeight;

//alert(Right(document.getElementById('body0').src,6))


	if (Right(document.getElementById('body0').src,6) == 'oc.asp')
		    document.getElementById('body0').height = 500
	else			
    //change the height of the iframe
    document.getElementById('body0').height =the_height + 50;
    }
function AGRANDA() {
     document.getElementById('body0').height = 700
}
</script>

<body style="background-image:url(IMAGES/fondo.png)" >
<table border="0" align="center" width="100%">
<tr >
<td align="left" rowspan="2" width="5%"><img src="IMAGES/LOGO_CH.PNG" border="0" />
</td>
<td rowspan="2" align="center" >
<table id="TABLA" align="center"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="1"  cellspacing="2"  border="0" ><tr>
<td class="Estilo2">Empresa :&nbsp;<%=cianame%></td>
</tr>
</table>
</td>
<td align="right" width="5%" class="Estilo9">Usuario :&nbsp; </td>
<td align="right" class="Estilo9"><%=trim(nombre)%></td>
</tr>
<tr class="Estilo9" ><td align="right" >Fecha :&nbsp; </td>
<td align="right" class="Estilo9" width="5%"><%=formatdatetime(date(),2)%></td></tr>
</table>
<%cad = "select * from view_menu_usr where usuario = '"&usr&"'"  
rs.open cad,cnn
if rs.recordcount <= 0 then
    response.write ("Usuario no tiene opciones disponibles")
    response.End
end if
rs.movefirst
'response.write(cad)
'response.end
%>
<div id='cssmenu'>
<ul>
    <%do while not rs.eof %>  
           <%men = rs("menu") 
           dmen = rs("desmenu")
           SUBM= RS("DESCRIPCION")
           prg = rs("programa")%>
        <%rs.movenext %>
        <%if rs.eof OR MEN<> RS("MENU")then %>
            <li class='has-sub'><a  href="javascript:opciones('blanco.htm')"><span><%=dmen%></span></a>
                <ul><li><a  href="javascript:opciones('<%=prg%>')"><span><%=SUBM%></span></a></li></ul>
            </li>
  
        <%else%>
            <li class='has-sub'><a href="javascript:opciones('blanco.htm')"><span><%=DMEN%></span></a>
            <ul>
                <li><a  href="javascript:opciones('<%=prg %>')"><span><%=SUBM%></span></a></li>
                <%do while not rs.eof and men = rs("menu")%>
                    <li><a  href="javascript:opciones('<%=rs("programa")%>')"><span><%=rs("DESCRIPCION")%></span></a></li>
                <%rs.movenext %>
                <%IF RS.EOF THEN EXIT DO %>
                <%loop%>
        </ul>
           </li>
        <%END IF%>
    <%loop%>
 <!--   <ul>
      <li class='active'><a href='#'><span>inicio</span></a>
      <li class='has-sub'><a href='#'><span>Products</span></a>
         <ul>
            <li><a href='#'><span>Product 1</span></a></li>
            <li><a href='#'><span>Product 2</span></a></li>
        </ul>
      </li>
       <li class='NO-has-sub'><a href='#'><span>About</span></a></li>
    </ul>
!-->
</ul>
</div>
<script language="jscript" type="text/jscript">
    function opciones(prg) {
        document.getElementById('body0').src = prg
    }
</script>
<iframe src="blanco.htm" width="100%" name="body0" id="body0" onLoad="calcHeight();" frameborder="0" heigth="700px">

</iframe>



</body>

<!--</noframes>
!-->
</html>
