<%
Set cnn = Server.CreateObject("ADODB.Connection")
cnn.CommandTimeout = 900

'***********************************************************************************************
'   ESTE ES EL QUE ESTOY USANDO EN LA CASA y en EL MODELADOR
'***********************************************************************************************
dim txtConexion

' MODELADOR
'	txtConexion = "Provider=SQLOLEDB.1;Data Source=192.168.3.4;Initial Catalog=multi; User id=SA; Password=F3QY17;"
'	txtConexion = "Provider=SQLOLEDB.1;Data Source=192.168.3.30;Initial Catalog=multi; User id=sa; Password=c4r4m3l1t0;"
txtConexion = "Provider=SQLNCLI; Data Source=192.168.3.4 ; Initial Catalog=MULTI; User id=SA; Password=F3QY17"
 
 Cnn.Open txtConexion

Set RS = Server.CreateObject("ADODB.Recordset")
	RS.ActiveConnection = Cnn
	
	RS.CursorType       = 3 'CONST adOpenStatic = 3
	RS.LockType         = 1 'CONST adReadOnly = 1
	RS.CursorLocation   = 3 'CONST adUseClient = 3
set txtConexion = nothing

' DEVELOPER - Modelador
'   txtConexion = "DRIVER={SQL Server};SERVER=localhost;Database=multi;Uid=sa;PWD=c4r4m3l1t0"
'CASA
	

%>
