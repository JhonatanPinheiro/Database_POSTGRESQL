---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
/* SQL para Análise de Dados: Do básico ao avançado! */
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

---------------------8. SELECT---------------------
SELECT coluna_1,coluna_1,coluna_3
FROM schema_1.nome_da_tabela;

-- Seleção de uma coluna de uma tabela
-- Liste os e-mails dos clientes da tabela sales.customers
SELECT email
FROM sales.customers


--Seleção de mais de uma coluna  de uma tabela
--Liste os emails e nomes dos clientes da tabela sales.customers
SELECT email, firsty_name, last_name 
FROM sales.customers


-- Seleçao de todas as colunas de uma table
-- Liste todas as informações dos clientes da tabela sales.customers
SELECT * FROM sales.customers

--RESUMO
-- 1 Comando usado para selecionar colunas de tabelas
-- 2 Quando selecionar mais de duas coluna, elas devem ser separadas por vígula sem conter vírgula antes do comando FROM
-- 3 Pode-se utilizar o asterisco (*) para selecionar todas as colunas da tabela


---------------------9. DISTINCT---------------------
-- Serve para remover linhas duplicadas e mostrar apenas linhas distintas
-- Muito usado na etapa de exploração das bases
SELECT DISTINCT coluna_1, coluna_2, coluna_3
FROM schema_1.tabela_1

-- Seleção de uma coluna sem DISTINCT
-- Lista as marcas de carro que constam na tabela products
SELECT brand
FROM sales.products
-- Resultado 333 linhas

-- Seleção de uma coluna com DISTINCT
-- Lista as marcas de carro distintas que constam na tabela products
SELECT DISTINCT brand
FROM sales.products;
-- Resultado 40 linhas

-- Seleção de mais de uma coluna com DISTINCT
-- Liste as marca e anos de modelo distintos que constam na tabela products
SELECT DISTINCT brand, model_year
FROM sales.products
-- Resultado 184 linhas

--RESUMO: 
-- 1 Comando usado para remover linhas duplicadas e mostrar apenas linhas distintas
-- 2 Muito utilizado na etapa de exploração dos dados
-- 3 Caso mais de uma coluna seja selecionado, o comando  SELECT DISTINCT irá retornar todas as combinações distintas.


---------------------10. WHERE----------------------

-- Filtro com condição única
-- Liste os emails dos clientes da nossa base que moram no estado de Santa Catarina

SELECT email
FROM sales.customers
WHERE state = 'SC'

SELECT email, state
FROM sales.customers
WHERE state = 'SC'

--Filtro com mais de uma codição
-- Liste os emails dos clientes da nossa base que moram no estado de Santa Catarina OU Mato Grosso do Sul

SELECT email
FROM sales.customers
WHERE state = 'SC' OR state = 'MS'

SELECT email, state
FROM sales.customers
WHERE state = 'SC' OR state = 'MS'


-- Filtro de cindição com data

-- Liste os emails dos clientes da nossa base que moram no estado de Santa Catarina OU Mato Grosso do Sul e que mais de 30 anos
SELECT email,birth_date
FROM sales.customers

--RESUMO
-- 1 Comando utilizado para filtrar linhas de acordo com uma codição
-- 2 No PostgreSQL são utilizadas aspas simples para delimitar strings
-- 3 string = sequência de caracteres = texto
-- 4 Pode-se combinar mais de uma condição utilizando os operadores lógicos
-- 5 No PostgreSQL as datas são escritas no formato 'YYYY-MM-DD' ou 'YYYYMMDD'



---------------------11. ORDER BY----------------------
SELECT coluna_1,coluna_2,coluna_3
FROM schema_1.tabela_1
WHERE condicao_x = true
ORDER BY coluna_2

-- Ordenação de valores numéricos
-- Liste produtos das tabela products na ordem crescente com base no preço
SELECT product_id, brand, model, model_year, price
FROM sales.products
ORDER BY brand

SELECT * FROM sales.products
ORDER BY brand

-- Ordenação de valores numéricos
-- Liste produtos das tabela products na ordem decrecente com base no preço
SELECT product_id, brand, model, model_year, price
FROM sales.products
ORDER BY brand DESC

SELECT * FROM sales.products
ORDER BY brand DESC

-- Ordenação de Texto
-- Liste os estados distintos da tabela customers na ordem crescente A -> Z
SELECT DISTINCT state
FROM sales.customers
ORDER BY state

-- Ordenação de Texto
-- Liste os estados distintos da tabela customers na ordem decrecente Z -> A
SELECT DISTINCT state
FROM sales.customers
ORDER BY state DESC

--RESUMO
-- 1 Comando utilizado para ordenar a seleção de acordo com uma regra definida
-- 2 Por padrão o comando ordena na ordem crescente. Para mudar a ordem descrescente usar o comando DESC
-- 3 No caso de strings a ordenação será seguirá a ordem alfabetica


---------------------12. LIMIT----------------------
-- Seleção das N primeiras linhas usando LIMIT
-- Liste as 10 primeiras linhas da tabela funnel
SELECT * FROM sales.funnel
LIMIT 10

-- Seleção das N primeiras linhas usando LIMIT e ORDER BY
-- Liste os 10 produtos mais caros da tabela products
SELECT * FROM sales.products
ORDER BY price DESC
LIMIT 10


-- RESUMO
-- 1 Comando utilizado para limitar o nª de linhas da consulta
-- 2 Muito utlizado na etapa de exploração dos dados
-- 3 Muito utilizado em conjunto com o comando ORDER BY quando o que importa são os TOP N. Ex: "N pagamentos mais recentes", "N produtos mais caros"

---------------------13. DESAFIO ----------------------
-- EXERCÍCIOS ######################################################################

-- (Exercício 1) Selecione os nomes de cidade distintas que existem no estado de
-- Minas Gerais em ordem alfabética (dados da tabela sales.customers)
SELECT DISTINCT city, state
FROM sales.customers
WHERE state = 'MG'


-- (Exercício 2) Selecione o visit_id das 10 compras mais recentes efetuadas
-- (dados da tabela sales.funnel)
SELECT visit_page_date,visit_id
FROM sales.funnel
WHERE paid_date IS NOT NULL
ORDER BY paid_date DESC
LIMIT 10


-- (Exercício 3) Selecione todos os dados dos 10 clientes com maior score nascidos
-- após 01/01/2000 (dados da tabela sales.customers)
SELECT * FROM sales.customers
WHERE birth_date >= '2000-01-01' AND score > '900'
ORDER BY score DESC
LIMIT 10

--OU

SELECT *
FROM sales.customers
WHERE birth_date >= '2000-01-01'
ORDER BY score DESC
LIMIT 10

---------------------13. DESAFIO ----------------------
-- Servem para executar operações matemáticas
-- Muito utilizados para criar colunas calculadas

-- Tipos 
-- + 
-- -
-- *
-- /
-- ^
-- ||


-- Criação de coluna calculada
-- Crie uma coluna contendo a idade do cliente da tabela sales.customers
SELECT * FROM sales.customers 
LIMIT 10;

SELECT email, birth_date,
(current_date - birth_date)/365 AS idade
FROM sales.customers
ORDER BY "idade"


-- Criação de coluna calculada com strings
-- Crie a coluna "nome_completo" contendo o nome completo do cliente

SELECT 
    first_name || ' ' || last_name AS "Nome completo"
FROM sales.customers

-- RESUMO
-- 1 Servem para executar operações matemáticas
-- 2 Muito utilizado para criar colunas calculadas
-- 3 Alias (pseudônimos) são muito utilizados para dar nome as colunas calculadas.
-- 4 Para Criar pseudônimos que contém espaços no nome são utilizadas aspas duplas
-- 5 No caso de strings o operador de adição (||) irá concatenar as strings
-- 6 Utilize o Guia de comandos para consultar os operadores utilizados no SQL


-------------------------- 16. Operadores de comparação ----------------------------------
-- TIPOS
-- =
-- >
-- <
-- >=
-- <=
-- <>

-- Uso de operadores como flag
-- Crie uma tabela que retorne TRUE sempre que um cliente for um profissional clt

SELECT * FROM sales.customers 
LIMIT 100

SELECT count (*), professional_status FROM sales.customers 
GROUP BY professional_status

SELECT first_name ||' '|| last_name AS "Nome Completo" , professional_status
FROM sales.customers
WHERE professional_status = 'clt'

SELECT first_name ||' '|| last_name AS "Nome Completo" , (professional_status = 'clt')
FROM sales.customers

SELECT first_name ||' '|| last_name AS "Nome Completo" , (professional_status = 'clt')
FROM sales.customers
WHERE professional_status = 'clt'


-- RESUMO
-- 1 Servem para comprar dois valores retornando TRUE ou FALSE
-- 2 Muito utilizado em conjunto com a função WHERE para filtrar linhas de uma seleção
-- 3 Utilizados para criar colunas Flag que retornem TRUE ou FALSE
-- 4 Utilize o Guia de comandos para consultar os operadores utilizados no SQL   


-------------------------- 16. Operadores de comparação ----------------------------------
-- Uso do comando BETWEEN
-- Seleciona veículos que custam entre 100k e 200k na tabela products
SELECT * FROM sales.products
WHERE price >= 100000 AND price <= 200000;

SELECT * FROM sales.products
WHERE price BETWEEN 10000 AND 200000; 

-- Uso do comando NOT
-- Selecione veículos que custam abaixo de 100k ou acima 200k
SELECT * FROM sales.products
WHERE  price < 100000 OR price > 200000;

SELECT * FROM sales.products 
WHERE price NOT BETWEEN 100000 AND 200000;

-- Uso do comando IN
-- Selecionar produtos que sejam da marca HONDA, TOYOTA ou RENAULT
SELECT * FROM sales.products
WHERE brand IN('HONDA','TOYOTA','RENAULT');

SELECT * FROM  sales.products
WHERE brand = 'HONDA' OR brand = 'TOYOTA' OR brand = 'RENAULT';


-- Selecionar produtos que NÃO sejam da marca HONDA, TOYOTA ou RENAULT
SELECT * FROM sales.products
WHERE brand NOT IN('HONDA','TOYOTA','RENAULT');


-- Uso do comando LIKE (matchs imperfeitos)
-- Selecione os primeiros nomes distintos da tabela customers que começam com as iniciais ANA
SELECT DISTINCT c.first_name FROM sales.customers c
WHERE first_name LIKE('ANA%');


-- Uso do comando ILIKE (ignora letras maiúsculas e minúculas)
-- Selecione os primeiros nomes distintos com iniciais 'ana'
SELECT DISTINCT c.first_name FROM sales.customers c
WHERE first_name ILIKE('ana%');

-- Uso do comando IS NULL
-- Selecionar apenas as linhas que contém nulo no campo "population" na tabela temp_tables.regions
SELECT * FROM temp_tables.regions
WHERE population IS NULL;

-- Lembrando que o comando a baixo não funciona. Devemos sempre usar o IS NULL, dessa forma ele mostrará os/todos campos vazios
SELECT * FROM temp_tables.regions
WHERE population = NULL;

--RESUMO
-- 1 Usados para unir expressões simples em uma composta
-- 2 AND: Verifica se duas comparações são simultaneamente verdadeiras
-- 3 OR: Verifica se uma ou outra comparação é verdadeiras
-- 4 BETWEEN: Verifica quais valores estão dentro do range definido
-- 5 IN: Funciona como multiplos ORs
-- 6 LIKE e ILIKE: Comparam textos e são sempre utilizados em conjunto com o operador %, que funciona como coringa, indicando que qualquer texto pode aparecer no lugar do campo
-- 7 ILIKE ignora se o campo tem letras maiúsculas ou minúsculas na camparação
-- 8 IS NULL: Verifica se o campo é nulo
-- 9 Utilize o Guia de comandos para consultar os operadores utilizados no SQL


-------------------------- 18. Desafios ----------------------------------
-- (Exercício 1) Calcule quantos salários mínimos ganha cada cliente da tabela 
-- sales.customers. Selecione as colunas de: email, income e a coluna calculada "salários mínimos"
-- Considere o salário mínimo igual à R$1200
SELECT email,income,(income/1200) AS "Quantidade de Salário Minimo" 
FROM sales.customers;

SELECT email, professional_status,CONCAT('R$ ',income), ROUND(income/1200,3) AS "Quantidade de Salário Minimo" 
FROM sales.customers
ORDER BY income DESC;



-- (Exercício 2) Na query anterior acrescente uma coluna informando TRUE se o cliente
-- ganha acima de 5 salários mínimos e FALSE se ganha 4 salários ou menos.
-- Chame a nova coluna de "acima de 4 salários"
SELECT email, professional_status,CONCAT('R$ ', income), ROUND(income/1200,2) AS "Quantidade de Salario Minimo", (((income/1200) > 5) = TRUE) AS "Acima de 5 Salarios minimos"
FROM sales.customers
ORDER BY income ASC;

SELECT email,income,(income/1200) AS "Quantidade de Salário Minimo",(((income/1200) > 5) = TRUE) AS "Acima de 5 Salarios minimos"
FROM sales.customers;


-- (Exercício 3) Na query anterior filtre apenas os clientes que ganham entre
-- 4 e 5 salários mínimos. Utilize o comando BETWEEN
SELECT email, professional_status,CONCAT('R$ ', income), (income/1200) AS "Quantidade de Salario Minimo", (((income/1200) > 5) = TRUE) AS "Acima de 5 Salarios minimos"
FROM sales.customers
WHERE (income/1200) BETWEEN 4 AND 5
ORDER BY income ASC;

SELECT email, professional_status,CONCAT('R$ ', income),(income/1200) AS "Quantidade de Salario Minimo", (((income/1200) > 5) = TRUE) AS "Acima de 5 Salarios minimos"
FROM sales.customers
WHERE (income/1200) BETWEEN 4 AND 5
ORDER BY income ASC;

select *, ROUND(income/1200,0) AS "Quantidade de Salario Minimo" FROM sales.customers
WHERE (income/1200) BETWEEN 4 AND 5
ORDER BY income ASC;


-- (Exercício 4) Selecine o email, cidade e estado dos clientes que moram no estado de 
-- Minas Gerais e Mato Grosso. 



-- (Exercício 5) Selecine o email, cidade e estado dos clientes que não 
-- moram no estado de São Paulo.



-- (Exercício 6) Selecine os nomes das cidade que começam com a letra Z.
-- Dados da tabela temp_table.regions
