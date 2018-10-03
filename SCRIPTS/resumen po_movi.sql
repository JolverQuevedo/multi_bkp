select codcli, nomcli ,estcli, estilo, mov, codser,desser, tot= sum(c0+c1+c2+c3+c4+c5+c6+c7+c8+c9)
from view_pos_movi where guia =''
group by estcli, estilo, mov, codcli, nomcli,codser,desser
order by codcli, estcli


select codcli, nomcli ,estcli, estilo, mov, codser,desser, tot= sum(c0+c1+c2+c3+c4+c5+c6+c7+c8+c9) from view_pos_movi where ESTADO = 'A' and GUIA ='' 













select codcli, nomcli ,estcli, estilo, mov, codser,desser,po, tot= sum(c0+c1+c2+c3+c4+c5+c6+c7+c8+c9)
from view_pos_movi where guia =''
group by estcli, estilo, mov, codcli, nomcli,codser,desser,po
order by codcli, estcli

select codcli, nomcli ,estcli, estilo, mov, codser,desser,ofi, po, color, tot= sum(c0+c1+c2+c3+c4+c5+c6+c7+c8+c9)
from view_pos_movi where guia =''
group by estcli, estilo, mov, codcli, nomcli,codser,desser,po, color,ofi
order by codcli, estcli,po, color

select codcli, nomcli ,estcli, estilo, mov, codser,desser,ofi, po, color,ruc, nompro, tot= sum(c0+c1+c2+c3+c4+c5+c6+c7+c8+c9)
from view_pos_movi where guia =''
group by estcli, estilo, mov, codcli, nomcli,codser,desser,po, color,ofi, ruc, nompro
order by codcli, estcli,po, color

select * from view_pos_movi 
--where id = '0000001036'