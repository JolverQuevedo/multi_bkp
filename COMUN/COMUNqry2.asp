<body>

<script ID="clientEventHandlersJS" LANGUAGE="javascript">
var pagesize = '<%=pagesize%>';
var oldrow = 1;
function dd(ff, op) 
{	var pos = parseInt(ff,10)
	var t = document.all.TABLA;
	if ((oldrow%2) ==0)
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
	else
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");
	// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
	eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("BARRA"))%>'");
    llena(t, pos);
	oldrow=pos
	return true;
}
function llena()
{
//return true
}



</script>
