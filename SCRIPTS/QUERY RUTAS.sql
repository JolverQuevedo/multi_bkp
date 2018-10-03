SELECT COTIZACION, TELA, ID, SERVICIO,
ORDEN,MERMA,COSTO 
FROM COTIRUTA
WHERE TELA = '6000001' AND ID = '99'


select CODIGO, S1.DESCRIPCION, S1.MERMA, unidad, moneda, 
costo = case when moneda = 'MN' then costo * (select top 1 xmeimp2 
from rsconcar..CTCAMB order by xfeccam desc) else costo * 1 end 

from TELARUTADETA AS T1 
INNER JOIN SERVICIOS AS S1 ON T1.SERVICIO = S1.CODIGO 
WHERE TELA ='600001 ' AND VERSION ='001' 
ORDER BY OPC 