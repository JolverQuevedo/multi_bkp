<%@ Language=VBScript LCID = 10250 %>
<%  Response.Buffer = true %>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="includes/funcionesVBscript.asp"-->
<%	
	DIM VAL
	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= txtPerfil
	
	PROTO	= Request.QueryString("PRO")
	VERSION = Request.QueryString("VER")
	CAD =	" FICHAPROTO " & "'" &PROTO& "'" & ",'" & VERSION & "'"

	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.ActiveConnection = Cnn
	RS2.CursorType       = 3 'CONST adOpenStatic = 3
	RS2.LockType         = 1 'CONST adReadOnly = 1
	RS2.Open CAD,CNN
	
	IF RS2.RecordCount >0 THEN
		RS2.MoveFirst
	END IF
	
	COTIZACION=RS2("COTIZACION")
	CLI = RS2("CLI")
	
	cad =	" select cliente from empresas where rtrim(ltrim(nombre)) " & _
			" = rtrim(ltrim('"&cli&"')) "
	rs.open cad,cnn
	if not rs.eof and not rs.bof then
		codcli = rs("cliente")		
	else
		codcli = ""
	end if
	rs.close

	CAD = "SELECT * FROM TALLAS WHERE TALLAS = '"&RS2("CODTAL")&"'"
	RS.OPEN CAD,CNN
	IF NOT RS.EOF AND NOT RS.BOF THEN
		TAL0 = RS("TALLA0")
		TAL1 = RS("TALLA1")
		TAL2 = RS("TALLA2")
		TAL3 = RS("TALLA3")
		TAL4 = RS("TALLA4")
		TAL5 = RS("TALLA5")
		TAL6 = RS("TALLA6")
		TAL7 = RS("TALLA7")
		TAL8 = RS("TALLA8")
		TAL9 = RS("TALLA9")
	END IF
	RS.CLOSE
	CAD = "SELECT * FROM PROPORCIONES WHERE PROPORCION = '"&RS2("CODRAT")&"'"
	RS.OPEN CAD,CNN
	IF NOT RS.EOF AND NOT RS.BOF THEN
		PRO0 = RS("PROP0")
		PRO1 = RS("PROP1")
		PRO2 = RS("PROP2")
		PRO3 = RS("PROP3")
		PRO4 = RS("PROP4")
		PRO5 = RS("PROP5")
		PRO6 = RS("PROP6")
		PRO7 = RS("PROP7")
		PRO8 = RS("PROP8")
		PRO9 = RS("PROP9")
	END IF
	RS.CLOSE
%>
<!--#include file="COMUN/FUNCIONfpro.ASP"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
<link REL="stylesheet" TYPE="text/css" HREF="HITEPIMA.CSS" >
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<title>FICHA DE PROTO</title>
<SCRIPT language="javascript">
var PRO = '<%=PRO%>'

</SCRIPT>
<SCRIPT ID="clientEventHandlersJS" LANGUAGE="javascript">
<!--
function window_onfocus() 
{	document.body.style.fontFamily = "arial"
	eval("document.body.style.color='NAVY'")	
	return true;	
}
function blancos()
{	thisForm.CODEST.value=''
	thisForm.DESEST.value = ''
	thisForm.TEM.value = ''
	thisForm.TEMDES.value = ''
	thisForm.GEN.value = ''
	thisForm.DESGEN.value = ''
}
//-->
</SCRIPT>
<script language="javascript" src="INCLUDES/FichaProto.js"></script>
<script language="javascript" src="INCLUDES/funcionescomunes.js"></script>
</HEAD>
<BODY bgColor="White" text="#009999" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onfocus="javascript:return window_onfocus()">
<form id="thisForm" method="post"   ACTION="COMUN/INSERPROTO.ASP">
<table border="0" cellpadding="0" cellspacing="0" width="100%" >
	<tr align="center">
		<td width="177"><input type="hidden" id="op" name="op">
			<img src="imagenes/CERRAR.gif" style="cursor:hand;" onclick="javascript: window.opener.location.replace('protos.asp?perfil=1&pos='+thisForm.PPROTO.value);window.close()">
		</TD>		
      <td width="676" align = center bgcolor="#ffffff">
		<b> <font color="#003399" size="3" Face=arial> 
       PROTO N° <%=trim(proTO)&" - "&trim(verSION)%></font></b> 
      </td>
		<td  width=35 ID=MAIL style="display:none;" > 
			<a href='<%=correo%>'>
			<img src="imagenes/mail.jpg" border="1"
				STYLE="cursor:hand;" alt="Avisa a Ingeniería"></a> 
		</td>
		<td  width=35 ID=NUEVO > 
			<img src="imagenes/proto.jpg"  border="1"
			style="cursor:hand;" alt="NUEVO PROTO" 
			onmousedown="javascript:VALIDA(2)" onclick="javascript:thisForm.op.value=2"> 
		</td>
		<td  width=35 ID=VERS  style="display:none;" > 
			<img src=imagenes/version.jpg   border=1
			STYLE="cursor:hand;" ALT="NUEVA VERSION"
			onmousedown="javascript:VALIDA(1)" onclick="javascript:thisForm.op.value=1"> 
		</td>
		<td  width=35 ID=GRABAR  style="display:none;" >
		<% 
		IF  TRIM(COTIZACION)="" OR ISNULL(COTIZACION) THEN
		%>
			<img src="imagenes/arregla.jpg"   border=1
			STYLE="cursor:hand;" ALT="GRABA CAMBIOS"
			onmousedown="javascript:VALIDA(0)" onclick="javascript:thisForm.op.value=0"> 
		<%
		END IF%>
		</td>
    </tr>
</TABLE>    
<table	border="1" cellpadding="1" WIDTH="100%" cellspacing="1" bgcolor="White" bordercolor="SeaGreen" bordercolordark="DARKGREEN"
bordercolorlight="LightSeaGreen">
    <tr align="center"> 
		<td align="left" bgcolor="#fbfff7" width="10%">
			<b> <font face="Arial" size="1" color="#003399"> 
			Proto - Ver</font></b> 
		</td>
		<td align="left" bgcolor="Snow" width="20%" colspan=4> 
		<%	if trim(RS2("PROTO")) = "" then 
					VAL=Request.Form("PPROTO")
			else
					VAL=muestra_cadena(RS2("PROTO"))
			end if%>
			<input type="text" id="PPROTO" name="PPROTO" 
			STYLE="WIDTH:70%; text-align:right; BORDER:NONE"  
			MAXLENGTH=10 READONLY value="<%=VAL%>">
		<%	if trim(RS2("VERSION")) = "" then 
					VAL=Request.Form("PVERSION")
			else 
					VAL=muestra_cadena(RS2("VERSION"))
			end if%>
			<input type="text" id="PVERSION" name="PVERSION" 
			STYLE="WIDTH:25%; text-align:right;BORDER:NONE" 
			READONLY MAXLENGTH=10 value="<%= VAL %>">	
		</td>
		<td align="left" bgcolor="#fbfff7"> 
			<b><font face="Arial" size="1" color="#003399">Cliente</font></b> 
        </td>
		<td align="left" bgcolor="Snow" WIDTH=15% colspan=3 > 
			<SELECT id="CLI" style="width:100%" NAME="CLI" onchange="blancos()">
			<option></option> 
			<%	CAD =	" SELECT  CLIENTE as CLI, " & _
						" NOMBRE AS cliente " & _
						" FROM EMPRESAS " & _
						" WHERE ESTADO = 'A'  AND " & _
						" TIPO = 'E' ORDER BY NOMBRE "
				rs.OPEN CAD, Cnn
			
			IF rs.eof OR rs.bof THEN%>
				<OPTION value="">No Hay Clientes Registrados </OPTION> 
		<%	ELSE
				IF trim(RS2("cli")) = "" THEN
					cli = Request.Form("CLI")
				END IF
				rs.movefirst
				DO WHILE NOT rs.eof%>
					<OPTION value=<%=rs("cli")%>
					<%IF TRIM(RS("CLIENTE")) = TRIM(RS2("CLI")) THEN%>
					SELECTED 
					<%END IF%>>
					<%=muestra_cadena(rs("cliente"))%></OPTION> 
					<%rs.movenext
				LOOP
			END IF%>
			</SELECT>
			<%RS.CLOSE%>
		</td>
		<td rowspan=12 align ="center" width=200>
			    <div align="center">
			        <%IF TRIM(RS2("FOT")) = "" THEN%>
				    <IMG SRC='FOTOS/hitepima.jpg' id="foto" name="foto" align="middle">
		            <%ELSE%>
		            <IMG SRC='<%="FOTOS/"+TRIM(RS2("FOT"))%>' name="foto" width="200" align="middle" id="foto">
		            <%END IF%>
                </div></td>
</tr>
<tr>		
	<td  width="10%" bgcolor="#fbfff7" align=center valign=top> 
		<div align="left"><font face="arial" size="1" color="#003399"> 
		  Estilo<br>
		  <br>
		  <IMG SRC="IMAGENES\HELP.GIF" width=20 STYLE="CURSOR:HAND;"  
	  		onclick="javascript:HELP('help/hlpESTILO.asp?cli='+thisForm.CLI.value,
			thisForm.CLI.options(thisForm.CLI.selectedIndex).innerText)"></font>
        </div></td>
    <td align="left"  bgcolor="Snow" WIDTH="20%" colspan="4"> 
	<TABLE WIDTH="100%" BORDER="0"  cellpadding="0" cellspacing="0">	
		<TR><TD>
		<%	IF TRIM(RS2("CODEST"))="" THEN
				VAL=Request.Form("CODEST")
	  		ELSE
	  			VAL=muestra_cadena(RS2("CODEST"))
	  		END IF%>
	  	<input id="CODEST" TYPE="text" NAME="CODEST" CLASS="datosgrande" 
	  	onchange="javascript:BAKE('estilos',this.value)" MAXLENGTH="15" value="<%=VAL%>">
		</TD>
		</tr>
		<tr>
		<TD>
		<%	IF TRIM(RS2("EST")) = "" THEN
	  			VAL=Request.Form("DESEST")
	  		ELSE
	  			VAL=muestra_cadena(RS2("est"))
	  		END IF%>
	  	<input	id="DESEST" READONLY  NAME="DESEST"	type="text" CLASS="DESCRIPTORES" value="<%=VAL%>">
    </TD></TR>
    </TABLE>
    </td>
     <td  width="10%" bgcolor="#fbfff7" valign=top align="left"> 
			<font face="arial" size="1" color="#003399"> 
			Temporada<br><br><IMG SRC="IMAGENES\HELP.GIF" width="20" STYLE="CURSOR:HAND;" 
				onclick="javascript:HELP('help/hlpTEMPO.asp?cli=', thisForm.CLI.value,thisForm.CLI.options(thisForm.CLI.selectedIndex).innerText)"> &nbsp;&nbsp;</font>
	  </td>
      <td align="left"  bgcolor="Snow" WIDTH=20% colspan=3>
      <TABLE WIDTH=100%  cellpadding=0 cellspacing=0 BORDER=0> 
      <TR><TD >	
	  <%	IF TRIM(RS2("CODTEM"))="" THEN 
				VAL=Request.Form("TEM")
	  		ELSE
	  			VAL=muestra_cadena(RS2("CODTEM"))
			END IF%>
			<input id="TEM" TYPE="text" NAME="TEM" CLASS="datosgrande" onchange="javascript:BAKE('TEMPORADAS',this.value)" MAXLENGTH="15" value="<%=VAL%>">
	  		</td>	
	  	</tr>
	  	<tr>		
	  		<td><%	IF TRIM(RS2("TEM"))="" THEN
	  				VAL=Request.Form("TEMDES")
	  			ELSE
	  				VAL=muestra_cadena(RS2("TEM"))
	  			END IF%>
			<input	id="TEMDES" READONLY NAME="TEMDES" CLASS="DESCRIPTORES" type="text" value="<%=VAL%>">
			</TD>
		</TR>
		</TABLE>
      </td>
</tr>
<tr>
		<td bgcolor="#fbfff7" WIDTH="10%" align="center" > 
			<div align="left"><font face="arial" size="1" color="#003399">Género</font> 
	      </div></td>
		<td align="left" bgcolor="Snow" WIDTH="20%" colspan="4">
		<TABLE WIDTH="100%" BORDER="0" cellpadding="0" cellspacing="0">	
		<TR>
			<TD width=50>
			<%	IF TRIM(RS2("CODGEN"))="" THEN
	  				VAL= Request.Form("GEN")
	  			ELSE
					VAL= muestra_cadena(RS2("CODGEN"))
	  			END IF%>		
			<input id="GEN" TYPE="text"  NAME="GEN" CLASS="texto" onchange="javascript:BAKE('generos',this.value)" MAXLENGTH="2" value="<%=VAL%>">
	  		</td>	
	  		<td>
			<%	IF TRIM(RS2("GEN"))="" THEN
	  				VAL= Request.Form("DESGEN")
	  			ELSE
	  				VAL= muestra_cadena(RS2("GEN"))
	  			END IF%>	
			<input id="DESGEN" READONLY NAME="DESGEN" CLASS="descriptores" value="<%= VAL %>">
		</TD>
	  	</tr>
		</TABLE>		
		</td>
		<td  width="10%" bgcolor="#fbfff7" valign=top align="left"> 
			<font face="arial" size="1" color="#003399"> 
			Tipo Prenda</font>
		</td>
      <td align="left"  bgcolor="Snow" WIDTH=20% colspan=3> 
      <TABLE WIDTH=100%>
		<TR>
			<TD WIDTH=40>
			<%	IF TRIM(RS2("CODTIP"))="" THEN
	  				VAL=Request.Form("TIPPRE")
	  			ELSE	
	  				VAL=muestra_cadena(RS2("CODTIP"))
	  			END IF%>				
			<input id="TIPPRE" TYPE="text" NAME="TIPPRE" class="texto" MAXLENGTH="2"
			onchange="javascript:BAKE('TIPPRENDA',this.value)" value="<%=VAL%>">
	  		</td>	
	  		<td>
			<%	IF TRIM(RS2("TIP"))="" THEN
	  				VAL=Request.Form("DESTPREN")
	  			ELSE
	  				VAL=muestra_cadena(RS2("TIP"))
				END IF%>
			<input	id="DESTPREN" READONLY  NAME="DESTPREN" CLASS="DESCRIPTORES" value="<%=VAL%>">
		</TD></TR>				
		</TABLE>
      </td>
</tr>
<tr>      
		<td bgcolor="#fbfff7" WIDTH=10%> 
			<font face="arial" size="1" color="#003399"> 
			Descripción </font> 
		</td>
		<td align="left" bgcolor="Snow" WIDTH=100% colspan=8>
			<%	IF TRIM(RS2("DES"))="" THEN
	  				VAL=Request.Form("DES")
	  			ELSE
	  				VAL= muestra_cadena(RS2("DES"))
	  			END IF%>
			<input	id="DES"  MAXLENGTH="200" NAME="DES" CLASS="DATOSgrande" value="<%=VAL%>">
			
		</td>
</TR>	
<TR>	
	<td  width="10%" bgcolor="#fbfff7"> 
		<IMG SRC="IMAGENES\HELP.GIF" width="20" STYLE="CURSOR:HAND;"
		onclick="javascript:HELP('help/HLPfotos.asp')"> 
			<font face="arial" size="1" color="#003399">Foto</font>
	</td>
    <td align="left"  bgcolor="Snow" WIDTH="20%" colspan="8">
		<%		IF TRIM(RS2("FOT"))="" THEN
		  			VAL=Request.Form("FOT")
	  			ELSE
			  		VAL=muestra_cadena(RS2("FOT"))
	  			END IF%> 
	  	 <input  id ="FOT"  TYPE="TEXT"  NAME="FOT" CLASS="DATOSgrande" value="<%=VAL%>">
	</td> 
</tr> 
<tr align="center"> 		
    <td bgcolor="#fbfff7" WIDTH=20% colspan=2> 
		<div align="left"><IMG SRC="IMAGENES\HELP.GIF" width=20 STYLE="CURSOR:HAND;"
		onclick="javascript:HELP('help/hlpfamTEL.asp')"> 
			   <font face="arial" size="1" color="#003399"> 
			  Tela Principal</font>
		  
	    </div></td>
    <TD width=5% bgcolor="#fbfff7" ALIGN=CENTER colspan=3>
	<%	IF TRIM(RS2("CODTEL"))="" THEN
	  		VAL=Request.Form("TEL")
	  	ELSE
	  		VAL=muestra_cadena(RS2("CODTEL"))
	  	END IF%>	
		<input id="TEL" TYPE="text"  NAME="TEL" class="datosgrande" MAXLENGTH="5" onchange="javascript:BAKE('TELAS',this.value)" value="<%=VAL%>">
	</td>
    <TD width=5% bgcolor="#fbfff7" ALIGN=CENTER>	

	  <font face="arial" size="1" color="#003399"><b> 
	  Densidad </b></font>
    </TD>
    <TD width=5% bgcolor="#fbfff7" ALIGN=CENTER>	
	  <font face="arial" size="1" color="#003399"><b> 
	  Ancho</b></font>
    </TD>
	<TD width=5% bgcolor="#fbfff7" ALIGN=CENTER>	
	  <font face="arial" size="1" color="#003399"><b> 
	  GG</b></font>
    </TD>      
    <TD width=5% bgcolor="#fbfff7" ALIGN=CENTER>	
	  <font face="arial" size="1" color="#003399"><b> 
	  Rend.</b></font>
    </TD>   
</tr>      
<tr>
	<td align="left" bgcolor="Snow" WIDTH=20% colspan=5> 			
		<%		IF TRIM(RS2("TEL"))="" THEN
	  				VAL=Request.Form("DESTEL")
				ELSE
	  				VAL=muestra_cadena(RS2("TEL"))
				END IF%>
		<input	id="DESTEL" READONLY  NAME="DESTEL" CLASS="DESCRIPTORES" value="<%=VAL%>">
      <%TEL = RS2("CODTEL")
		cad =	" SELECT tela as codtel, " & _
				" DEN = CASE WHEN anchabi IS NULL  " & _
				" THEN STR(Pesocru,10,2) ELSE str(ANCHABI,10,2) END, " & _
				" ANC = CASE WHEN ANCHABI IS NULL THEN STR(ANCHTUB,10,2)" & _
				"  ELSE str(ANCHABI,10,2) END, " & _
				" str(galga,10,0) as galga, " & _
				" REND = CASE WHEN RENDabi IS NULL THEN " & _
				" str(rendtub,10,2) ELSE STR(rendabi,10,2) END " & _
				" FROM telas WHERE TELA = '"&trim(tel)&"' " 

		rs.open cad,cnn
		if not rs.eof and not rs.bof then
			rs.movefirst		
			dens = rs("den")
			ancho = rs("anc")
			gg = rs("galga")
			ren = rs("rend")
		else
			dens = ""
			ancho = ""
			gg = ""
			ren = ""
		end if	
		rs.close
	  %>
	</td>
      <TD width=10% bgcolor="Snow" >
	 <%	IF TRIM(DENS) = "" THEN
	  		VAL=Request.Form("DENS")
	  	ELSE
	  		VAL=muestra_cadena(DENS)
	  	END IF%>
		<input	id="DENS" READONLY NAME="DENS" CLASS="DESCRIPTORES" value="<%=VAL%>">
      </TD>
      <TD width=10% bgcolor="Snow" >
	  <%IF TRIM(ANCHO)="" THEN
	  		VAL=Request.Form("ANCH")
		ELSE
	  		VAL=muestra_cadena(ANCHO)
		END IF%>
		<input	id="ANCH" READONLY   CLASS="DESCRIPTORES" value="<%=VAL%>">
      </TD>
      <TD width=10% bgcolor="Snow" >
	  <%	IF TRIM(GG)="" THEN
	  		VAL=Request.Form("GG")
	  	ELSE	
	  		VAL=muestra_cadena(GG)
	  	END IF%>
		<input	id="GG" READONLY  NAME="GG" CLASS="DESCRIPTORES" value="<%=VAL%>">
      </TD>
      <TD width=10% bgcolor="Snow" >
	 <%	IF TRIM(REN)="" THEN
	  		VAL=Request.Form("REND")
	  	ELSE	
	  		VAL=muestra_cadena(REN)
	  	END IF%>
		<input	id="REND" READONLY NAME="REND" CLASS=DESCRIPTORES value="<%=VAL%>">
      </TD>
    </TR>
<tr>
<td colspan=9 VALIGN=TOP>
	<table WIDTH=100% border=1 CELLPADDING=0 CELLSPACING=0 bordercolor=SeaGreen bordercolordark=DARKGREEN
		bordercolorlight=LightSeaGreen>
	<tr>		
		<td  width="10%" bgcolor="#fbfff7"> 
			<font face="arial" size="1" color="#003399"> 
			Talla</font>
			<%IF TRIM(RS2("CODTAL"))="" THEN
	  			VAL=Request.Form("TIPRAT")
	  		ELSE
	  			VAL=RS2("CODTAL")
	  		END IF%>
			<input id="TIPRAT" style="display:none;" NAME="TIPRAT" value="<%=VAL%>">
		</td>
		<TD WIDTH=10% ALIGN=CENTER valign=middle>	
			<IMG SRC="IMAGENES\HELP.GIF" width=20 STYLE="CURSOR:HAND;"
				onclick="javascript:HELP('help/hlpTALLAS.asp')"></TD> 
		<%FOR I=0 TO 9%>		
			<TD WIDTH=8% ALIGN=CENTER>
			<%	IF trim(eval("tal" & i))="" THEN
	  				VAL=Request.Form(trim(eval("TAL" & i)))
	  			ELSE	
	  				VAL=muestra_cadena(eval("tal" & i))
	  			END IF%>
				<input	id="TAL<%=I%>" READONLY CLASS="TALAS" SIZE="4" NAME="TAL<%=I%>" value="<%=VAL%>">
			</TD>
		<%NEXT%>
		
	</TR>
	<TR>
		<td  width="10%" bgcolor="#fbfff7"> 
			<font face="arial" size="1" color="#003399"> 
			Proporción</font>
			<%IF TRIM(RS2("CODRAT")) = "" THEN
				VAL=Request.Form("TIPPROP")
			ELSE	
				VAL=RS2("CODRAT")
			END IF%>
			<input id="TIPPROP" style="display:none;"  NAME="TIPPROP" value="<%=VAL%>">
		</td>
		<TD WIDTH= 10% ALIGN=CENTER valign=middle>
				<IMG SRC="IMAGENES\HELP.GIF" width=20 STYLE="CURSOR:HAND;"
					onclick="javascript:HELP('help/hlppropor.asp')"></TD> 
			<%FOR I=0 TO 9%>
				<TD WIDTH=8%>
				  <%IF trim(eval("PRO" & i))="" THEN
	  					VAL=Request.Form(trim(eval("PRO" & i)))
	  				ELSE	
	  					VAL=muestra_cadena(eval("PRO" & i))
	  				END IF%>
				<input	id="PRO<%=I%>" READONLY 
					class="TALAS" SIZE="4" NAME="PRO<%=I%>" value="<%=VAL%>">
				</TD>
			<%NEXT%>
	</tr>
	</table>
</td>
</tr>
</TABLE>  
<TABLE BORDER=0 WIDTH=100% bgcolor=#E8FED8 >
<TR><TD VALIGN=MIDDLE WIDTH=20>
		<IMG SRC="IMAGENES\HELP.GIF" width=20 STYLE="CURSOR:HAND;"
	  		onclick="javascript:HELP('help/hlpSERV.asp?tip=001&TIT=PRENDA&topo=0')" >
	  </TD>		
	  <TD VALIGN=MIDDLE>
			<FONT SIZE = 1 COLOR = BLACK FACE=ARIAL>
			<b>Servicios en Prenda :</b></font>
</TD></TR>	
</TABLE>
<TABLE width=100% BORDER=1 cellpadding="1" 
cellspacing="1" bordercolor=SeaGreen bordercolorlight=LightSeaGreen
bordercolordark=DARKGREEN  bgcolor=White id=PRENDAS>
		<%cad =	" select *, ss.descripcion as dd " & _
				" from [proto-detalles] pp  " & _
				" inner join protos on protos.proto = pp.proto " & _
				" and protos.version = pp.version " & _
				" inner join servicios ss on pp.codigo = ss.codigo" & _
				" where tipodetalle = '01' and pp.estado = 'A' " & _
				" and pp.proto = '"&proto&"' and pp.version = '"&version&"' " 
		rs.open cad,cnn	  
		conta=0
		if not rs.eof and not rs.bof then
			rs.movefirst
			do while not rs.eof%>
			<tr  ID="FILA1<%=conta%>" STYLE="DISPLAY:block;">
				<td width="2%" valign="top">
					<INPUT TYPE="CHECKBOX" ID='CHK1<%=conta%>' NAME='CHK1<%=conta%>'
  					value ="<%=trim(RS("ID"))%>" ONClick="javascript:ids('<%=conta%>','1')">
			  </td>	
  				<td WIDTH="4%" valign="top">
  					<INPUT TYPE="HIDDEN" ID='DEL1<%=conta%>' NAME='DEL1<%=conta%>' VALUE="0">
  					<INPUT TYPE="text" ID='ID1<%=conta%>' NAME='ID1<%=conta%>'
  					value ="<%=trim(RS("ID"))%>" class="texto" readonly>
			  </td>
  				<TD WIDTH="12%" valign="top">	
					<INPUT TYPE=text ID='COD1<%=conta%>'  NAME='COD1<%=conta%>'
						value ="<%=muestra_cadena(RS("CODIGO"))%>" class="datosgrande"
						onchange="javascript:BAKE('servicios', this.value, '001','<%=conta%>')">
			  </TD>
				<td width="33%"  valign=top bgcolor="#fbfff7" >
				<TEXTarea ID="DATO1<%=conta%>"   NAME="DATO1<%=conta%>"   
				wrap="PHYSICAL"  CLASS="TEXTO" READONLY><%=trim(RS("DD"))%></textarea>
			  </td><td width="50%" valign=top>
				<textarea  ID="ADIC1<%=conta%>" wrap="PHYSICAL" NAME="ADIC1<%=conta%>" 
				onfocusout="javascript:return cuenta(this.value,this.id,200)"
				CLASS="ADICIONAL"><%= trim(rs("adicional"))%></textarea>
				</td>
			</tr>
		<%		rs.movenext
				conta = conta + 1
			loop
		end if	
		rs.close%>
			<INPUT TYPE="hidden" ID="conta1" name="conta1"  value ="<%=conta%>">
			<%FOR I=conta TO conta + 20%>
			<tr ID="FILA1<%=I%>" 
		<%	if i > conta then
				response.Write("STYLE='DISPLAY:NONE'")
			else
				response.Write("style='display:block;'")
			end if %>>
				<td width="2%" valign="top">
					<INPUT TYPE="CHECKBOX" ID='CHK1<%=I%>' NAME='CHK1<%=I%>'
					 onClick="javascript:ids('<%=I%>',1)" value="0">
					<INPUT TYPE="HIDDEN" ID='DEL1<%=I%>' NAME='DEL1<%=I%>' value="0">
			  </TD>
				<td width="4%" valign="top">
					<INPUT TYPE="TEXT" ID='ID1<%=I%>' NAME='ID1<%=I%>' value="0" CLASS="TEXTO" readonly>
			  </TD>
				<td width="12%"  valign="top">	
					<INPUT TYPE="TEXT"   ID='COD1<%=I%>' NAME='COD1<%=I%>'
					onkeypress="javascript:MAS('1','<%=i+1%>','<%=conta+20%>')"
					MAXLENGTH="6" CLASS="DATOSGRANDE"
					onchange="javascript:BAKE('servicios', this.value, '001','<%=I%>')">
			  </TD>
				<td  width="33%" valign=top bgcolor="#fbfff7" >
					<TEXTarea ID="DATO1<%=I%>"  wrap="PHYSICAL" NAME="DATO1<%=I%>" 
					CLASS="TEXTO" readonly></textarea>
			  </td>
				<td  width="50%" valign=top>
					<textarea ID="ADIC1<%=I%>"  wrap="PHYSICAL"
					onchange="javascript:return cuenta(this.value,this.id,200)" NAME="ADIC1<%=I%>"
					CLASS="ADICIONAL"></textarea>
			  </td>
			</tr>
			<%NEXT%>
  </table>		
		
<%'********************************************	
  '              SERVICIOS EN TELA
  '********************************************%>	
<TABLE BORDER="0" WIDTH="100%" bgcolor="#E8FED8" >
<TR><tD  BGCOLOR="#E8FED8"   WIDTH="20">
			<IMG SRC="IMAGENES\HELP.GIF" width="20"
	  		STYLE="CURSOR:HAND;"
	  		onclick="javascript:HELP('help/hlpSERV.asp?tip=002&TIT=TELA&topo=0')">
	  	</TD>	
	  	<TD VALIGN=MIDDLE ALIGN=LEFT>
			<FONT SIZE = 1 COLOR = BLACK FACE=ARIAL>
			<b>Servicios en Tela :</b></font>
		</TD>
</tr>	
</TABLE>
  <TABLE width="100%" BORDER="1" cellpadding="1"
	cellspacing="1" bordercolor="SeaGreen" bordercolorlight="LightSeaGreen"
    bordercolordark="DARKGREEN"  bgcolor="White" id = "TELAS">
			<%cad =	" select *, ss.descripcion as dd " & _
				" from [proto-detalles] pp  " & _
				" inner join protos on protos.proto = pp.proto " & _
				" and protos.version = pp.version " & _
				" inner join servicios ss on pp.codigo = ss.codigo" & _
				" where tipodetalle = '02' and pp.estado = 'A' " & _
				" and pp.proto = '"&proTO&"' and pp.version = '"&verSION&"' " 
		rs.open cad,cnn	  
		conta=0
		if not rs.eof and not rs.bof then
			rs.movefirst
			do while not rs.eof%>
			<tr  ID="FILA2<%=conta%>" STYLE="DISPLAY:block;">
				<td width=2% valign=top>
					<INPUT TYPE="CHECKBOX" ID='CHK2<%=conta%>' NAME='CHK2<%=conta%>'
  					value ="<%=RS("ID")%>" ONClick="javascript:ids('<%=conta%>','2')">
			  </td>	
  				<td WIDTH=4% valign=top>
  					<INPUT TYPE="HIDDEN" ID='DEL2<%=conta%>' NAME='DEL2<%=conta%>' VALUE="0">
  					<INPUT TYPE="text" ID='ID2<%=conta%>' NAME='ID2<%=conta%>'
  					value ="<%=RS("ID")%>" class="texto" readonly>
			  </td>
  				<TD WIDTH=12% valign=top>	
					<INPUT TYPE="text" ID='COD2<%=conta%>'  NAME='COD2<%=conta%>'
						value ="<%=muestra_cadena(RS("CODIGO"))%>" class="datosgrande"
						onchange="javascript:BAKE('servicios', this.value, '002','<%=conta%>')">
			  </TD>
				<td width=33%  valign=top bgcolor="#fbfff7">
				<TEXTarea ID="DATO2<%=conta%>"   NAME="DATO2<%=conta%>"   
				wrap="PHYSICAL"  CLASS="TEXTO"READONLY><%=trim(RS("DD"))%></textarea>
			  </td><td width=50% valign=top>
				<textarea  ID="ADIC2<%=conta%>" wrap="PHYSICAL" NAME="ADIC2<%=conta%>" 
				onfocusout="javascript:return cuenta(this.value,this.id,200)" CLASS="ADICIONAL"><%= trim(rs("adicional"))%></textarea>
				</td>
			</tr>
	<%			rs.movenext
				conta = conta + 1
			LOOP
		end if	
		rs.close%>
			<INPUT TYPE="hidden" ID="conta2" name="conta2"  value ="<%=conta%>">
			<%FOR I=conta TO conta + 20%>
			<tr ID="FILA2<%=I%>"  
		<%	if i > conta then
				response.Write("STYLE='DISPLAY:NONE'")
			else
				response.Write("style='display:block'")
			end if %>>
				<td WIDTH="2%"  valign="top">
					<INPUT TYPE="CHECKBOX" ID='CHK2<%=I%>' NAME='CHK2<%=I%>'
					 ONClick="javascript:ids('<%=I%>',2)"value="0">
					<INPUT TYPE="HIDDEN" ID='DEL2<%=I%>' NAME='DEL2<%=I%>' value="0">
			  </TD>
				<td WIDTH=4% valign=top>
					<INPUT TYPE="TEXT" ID='ID2<%=I%>' NAME='ID2<%=I%>' value="0"
					CLASS="TEXTO" readonly>
			  </TD>
				<td WIDTH=12%  valign=top>	
					<INPUT TYPE="TEXT"   ID='COD2<%=I%>' NAME='COD2<%=I%>'
					onkeypress="MAS('2','<%=i+1%>','<%=conta+20%>')"
					MAXLENGTH="6" CLASS="DATOSGRANDE"
					onchange="javascript:BAKE('servicios', this.value, '002','<%=I%>')">
			  </TD>
				<td WIDTH=33%  valign=top bgcolor="#fbfff7">
					<TEXTarea ID="DATO2<%=I%>"  wrap=PHYSICAL NAME="DATO2<%=I%>" 
					CLASS="TEXTO"
					readonly></textarea>
			  </td>
				<td WIDTH=50%  valign=top>
					<textarea  ID="ADIC2<%=I%>"  wrap="PHYSICAL"
					onchange="return cuenta(this.value,this.id,200)" NAME="ADIC2<%=I%>"
					CLASS="ADICIONAL"></textarea>
			  </td>
			</tr>
			<%NEXT%>
  </table>	
		
				
<%'********************************************	
  '              SERVICIOS EN Pieza
  '********************************************%>	

<TABLE BORDER=0 WIDTH=100% bgcolor=#E8FED8 >
<TR><tD  BGCOLOR=#E8FED8   WIDTH=20>
			<IMG SRC="IMAGENES\HELP.GIF" width=20
	  		STYLE="CURSOR:HAND;"
	  		onclick="HELP('help/hlpSERV.asp?tip=003&TIT=PIEZA&topo=0')">
	  </TD>		
	  <TD VALIGN =MIDDLE>
			<FONT SIZE = 1 COLOR = BLACK FACE=ARIAL>
			<b>Servicios en Pieza :</b></font>
	  </TD>
</tr>	
</table>
  <TABLE width="100%" BORDER="1" cellpadding="1"
	cellspacing="1" bordercolor="SeaGreen" bordercolorlight="LightSeaGreen"
    bordercolordark="DARKGREEN"  bgcolor="White" id = "PIEZA">
			<%cad =	" select *, ss.descripcion as dd " & _
				" from [proto-detalles] pp  " & _
				" inner join protos on protos.proto = pp.proto " & _
				" and protos.version = pp.version " & _
				" inner join servicios ss on pp.codigo = ss.codigo" & _
				" where tipodetalle = '03' and pp.estado = 'A' " & _
				" and pp.proto = '"&PROTO&"' and pp.version = '"&VERSION&"' " 
		rs.open cad,cnn
		conta=0
		if not rs.eof and not rs.bof then
			rs.movefirst
			do while not rs.eof%>
			<tr  ID="FILA3<%=conta%>" STYLE="DISPLAY:block;">
				<td width=2% valign=top>
					<INPUT TYPE="CHECKBOX" ID='CHK3<%=conta%>' NAME='CHK3<%=conta%>'
  					value ="<%=RS("ID")%>" onClick="javascript:ids('<%=conta%>','3')">
			  </td>	
  				<td WIDTH="4%" valign="top">
  					<INPUT TYPE="HIDDEN" ID='DEL3<%=conta%>' NAME='DEL3<%=conta%>' VALUE="0">
  					<INPUT TYPE="text" ID='ID3<%=conta%>' NAME='ID3<%=conta%>'
  					value ="<%=RS("ID")%>" class="texto" readonly>
			  </td>
  				<TD WIDTH="12%" valign="top">	
					<INPUT TYPE="text" ID='COD3<%=conta%>'  NAME='COD3<%=conta%>'
						value ="<%=muestra_cadena(RS("CODIGO"))%>" class="datosgrande"
						onchange="javascript:BAKE('servicios', this.value, '003','<%=conta%>')">
			  </TD>
				<td width=33%  valign=top bgcolor="#fbfff7">
				<TEXTarea ID="DATO3<%=conta%>"   NAME="DATO3<%=conta%>"   
				wrap="PHYSICAL"  CLASS="TEXTO"
				READONLY><%=trim(RS("DD"))%></textarea>
			  </td><td width=50% valign=top>
				<textarea  ID="ADIC3<%=conta%>" wrap="PHYSICAL" NAME="ADIC3<%=conta%>" 
				onfocusout="javascript:return cuenta(this.value,this.id,200)" 
				CLASS="ADICIONAL"><%= trim(rs("adicional"))%></textarea>
				</td>
			</tr>
			<%	rs.movenext
				conta = conta + 1
			LOOP
		end if	
		rs.close%>
			<INPUT TYPE=hidden ID="conta3" name=conta3  value ="<%=conta%>">
			<%FOR I=conta TO conta + 20%>
			<tr ID="FILA3<%=I%>" 
		<%	if i > conta then
				response.Write("STYLE='DISPLAY:NONE'")
			else
				response.Write("style='display:block'")
			end if %>>
				<td WIDTH="2%"  valign="top">
					<INPUT TYPE="CHECKBOX" ID='CHK3<%=I%>' NAME='CHK3<%=I%>'
					 ONClick="javascript:ids('<%=I%>','3')" value="0">
					<INPUT TYPE="HIDDEN" ID='DEL3<%=I%>' NAME='DEL3<%=I%>' value="0">
			  </TD>
				<td WIDTH=4% valign=top>
					<INPUT TYPE="TEXT" ID='ID3<%=I%>' NAME='ID3<%=I%>' value="0"
					CLASS="TEXTO" readonly>
			  </TD>
				<td WIDTH=12%  valign=top>	
					<INPUT TYPE="TEXT"   ID='COD3<%=I%>' NAME='COD3<%=I%>'
					onkeypress="MAS('3','<%=i+1%>','<%=conta+20%>')"
					MAXLENGTH="6" CLASS="DATOSGRANDE"
					onchange="javascript:BAKE('servicios', this.value, '003','<%=I%>')">
			  </TD>
				<td WIDTH=33%  valign=top bgcolor="#fbfff7">
					<TEXTarea ID="DATO3<%=I%>"  wrap="PHYSICAL" NAME="DATO3<%=I%>" 
					CLASS="TEXTO" readonly></textarea>
			  </td>
				<td WIDTH=50%  valign=top>
					<textarea  ID="ADIC3<%=I%>"  wrap="PHYSICAL"
					onchange="javascript:return cuenta(this.value,this.id,200)" NAME="ADIC3<%=I%>"
					CLASS="ADICIONAL"></textarea>
			  </td>
			</tr>
			<%NEXT%>
  </table>	
<%'********************************************	
  '            DESCRIPCION DE TELAS
  '********************************************%>	
<TABLE BORDER="0" WIDTH="100%" bgcolor="#E8FED8" >
<TR><tD  BGCOLOR="#E8FED8" WIDTH="20">
		<IMG SRC="IMAGENES\HELP.GIF" width=20
	  		STYLE="CURSOR:HAND;"
	  		onclick="javascript:HELP('help/hlpFAMTEL.asp?tip=001&op=4&OPC=0')" >
	  </TD>		
	<TD VALIGN=MIDDLE >
			<FONT SIZE = 1 COLOR = BLACK FACE=ARIAL>
			<b>Descripción de Telas :</b></font>
	  </td>
	</tr>	
</TABLE>	
<TABLE width=100% BORDER=1 cellpadding="1"
	cellspacing="1" bordercolor=SeaGreen bordercolorlight=LightSeaGreen
    bordercolordark=DARKGREEN  bgcolor=White id = DETTEL>

<%'cad =	" select *, ss.DESCRIPCION as dd " & _
		'" from [proto-detalles] pp  " & _
		'" inner join protos on protos.proto = pp.proto " & _
		'" and protos.version = pp.version " & _
		'" inner join [TELAS] ss on pp.codigo = ss.TELA" & _
		'" where tipodetalle = '04' and pp.estado = 'A' " & _
		'" and pp.proto = '"&proto&"' and pp.version = '"&version&"' " 
cad= "SELECT PP.ID,PP.CODIGO,PP.ADICIONAL, "&_
	 "SS.DESCRIPCION AS DD,STR(SS.PESOACA,10,2) AS DEN, "&_
	 "'ANCH'= CASE WHEN SS.anchabi IS NOT NULL THEN  STR(SS.ANCHABI,10,2) ELSE STR(SS.ANCHABI,10,2)END, "&_
	 "STR(SS.GALGA,10,0) AS GG, "&_
	 "'REND'= CASE WHEN SS.RENDABI IS NOT NULL THEN STR(SS.RENDABI,10,2) ELSE STR(SS.RENDTUB,10,2)END "&_
	 "FROM [PROTO-DETALLES] PP "&_
	 "INNER JOIN [PROTOS] ON PROTOS.PROTO = PP.PROTO AND PROTOS.version = PP.VERSION "&_
	 "INNER JOIN [TELAS] SS ON PP.CODIGO = SS.TELA "&_
	 "WHERE tipodetalle = '04' AND PP.ESTADO = 'A' AND PP.PROTO = '"&TRIM(proto)&"' and PP.VERSION = '"&TRIM(version)&"' "
rs.open cad,cnn	  
	'response.Write(cad)	
conta=0
if not rs.eof and not rs.bof then
	rs.movefirst
	do while not rs.eof%>
	<tr  ID="FILA4<%=conta%>" STYLE="DISPLAY:BLOCK;">
		<td width="2%" valign="top">
			<INPUT TYPE="CHECKBOX" ID='CHK4<%=conta%>' NAME='CHK4<%=conta%>' value="0" ONCLICK="javascript:ids('<%=conta%>','4')">
	  </TD>	
		<TD WIDTH=4%>
			<INPUT TYPE="TEXT" ID='ID4<%=conta%>' NAME='ID4<%=conta%>'
			CLASS = "TEXTO" value="<%=rs("ID")%>" readonly>
			<INPUT TYPE="HIDDEN" ID='DEL4<%=conta%>' NAME='DEL4<%=conta%>'
			value="<%=rs("ID")%>" ONCLICK="ids('<%=conta%>','4')">
	  </TD>	
		<TD WIDTH=12%>
			<INPUT TYPE=TEXT ID='COD4<%=CONTA%>' VALUE="<%=muestra_cadena(RS("CODIGO"))%>"
			NAME='COD4<%=CONTA%>' MAXLENGTH=5 CLASS="DATOSGRANDE"
			onchange="javascript:BAKE('TELAS', this.value, '444','<%=conta%>')"
			<%IF CONTA = 0 THEN%>DISABLED<%END IF%>>
	  </TD>
		<td width=33%  valign=top  bgcolor=#fbfff7>
		<TEXTAREA ID="DATO4<%=conta%>"  NAME="DATO4<%=conta%>"  
			CLASS="TEXTO" readonly><%=trim(rs("dd"))&" ( DEN: "&trim(rs("DEN"))&" / ANCH: "&trim(rs("ANCH"))&" / GG: "&trim(rs("GG"))&" / REND: "&trim(rs("REND"))&" )"%></TEXTAREA>
	  </td>
		<td width=50% valign=top>
		<TEXTAREA ID="ADIC4<%=conta%>"  NAME="ADIC4<%=conta%>"  
			onfocusout="javascript:return cuenta(this.value,this.id,200)"
			CLASS="ADICIONAL"><%=trim(rs("adicional"))%></TEXTAREA>
	  </td>
	</tr>
	<%	rs.movenext
		conta = conta + 1
	loop
end if	
rs.close%>
	<INPUT TYPE=HIDDEN ID="conta4" NAME=CONTA4 value ="<%=conta%>">
	<%FOR I=conta TO 20%>
	<tr ID="FILA4<%=I%>" 
<%	if i > conta then
		response.Write("STYLE='DISPLAY:NONE'")
	else
		response.Write("style='display:block'")
	end if %>>
		<td  width=2% valign=top >
			<INPUT TYPE="CHECKBOX" ID='CHK4<%=I%>' NAME='CHK4<%=I%>' 
			ONCLICK="javascript:ids('<%=I%>','4')" value="0">
	  </TD>	
		<TD WIDTH="4%">
			<INPUT TYPE="TEXT"   ID='ID4<%=I%>'  NAME='IDK4<%=I%>' value="0" CLASS="TEXTO" readonly>
			<INPUT TYPE="HIDDEN"   ID='DEL4<%=I%>' NAME='DEL4<%=I%>' value="0">
	  </TD>	
		<TD WIDTH="12%">
			<INPUT TYPE="TEXT" CLASS="DATOSGRANDE"	MAXLENGTH="5" ID='COD4<%=I%>' NAME='COD4<%=I%>'
			onkeypress="MAS('4','<%=i+1%>','<%=conta+20%>')"
			onchange="javascript:BAKE('TELAS', this.value, '444','<%=i%>')">
	  </TD>
		<td width=33%  valign=top bgcolor=#fbfff7>
			<TEXTAREA ID="DATO4<%=I%>" READONLY wrap="virtual"
			CLASS="TEXTO" NAME="DATO4<%=I%>"></TEXTAREA>
	  </td>
		<td width=50% valign=top>
			<TEXTarea ID="ADIC4<%=I%>" wrap="virtual" NAME="ADIC4<%=I%>"
			onfocusout="javascript:return cuenta(this.value,this.id,200)" 
			CLASS="ADICIONAL"></textarea>
	  </td>
	</tr>
	<%NEXT%>
</table>	
<%'********************************************	
  '            DETALLE DE AVIOS
  '********************************************%>		
<TABLE BORDER="0" WIDTH="100%" bgcolor="#E8FED8" >
<TR>
		<tD  BGCOLOR="#E8FED8" WIDTH="20">
		<IMG SRC="IMAGENES\HELP.GIF" width=20 STYLE="CURSOR:HAND;"
	  	onclick="HELP('help/hlpFAMavi.asp?tip=001,OP=0')" >
	  	</TD>	
	  	<TD VALIGN=MIDDLE >	
			<FONT SIZE = 1 COLOR = BLACK FACE=ARIAL>
			<b>Detalle Avíos :</b></font>
		</td>
	</tr>	
</table>
<table width="100%" BORDER="1" cellpadding="1" 
	cellspacing="1" bordercolor="SeaGreen" bordercolorlight="LightSeaGreen"
  bordercolordark="DARKGREEN"  bgcolor="White" id="DETAVI">
<%cad =	" select *, ss.DESCRIPCION as dd " & _
		" from [proto-detalles] pp  " & _
		" inner join protos on protos.proto = pp.proto " & _
		" and protos.version = pp.version " & _
		" inner join [avios] ss on pp.codigo = ss.codigo" & _
		" where tipodetalle = '05' and pp.estado = 'A' " & _
		" and pp.proto = '"&proto&"' and pp.version = '"&VERSION&"' "
rs.open cad,cnn	  
	conta=0
if not rs.eof and not rs.bof then
	rs.movefirst
	do while not rs.eof%>
	<tr  ID="FILA5<%=conta%>" STYLE="DISPLAY:BLOCK">
		<td width="2%" valign="top">
			<INPUT TYPE="CHECKBOX" ID='CHK5<%=conta%>' NAME='CHK5<%=conta%>'
			value="<%=rs("ID")%>" ONCLICK="javascript:ids('<%=conta%>','5')">
	  </td>	
		<td width="4%" valign="top">
			<INPUT TYPE="text" ID='ID5<%=conta%>' NAME='ID5<%=conta%>'
			value="<%=rs("ID")%>" class="texto" readonly>
			<INPUT TYPE=HIDDEN ID='DEL5<%=conta%>' NAME='DEL5<%=conta%>'
			value=0>
	  </td>	
		<td width=12% valign=top>
			<INPUT TYPE="text" ID='COD5<%=CONTA%>' class="datosgrande"
			VALUE="<%=muestra_cadena(RS("CODIGO"))%>" NAME='COD5<%=CONTA%>' MAXLENGTH="7"
			onchange="javascript:BAKE('AVIOS', this.value, '000','<%=CONTA%>')">
	  </TD>
		<td width=33%  valign=top  bgcolor=#fbfff7>
			<TEXTAREA ID="DATO5<%=conta%>"   wrap="virtual" NAME="DATO5<%=conta%>"
			CLASS="TEXTO" readonly><%=trim(rs("dd"))%></TEXTAREA>
	  </td>
		<td width=50% valign=top>
			<TEXTAREA ID="ADIC5<%=conta%>"   wrap="virtual" NAME="ADIC5<%=conta%>" 
			onCHANGE="javascript:return cuenta(this.value,this.id,200)"
			CLASS="ADICIONAL"><%= trim(rs("adicional"))%></TEXTAREA>
	  </td>
	</tr>
	<%	rs.movenext
		conta = conta + 1
	loop
end if	
rs.close%>
	<INPUT TYPE="HIDDEN" ID="conta5"  value ="<%=conta%>" name="conta5">
	<%FOR I=conta TO 60%>
	<tr ID="FILA5<%=I%>" 
	<%	if i > conta then 
			response.Write("STYLE='DISPLAY:NONE'")
		else
			response.Write("style='display:block'")
		end if %>>
		<td width=2% valign=top>
			<INPUT TYPE="CHECKBOX" ID='CHK5<%=I%>' NAME='CHK5<%=I%>'
			 onclick="ids('<%=I%>','5')" value="0">
			 <INPUT TYPE="HIDDEN"   ID='DEL5<%=I%>' NAME='DEL5<%=I%>'  value="0">
	  </TD>	 
		<TD WIDTH="4%" VALIGN="TOP">
			<INPUT TYPE="TEXT"  ID='ID5<%=I%>'  NAME='ID5<%=I%>' CLASS="TEXTO" value="0" readonly>
	  </TD>	
		<TD WIDTH="12%" VALIGN="TOP">
			<INPUT TYPE="TEXT"   ID='COD5<%=I%>' NAME='COD5<%=I%>' 
			CLASS="DATOSGRANDE" MAXLENGTH="7"
			onkeypress="javascript:MAS('5','<%=i+1%>','<%=conta+20%>')"
			onchange="javascript:BAKE('AVIOS', this.value, '000','<%=i%>')">
	  </TD>
		<td width="33%"  valign="top"  bgcolor="#fbfff7">
			<TEXTAREA ID="DATO5<%=I%>" readonly wrap="virtual" NAME="DATO5<%=I%>"
			CLASS="TEXTO"></TEXTAREA>
	  </td>
		<td width="50%" valign="top">
			<TEXTAREA ID="ADIC5<%=I%>" wrap="virtual" 
			onfocusout="javascript:return cuenta(this.value,this.id,200)"
			CLASS="ADICIONAL" NAME="ADIC5<%=I%>"></textarea>
	  </td>
	</tr>
	<%NEXT%>
</table>		
<%'*************************************************	
  '            DETALLES DE CONSTRUCCION
  '*************************************************%>	
<TABLE BORDER=0 WIDTH=100% bgcolor=#E8FED8 >
<TR>
	<tD  VALIGN=TOP width=20>
		<IMG SRC="IMAGENES\HELP.GIF" width=20
	  		STYLE="CURSOR:HAND;"
	  		onclick="HELP('help/hlpMATRIZ.asp')" >
	</td>  	
	<td VALIGN=MIDDLE >		
		<FONT SIZE = 1 COLOR=BLACK FACE=ARIAL>
		<b>Detalles de Construcción :</b></font>
	</td>
</tr>	
</TABLE>	
<table width="100%" BORDER=1 cellpadding="1" 
	cellspacing="1" bordercolor="SeaGreen" bordercolorlight="LightSeaGreen"
	bordercolordark="DARKGREEN"  bgcolor="White" id="MATRIZ">
		<%cad =	" select *, ss.DESCRIPCION as dd " & _
				" from [proto-detalles] pp  " & _
				" inner join protos on protos.proto = pp.proto " & _
				" and protos.version = pp.version " & _
				" inner join [matriz_proto] ss on pp.codigo = ss.codigo" & _
				" where tipodetalle = '06' and pp.estado = 'A' " & _
				" and pp.proto = '"&proto&"' and pp.version = '"&version&"' " 
		rs.open cad,cnn	  
			conta=0
		if not rs.eof and not rs.bof then
			rs.movefirst
			do while not rs.eof%>
			<tr  ID="FILA6<%=conta%>" STYLE="DISPLAY:BLOCK">
				<td width=2% valign=top>
					<INPUT TYPE="CHECKBOX" ID='CHK6<%=conta%>' NAME='CHK6<%=conta%>'
					value="<%=rs("ID")%>"  onclick="javascript:ids('<%=CONTA%>','6')">
					<INPUT TYPE="HIDDEN" ID='DEL6<%=conta%>' NAME='DEL6<%=conta%>'
					value="0">
			  </td>	
				<td width=4% valign=top>
					<INPUT TYPE="text" ID='ID6<%=conta%>' NAME='ID6<%=conta%>'
					value="<%=rs("ID")%>" class="texto" readonly>
			  </td>
				<td width=12% valign= top>	
					<INPUT TYPE="text" name='COD6<%=CONTA%>'
					ID = 'COD6<%=CONTA%>' VALUE="<%=muestra_cadena(RS("CODIGO"))%>"
					class = "datosgrande" maxlength="3"
					onchange="javascript:BAKE('MATRIZ_PROTO', this.value, '000','<%=CONTA%>')">
			  </TD>
				<td width=33%  valign=top  bgcolor=#E8FED8>
				<TEXTAREA ID="DATO6<%=conta%>"  
					CLASS="TEXTO" readonly WRAP="VIRTUAL"><%=trim(rs("dd"))%></TEXTAREA>
			  </td><td width=50% valign=top>
				<TEXTAREA ID="ADIC6<%=conta%>" NAME="ADIC6<%=conta%>"
					onfocusout="javascript:return cuenta(this.value,this.id,200)"
					 wrap="virtual" CLASS="ADICIONAL"><%= trim(rs("adicional"))%></TEXTAREA>
				</td>
			</tr>
		<%		rs.movenext
				conta = conta + 1
			loop
		end if	
		rs.close%>
			<INPUT TYPE="HIDDEN" ID="conta6" NAME="conta6" value ="<%=conta%>">
			<%FOR I=conta TO 60%>
			<tr ID="FILA6<%=I%>" 
			<%	if i > conta then
					response.Write("STYLE='DISPLAY:NONE'")
				else
					response.Write("style='display:block'")
				end if %>>
				<td  width="2%" valign="top">
					<INPUT TYPE="CHECKBOX" ID='CHK6<%=I%>' NAME='CHK6<%=I%>' 
					 onclick="javascript:ids('<%=I%>','6')" value="0">
					<INPUT TYPE="HIDDEN" ID='DEL6<%=I%>' NAME='DEL6<%=I%>' value="0">
			  </TD>	
				<TD WIDTH="4%" VALIGN="TOP">
					<INPUT TYPE="TEXT" ID='ID6<%=I%>'  NAME='ID6<%=I%>' value="0"
					CLASS ="TEXTO" readonly>
			  </TD>	
				<TD WIDTH="12%" VALIGN="TOP">
					<INPUT TYPE="text" ID='COD6<%=I%>' NAME='COD6<%=I%>'
					MAXLENGTH="3" CLASS="DATOSGRANDE"
					onkeypress="javascript:MAS('6','<%=i+1%>','<%=conta+20%>')"
					onchange="javascript:BAKE('MATRIZ_PROTO', this.value, '000','<%=i%>')">
			  </TD>
				<td width=33%  valign=top  bgcolor=#E8FED8>
					<TEXTAREA ID="DATO6<%=I%>" readonly NAME="DATO6<%=I%>"
					CLASS="TEXTO"></TEXTAREA>
			  </td>
				<td width=50% valign=top>
					<TEXTAREA ID="ADIC6<%=I%>" WRAP="VIRTUAL" NAME="ADIC6<%=I%>" 
					onfocusout="javascript:return cuenta(this.value,this.id,200)"
					CLASS="ADICIONAL"></TEXTAREA>
			  </td>
			</tr>
			<%NEXT%>
  </table>		
		</td>
		
	</tr>
</table>		
<%	'********************************************************
	'                    S O L I C I T A                     
	'********************************************************%>
<TABLE width=100% BORDER=1 cellpadding="5" 
	cellspacing="1"  bgcolor="White" bordercolor="SeaGreen"
  bordercolordark="DARKGREEN" bordercolorlight="LightSeaGreen">
	<TR>
		<tD  BGCOLOR="#ebe7e6" colspan="2">
		
			<FONT SIZE = 1 COLOR = black FACE=ARIAL>
			<b>Se Solicita :</b></font>
		</td>
	</tr>	
	<tr>
		<tD  BGCOLOR="SNOW"  valign="top" >
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="SOLICITA">
		<%cad =	" select SOLICITA " & _
				" from [proto-OBS] pp  " & _
				" where  pp.proto = '"&proto&"' and pp.version = '"&version&"' " 
		rs.open cad,cnn	  
		if not rs.eof and not rs.bof then
			rs.movefirst%>
			<%SOLICITA = RS("SOLICITA")%>
	<%	else
			SOLICITA= ""
		end if
		RS.CLOSE%>	
		<tr  ID="FILA7" STYLE="DISPLAY:BLOCK">
			<td valign="top" width="100%" >
			<TEXTAREA ID="SOLICITA" NAME="SOLICITA" style= "WIDTH:100%;HEIGHT: 100%;
			FONT-FAMILY:Courier;FONT-SIZE:11px; overflow:auto"><%= trim(SOLICITA)%></TEXTAREA>
				
			</td>
		</tr>
	</table>
	</td>
	</tr>
</table>
<%	'********************************************************
	'              O B S E R V A C I O N E S                 
	'********************************************************	%>
<TABLE width=100% BORDER="1" cellpadding="5" 
	cellspacing="1"  bgcolor="White" bordercolor="SeaGreen"
  bordercolordark="DARKGREEN" bordercolorlight="LightSeaGreen">
	<TR>
		<tD  BGCOLOR="#ebe7e6" >
			<FONT SIZE = 1 COLOR = BLACK FACE=ARIAL>
			<b>Observaciones:</b></font>
		</td>
	</tr>	
	<tr>
		<tD  BGCOLOR="SNOW"  valign="top" >
		<table width="100%" border="0" cellpadding="0" cellspacing="0" id="OBSERVA">
		<%cad =	" select DDP " & _
				" from [proto-OBS]  " & _
				" where  proto = '"&proto&"' and version = '"&version&"' " 
		rs.open cad,cnn	  
		conta=0
		if not rs.eof and not rs.bof then
			rs.movefirst%>
			<%DDP = RS("DDP")%>
	<%	ELSE
			DDP= ""
		END IF
		RS.CLOSE%>	
		<tr  ID="FILA8">
			<td valign=top width=100%>
			<textarea ID="DDP"  NAME="DDP" style="width:100%; height:100%; font-family:Courier; font-size:11px; overflow:auto"><%=trim(DDP)%></TEXTAREA>
			</td>
		</tr>
</table>		
</td>
</tr>
</table>
<% RS2.Close %>
  <TABLE width="100%" BORDER="1" cellpadding="5" 
	cellspacing="1"  bgcolor="White" bordercolor="SeaGreen"
  bordercolordark="DARKGREEN" bordercolorlight="LightSeaGreen">
	<TR>
		<tD width="33%">
			<font color="#003399" size="2" Face="arial"> 
			<B>Fecha : </b></font>
			<input	value = "<%=date()%>"
				id="FEC" style="width:60%;border:none;color:DarkGreen;
				font-family:arial; font-size:10px;
				background-color:transparent">
		</TD>
		<tD width=34%>
			<font color="#003399" size="2" Face="arial"> 
			<B>Usuario : </b></font>
			<input	value = "<%=UCASE(txtUsuario)%>"
				id="USR" style="width:60%;border:none;color:DarkGreen;
				font-family:arial; font-size:10px;
				background-color:transparent">
			
		</TD>
		<tD width=33% align=right>
			<font color="#003399" size="2" Face="arial"> 
			<B>Estado : </b></font>
			<input	value = "<%="A"%>"
				id="EDO" style="width:60%;border:none;color:DarkGreen;
				font-family:arial; font-size:10px;
				background-color:transparent">
		</TD>
	</TR>
</TABLE>
<script language="javascript">
if (trim('<%=PROTO%>') != '')
	{	MAIL.style.display='block';
		VERS.style.display= 'block';
		GRABAR.style.display='block';
	}
//var _objetus=objetus() //crear objeto ajax
var cli= document.getElementById("CLI")
var valor
var _obj
var _tb
var _f
var _ci
var _n
var help= null	
function HELP(pag,h,w)
{	
	CierraHelp()
	if(cli.value==""){
		MensajeForm("Primero se elige el CLIENTE",cli)
		return false
	}
	if(h==null) h=580
	if(w==null) w=500
	
	var opc = "height="+h+",width="+w+",channelmode=0,dependent=0,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,scrollbars=1,status=1,toolbar=0" 
	help=window.open(pag,'help',opc)
	
}
function CierraHelp(){
	if (help != null){
		help.close()
		help=null
	}
}
	
</script>	
</form>
</BODY>
</HTML>