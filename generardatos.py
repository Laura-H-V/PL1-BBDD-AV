import random
import string
import csv
from datetime import datetime, timedelta

# Lista de provincias españolas
provincias = [
    "Álava", "Albacete", "Alicante", "Almería", "Asturias", "Ávila", "Badajoz", "Barcelona", "Burgos", "Cáceres", "Cádiz", "Cantabria", "Castellón", "Ciudad Real", "Córdoba", "Cuenca", "Gerona", "Granada", "Guadalajara", "Guipúzcoa", "Huelva", "Huesca", "Islas Baleares", "Jaén", "La Coruña", "La Rioja", "Las Palmas", "León", "Lérida", "Lugo", "Madrid", "Málaga", "Murcia", "Navarra", "Orense", "Palencia", "Pontevedra", "Salamanca", "Santa Cruz de Tenerife", "Segovia", "Sevilla", "Soria", "Tarragona", "Teruel", "Toledo", "Valencia", "Valladolid", "Vizcaya", "Zamora", "Zaragoza"
]

# Función para guardar en CSV
def guardar_csv(nombre, datos, campos):
    with open(nombre, mode='w', newline='', encoding='utf-8') as file:
        writer = csv.DictWriter(file, fieldnames=campos)
        writer.writeheader()
        writer.writerows(datos)

# Generar 3.000.000 clientes
clientes = [{"id": i+1, "provincia": random.choice(provincias)} for i in range(3_000_000)]
guardar_csv("clientes.csv", clientes, ["id", "provincia"])

# Generar 500 marcas con 5 a 20 modelos y 5 a 15 colores
marcas = {f"Marca_{i+1}": [f"Modelo_{j+1}" for j in range(1, random.randint(5, 20) + 1)] for i in range(500)}
colores_disponibles = ["Negro", "Blanco", "Rojo", "Azul", "Verde", "Amarillo", "Gris", "Plateado", "Dorado", "Marrón", "Beige", "Turquesa", "Violeta", "Naranja", "Rosa"]
colores = random.sample(colores_disponibles, min(len(colores_disponibles), random.randint(5, 15)))

# Generar 5.000.000 vehículos
vehiculos = []
for i in range(5_000_000):
    marca = random.choice(list(marcas.keys()))
    modelo = random.choice(marcas[marca]) if marcas[marca] else "Modelo_Default"
    vehiculos.append({
        "id": i+1,
        "propietario_id": random.randint(1, 3_000_000),
        "marca": marca,
        "modelo": modelo,
        "color": random.choice(colores)
    })
guardar_csv("vehiculos.csv", vehiculos, ["id", "propietario_id", "marca", "modelo", "color"])

# Generar 200.000 plazas de parking
plazas = [{
    "id": i+1,
    "planta": random.randint(-10, 0),
    "seccion": random.choice(string.ascii_uppercase[:6])  # A-F
} for i in range(200_000)]
guardar_csv("plazas.csv", plazas, ["id", "planta", "seccion"])

# Generar 40.000.000 reservas
reservas = []
payment_methods = ["Efectivo", "Tarjeta Crédito", "Tarjeta Débito", "PayPal", "Bizzum", "Transferencia"]
base_date = datetime(2024, 1, 1)

def random_datetime(start_date, end_date):
    delta = end_date - start_date
    return start_date + timedelta(days=random.randint(0, max(1, delta.days)), hours=random.randint(0, 23))

for i in range(40_000_000):
    plaza_id = random.randint(1, 200_000)
    cliente_id = random.randint(1, 3_000_000)
    inicio = random_datetime(base_date, datetime(2024, 12, 31))
    duracion = timedelta(days=random.randint(1, 10))
    fin = inicio + duracion
    horas = duracion.days * 24
    precio = horas * 3
    metodo_pago = random.choice(payment_methods)
    fecha_pago = random_datetime(base_date, max(base_date, inicio - timedelta(days=random.randint(1, 10))))
    
    reservas.append({
        "id": i+1,
        "plaza_id": plaza_id,
        "cliente_id": cliente_id,
        "inicio": inicio,
        "fin": fin,
        "precio": precio,
        "metodo_pago": metodo_pago,
        "fecha_pago": fecha_pago
    })

guardar_csv("reservas.csv", reservas, ["id", "plaza_id", "cliente_id", "inicio", "fin", "precio", "metodo_pago", "fecha_pago"])

# Generar 4.000.000 incidencias
estados_incidencia = ["Nueva", "Abierta", "En proceso", "Resuelta", "Cerrada"]
incidencias = [{
    "id": i+1,
    "reserva_id": random.randint(1, 40_000_000),
    "estado": random.choice(estados_incidencia)
} for i in range(4_000_000)]
guardar_csv("incidencias.csv", incidencias, ["id", "reserva_id", "estado"])

print("Datos generados y guardados en archivos CSV correctamente.")
