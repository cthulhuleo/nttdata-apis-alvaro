PROYECTO: PRUEBAS AUTOMATIZADAS API PETSTORE

============================================



DESCRIPCIÓN

-----------

Proyecto de automatización de pruebas API para PetStore utilizando Karate Framework.

Incluye pruebas CRUD (Create, Read, Update, Delete) completas y casos de prueba 

negativos con generación automática de reportes en formato HTML.



TECNOLOGÍAS UTILIZADAS

----------------------

\- Java 11+

\- Gradle 7.6.1

\- Karate Framework 1.4.1

\- JUnit 5

\- Cucumber Reporting 5.7.5



ESTRUCTURA DEL PROYECTO

-----------------------

nttdata-apis-alvaro/

├── src/test/java/com/petstore/runner/

│   └── TestRunner.java          # Ejecutor principal de pruebas

├── src/test/resources/features/

│   └── petTests.feature         # Escenarios de prueba Gherkin

├── src/test/resources/

│   ├── karate-config.js         # Configuración de entorno

│   └── logback-test.xml         # Configuración de logs

├── build.gradle                 # Configuración de dependencias

└── README.txt                   # Este archivo



CARACTERÍSTICAS

---------------

✓ Pruebas CRUD completas 

✓ Casos de prueba negativos y validaciones

✓ Reportes HTML automáticos (Cucumber Reports)

✓ Configuración multi-entorno (dev, prod)

✓ Ejecución paralela de pruebas

✓ Logging detallado con Logback



EJECUCIÓN DE PRUEBAS

--------------------

\# Para limpiar y empezar fresco

.\\gradlew clean build



\# Ejecutar todas las pruebas

.\\gradlew clean fullTest



\# Ejecutar solo pruebas CRUD

.\\gradlew test --tests "TestRunner.testPetCRUD"



\# Ejecutar solo pruebas negativas

.\\gradlew test --tests "TestRunner.testNegative"



\# Generar reportes HTML

.\\gradlew generateCucumberReports



\# Abrir reportes en navegador

.\\gradlew openCucumberReport



REPORTES GENERADOS

------------------

1\. Reportes Karate: build/karate-reports/

2\. Reportes Cucumber HTML: build/cucumber-reports/

3\. Reportes JUnit: build/reports/tests/



ENDPOINTS TESTEADOS

-------------------

\- POST /v2/pet             - Crear mascota

\- GET /v2/pet/{id}         - Obtener mascota por ID

\- PUT /v2/pet              - Actualizar mascota

\- GET /v2/pet/findByStatus - Buscar por estado

\- DELETE /v2/pet/{id}      - Eliminar mascota



DEPENDENCIAS

------------

Ver archivo build.gradle para la lista completa de dependencias.



AUTOR

-----

Alvaro

Proyecto para NTT Data - Automatización de APIs



VERSIÓN

-------

1.0.0 - Diciembre 2025

