SELECT  PO, COLOR,MOV, DESSER, NOMPRO, estcli,
	SUM(C0+C1+C2+C3+C4+C5+C6+C7+C8+C9) AS TOTAL
	FROM view_pos_movi WHERE CODCLI= '00001'  and estcli ='548491' and po='214-479'
	and mov ='s' and codser ='01'
	GROUP BY PO, COLOR,MOV, DESSER, NOMPRO,estcli
	ORDER BY 1,2,3,4
	
---	select * from modelador..cliente