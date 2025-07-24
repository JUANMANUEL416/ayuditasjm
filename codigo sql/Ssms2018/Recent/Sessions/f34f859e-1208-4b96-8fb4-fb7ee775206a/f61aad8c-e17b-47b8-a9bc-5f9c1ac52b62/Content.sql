
SELECT  * FROM #A

SELECT FACTE, * FROM FTR WHERE N_FACTURA IN(SELECT  * FROM #A)

UPDATE FTR SET FACTE=1 WHERE N_FACTURA IN(SELECT  * FROM #A)

SELECT * FROM string_split('ANTC|001|2','|')

SELECT WORD FROM DBO.FNK_EXPLODE('ANTC|001|2','|') WHERE WORDID=1

X 100
3600 3

SELECT 3600/(3.00/100)

SELECT (3600*1)/0.03

SELECT 120000.00000000 * 0.03

<i class="fa-solid fa-cloud-arrow-up"></i>
<i class="fa-solid fa-square-check"></i>
<i class="fa-solid fa-eraser"></i>
<i class="fa-solid fa-xmark"></i>