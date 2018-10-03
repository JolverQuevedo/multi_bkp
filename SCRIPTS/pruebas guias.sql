SELECT * FROM 
--UPDATE 
PO_MOVI 
SET GUIA = '' 
WHERE MOV = 'S' AND RUC = '20548229520'
ORDER BY ID DESC


exec saldo_po_color_total '540291' , '20548229520', '01', '00', '00'

exec po_color_guia '540391' , '20548229520', '01' 

	 select PO, CODART,  color, tot=sum(c0+c1+c2+c3+c4+c5+c6+c7+c8+c9) , ID, isnull(ar_cdescri,'NO EXISTE EN REAL') AS DESCRIP
from view_pos_movi 
where MOV = 'S' AND GUIA='' 
	and estcli = '540391' and ruc = '20548229520'  AND CODSER = '01'
GROUP BY CODART,  color, po, ID,ar_cdescri



