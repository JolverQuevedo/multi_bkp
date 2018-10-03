<%@ Language=VBScript %>
<%Response.Buffer = TRUE %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%'response.write(Request.QueryString())
' PRIMERO hay que revisar el Stock de los avios
' si sale algun negativo se cancela todo
RUC = request.QueryString("RUC")
cod = request.QueryString("cod")
aCod = split(Cod, ",")
can = request.QueryString("can")
aCan = split(can, ",")
des = request.QueryString("des")
RESPONSE.WRITE(DES)
 RESPONSE.WRITE("<BR>")
aDes = split(des, ",")
aStk = array(ubound(aCod))
age = ucase(request.QueryString("age"))
srv = ucase(request.QueryString("ser"))
GUIA = cdbl(ucase(request.QueryString("GUI")))

nom = ucase(request.QueryString("nom"))
dir = ucase(request.QueryString("dir"))
trs = ucase(request.QueryString("tra"))
dtr = ucase(request.QueryString("dtr"))
emi = ucase(request.QueryString("emi"))
pos = request.QueryString("pos")
pos = "'" + replace(pos, ",", "','") + "'"

alm = request.QueryString("alm")
if len(trim(alm)) = 0 then alm = "00M2"


idd = request.QueryString("idd")
idd = "'" + replace(idd, ",", "','") + "'"
'response.write(pos)
'RESPONSE.WRITE("<BR>")
'RESPONSE.WRITE("<BR>")
'response.end
tbl1 = "RSFACCAR..AL"+cia+"ALMA"
tbl2 = "RSFACCAR..AL"+cia+"MOVC"
tbl3 = "RSFACCAR..AL"+cia+"ARTI"
tbl4 = "RSFACCAR..AL"+cia+"MOVD"
tbl5 = "RSFACCAR..AL"+cia+"STOC"
tbl6 = "RSFACCAR..FT"+cia+"NUME"
TBL7 = "RSCONCAR..CP"+CIA+"MAES"
Cnn.BeginTrans	

' ************************************************************************************************* 
' Partes de entrada para las PRENDAS de la GUIA
' *************************************************************************************************
rs.open "Select A1_NNUMENT+1 as conta From "&tbl1&" Where A1_CALMA='"&ALM&"'" , cnn
rs.movefirst 
PENT = RIGHT("00000000000"+TRIM(rs("conta")),11)
rs.close

CAD =   " set dateformat dmy ; Update "&TBL1&"  Set A1_NNUMENT =    " & _
        " (Select A1_NNUMENT+1 From "&tbl1&" Where A1_CALMA='"&ALM&"') " & _ 
        " Where A1_CALMA='"&ALM&"' ;                                   "

Cnn.Execute(CAD)
Cnn.CommitTrans	

cnn.BeginTrans
prenda = request.QueryString("PDA")
' ****************************************************
' RESPONSE.WRITE(request.QueryString("KNT"))
' ****************************************************
CANTIDAD = request.QueryString("KNT")
estilo = request.QueryString("est")
srv = request.QueryString("Ser")
rs.open "select descripcion from servicios where codigo = '"&srv&"'" , cnn
rs.movefirst
servicio = "SERVICIO DE " + ucase(ltrim(rtrim(rs("descripcion"))))
rs.close
' cabecera de prendas
' hay que hacer el ingreso para poder hacer la salida de stock
rs.open "Select ar_cdescri From "&tbl3&" Where AR_CCODIGO='"&prenda&"' " , cnn
if rs.recordcount <= 0 Then
    response.write("<font size =5 color = red>")
    response.write("Codigo de Prenda no Existe en el Real")
    Cnn.RollbackTrans
    response.end
end if
rs.movefirst
descripcion =  ucase(trim(rs("ar_cdescri")))
rs.close
cad= ""
cad =  cad +    " Insert Into "&TBL2&" (C5_CALMA,C5_CTD,C5_CTIPMOV,C5_CCODMOV,C5_CNUMDOC,C5_DFECDOC,C5_CCODPRO,C5_CRFTDOC,C5_CRFTDO2,   " & _
                " C5_CRFNDOC,C5_CRFNDO2,C5_CNUMORD,C5_CCIAS,C5_CORDEN,C5_CSOLI,C5_CCENCOS,C5_CRFALMA,C5_CCODCLI,C5_CCODANE,C5_CGLOSA1,  " & _
                " C5_CGLOSA2, C5_CGLOSA3, C5_CNOMPRO, C5_CNOMCLI, C5_DFECCRE, C5_CUSUCRE, C5_CLOCALI, C5_CCODMON, C5_NTIPCAM, C5_CTIPO, " & _
                " c5_csitua) " & _
                " Values('"&ALM&"', 'PE', 'E', 'PP', '"&pent&"', Convert(datetime,'"&emi&"',103)  , '','','','', '','', '',  '"&estilo&"', " & _
                "  '', '', '', '', '', '"&servicio&"',  '', '', '   ', '',  Convert(datetime,'"&emi&"',103)  , 'MHD  ', '0001',         " & _
                " 'US', 3.25, 'C','V' ) ;                                                                                                   " 


' detalle de la tabla de movimientos  PRENDAS
cad = cad + " Insert Into "&tbl4&" (C6_CALMA, C6_CTD, C6_CNUMDOC, C6_CCODMOV, C6_CITEM, C6_CCODIGO, C6_CDESCRI,                    " & _
            "  C6_CORDEN, C6_NCANTID, C6_DFECDOC, C6_CLOCALI,C6_CSOLI, c6_npreun1, c6_npreuni, c6_nmnprun, c6_nusprun, c6_ccodmon, " & _
            " c6_ctipo, c6_ntipcam, c6_nvaltot, c6_nmnimpo, c6_nusimpo, c6_cestado  ) Values('"&ALM&"', 'PE', '"&pent&"', 'PP',                   " & _
            " '0001','"&prenda&" ','"&descripcion&"','"&estilo&"',"&CANTIDAD&",  Convert(datetime,'"&emi&"',103)  ,'0001','',      " & _
            " 0.01, 0.01, 0.0325, 0.01, 'US', 'C', 3.25, 0.01*"&CANTIDAD&",0.0325*"&CANTIDAD&",0.01*"&CANTIDAD&", 'V') ;                "

' ingresa el stock en el almacen (para poder hacer la salida con guia...
    rs.open "select * from "&tbl5&"  where SK_CALMA = '"&ALM&"' and SK_CCODIGO = '"&prenda&"' ", cnn
if rs.recordcount <= 0 then
    cad = cad + " Insert Into "&tbl5&" (SK_CALMA, SK_CCODIGO, SK_NSKDIS, SK_DFECMOV) Values('"&ALM&"', '"&PRENDA&"',               " & _
                " "&CANTIDAD&",  Convert(datetime,'"&emi&"',103)   );                                                           "
Else
    cad = cad + " update  "&tbl5&" set SK_NSKDIS =  SK_NSKDIS + "&cantidad&", SK_DFECMOV = Convert(datetime,'"&emi&"',103) where SK_CALMA = '"&ALM&"' and SK_CCODIGO = '"&prenda&"' ; "
End If
'response.write(request.QueryString())
'rESPONSE.WRITE("<BR>")
'RESPONSE.WRITE("<BR>")
 rs.close
'response.end
Cnn.Execute(CAD)

'verifica y actualiza el stock de todos los avios del array de codigos y que no genere ningun negativo
for i=0 to ubound(aCod)
    cn = cdbl(aCan(i))
   
    'response.Write(aCod(i))
    KAD = "Select SK_NSKDIS - "&cn&" as stk From "&tbl5&" Where SK_CALMA='"&ALM&"' AND SK_CCODIGO='"&aCod(i)&"' "
    rs.open KAD , cnn
    if rs.recordcount > 0 then
    rs.movefirst
        if cdbl(rs("stk")) < 0 then%>
            <script language="jscript" type="text/jscript">
                alert("Se genera un negativo en el avio " + '<%=aCod(i)%>' + "DE : " + <%= RS("STK")%>)
            </script>
            <%
           
            Cnn.RollbackTrans
            response.End
        else
            cnn.execute ("update  "&tbl5&" set SK_NSKDIS = SK_NSKDIS - "&cn&" Where SK_CALMA='"&ALM&"' AND SK_CCODIGO='"&aCod(i)&"' ")
           'RESPONSE.WRITE(".............")
           'RESPONSE.WRITE(KAD )
           'RESPONSE.WRITE("<BR>")
        end if
    end if
    rs.close
next


'Cnn.RollbackTrans
'response.end
' *************************************************************************************************
'   ya tengo las cantidades verificadas y el ingreso de las prendas a la tabla de stocks
'   solo queda generar los movimientos para la guia
' *************************************************************************************************
'   PRIMERO : EL NUMERADOR DE GUIAS
'   SEGUNDO : GENERAR LA CABECERA
'   TERCERO : INSERTAR LAS LINEAS DE DETALLE
'   CUARTO  : ACTUALIZAR EL STOCK

'rs.close
CAD = ""
rs.open "Select TN_NNUMERO+1 as contador From "&tbl6&" Where TN_CCODIGO='GS' AND TN_CNUMSER='001'" , cnn
rs.movefirst 


if cdbl(guia) > CDBL(rs("contador")) then
    NUMGUI = GUIA
    guia = "001"+ right("0000000"+trim(guia),7)
    numero = rs("contador")
    CAD = cad +     " Update "&TBL6&"  Set TN_NNUMERO =   "&NUMGUI&"                                " & _ 
                "  Where TN_CCODIGO='GS' AND TN_CNUMSER='001' ;                                     "
ELSE
    guia = "001"+ right("0000000"+trim(GUIA),7)
END IF
' RESPONSE.WRITE("<BR>")
' RESPONSE.WRITE(numgui)
' RESPONSE.WRITE("<BR>")
' RESPONSE.WRITE("<BR>")
' RESPONSE.WRITE( CDBL(rs("contador")))
' RESPONSE.WRITE("<BR>")
' RESPONSE.WRITE(cdbl(guia) > CDBL(rs("contador")))
' RESPONSE.WRITE("<BR>")


rs.close
rs.open "SELECT  AC_CNOMBRE as nombre From "&TBL7&" Where AC_CVANEXO='P' AND AC_CCODIGO='"&RUC&"'", cnn
rs.movefirst
nombre = rs("nombre")
rs.close
cad = cad +     " Insert Into "&tbl2&" ( C5_CALMA, C5_CTD, C5_CTIPMOV, C5_CCODMOV, C5_CNUMDOC,          " & _
                " C5_DFECDOC, C5_CCODPRO, C5_CNOMPRO, C5_CRFTDOC, C5_CRFNDOC,C5_CRFTDO2, C5_CRFNDO2,    " & _
                " C5_CNUMORD, C5_CSOLI, C5_CCENCOS, C5_CRFALMA, C5_CCODCLI, C5_CNOMCLI, C5_CRUC,        " & _
                " C5_CGLOSA1, C5_CGLOSA2, C5_CGLOSA3, C5_CCODTRA, C5_CNOMTRA, C5_CCODVEH,               " & _
                " C5_CDESTIN, C5_CDIRENV, C5_CTIPOGS, C5_CTIPGUI, C5_CSITGUI, C5_CGUIFAC,C5_CCODAGE,    " & _
                " C5_CLOCALI, C5_CTIPFOR, C5_CTF, C5_DFECEMB, C5_DFECCRE, C5_CUSUCRE, C5_CFLGPEN,       " & _
                " C5_CTIPO, c5_ccodmon, c5_ccodaut, C5_CSITUA, C5_NTIPCAM)       " & _
                " Values('"&ALM&"','GS','S','12','"&guia&"', Convert(datetime,'"&emi&"',103)  ,'"&ruc&"',  " & _
                "   '"&nombre&"',                                                                       " & _
                " 'GS', '"&age&"', '', '', '', 'CH','20000', '', '', '', '', '', '', '"&serVICIO&"',    " & _
                " '"&trs&"','"&dtr&"', '', '', '"&dir&"', 'N', '12', 'V', '', '', '0001', '51','01',    " & _
                " Convert(datetime,'"&emi&"',103),Convert(datetime,'"&emi&"',103), '"&usr&" ','F',      " & _
                " 'C','US', 'S','V', 3.25);     "


' primero va la linea de Prendas y luego los avios
canpre = 0
for i= 0 to ubound(aCod)
        lin = right("0000"+ trim(cstr(i)),4)
' inserta detalle de movimiento  GUIA
' tengo problema con  las lineas donde se describen las PO's por prenda porque en la impresion jala el descriptor
' de la prenda !!!!!!!!!!!!!!!
' voy a grabar una linea de texto para cada PO y acumular el total de prendas 
' luego grabar una linea adicional con la cantidad y codigo de prenda
' A VER SI FUNCIONA!!!!!!!!!!!!!!!!!!!!!!!!
' RESPONSE.WRITE("<br>")
' RESPONSE.WRITE("<br>")
' RESPONSE.WRITE(Acod(I)) 
' RESPONSE.WRITE(" **** ")
' RESPONSE.WRITE(AdES(I))
' RESPONSE.WRITE("<br>")
RESPONSE.WRITE("<br>")
if trim(aDes(i)) = "" then 
    cad =  cad +    " Insert Into "&tbl4&" (C6_CALMA, C6_CTD, C6_CNUMDOC, C6_CCODMOV, C6_CITEM, C6_CCODIGO,     " & _
                    " C6_CDESCRI, C6_NCANTID, C6_NUNXENV, C6_NNUMENV, C6_CSERIE, C6_DFECDOC, C6_CSOLI,          " & _
                    " C6_NPESO, C6_CCENCOS, C6_CRFALMA, C6_CESTADO, C6_CLOCALI, C6_NCANTEN, C6_CSTOCK, C6_CTR,  " & _
                    " c6_ccodmon, c6_ctipo, c6_ntipcam, c6_nvaltot, c6_nmnimpo, c6_nusimpo, C6_NPREUNI,         " & _
                    " C6_NPREUN1, c6_nusprun, c6_nmnprun)                                                       " & _
                    " Values   ('"&ALM&"','GS','"&guia&"','12','"&lin&"','"&aCod(i)&"',                         " 
            pak =  "(Select LEFT(AR_CDESCRI,50) as descri From "&tbl3&" Where AR_CCODIGO='"&aCod(i)&"')         "
         ' RESPONSE.WRITE("<BR>")
         ' RESPONSE.WRITE(pak)
         ' RESPONSE.WRITE("<BR>")
         ' RESPONSE.WRITE("<BR>")
           rs.open pak , cnn
           IF RS.RECORDCOUNT > 0 THEN 
            rs.movefirst
            if ucase(trim(acod(i))) <> "TXT" then  aDes(i) = RTRIM(Ltrim(rs("descri")))
          
           rs.close
           tot1 = 0
           tot2 = 0
           tot3 = 0
           KKK =    " (select isnull(AR_NPRECOS,0) as ar_nprecos, isnull(AR_NPRECOM,0) as ar_nprecom,           " & _
                    " isnull(ar_nprefob,0) as ar_nprefob, isnull(AR_CMONFOB,'') as ar_cmonfob,                  " & _
                    " isnull(ar_cmoncos, '') as ar_cmoncos  from "&tbl3&"  where ar_ccodigo  = '"&aCod(i)&"')   "
           rs.open KKK, CNN
          ' RESPONSE.WRITE(KKK)
           rs.movefirst
           if len(trim(rs("ar_cmoncos"))) <= 0 then mon = trim(rs("ar_cmonfob")) else mon = trim(rs("ar_cmoncos"))
           
           if CDBL(rs("AR_NPRECOS")) > 0 then   
                cosT = CDBL(rs("ar_nprecos")) 
           elseif CDBL(rs("ar_nprecom")) > 0 then 
                cosT = CDBL(rs("ar_nprecom")) 
           else 
                cosT= CDBL(rs("ar_nprefob"))
           END IF 
           if mon = "US" then us = cost else us=cost*3.25
           if mon = "MN" then mn = cost else mn=cost/3.25
           tot1 = cosT * acan(i)

           if ltrim(rtrim(ucase(mon))) = "US"  then   
                tot2 = acan(i) * cosT * 3.25
                tot3 = acan(i)* cosT 
           else  ' soles
                tot2 = acan(i) * cosT
                tot3 = (acan(i)* cosT) / 3.25
           end if
         '  RESPONSE.WRITE(TOT2)
         '  RESPONSE.WRITE("<br>")
         '  RESPONSE.WRITE("<br>")
         '  RESPONSE.WRITE("<br>")
           rs.close
           cad = cad + " '"& LEFT(Ltrim(RTRIM(aDes(i))),50)&"'                          "
           cad = cad + " , "&aCan(i)&", 0, 0, '',  Convert(datetime,'"&emi&"',103)  ,   " 
           cad = cad + " 'CH',0, '20000', '', 'V', '0001', "&aCan(i)&" ,'S', '',        " & _ 
                       " '"&mon&"' , '', 3.25, "&tot1&", "&tot2&", "&tot3&" , "&COST&", " & _
                       " "&COST&", "&mn&", "&us&") ;        "
          else
             ' ES UNA LINEA DE TXT
            cad = cad + " '"& LEFT(Ltrim(RTRIM(aDes(i))),50)&"'                          "
            cad = cad + " , 0, 0, 0, '',  Convert(datetime,'"&emi&"',103)  ,   " 
            cad = cad + " 'CH',0, '20000', '', 'V', '0001', 0 ,'S', '',        " & _ 
                        " 'MN' , '', 3.25, 0, 0, 0 , 0, " & _
                        " 0, 0, 0) ;        "
             RS.CLOSE
          END IF
    else
      
        cad =  cad +    " Insert Into "&tbl4&" (C6_CALMA, C6_CTD, C6_CNUMDOC, C6_CCODMOV, C6_CITEM, C6_CCODIGO,     " & _
                        " C6_CDESCRI, C6_NCANTID, C6_NUNXENV, C6_NNUMENV, C6_CSERIE, C6_DFECDOC, C6_CSOLI,          " & _
                        " C6_NPESO, C6_CCENCOS, C6_CRFALMA, C6_CESTADO, C6_CLOCALI, C6_NCANTEN, C6_CSTOCK, C6_CTR)  " & _
                        " Values   ('"&ALM&"','GS','"&guia&"','12','"&lin&"','TXT',                                    "
        cad = cad +   " '"& LEFT(Ltrim(RTRIM(aDes(i))),50)&"' "
        cad = cad +     " , 0, 0, 0, '',  Convert(datetime,'"&emi&"',103)  ,'CH',0, '20000', '', 'V', '0001', 0 ,'S', 'T') ;                  "
        canpre = canpre + cdbl(aCan(i))

   End if

next


' aca recien voy a adicionar la linea con el total de prendas
 lin = right("0000"+ trim(cstr(i)),4)
cad =  cad +    " Insert Into "&tbl4&" (C6_CALMA, C6_CTD, C6_CNUMDOC, C6_CCODMOV, C6_CITEM, C6_CCODIGO,         " & _
                    " C6_CDESCRI, C6_NCANTID, C6_NUNXENV, C6_NNUMENV, C6_CSERIE, C6_DFECDOC, C6_CSOLI,          " & _
                    " C6_NPESO, C6_CCENCOS, C6_CRFALMA, C6_CESTADO, C6_CLOCALI, C6_NCANTEN, C6_CSTOCK, C6_CTR,  " & _
                    " c6_ntipcam, c6_nvaltot, c6_nmnimpo, c6_nusimpo, C6_NPREUNI, C6_NPREUN1  )                             " & _
                    " Values   ('"&ALM&"','GS','"&guia&"','12','"&lin&"','"&prenda&"',                            " 
           rs.open "(Select LEFT(AR_CDESCRI,50) as descri From "&tbl3&" Where AR_CCODIGO='"&prenda&"')" , cnn
           rs.movefirst
           aDesc = rs("descri")
           rs.close
           cad = cad +   " '"& LEFT(aDesc,50)&"' "
    cad = cad +     " , "&canpre&", 0, 0, '',  Convert(datetime,'"&emi&"',103)  ,'CH',0, '20000', '', 'V', '0001', "&canpre&" ,'S', '', " & _
                    " 3.25, 0.01*"&CANPRE&",0.0325*"&CANPRE&",0.01*"&CANPRE&", 0.01, 0.01) ;                 "

cad = cad + " update po_movi set guia = '"&guia&"' where id in ("&idd&") ;      "



response.Write(cad)

'response.end


Cnn.Execute(CAD)

if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	
else
	Cnn.CommitTrans	
end if

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	


'response.write(cad)
response.end
'Cnn.Execute(CAD)
%>
</BODY>
</HTML>
