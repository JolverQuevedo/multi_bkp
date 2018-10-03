<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<link href="../multisty.css" rel="stylesheet" type="text/css">
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<script type="text/jscript" language="jscript">


</script>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title></title>
</head>
<body>
PROCESANDO...
<script type="text/jscript" language="jscript">
var aData = new Array()
var aVal = new Array()
xx = 0
//alert(parent.window.thisForm.ser.options.length)

// se crea una variable llamada SELECT que captura el elemento del form que queremos llenar....
var select = parent.window.thisForm.ser
// borra los elementos PRE - existentes
select.options.length = 0;
// ARTIFICIO PARA QUE EL PRIMER ELEMENTO SE MUESTRE EN BLANCO
select.options[0] = new Option('','');
// POR EL ARTIFICIO ANTERIOR SE TIENE QUE RETROCEDER EL INDICE DE LOS ARRAYS CON LA DATA 
// Y QUEDA              P E R F E C T O O O O O O O ! ! ! ! 
</script>
<%	
sele	= Request.QueryString("sele")
alm 	= Request.QueryString("alm")
TBL1 = "AL_TiposMov" + CIA
TBL2 = "AL_TipoMovxAlmacen" + CIA
            'ALM = DOCUMENT.ALL.ALM.VALUE
        CAD =   " select  codtipomov AS COD, destipomov AS DESCRI from  "&TBL1&"  " & _
                " where codtipomov in(select codtipomov from "&TBL2&" where     " & _ 
                " codalmacen='"&ALM&"') order by 1 "
        
		RS.OPEN CAD, CNN
		RESPONSE.Write(cad)
		RESPONSE.Write("<br>")
		RESPONSE.Write(RS.RECORDCOUNT)
		'response.end
		if RS.RECORDCOUNT > 0 then%>
			<%rs.movefirst%>
            <%do while not rs.eof%>
                <script type="text/jscript" language="jscript">
					aData[xx]     = '<%=trim(rs("cod"))%>';
					aVal[xx++]    = '<%=trim(rs("descri"))%>';
                </script>
				<%=RS("cod")%>
            	<%RS.MOVENEXT%>
            <%loop%>
            <script type="text/jscript" language="jscript">
				 for(i=1; i <= xx; i++) 
				  	select.options[i] = new Option( aVal[i-1], aData[i-1]); 				  
             </script>	
		<%end if%>


	FIN
</body>
</html>