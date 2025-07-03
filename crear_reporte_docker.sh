#!/bin/bash

# --- Script para generar el reporte de verificación de Docker ---

echo "Creando reporte de Docker..."

# Ruta del archivo de salida
OUTPUT_FILE="contenedores/verificacion_contenedores.txt"

# Encabezado del archivo (sobrescribe si existe)
echo "========== VERIFICACIÓN CONTENEDORES -- muniz ==========" > $OUTPUT_FILE

# Contenedores en ejecución
echo "Contenedores en ejecución:" >> $OUTPUT_FILE
sudo docker ps >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Estado de docker-compose
echo "Estado de docker-compose:" >> $OUTPUT_FILE
(cd contenedores && sudo docker-compose ps >> ../$OUTPUT_FILE)
echo "" >> $OUTPUT_FILE

# Prueba de conectividad al servicio
echo "Prueba de conectividad al servicio:" >> $OUTPUT_FILE
curl -I http://192.168.56.101 >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "Reporte '$OUTPUT_FILE' generado exitosamente."
