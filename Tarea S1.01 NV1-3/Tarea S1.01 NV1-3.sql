# TAREA S1.01 NIVEL 1

/*Ejercicio 2
En este ejercicio se trata de una Consulta que da como resultado un listado con el Nombre, email y 
país de origen de las empresas en la base de datos dentro del esquema de trabajo,
se ha ordenado el resultado alfabeticamente teniendo en cuenta el nombre de la empresa*/

SELECT transactions.company.company_name AS NOMBRE, transactions.company.email AS "E-MAIL", transactions.company.country AS PAIS
FROM transactions.company
ORDER BY transactions.company.company_name;

/*Ejercicio 3
En esta consulta se nos solicita un listado de los países desde los cuales se están realizando compras, 
la información presentada refleja solo las operaciones realizadas con éxito.*/

SELECT DISTINCT transactions.company.country AS País
FROM transactions.company
INNER JOIN transactions.transaction ON transactions.transaction.company_id = transactions.company.id
WHERE transactions.transaction.declined = 0;

/*Ejercicio 4
En esta consulta se nos solicita el número total de los países desde los cuales se están realizando compras, 
la información presentada refleja solo las operaciones realizadas con éxito.*/

SELECT count(DISTINCT transactions.company.country) AS "No. de Países"
FROM transactions.company
INNER JOIN transactions.transaction ON transactions.transaction.company_id = transactions.company.id
WHERE transactions.transaction.declined = 0;

/*Ejercicio 5
Se nos solicita el nombre y país del id "b-2354" en la tabla company de nuestro esquema de trabajo,
se muestran solo los datos del registro solicitado.*/

SELECT transactions.company.company_name AS Nombre, transactions.company.country AS País
FROM transactions.company
WHERE transactions.company.id = "b-2354";

/*Ejercicio 6
 Se nos ha solicitado el nombre la compañía con el mayor gasto medio, la consulta ejecutada muestra
el resultado teniendo en cuenta solo las operaciones efectivamente completadas.*/

SELECT transactions.company.company_name AS Compañía, FORMAT(AVG(transactions.transaction.amount), 2) AS Gasto_Medio
FROM transactions.transaction
INNER JOIN transactions.company ON transactions.transaction.company_id = transactions.company.id
WHERE transactions.transaction.declined = 0
GROUP BY transactions.transaction.company_id
ORDER BY AVG(transactions.transaction.amount) DESC
LIMIT 1;

# TAREA S1.01 NIVEL 2

/*Ejercicio 1
Se nos solicita comprobar si existen compañías con identificadores duplicados, para comprobarlo he realizado un conteo de los identificadores y 
lo he comparado con un conteo de los nombres únicos de las compañías verificando que el número de registros de identificadores y nombres únicos de empresa coincide, 
y así se comprueba que no existen identificadores duplicados.*/

SELECT count(transactions.company.id) AS total_de_registros, count(DISTINCT transactions.company.company_name) AS nombres_unicos
FROM transactions.company;

/*Ejercicio 2
Se nos ha solicitado una consulta que arroje la información sobre los cinco días en que se han realizado las mayores ventas,
a fin de ofrecer la información más precisa, se han tomado en cuenta solo las operaciones completadas con éxito.*/

SELECT SUM(transactions.transaction.amount) AS Total_Ventas, date(transactions.transaction.timestamp) AS Fecha
FROM transactions.transaction
GROUP BY Fecha
ORDER BY Total_Ventas DESC
Limit 5;

/*Ejercicio 3
Se nos ha solicitado una consulta que arroje la información sobre los cinco días en que se han realizado las menores ventas,
a fin de ofrecer la información más precisa, se han tomado en cuenta solo las operaciones completadas con éxito.*/

SELECT SUM(transactions.transaction.amount) AS Total_Ventas, date(transactions.transaction.timestamp) AS Fecha
FROM transactions.transaction
WHERE transactions.transaction.declined = 0
GROUP BY Fecha
ORDER BY Total_Ventas
Limit 5;

/*Ejercicio 4
Se nos ha solicitado una consulta que arroje la información sobre la media de gasto por país,
a fin de ofrecer la información más precisa, se han tomado en cuenta solo las operaciones completadas con éxito 
y se presentan ordenadas de mayor a menor.*/

SELECT transactions.company.country AS País, FORMAT(AVG(transactions.transaction.amount), 2) AS Gasto_Medio
FROM transactions.transaction
INNER JOIN transactions.company ON transactions.transaction.company_id = transactions.company.id
WHERE transactions.transaction.declined = 0
GROUP BY transactions.company.country
ORDER BY AVG(transactions.transaction.amount) DESC;

# TAREA S1.01 NIVEL 3

/*Ejercicio 1
Se nos solicita una consulta que muestre el nombre, teléfono y país de las compañías, junto con la cantidad total gastada, 
de aquellas que realizaron transacciones con un gasto comprendido entre 100 y 200 euros. 
Se han tenido en cuenta solo las operaciones completadas con éxito.
Se ordenan los resultados de mayor a menor cantidad gastada.*/

SELECT transactions.company.company_name as Nombre, transactions.company.phone AS Teléfono, transactions.company.country AS País, sum(transactions.transaction.amount) Total
FROM transactions.company
INNER JOIN transactions.transaction ON transactions.transaction.company_id = transactions.company.id
WHERE transactions.transaction.declined = 0
GROUP BY País, Nombre, Teléfono
HAVING Total BETWEEN 100 AND 200
ORDER BY Total DESC;

/*Ejercicio 2
Se nos solicita una consulta que muestre el nombre, el nombre de las compañías que realizaron compras el 16 de marzo de 2022, 28 de febrero de 2022 y 13 de febrero de 2022.
Se muestran los resultados con la fecha de la operación, solo se han tenido en cuenta las operaciones completadas con éxito.*/

SELECT transactions.company.company_name as Compañía, date(transactions.transaction.timestamp) AS Fecha
FROM transactions.company
INNER JOIN transactions.transaction ON transactions.transaction.company_id = transactions.company.id
WHERE  date(transactions.transaction.timestamp) IN ("2022-02-13", "2022-02-28", "2022-03-16") AND transactions.transaction.declined = 0
ORDER BY Fecha;
