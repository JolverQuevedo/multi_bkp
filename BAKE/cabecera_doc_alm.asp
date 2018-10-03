<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/COMUNqry.ASP"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<link REL="stylesheet" TYPE="text/css" HREF="../MULTISTY.CSS" >
<%
alm	= Request.QueryString("alm") 
doc	= Request.QueryString("doc") 
ctd	= Request.QueryString("ctd") 
TBL = "RSFACCAR..AL" + CIA + "movc"


cad = "Select * from "&tbl&" Where C5_CALMA='"&alm&"' AND C5_CTD='" & ctd & "' AND C5_CNUMDOC LIKE '%"&doc&"'"
RESPONSE.Write(CAD)
	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
		RS.MOVEFIRST
        cod = rs("c5_ccodpro")
        des = rs("c5_cnompro") 
        FEC = rs("c5_dfecdoc")
        EDO = rs("c5_csitgui")
        DOC = rs("c5_cnumdoc")

        %>
        <script language="javascript" type="text/jscript">
            COD = '<%=cod %>'
            DES = '<%=des %>'
            FEC = '<%=FEC %>'
            EDO = '<%=EDO %>'
            DOC = '<%=doc %>'
            parent.window.document.all.ruc.value=COD
            parent.window.document.all.pr.value = DES
            parent.window.document.all.fec.value = FEC
            parent.window.document.all.gui.value = DOC
            if (trim(EDO) == 'A') {
                parent.window.document.all.edo.value = 'ANULADO'
                parent.window.document.all.uno.disabled = true
                parent.window.document.all.dos.disabled = true
                parent.window.document.all.tres.disabled = false
                parent.window.document.all.cuatro.disabled = false
                OPC = 0
            }
            else {
                parent.window.document.all.edo.value = 'VALORIZADO'
                parent.window.document.all.uno.disabled = false
                parent.window.document.all.dos.disabled = false
                parent.window.document.all.tres.disabled = true
                parent.window.document.all.cuatro.disabled = true
                OPC = 1
            }
        cad  = 'frames/deta_doc_alm.asp'
        cad += '?doc=' + DOC
        cad += '&CTD=' + '<%=ctd%>'
        cad += '&alm=' + '<%=alm%>'
        cad += '&OPC=' + OPC
        parent.window.document.all.lineas.src = cad
        </script>
        <%else %>
            <script language="javascript" type="text/jscript">
                alert("Documento no ENCONTRADO...")
                parent.window.document.all.ruc.value = ''
                parent.window.document.all.pr.value = ''
                parent.window.document.all.edo.value = ''
                parent.window.document.all.alm.selectedIndex = -1
                parent.window.document.all.mov.selectedIndex = -1
                parent.window.document.all.gui.value = ''
                parent.window.document.all.fec.value = ''
                parent.window.document.all.lineas.src = 'blanco.htm'
                parent.window.document.all.uno.disabled = true
                parent.window.document.all.dos.disabled = true
                parent.window.document.all.tres.disabled = true
                parent.window.document.all.cuatro.disabled = true
            </script>
	<%eND IF %>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">


</HEAD>
<BODY >


<%
	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
    </BODY>
</HTML>