import csv
import random

# Definir el número de registros
NUM_REGISTROS = 25000000
NOMBRE_ARCHIVO = "productos.csv"
random.seed(1)

# Crear el archivo CSV
with open(NOMBRE_ARCHIVO, "w", newline="", encoding="utf-8") as file:
    writer = csv.writer(file)
    
    # Escribir la cabecera
    writer.writerow(["producto_id", "nombre", "stock", "precio"])
    
    # Generar los registros
    for producto_id in range(1, NUM_REGISTROS + 1):
        nombre = "productos"
        stock = random.randint(0, 20000)
        precio = round(random.uniform(10, 5000), 2)
        writer.writerow([producto_id, nombre, stock, precio])

print(f"Archivo {NOMBRE_ARCHIVO} generado con {NUM_REGISTROS} registros.")
