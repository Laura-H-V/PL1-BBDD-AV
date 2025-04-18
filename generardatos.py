import random
import string
import csv
from datetime import datetime, timedelta


# Lista de provincias españolas
provincias = [
    "Álava", "Albacete", "Alicante", "Almería", "Asturias", "Ávila", "Badajoz", "Barcelona", "Burgos", "Cáceres", "Cádiz", "Cantabria", "Castellón", "Ciudad Real", "Córdoba", "Cuenca", "Gerona", "Granada", "Guadalajara", "Guipúzcoa", "Huelva", "Huesca", "Islas Baleares", "Jaén", "La Coruña", "La Rioja", "Las Palmas", "León", "Lérida", "Lugo", "Madrid", "Málaga", "Murcia", "Navarra", "Orense", "Palencia", "Pontevedra", "Salamanca", "Santa Cruz de Tenerife", "Segovia", "Sevilla", "Soria", "Tarragona", "Teruel", "Toledo", "Valencia", "Valladolid", "Vizcaya", "Zamora", "Zaragoza"
]

# Listas de nombres y apellidos para clientes
nombres = ["Sergio", "Laura", "Ana", "Carlos", "Elena", "Miguel", "Lucía", "Sergio"]
apellidos = ["García", "Fernández", "López", "Martínez", "Sánchez"]

# Función para guardar una lista de diccionarios como archivo CSV
def guardar_csv(nombre, datos, campos):
    with open(nombre, mode='w', newline='', encoding='utf-8') as file:
        writer = csv.DictWriter(file, fieldnames=campos) # Crea un escritor de CSV con claves como columnas
        writer.writeheader()     # Escribe los encabezados del CSV
        writer.writerows(datos)  # Escribe todas las filas de datos
    print(f"{nombre} generado correctamente.")


# Generar 3.000.000 de clientes con datos aleatorios
clientes = []
telefonos_generados = set()

for i in range(3_000_000):

    # Genera un teléfono único empezando por 6
    while (telefono := f"6{random.randint(10000000, 99999999)}") in telefonos_generados:
        pass
    telefonos_generados.add(telefono)
    
    # Añadir cliente generado a la lista
    clientes.append({
        "clienteid": i+1,
        "nombre": random.choice(nombres),
        "apellido": random.choice(apellidos),
        "telefono": telefono,
        "email": f"cliente{i+1}@mail.com",
        "provincia": random.choice(provincias)
    })

# Guardar clientes en un archivo CSV
guardar_csv("clientes.csv", clientes, ["clienteid", "nombre", "apellido","telefono", "email", "provincia"])


# Generar 500 marcas con 5 a 20 modelos y 5 a 15 colores
marcas = {f"Marca_{i+1}": [f"Modelo_{j+1}" for j in range(1, random.randint(5, 20) + 1)] for i in range(500)}

# Lista de colores posibles para vehículos
colores = ["Negro", "Rojo", "Azul", "Verde", "Blanco", "Gris", "Amarillo", "Naranja", "Morado", "Rosa"]


# Generar 5.000.000 vehículos
matriculas_generadas = set() # Para evitar matrículas duplicadas
vehiculos = []

for i in range(5_000_000):

    # Genera una matrícula única en formato XXXX-AAA
    while (matricula := f"{random.randint(1000,9999)}-{''.join(random.choices(string.ascii_uppercase, k=3))}") in matriculas_generadas:
        pass
    matriculas_generadas.add(matricula)
    
    # Selecciona marca, modelo, color y cliente aleatorios
    marca = random.choice(list(marcas.keys()))
    vehiculos.append({
        "vehiculoid": i+1,
        "matricula": matricula,
        "marca": marca,
        "modelo": random.choice(marcas[marca]),
        "color": random.choice(colores),
        "clienteid": random.randint(1, 3_000_000)
    })

# Guardar vehículos en CSV
guardar_csv("vehiculos.csv", vehiculos, ["vehiculoid", "matricula", "marca", "modelo", "color", "clienteid"])


# Generar 200.000 plazas de parking con niveles y secciones aleatorias
plazas = [{
    "plazaid": i+1,
    "numero": i+1,
    "nivel": random.randint(-10, 0),
    "seccion": random.choice("ABCDEF")
} for i in range(200_000)]

# Guardar plazas en CSV
guardar_csv("plazas.csv", plazas, ["plazaid", "numero", "nivel", "seccion"])


# Generar 40.000.000 reservas
reservas = []
payment_methods = ["Efectivo", "Tarjeta Crédito", "Tarjeta Débito", "PayPal", "Bizum", "Transferencia"]
base_date = datetime(2024, 1, 1) # Fecha base para inicio de reservas

# Función que genera una fecha aleatoria entre dos fechas dadas
def random_datetime(start_date, end_date):
    if start_date >= end_date:
        return start_date
    delta = end_date - start_date
    return start_date + timedelta(days=random.randint(0, delta.days), hours=random.randint(0, 23))

# Crear reservas con fechas, plazas, vehículos y clientes aleatorios
for i in range(40_000_000):
    plaza_id = random.randint(1, 200_000)
    cliente_id = random.randint(1, 3_000_000)
    vehiculo_id = random.randint(1, 5_000_000)
    inicio = random_datetime(base_date, datetime(2024, 12, 31))
    duracion = timedelta(days=random.randint(1, 10))
    fin = inicio + duracion
    reservas.append({
        "reservaid": i+1,
        "fechainicio": inicio,
        "fechafin": fin,
        "vehiculoid": vehiculo_id,
        "plazaid": plaza_id,
        "clienteid": cliente_id
    })

# Guardar reservas en CSV
guardar_csv("reservas.csv", reservas, ["reservaid", "fechainicio", "fechafin", "vehiculoid", "plazaid", "clienteid"])


# Generar 40.000.000 pagos con diferentes métodos de pago y cantidades aleatorias
pagos = [{
    "pagoid": i+1,
    "cantidad": random.randint(1, 72) * 3,
    "fechapago": random_datetime(base_date, datetime(2024, 12, 31)),
    "metodopago": random.choice(payment_methods),
    "reservaid": i+1 # Asignado al mismo ID de reserva
} for i in range(40_000_000)]

# Guardar pagos en CSV
guardar_csv("pagos.csv", pagos, ["pagoid", "cantidad", "fechapago", "metodopago", "reservaid"])


# Generar 4.000.000 de incidencias vinculadas a reservas
incidencias = []
estados = ["nueva", "abierta", "en proceso", "resuelta", "cerrada"]
for i in range(4_000_000):
    incidencia_id = i + 1
    reservaid = random.randint(1, 40_000_000)   # Cada incidencia vinculada a una reserva
    descripcion = f"Incidencia generada automáticamente #{incidencia_id}"
    fecha_incidencia = random_datetime(base_date, datetime(2024, 12, 31))
    estado = random.choice(estados)

    incidencias.append({
        "incidenciaid": incidencia_id,
        "descripcion": descripcion,
        "fechaincidencia": fecha_incidencia,
        "estado": estado,
        "reservaid": reservaid 
    })

# Guardar incidencias en CSV
guardar_csv("incidencias.csv", incidencias, ["incidenciaid", "descripcion", "fechaincidencia", "estado", "reservaid"])


print("Datos generados y guardados en archivos CSV correctamente.")