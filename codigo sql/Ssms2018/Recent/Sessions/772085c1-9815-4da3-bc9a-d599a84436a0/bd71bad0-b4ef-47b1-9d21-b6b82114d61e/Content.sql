SELECT TOP 50 * FROM API_LOG WHERE USUARIO='1152221190' ORDER BY ITEM DESC
SELECT * FROM KPAGE ORDER BY IDKPAGE 
EXEC SPQ_JSON '{"MODELO":"RECAUDO_PE","METODO":"GES_LINK_PAGO","PARAMETROS":{"PROCESO":"ENVIA","TABLA":"CIT","PROCEDENCIA":"AGENDA","CONSECUTIVO":"030370982754","IDAFILIADO":"MP00001031","CELULAR":"3024545896","EMAIL":"isaiasquintero92141@gmail.com"},"USUARIO":"1152221190"}'


SELECT  * FROM CIT WHERE CONSECUTIVO='030370982754'

{"data":{"id":"kFRMBk","name":"Pago de Atención Médica","amount_in_cents":170000,"currency":"COP","single_use":true,"description":"CONSULTA DE PRIMERA VEZ POR PSICOLOGIA","sku":"38","expires_at":null,"collect_shipping":false,"collect_customer_legal_id":false,"redirect_url":null,"image_url":null,"active":true,"customer_data":null,"created_at":"2025-07-14T17:25:32.464Z","updated_at":"2025-07-14T17:25:32.464Z","taxes":[],"default_language":"es","merchant_public_key":"pub_prod_uVe7R8g2QZglQz0crxB2uWuPRHv4tR8o"},"meta":{}}


SELECT  * FROM FNPAG