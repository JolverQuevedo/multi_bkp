<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<link REL="stylesheet" TYPE="text/css" HREF="../MULTISTY.CSS" >
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
est	= Request.QueryString("est") 
ruc	= Request.QueryString("ruc") 
COL	= Request.QueryString("COL")
LII = Request.QueryString("LIN")
PZA = Request.QueryString("PZA")
BOL = Request.QueryString("BOL")
MOT = Request.QueryString("MOT")
FEC = Request.QueryString("FEC")
'response.write(fec)
CAN	= Request.QueryString("CAN")
pos = Request.QueryString("pos") 
ser	= Request.QueryString("ser") 
con	= Request.QueryString("con") 
def	= Request.QueryString("def") 
GUI	= Request.QueryString("GUI") 
g2	= Request.QueryString("g2") 
cor	= Request.QueryString("cor") 
apos= SPLIT(pos,",")
Agui= SPLIT(GUI,",")
ACAN= SPLIT(CAN,",")
aCol = split(col,",")
letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
alet = "ZYXWVUTSRQPONMLKJIHGFEDCBA"

	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY >

<form name="thisForm" METHOD="post" action="" >

<table  border="0" cellspacing="1" cellpadding="1" align="left" width="100%">
    
<%LIN = 0
' ES EL CONTADOR DE LINEAS DE PO MOSTRADAS.,...
'RESPONSE.WRITE(POS)
 %>
 <%FOR  M=0 TO UBOUND(aCol)
 CAD =	"exec saldoS_po_color_GUIA  '"&est&"' ,'"&aCol(m)&"', '"&ruc&"',  '"&ser&"', '"&con&"', '"&def&"', '"&APOS(M)&"' "         
   ' RESPONSE.Write(CAD)
    RS.Open CAD, Cnn
	IF NOT RS.EOF OR NOT RS.BOF THEN 
        RS.MOVEFIRST
    ELSE
    %>
<table width="100%" border="0">
 <tr>       
		 <td class="estilo5" colspan="2" style="color:Red" align="center">Nada pendiente por ingresar del estilo <%=ucase(est)%>,  <%=ucase(aCol(m))%> </td>
  </tr>
    <tr style="height:80px; vertical-align:middle">       
		 <td class="estilo5" colspan="2" style="color:Navy; cursor:pointer" onclick="javascript: top.window.close()" align="center"> << C E R R A R >></td>
  </tr>
  </table>
  
<%response.end
    END IF
    ' k es el contador de POS del color que se esta barriendo
   J = 0   
 %>
    <tr class="Estilo3" ><td width="1%"></td>
        <td  width="5%" class="Estilo3" >PO N&ordm;</td>
        <td style="width:20%"  class="texto" >COLOR -> <%=RS("COLOR") %> </td>
        <%FOR I = 0 TO 9%>
            <td align="center" width="7%"><%TALLA = "T"&i %> <%=RS(TALLA)%></td>    
        <%NEXT%>
        <td width="7%" class="texto" align="center">TOTAL</td>
    </tr>     
  <%do while not rs.eof %>  
    <!-- ***********************************************************************   -->
    <!-- ACA HAY QUE HACER UN WHILE PARA QUE BARRA TODAS LAS PO'S DISNIBLES  ???     -->
    <!-- ***********************************************************************   -->
    
      <!-- *********************************************   -->
      <!-- cantidades disponibles para hacer un ingreso    -->
      <!-- *********************************************   -->
      <tr class="Estilo13" >
      <td width="1%"></td>  <td><%=aGui(m) %></td>
        <td style="width:39%">Pendiente </td>
        <%tq=0%>
             <%FOR I = 0 TO 9%>
                   <td align="center" width="5%">
                   <%can = "S"&i 
                   ccc = formatnumber(cdbl(rs(can)),0,,true)
                    tq = tq + cdbl(ccc)
                   if ccc = 0 then ccc = ""%>
                     <input id="S<%=I%>" name="S<%=I%>" value="<%=ccc %>" class="estilo13" style="width:100%; text-align:center"  />
                  </td>    
            <%NEXT%>
            <td style="width:7%"><input id="TOT<%=K%>" name="TOT<%=K%>" value="<%=tq%>" class="estilo13" style="width:100%;text-align:right; border-width:0px; text-align:center;" tabindex=-1 readonly/></td>
      </tr>
      <!-- ****************************************************   -->
      <!-- muestra como se distribuye lo que tengo por ingreso    -->
      <!-- ****************************************************   -->
      <!-- ****************************************************   -->
      <!-- INDICE (aCol) xx LIN  COL 
           xx = constante de tipo caracter que identifica el campo
           COL = I del barrido de las columnas por talla          -->
      <!-- ****************************************************   -->
      <!-- ****************************************************   -->
         
       <tr class="Estilo14">  <td width="1%" style="width:1%" ><input  id="<%=M%>UBI<%=lin%>" name="<%=M%>UBI<%=lin%>" value="<%=RS("ubi")%>" class="estilo14" tabindex=-1 readonly style="display:block;width:15px;"/>
        </td>
        <td style="width:3%" ><input id="<%=M%>PO<%=lin%>" name="<%=M%>PO<%=lin%>" class="Estilo14" value="<%=rs("po")%>" tabindex=-1 readonly style="width:100%; border-width:0px; text-align:center;"   /></td>
        <td style="width:39%">Ingreso</td>
        <%tq=0%>
             <%FOR I = 0 TO 9%>
                   <td align="center" width="5%">
                   <%
                  ' TENGO QUE USAR EL ARRAY DE CANTIDADES CON "M"
                  ' PORQUE LAS CANTIDADES SON EL TOTAL POR COLOR
                   can = "S"&i 
                   ccc = formatnumber(cdbl(rs(can)),0,,true)
                   if CDBL(aCan(M)) - ccc < 0 then
                        ccc = CDBL(aCan(M))
                        Acan(M) = 0
                   else
                    aCan(M) = CDBL(aCan(M)) - ccc
                   end if

                    tq = tq + cdbl(ccc)
                   if ccc = 0 then ccc = ""                   %>
                   <%K = mid(letras, I+1,1) %>
                     <input id="<%=m%>C<%=LIN%><%=K%>" name="<%=m%>C<%=LIN%><%=K%>" value="<%=ccc%>" class="estilo14" style="width:100%; text-align:center" />
                  </td>    
            <%NEXT%>
            <td style="width:15%"><input id="<%=m%>PO<%=K%>" name="<%=m%>PO<%=K%>" value="<%=tq%>" class="estilo14" style="width:100%; text-align:center" tabindex=-1 readonly/></td>
      </tr>

    <%RS.MOVENEXT%>
    <%LIN = LIN + 1 %>
    <%J=J+1%>
    <%if aCan(m) = 0 then exit do %>
    <%LOOP%>
    <%RS.CLOSE%>
<%next   ' del for M (aCol) %>

<tr>
<%
' CAPTURAR LOS VALORES DE CABECERA
man = ""
CAN	= Request.QueryString("CAN") 
ACAN= SPLIT(CAN,",")
FOR  MM=0 TO UBOUND(aCol)
    CAD =	" exec saldoS_po_color_guia  '"&est&"' ,'"&aCol(Mm)&"', '"&ruc&"',  '"&ser&"', '"&con&"', '"&def&"', '"&ApOS(MM)&"' "         
    'RESPONSE.Write(CAD)
    RS.Open CAD, Cnn
	IF NOT RS.EOF OR NOT RS.BOF THEN RS.MOVEFIRST

    do while not rs.eof  
    ' tiene que capturar el nuemro de ID por cada linea que va a grabar
    cod =  " select isnull(RIGHT('0000000000'+(SELECT CONVERT(NUMERIC,MAX([ID])) + 1 FROM  MULTI..PO_MOVI ),10), '0000001000') "
    rs2.open cod,cnn
    rs2.movefirst
    cod = rs2.fields.item(0)
    cod = right("0000000000"+ trim(cod),10)
    rs2.close
    po  = rs("po")
    ubi = RS("ubi")

    aSal = Array(0,0,0,0,0,0,0,0,0,0)
    FOR v = 0 TO 9
        ' TENGO QUE USAR EL ARRAY DE CANTIDADES CON "M"
        ' PORQUE LAS CANTIDADES SON EL TOTAL POR COLOR
        can = "S"&v 
        ccc = formatnumber(cdbl(rs(can)),0,,true)  
        if CDBL(aCan(MM)) - ccc < 0 then
            ccc = CDBL(aCan(MM))
            Acan(MM) = 0
        else
        aCan(MM) = CDBL(aCan(MM)) - ccc
        end if
        aSal(v)= cdbl(ccc)
        
    NEXT

        man =   " INSERT INTO MULTI..PO_MOVI ( [id], po, ubi, empresa,   " & _
                " mov, guia, ruc, defecto, pieza, servicio, condicion,   " & _
                " can0, can1, can2, can3, can4, can5, can6, can7,can8,   " & _
                " can9, usuario, fecha, fecdoc,estado, BOLSA, MOTIVO,    " & _
                " LINEA, guia2, corte) values (                          " & _
                " '"&cod&"',  '"&po&"', '"&ubi&"', '"&cia&"', 'I',       " & _
                " '"&aGUI(mm)&"', '"&ruc&"', '"&def&"', '"&pza&"', '"&ser&"', " & _
                " '"&con&"', "&aSal(0)&", "&aSal(1)&", "&aSal(2)&",      " & _
                " "&aSal(3)&", "&aSal(4)&", "&aSal(5)&", "&AsAL(6)&",    " & _
                " "&AsAL(7)&", "&AsAL(8)&", "&AsAL(9)&", '"&usr&"',      " & _
                " getdate(), Convert(datetime,'"&fec&"',103),'a',        " & _
                " '"&BOL&"', '"&MOT&"', '"&LII&"', '"&g2&"','"&cor&"' ); "
        
        'response.write(man)
       'response.write("<br>")
        cnn.execute man
        if aCan(mM) = 0 then exit do 
        RS.MOVENEXT
    LOOP
   
    RS.CLOSE
next   ' del for M (aCol) 


'RESPONSE.END
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING%>
      
	Datos Actualizados del estilo <%=ucase(est)%></td>
  </tr>
    <tr style="height:30px; vertical-align:middle">       
		 <td class="estilo5" colspan="14" style="color:Navy; cursor:pointer" onclick="javascript: top.window.close()" align="center"> << C E R R A R >></td>
</tr>
</table>   
</form>    

     
<script language="jscript" type="text/jscript">
 parent.window.document.all.ENVI.style.display='none'
</script>
    </BODY>
</HTML>