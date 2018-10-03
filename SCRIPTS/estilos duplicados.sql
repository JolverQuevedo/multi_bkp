select distinct right(codarticulo,5) as COD_REAL ,
right(codarticulo,5) + ltrim(rtrim(estcli)) as largo,
cliente.codigo as CODCLI, NOMBRE from estilos 
inner join cliente on cliente.codigo = estilos.cliente
where (right(codarticulo,5) + ltrim(rtrim(estcli)) in (select right(codarticulo,5) + ltrim(rtrim(estcli)) from estilos WHERE ESTILOS.ESTADO = 'A'
GROUP BY right(codarticulo,5) + ltrim(rtrim(estcli)) HAVING COUNT(*) > 1))
AND CODARTICULO <> '' AND ESTILOS.ESTADO = 'A'
order by 1
 
 
/*select cliente.codigo as CODCLI, NOMBRE,  CODEST, ESTCLI, DESCRIPCION, CODARTICULO, estilos.estado from estilos 
inner join cliente on cliente.codigo = estilos.cliente
where right(codarticulo,5) ='17458'
*/