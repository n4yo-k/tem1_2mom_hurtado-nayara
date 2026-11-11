# tem1_2mom_hurtado-nayara
# Proyecto Analítico Apache Hive - Superstore Sales

## 1. Descripción y Objetivos
Proyecto individual de procesamiento y análisis de Big Data utilizando Apache Hive sobre el dataset Sample Superstore.

## 2. Requisitos del Entorno
- Docker Desktop
- Apache Hive 4.0.1 (Contenedor Docker)
- Beeline CLI

## 3. Estructura del Repositorio
- `data/`: Dataset procesado en UTF-8.
- `sql/`: Scripts DDL, DML y consultas HiveQL.
- `docs/`: Diccionario de datos, documentación de resultados y optimización.
- `evidencias/`: Capturas de pantalla de ejecución.
- `resultados/`: Salidas de Beeline generadas por scripts.

## 4. Procedimiento de Ejecución
1. Levantar el contenedor: `docker run ...`
2. Crear tablas e ingestar datos: `./run.sh sql/00_ddl.sql` y `./run.sh sql/01_dml_carga.sql`
3. Ejecutar consultas analíticas: `./run.sh sql/q0X_...sql`

## 5. Resumen de Conclusiones Generales
- **Calidad de Datos:**  Se identificaron 9,994 registros
- **Impacto de Descuentos:** Los descuentos superiores al 20% reducen lac rengtabilidad, generando pérdidas en categorías  como Tecnología/Muebles.
