## PROYECTO: PRUEBAS AUTOMATIZADAS API PETSTORE

Proyecto de automatización de pruebas API para PetStore utilizando Karate Framework.
Incluye pruebas CRUD (Create, Read, Update, Delete) completas y casos de prueba negativos con generación automática de reportes con Cucumber en formato HTML.

---

## TECNOLOGÍAS UTILIZADAS
- **Lenguaje: Java (JDK 11, 17 o 21)**
- **Gestor de Dependencias: Gradle 7.6.1**
- **Framework de Pruebas: Karate 1.4.1 (que incluye Gherkin, HTTP client, assertions)**
- **Ejecutor de Pruebas: JUnit 5 5.9.3**
- **Generación de Reportes: Cucumber Reporting 5.7.0**
- **Logging: Logback 1.2.11**

---

## ESTRUCTURA DEL PROYECTO
nttdata-apis-alvaro/
├── .gitignore                  # Archivos y carpetas ignorados por Git
├── build.gradle                # Configuración de dependencias, plugins y tareas
├── gradlew / gradlew.bat       # Wrapper de Gradle (no requiere instalación global)
├── README.md                   # Este archivo (instrucciones y documentación)
├── Conclusiones.txt            # Hallazgos y conclusiones del ejercicio
│
├── src/
│   └── test/
│       ├── java/
│       │   └── com/
│       │       └── petstore/
│       │           └── runner/
│       │               └── TestRunner.java   # Clase para ejecutar pruebas y generar reportes
│       │
│       └── resources/
│           ├── karate-config.js               # Configuración global (URL base, tiempos, etc.)
│           ├── logback-test.xml               # Configuración de logging para pruebas
│           │
│           ├── data/                          # Datos de prueba parametrizados
│           │   ├── pets.json                   # Datos de mascotas para pruebas CRUD
│           │   └── pets.csv                    # Datos para pruebas negativas
│           │
│           └── features/                       # Escenarios de prueba en formato .feature
│               └── petTests.feature            # Feature con todos los escenarios
---

## CARACTERÍSTICAS
- Pruebas CRUD completas (Crear, Leer, Actualizar, Eliminar)
- Casos de prueba negativos y validaciones de errores
- Reportes HTML automáticos (Cucumber Reports)
- Configuración multi-entorno (dev, prod)
- Ejecución paralela de pruebas para optimizar tiempo
- Logging detallado con Logback para depuración
- Datos parametrizados desde archivos JSON y CSV
- Tags en escenarios para ejecución selectiva

---

## EJECUCIÓN DE PRUEBAS
\# Para clonar el repositorio:
git clone <URL_DE_TU_REPOSITORIO>
cd nttdata-apis-alvaro
\# Para limpiar y empezar fresco:
.\\gradlew clean build
\# Ejecutar todas las pruebas:
.\\gradlew clean fullTest
\# Ejecutar solo pruebas CRUD:
.\\gradlew test --tests "com.petstore.runner.TestRunner.testCRUDOnly"
\# Ejecutar solo pruebas negativas:
.\\gradlew test --tests "com.petstore.runner.TestRunner.testNegativeOnly"
\# Ejecutar con entorno específico:
.\\gradlew test "-Dkarate.env=dev"
\# Generar reportes HTML:
.\\gradlew generateCucumberReports
\# Abrir reportes en navegador:
.\\gradlew openCucumberReport

---

## REPORTES GENERADOS
1. Reportes Karate: build/karate-reports/
2. Reportes Cucumber HTML: build/cucumber-reports/
3. Reportes JUnit: build/reports/tests/

---

## ENDPOINTS TESTEADOS
\-- POST /v2/pet             - Crear mascota
\-- GET /v2/pet/{id}         - Obtener mascota por ID
\-- PUT /v2/pet              - Actualizar mascota
\-- GET /v2/pet/findByStatus - Buscar por estado
\-- DELETE /v2/pet/{id}      - Eliminar mascota

---

## DEPENDENCIAS
Ver archivo build.gradle para la lista completa de dependencias.

---

## AUTOR
Alvaro.
Proyecto Automatización de APIs.

---

VERSIÓN
1.0.1 - Marzo 2026