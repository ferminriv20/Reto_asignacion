# Solución al Student Challenge '25 - ASOCIO

## Asignación Optimizada de Puestos para un Entorno de Trabajo Híbrido

Este repositorio contiene la solución completa para el reto de asignación de puestos de trabajo. Se ha desarrollado un modelo de optimización matemática para encontrar la mejor asignación posible, balanceando las preferencias de los empleados y la cohesión de los equipos.

### Estrategia de Solución

La metodología se basa en un modelo de optimización multi-objetivo implementado en AMPL y resuelto con Gurobi. El modelo maximiza la satisfacción de las preferencias del personal y minimiza la dispersión espacial de los equipos. Para más detalles, consultar el informe técnico.

### Estructura del Repositorio

- **/data:** Contiene los 10 archivos de datos (`.dat`) para cada instancia del problema.
- **/src:** Contiene el código fuente de la solución.
  - `modelo_asignacion.mod`: La formulación matemática abstracta del modelo en AMPL.
  - `script_ejecucion.run`: El script de AMPL para cargar el modelo, los datos, resolver y mostrar los resultados.

### Prerrequisitos

- **AMPL:** Lenguaje de modelado matemático.
- **Gurobi Solver:** Motor de optimización.



### Autores

- Juan Florez
- Andres Ballesta
- Fermín Rivero 

