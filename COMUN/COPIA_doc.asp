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

<%
alm = ucase(TRIM(Request.QueryString("alm")))
NDOC = ucase(TRIM(Request.QueryString("NDOC")))
doc = ucase(TRIM(Request.QueryString("OLD_Doc")))
can = ucase(TRIM(Request.QueryString("can")))
des = ucase(TRIM(Request.QueryString("Des")))
lin = ucase(TRIM(Request.QueryString("lin")))
cod = ucase(TRIM(Request.QueryString("cod")))

TBL1 = "RSFACCAR..AL"+CIA+"MOVC" 
TBL2 = "RSFACCAR..AL"+CIA+"MOVD" 
TBL3 = "RSFACCAR..AL"+CIA+"ASER"
TBL4 = "RSFACCAR..AL"+CIA+"STOC"
TBL5 = "RSFACCAR..AL"+CIA+"SERI"
TBL6 = "RSFACCAR..FT"+CIA+"NUME"

 cad =  " Select *  into #Cabecera from "&TBL1&"                                " & _
        " Where C5_CALMA='"&ALM&"' AND C5_CTD='GS' AND C5_CNUMDOC='"&DOC&"';    " & _
        " Select *  into #Detalle from "&TBL2&"                                 " & _
        " Where C6_CALMA='"&ALM&"' AND C6_CTD='GS' AND C6_CNUMDOC='"&DOC&"';    " & _
        " select * into  #Lote from "&TBL3&"                                    " & _
        " Where C6_CALMA='"&ALM&"' AND C6_CTD='GS' AND C6_CNUMDOC='"&DOC&"';    " & _
        " UPDATE #Cabecera                                                      " & _
        " SET C5_CNUMDOC='"&NDOC&"', C5_CSITUA='', C5_DFECCRE=getdate (),       " & _
        " C5_DFECMOD=NULL,C5_CUSUMOD='',C5_CSITGUI='V',C5_CCODAUT='' ;          " & _
        " UPDATE #Detalle                                                       " & _
        " SET C6_CNUMDOC='"&NDOC&"',C6_CSITUA='';                               " & _
        " UPDATE #Lote                                                          " & _
        " SET C6_CNUMDOC='"&NDOC&"';                                            " & _
        " Insert "&TBL1&"                                                       " & _
        " select * from #Cabecera ;                                             " & _
        " Insert "&TBL2&"                                                       " & _
        " select * from #Detalle ;                                              " & _
        " Insert "&TBL3&"                                                       " & _
        " select * from #Lote ;                                                 " & _
        " Select C6_CALMA,C6_CCODIGO,C6_CSERIE,SUM(C6_NCANTID) as C6_NCANTID    " & _
        " into #stkLote                                                         " & _
        " From "&TBL3&"                                                         " & _
        " Where C6_CALMA='"&ALM&"' AND C6_CTD='GS' AND C6_CNUMDOC='"&DOC&"'     " & _
        " GROUP BY C6_CALMA,C6_CCODIGO,C6_CSERIE ;                              " 
CNN.BEGINTRANS
'response.write cad

CNN.EXECUTE CAD

CAD = ""
kad =   " SELECT C6_CCODIGO as cod, SUM(C6_NCANTID) AS CANT      " & _
        " from #Detalle WHERE C6_CCODIGO<>'TXT' AND              " & _
        " C6_CSTOCK='S' GROUP BY C6_CCODIGO                      "
rs.open kad,cnn

'response.write ("<br>")
'response.write kad
if rs.recordcount > 0 then
rs.movefirst
    do while not rs.eof
        cant = rs("cant")
        codi = rs("cod")
     '   response.write("<br>")
     '  response.write(cant)
     '   response.write("<br>")

        cad = cad + " Update "&TBL4&"                                       " & _
	                " Set SK_NSKDIS=(SK_NSKDIS-"&cant&"),                   " & _
		            " SK_DFECMOV=GETDATE() 	Where SK_CALMA=                 " & _
                    " '"&ALM&"' AND SK_CCODIGO='"&cod&"'                    " & _
	                " Update  "&TBL5&"                                      " & _
	                " Set SR_NSKDIS=SR_NSKDIS-B.C6_NCANTID                  " & _
	                " From "&TBL5&" A                           " & _
                    " INNER JOIN #stkLote B ON(A.SR_CALMA=B.C6_CALMA AND    " & _
                    " SR_CCODIGO=C6_CCODIGO AND SR_CSERIE=C6_CSERIE) Where  " & _
	                " A.SR_CALMA='"&ALM&"' AND A.SR_CCODIGO='"&cod&"';      " 
        rs.movenext
    loop
end if


'cad = cad + " UPDATE "&TBL6&" SET  TN_NNUMERO               " & _
'           " =CAST(RIGHT(rtrim('"&NDOC&"'),7) AS INT) WHERE            " & _
'          " TN_CCODIGO='GS' AND TN_CNUMSER=SUBSTRING('"&NDOC&"',1,3)  "


cad = cad + "drop table #Cabecera; drop table #detalle; drop table #lote; drop table #stklote "
'response.write(cad)
'response.end
Cnn.Execute(CAD)

if  err.number <> 0 then%>
	
<script language="jscript" type="text/jscript">
    alert("No se han podido actualizar los datos, reintente en unos momentos")
</script>    
    
    Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	<%Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if

%>

<script language="jscript" type="text/jscript">
    alert("Datos Actualizados!")
    window.parent.window.opener.document.all.gui.value = '<%=ndoc%>'
    window.parent.window.opener.window.cargadatos()
    window.close()
 
</script>
</BODY>
</HTML>
