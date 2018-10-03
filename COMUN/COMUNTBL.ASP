<body>
<script ID="clientEventHandlersJS" LANGUAGE="javascript">

var pag2 =  '&tbl=' + alias +'&l1=' + largo+ '&l2=' + largo2
var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900";
function GRABAR_onclick() 
{ var ok = VALIDA();
	//alert(VALIDA())
/*	document.all.ACTIV.style.visibility='visible'
	document.all.ACTIV.height="150"
	document.all.ACTIV.width="100%"
	*/
	var cad =  'pos=' + trim(thisForm.COD.value)  ;
		cad += '&des=' + Left(ltrim(thisForm.DES.value,largo2) ) ;
		cad += '&url=' + url
		cad += '&tbl=' + TBL
		cad += '&PK='  + PK
		cad += '&DS=' + DS
	    cad += '&chk=' + chk   
	    cad += '&L1=' + largo
        cad += '&l2=' + largo2
       // alert(cad)
	if (ok == true )
	{ 	document.all.ACTIV.src=(funcionalidad + cad); }
}

function elimina()
{	var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
    var cad =   'pos=' +trim(thisForm.COD.value)  ;
		cad += '&des=' + Left(thisForm.DES.value,largo2)  ;
		cad += '&url=' + url
		cad += '&tbl=' + TBL
		cad += '&PK='  + PK
		cad += '&DS='  + DS
	    cad += '&chk=1'  
	    cad += '&L1=' + largo
        cad += '&l2=' + largo2
       // alert(funcionalidad+cad)
	window.location.replace(funcionalidad + cad); 
	return true;
}

function NUEVO_onclick() {
chk="0"
nuevo = 1
if (auto==1)
{	thisForm.COD.readOnly= false;
	thisForm.COD.value = 'AUTO';
	thisForm.COD.readOnly= false;
	thisForm.DES.focus();
}
else
{	thisForm.COD.readOnly= false;
	thisForm.COD.value = '';
	thisForm.COD.focus();
}
thisForm.DES.value = '';

//alert()
}
function dd(ff) 
{	var pos = parseInt(ff,10)
	var t = document.all.TABLA;
	if ((oldrow%2) ==0)
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");
	else
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
	// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
	eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("barra"))%>'");
	// Rellena los valores en los textbox
	thisForm.COD.value = ltrim(t.rows(pos).cells(0).innerText );
	thisForm.DES.value = ltrim(t.rows(pos).cells(1).innerText) ;
	thisForm.COD.readOnly= true
    thisForm.DES.readOnly= false

    nuevo = 0
	oldrow=pos
	return true;
}
function retrocede() 
{	var t = document.all.TABLA;
	var ff = 1;
	if (oldrow>1)
		dd(oldrow-1)
    else 
        dd(1)    ;
}
function avanza() 
{	var t = document.all.TABLA;
	var ff = 1;
	
  var max 
  ff =oldrow  + 1
  max =  t.rows.length -1;
  if (ff <= max)
   {dd(ff); }
}
function pagina() 
{	var t = document.all.TABLA;
	var i = t.rows.length -1;
	// captura el valor del último código mostrado en el GRID
	var cad = trim(t.rows(i).cells(0).innerText);
	window.location.replace(pag +cad+ pag2 )	;
}
function primera() 
{	window.location.replace(pag  + pag2)	;
}
function atras() 
{	var t = document.all.TABLA;
	var cod = t.rows(1).cells(0).innerText; // primer valor del browse
	var cad = 'comun/BACK0.asp?pos='+ trim(cod) + '&pk=codigo&ds=descripcion' 
    cad += '&alias='+ TBL + '&pag='+ pagesize ;
	cad += '&url='+ url;
	//alert(cad)
	//return true;
	window.location.replace(cad)	;
}
function ultima() 
{	var cad = 'comun/LAST.asp?pos=&pk=codigo&ds=descripcion' 
	cad += '&alias='+ TBL + '&pag='+ pagesize ;
	cad += '&url='+ url;
    //alert(cad)
	window.location.replace( cad );
}
function VALIDA()
{	
	if (window.thisForm.COD.value == "" && largo > 0 && window.thisForm.COD.value!= 'AUTO')
	{	alert('Debe Informar el Código');
		window.thisForm.COD.focus();
		return false;
	}
	else {	cad = window.thisForm.COD.value;
			ff = trim(window.thisForm.COD.value);
			if(ff.length > largo && largo > 0 && window.thisForm.COD.value!='AUTO')
			{	alert("El código no puede tener más de " + largo + " dígitos")
				return false;
			}
	}
	if (trim(window.thisForm.DES.value) == "" && largo2 > 0 )
	{	alert('Debe Informar la Descripción');
		window.thisForm.DES.focus();
		return false;
	}		
	else
	{	thisForm.DES.value = Left(ltrim(rtrim(thisForm.DES.value)),largo2)
		}
	return true;
}

function imprime()
{	cad = 'REPORTES/prnTBL.asp?tbl=' +TBL

	window.open(cad)
}
	
function BUSCA() 
{	if (trim(window.thisForm.kod.value) == '' && trim(window.thisForm.ds.value) == '')
	{	alert("Debe informar al menos el Código o la descripción");
		window.thisForm.kod.focus();
	}
/*  document.all.ACTIV.style.visibility='visible'
    document.all.ACTIV.height="150"
    document.all.ACTIV.width="100%"
*/
    var cad =  'search/SEARCHtbl.asp?pos=' + Left(thisForm.kod.value,largo) 
        cad += '&des='+ ltrim(window.thisForm.ds.value) ;
		cad += '&tbl=' + '<%=tbl%>'
        cad += '&pk=codigo&ds=descripcion' 
        cad += '&alias='+ '<%=trim(tbl) %>' 
	    cad += '&url='+ url;
     //   alert(cad)
	document.all.ACTIV.src=(cad)

	return true;
}
</SCRIPT>
