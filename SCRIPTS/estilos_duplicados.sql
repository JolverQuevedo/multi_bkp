

select  right(codarticulo,5) as COD_REAL , NOMBRE,ESTCLI, DESCRIPCION
from estilos 
inner join cliente on cliente.codigo = estilos.cliente
WHERE ESTILOS.ESTADO = 'A' AND  CODARTICULO <> ''  and (right(codarticulo,5) 
in (select right(codarticulo,5) from estilos WHERE ESTILOS.ESTADO = 'A' 
GROUP BY right(codarticulo,5)  HAVING COUNT(*) > 1))
and (right(codarticulo,5) + CLIENTE.CODIGO NOT
in (select right(codarticulo,5)+ESTILOS.CLIENTE from estilos 
WHERE ESTILOS.ESTADO = 'A' 
GROUP BY right(codarticulo,5)+ESTILOS.CLIENTE  HAVING COUNT(*) > 1))
order by 1
