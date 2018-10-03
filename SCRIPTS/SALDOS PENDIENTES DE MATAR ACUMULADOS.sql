
select  po, ofi, color, ubi, cia,codcli, nomcli,fob,estilo, ruc, nompro,
coddef, desdef, codpza,despza, codser, desser,codcon, descon, t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,
q0, q1, q2,q3,q4,q5,q6,q7,q8,q9,
c0= SUM(case when mov = 'i' then c0 *-1 else c0 end),
c1= SUM(case when mov = 'i' then c1 *-1 else c1 end),
c2= SUM(case when mov = 'i' then c2 *-1 else c2 end),
c3= SUM(case when mov = 'i' then c3 *-1 else c3 end),
c4= SUM(case when mov = 'i' then c4 *-1 else c4 end),
c5= SUM(case when mov = 'i' then c5 *-1 else c5 end),
c6= SUM(case when mov = 'i' then c6 *-1 else c6 end),
c7= SUM(case when mov = 'i' then c7 *-1 else c7 end),
c8= SUM(case when mov = 'i' then c8 *-1 else c8 end),
c9= SUM(case when mov = 'i' then c9 *-1 else c9 end),
codmot, desmot,bolsa,codlin, deslin, codart, desart, proto, version, estado, codest
--select * 
from view_pos_movi 

where codcli = '00001' and estcli = '540291' and color = 'ANTRACITA19' and ruc = '20548229520'
and codser = '01'and codcon= '00' and coddef = '00'

GROUP BY  po, ofi, color, ubi, cia,codcli, nomcli,fob,estilo, ruc, nompro,
coddef, desdef, codpza,despza, codser, desser,codcon, descon, t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,
q0, q1, q2,q3,q4,q5,q6,q7,q8,q9,codmot, desmot,bolsa,codlin, deslin, codart, desart, proto, version, estado, codest


