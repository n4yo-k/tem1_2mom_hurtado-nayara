#!/usr/bin/env bash
# Uso: ./run.sh sql/q02_calidad_datos.sql
export MSYS_NO_PATHCONV=1
f="$1"
name=$(basename "$f" .sql)
mkdir -p resultados
docker exec hive4 beeline -u jdbc:hive2://localhost:10000/ --silent=true -f "/work/$f" 2>&1 \
  | grep -v "SLF4J" | tee "resultados/$name.txt"
