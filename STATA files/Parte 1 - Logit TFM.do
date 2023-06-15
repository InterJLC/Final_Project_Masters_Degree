* Jonathan Llamas Crespillo

* Modelo Logit para TFM (Parte 1/2)

* En este fichero .DO se va poner a prueba la capacidad predictiva del modelo original sin la columna
* 'Assurance'. Esto nos servirá para comparar resultados.

* 1. Importamos el fichero6, con el cual vamos a medir la capacidad de predictiva de Status para después,
* comparlo con los resultados de la columna 'Assurance' de la parte 2/2.
import delimited "C:\Users\jlc15\Desktop\MECOFIN\2º Cuatrimestre\TFM\Y - Ficheros Python\fichero6.csv"

* Abrimos 'log':
log using Parte1_STATA, replace text

* 2. Estudiamos la distribución de la vble endógena Status
tab status

* 3. Estimamos vía logit el modelo original
logit status gender education workexp programmingexp

* 4. Calculamos los marginales
margins

* 5. Calculamos la matriz de aciertos y errores
predict status_pr
estat class

* 6. Realizamos un análisis univariante básico de la columna de predicciones
sum status_pr

* 7. Realizamos un análisis univariante básico de la columna Status
sum status

* Como resultado vemos que la media es la misma, por lo que aunque status_pr no
* esté normalizada y Status sí, tienen un resultado muy parecido. 

* 8. Calculamos la capacidad predictiva con un límite de 0.5
estat class, cutoff(0.5)

* 9. Comprobamos que añadir matching no tiene sentido porque imita el comportamiento
*    de Status.
logit status gender education workexp programmingexp matching

* 10. Comprobamos el comportamiento entre matching y status. Los resultados son muy buenos.
tab matching status

* 11. Se calculan los marginales de todas las vbles (comprobamos p-value y signo del coeficiente)
margins, dydx(*)