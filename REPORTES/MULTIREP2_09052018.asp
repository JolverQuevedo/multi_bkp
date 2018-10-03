<%@ Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="multisty.CSS" />
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="../includes/Cnn.inc"-->


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Reporte <%=ucase(request.QueryString("dcl"))%></title>
<link rel="stylesheet" type="text/css" href="../multisty.CSS" />
</head>
<body topmargin="0" leftmargin="0" rightmargin="0" border="0">
<%
IF  request.QueryString("EXCEL") = "1" THEN
  archivo = "c:\temp\cajaexcel.xls"
    Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 
END IF
cli	=	Request.QueryString("cli") 
EMP	=	Request.QueryString("EMP") 
dcl	=	Request.QueryString("dcl") 
fil	=	Request.QueryString("fil") 
sbt	=	Request.QueryString("sbt") 
Ord	=	Request.QueryString("Ord") 
Ubi	=	Request.QueryString("Ubi") 
dat	=	Request.QueryString("dat") 
det	=	Request.QueryString("det") 
val = 	Request.QueryString("val") 
'ecl	=	Request.QueryString("ecl") 
'pos	=	Request.QueryString("pos") 
'CCC	=	Request.QueryString("CCC") 
'mov	=	Request.QueryString("mov") 
'GUI	=	Request.QueryString("GUI") 
'RUC	=	Request.QueryString("RUC") 
'DEF	=	Request.QueryString("DEF") 
'pza	=	Request.QueryString("pza") 
'SER	=	Request.QueryString("SER") 
'CON	=	Request.QueryString("CON") 
INI	=	Request.QueryString("INI") 
FIN =	Request.QueryString("FIN")
aFil = split(fil,",")
aSbt = split(sbt,",")
aOrd = split(ord,",")
aUbi = split(ubi,",")
aDat = split(dat,",")
aDet = split(det,",")
aVal = split(val,",")

'response.write("<br>")
' response.write(dat)
' response.write("<br>")
' response.write(det)
' response.write("<br>")
' response.write(val)
' response.write("<br>")
' 'ordenar todas columnas de acuerdo a su ubicacion
For i = LBound(aUbi) to UBound(aUbi)
  For j = LBound(aUbi) to UBound(aUbi) - 1
      If cint(aUbi(j)) > cint(aUbi(j + 1)) Then
         Tmp1        = aUbi(j + 1)
         aUbi(j + 1) = aUbi(j)
         aUbi(j)     = Tmp1
         
         Tmp2        = aDat(j + 1)
         aDat(j + 1) = aDat(j)
         aDat(j)     = Tmp2

         Tmp3        = aDet(j + 1)
         aDet(j + 1) = aDet(j)
         aDet(j)     = Tmp3

         Tmp4        = aFil(j + 1)
         aFil(j + 1) = aFil(j)
         aFil(j)     = Tmp4

         Tmp5        = aSbt(j + 1)
         aSbt(j + 1) = aSbt(j)
         aSbt(j)     = Tmp5

        
         IF J < UBound(aUbi) - 3 THEN

             Tmp7        = aVal(j + 1)
             aVal(j + 1) = aVal(j)
             aVal(j)     = Tmp7
         END IF
      End If
  Next
Next

CAD =	"SET DATEFORMAT DMY; SELECT  [ID], NOMCLI, "  
for i= 1 to ubound(aubi)-3
    if cint(aUbi(i)) > 0 then
        dat = UCASE(aDat(i))
        cad = cad + " "&dat&" , "
        if len(trim(adet(i)))  > 1 then 
            det = UCASE(adet(i))
            cad = cad + " "&det&" , "
        end if
    end if
next
cad = cad + "T0,T1,T2,T3,T4,T5,T6,T7,T8,T9, C0,C1,C2,C3,C4,C5,C6,C7,C8,C9  "

cad = cad + " from view_pos_movi  where estado = 'a' " 

FOR I= 1 TO UBOUND(aVal)
   if len(trim(aVal(i))) > 0 then
       if trim(UCASE(aDat(i))) = "FECDOC" then
           cad = cad + " and fecdoc between Convert(datetime,'"&ini&"',103)  and Convert(datetime,'"&fin&"',103) "
        else
            val = UCASE(aVal(i))
            col = replace(UCASE(aDat(i))," ","")
            cad = cad + " and replace("&col&",' ' , '') = '"&val&"' "
        end if
    end if
next

I1 = request.QueryString("id1")
I2 = request.QueryString("id2")

if len(trim(I1)) > 0 then  
    ID1 = RIGHT("0000000000"+ TRIM(I1),10)
    ID2 = RIGHT("0000000000"+ TRIM(I2),10)
    cad = cad + " and ([id] >= '"&ID1&"' and  [id] <= '"&ID2&"'  ) "
END IF

'response.write(ord)
'response.write("<br>")
'response.write(Request.QueryString("dat") )
'response.write("<br>")
'
aInd = split(Request.QueryString("dat") ,",")

For i = LBound(aOrd) to UBound(aOrd)
  For j = LBound(aOrd) to UBound(aOrd) - 1
      If aOrd(j) > aOrd(j + 1) Then
        Tmp1        = aInd(j + 1)
        aInd(j + 1) = aInd(j)
        aInd(j)     = Tmp1

        Tmp6        = aOrd(j + 1)
        aOrd(j + 1) = aOrd(j)
        aOrd(j)     = Tmp6
      End If
  Next
Next

bbb = ""
FOR I= 1 TO UBOUND(aOrd)
    if cint(aOrd(i)) > 0 then
        met = aInd(i)
        bbb = bbb + " "&met&" , "
    end if
next
if len(trim(bbb)) > 0 then
    bbb = left(trim(bbb),len(trim(bbb))-1)
	cad = cad +	" ORDER BY " + bbb + ", 1"
else
    cad = cad + "order by 1"
end if


'response.Write(cad)
	RS.OPEN CAD ,Cnn
		
If rs.eof or rs.bof then
	Response.Write("No hay registros que cumplan el criterio solicitado")		
	Response.End
end if	
LIMITE =  rs.fields.count - 1

rs.movefirst
%>
<table width="100%">
	<tr>
	    <td width="5%">&nbsp;</td>
		<td  align="center" class="Estilo2"><%=ucase(DCL)%></td>
		<td  align="right" width="5%"> 
		  	<img src="../images/logo.jpg" alt="" border="0" />
		  </td>
        </tr>
	<tr><td  colspan="3"><hr /></td></tr>
</table>
<table id="TABLA" align="center" width="100%" cellpadding="0" cellspacing="0" bordercolor='<%=application("color2") %>' border="0" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>

<%cont = 0%>
<tr >
	<%for I=0 to LIMITE-20 %>
		<td class="Estilo3"><%=trim(RS.FIELDS(I).name)%>&nbsp;</td>
	<%next%>	
    <%for I=LIMITE-19 to LIMITE-10 %>
		<td class="Estilo3"><%=trim(RS.FIELDS.ITEM(I))%>&nbsp;</td>
	<%next%>	
    <td class="Estilo3">TOTAL</td>
    
</tr>
<%aTot= array(0,0,0,0,0,0,0,0,0,0,0) %>
<%do while not rs.eof%>
<tr bgcolor="<%IF CONT MOD 2 = 0 THEN RESPONSE.WRITE(application("color1")) ELSE RESPONSE.WRITE(application("color2"))%>">
	<%FOR i=0 TO limite-20%>
		<td class="Estilo5"><%=(trim(rs.fields.item(i)))%></td>
	<%NEXT%>
    <%st=0
    j=0 %>
    <%FOR i=LIMITE-9 TO limite%>
        <%st = st + cint(rs.fields.item(i))  
        aTot(j) = aTot(j) + cint(rs.fields.item(i))   
        aTot(ubound(atot)) = aTot(ubound(atot)) + cint(rs.fields.item(i))%>
		<td class="Estilo5" align="right" style="padding-right:10px;"><%=(trim(rs.fields.item(i)))%></td>
        <%j= j + 1 %>
	<%NEXT%>
    	<td class="Estilo5" align="right" style="padding-right:10px;"><%=st%></td>
       
</tr>
    <%RS.MOVENEXT%>
	<%if rs.eof then exit do%>
    <%CONT = CONT + 1%>
<%loop%>

<tr bgcolor="<%=(application("barra"))%>">
	<%FOR i=0 TO limite-20%>
		<td class="Estilo5">&nbsp;</td>
	<%NEXT%>
    <%st=0 %>
    <%FOR i=0 TO ubound(atot)%>
		<td class="Estilo5" align="right" style="padding-right:10px;"><%=aTot(i)%></td>
	<%NEXT%>
    	
       
</tr>


</table>
</body>
</html>
