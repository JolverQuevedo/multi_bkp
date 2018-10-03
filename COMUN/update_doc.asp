<%@ Language=VBScript %>
<%Response.Buffer = TRUE %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")
    Session.LCID=2057%>
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
ctd = ucase(TRIM(Request.QueryString("ctd")))
doc = ucase(TRIM(Request.QueryString("Doc")))
can = replace(ucase(TRIM(Request.QueryString("can"))),",","")
des = ucase(TRIM(Request.QueryString("Des")))
lin = ucase(TRIM(Request.QueryString("lin")))
cod = ucase(TRIM(Request.QueryString("cod")))

TBL1 = "RSFACCAR..AL"+CIA+"STOC" 
TBL2 = "RS_ALMOVD" + CIA
TBL3 = "RS_ALMOVD_TALLA" + CIA
TBL4 = "RSFACCAR..AL"+CIA+"MOVD" 



'response.end


	cad = " Update "&tbl4&" SET C6_CDESCRI = '"&des&"'          " & _
	      " Where C6_CALMA='"&alm&"' AND C6_CTD='"&CTD&"'       " & _
          " AND C6_CNUMDOC='"&DOC&"' AND C6_CITEM='"&lin&"' ;   "

IF cod <> "TXT" then
	kad =   " SELECT C6_NCANTID as old_can, C6_CSTOCK as stk    " & _
	        " FROM "&tbl4&"                                     " & _
	        " Where C6_CALMA='"&alm&"' AND C6_CTD='"&CTD&"'     " & _
            " AND C6_CNUMDOC='"&DOC&"' AND C6_CITEM='"&lin&"'   "
    rs.open kad,cnn
    RS.MOVEFIRST
    if rs.recordcount > 0 then 
        CSTK = RS("STK")
        OLDC = RS("OLD_CAN")
    else
        CSTK = 0
        OLDC = 0
    end if 
	cad =   cad + " UPDATE "&tbl4&" SET C6_NCANTID="&CAN&",     " & _
            " c6_ccodigo = '"&COD&"'                            " & _
	        " Where C6_CALMA='"&alm&"' AND C6_CTD='"&CTD&"'     " & _
            " AND C6_CNUMDOC='"&DOC&"' AND C6_CITEM='"&lin&"'   "

	IF CSTK ="S"  THEN
		IF CTD="PE" THEN
			CAD = CAD + " Update "&TBL1&"                               " & _
			            " Set SK_NSKDIS=(SK_NSKDIS-"&OLDC&"+"&CAN&"),   " & _
				        " SK_DFECMOV=GETDATE()              Where       " & _
			            " SK_CALMA='"&ALM&"' AND SK_CCODIGO='"&COD&"';  " 
		ELSE
            CAD = CAD + " Update "&TBL1&"                               " & _
			            " Set SK_NSKDIS=(SK_NSKDIS+"&OLDC&"-"&CAN&"),   " & _
				        " SK_DFECMOV=GETDATE()              Where       " & _
			            " SK_CALMA='"&ALM&"' AND SK_CCODIGO='"&COD&"';  " 
        END IF
	END IF
END IF

'response.write(cad)
Cnn.Execute(CAD)
%>

<script language="jscript" type="text/jscript">
 

    alert("Datos Actualizados!")

    window.opener.window.parent.window.cargadatos()
    window.close()
 
</script>
</BODY>
</HTML>
