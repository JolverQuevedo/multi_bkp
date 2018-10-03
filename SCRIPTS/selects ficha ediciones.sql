select destipomov+space(50)+codtipomov from AL_TiposMov0001 where CodClaseMov='S' 
AND codtipomov in(select distinct codtipomov from AL_TipoMovxAlmacen0001 where 
codalmacen='00MT')  order by 1

select CESTANTE+ ' ['+FILA+CAST(COLUMNA AS VARCHAR(5))+']'+space(100)+cubicacion 
from RS_ALMOV_UBICACION0001 
where CALMA='00MT' order by CESTANTE,FILA,COLUMNA

Select Talla, Cantidad From RS_ALMOVD_TALLA0001 Where calma='"&alm&"' and CTD='"&ctd&"' and CNUMDOC='"&doc&"' and CITEM='"&itm&"' 
ORDER BY orden

select * from RS_ALMOVD0001 WHERE CALMA='00MT' AND CTD='PE' AND CNUMDOC='00009008900' AND CITEM='0002'    

Select Talla, Cantidad From RS_ALMOVD_TALLA0001 Where calma='00mt' and CTD='ps' and CNUMDOC='00009008900' and CITEM='0005' 
ORDER BY orden