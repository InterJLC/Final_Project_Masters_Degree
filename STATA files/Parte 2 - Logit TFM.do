* Jonathan Llamas Crespillo

* Modelo Logit para TFM (Parte 2/2)

* En este fichero .DO se va poner a prueba la capacidad predictiva del modelo incluyendo la vble
* Assurance, la cual se va comparar con la capacidad predictiva del modelo original sin esta columna
* es decir, con las vbles originales

* Antes de ejecutar el este fichero .DO, se necesita realizar el paso 1, y cambiar el nombre de 'Assurance'
* por el de 'status_pr' y en la etiqueta de este misma columna cambiar 'Assurance' por 'Pr(Status)'.
* Esto es necesario para que el fichero .DO no de errores y se puede hacer desde el editor de datos de STATA.

* 1. Importamos el fichero5 el cual posee la vble que necesitamos en la comparación con la parte (1/2)
* que utiliza la columna Status_pr para medir la calidad de las predicciones del modelo.
import delimited "C:\Users\jlc15\Desktop\MECOFIN\2º Cuatrimestre\TFM\Y - Ficheros Python\fichero5.csv"

* Abrimos 'log':
log using Parte2_STATA, replace text

* 2. Estudiamos la distribución de la vble endógena Status
tab status

* 3. Estimamos vía logit el modelo original
logit status gender education workexp programmingexp

* 4. Calculamos los marginales
margins

* 5. Calculamos la matriz de acieros y errores
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
