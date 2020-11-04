import psycopg2 as pg
from tabulate import tabulate
import os
from time import sleep

clear = lambda: os.system('cls')

### Setup
host_db = '201.238.213.114'  # host que les enviamos
port_db = '54321'  # puerto que les enviamos
db_name = 'grupo2'  # su base datos ej: grupoXX
username_db = 'grupo2'  # usario que les mandamos
password = '5S14Kc'  # contraseña que les enviamos

conn = pg.connect(dbname=db_name, user=username_db, host=host_db, port=port_db,
                  password=password)  ##Creamos la conexión
cursor = conn.cursor()
current_user = -1
carrito = []

def try_cast(option):
    converted = -1
    try:
        converted = int(option)
    except ValueError:
        print("Formato invalido")
    return converted


def ver_local():
    print_locales()
    print("Seleccione el id de un local: ")
    choice = input()
    choice = try_cast(choice)
    if choice == -1:
        print("Volviendo al menu anterior")
        sleep(1)
        return -1
    else:
        string = f"SELECT * from locales l WHERE l.id_local = {choice}"
        cursor.execute(string)
        resultado = cursor.fetchall()
        if len(resultado) == 0:
            print("Id invalido, volviendo al menu anterior")
            sleep(1)
            return -1
        else:
            return choice


def anadir_local():
    nombre = input("Ingrese el nombre del local: ")
    direccion = input("Ingrese la direccion del local: ")
    string = f"SELECT * FROM locales l WHERE l.direccion = '{direccion}' and l.nombre = {nombre}"
    cursor.execute(string)
    resultado = cursor.fetchall()
    if len(resultado) != 0:
        print("Ya existe un local con ese nombre registrado en esa direccion")
    else:
        sub_rutina = "SELECT l.id_local FROM locales l ORDER BY l.id_local DESC limit 1"
        cursor.execute(sub_rutina)
        resultado = cursor.fetchall()
        resultado = resultado[0][0] + 1
        string = f"INSERT INTO Locales(ID_Local,nombre,direccion)values({resultado},'{nombre}','{direccion}')"
        cursor.execute(string)
        conn.commit()
        print("Local anadido con exito")


# Listo
def eliminar_local(local):
    string = f"DELETE FROM locales l WHERE l.id_local = {local}"
    cursor.execute(string)
    conn.commit()
    print("local eliminado con exito")


def print_locales():
    string = "SELECT * from locales"
    cursor.execute(string)
    resultado = cursor.fetchall()
    print(tabulate(resultado, headers=['id', 'nombre', 'direccion'],tablefmt="pretty"))


def iniciar_sesion():
    # clear()
    correo = input("Ingrese el correo: ")
    contrasena = input("Ingrese la contraseña: ")
    string = f"SELECT u.id_usuario, u.email, u.clave FROM usuarios u WHERE u.email = '{correo}' and u.clave = '{contrasena}'"
    cursor.execute(string)
    resultado = cursor.fetchall()
    if len(resultado) == 0:
        print("Credenciales erroneas")
        print("Volviendo al menu anterior....")
        return -1
    else:
        return resultado[0][0]


def registrarse():
    # clear()
    correo = input("Ingrese el correo: ")
    numero = input("Ingrese su numero: ")
    nombre = input("Ingrese su nombre: ")
    contrasena = input("Ingrese su contrasena: ")
    string = f"SELECT * FROM usuarios u WHERE u.email = '{correo}' or u.numero_telefono = '{numero}'"
    cursor.execute(string)
    resultado = cursor.fetchall()
    if len(resultado) != 0:
        print("El numero telefonico o el correo ya se encuentra registrado")
        print("Volviendo al menu anterior...")
        return -1
    else:
        sub_rutina = "SELECT u.id_usuario FROM usuarios u ORDER BY u.id_usuario DESC limit 1"
        cursor.execute(sub_rutina)
        resultado = cursor.fetchall()
        resultado = resultado[0][0] + 1
        string = f"INSERT INTO Usuarios (id_usuario,Numero_telefono,nombre,clave,email) values('{resultado}','{numero}','{nombre}','{contrasena}','{correo}');"
        cursor.execute(string)
        conn.commit()
        print("Registro realizado con exito")
        return resultado


def super_ver_menu(menu):
    flag = True
    while flag:
        print("Seleccione una de las siguientes opciones:")
        print("(1) Agregar menu a carrito")
        print("(2) Eliminar producto de menu")
        print("(3) Editar menu")
        print("(4) Eliminar menu")
        print("(5) Descuento")
        print("(6) Volver al menu anterior")
        option = input()
        option = try_cast(option)
        if option == -1:
            continue
        elif option == 1:
            carrito.append(("menu", menu))
        elif option == 2:
            pass
        elif option == 3:
            pass
        elif option == 4:
            pass
        elif option == 5:
            pass
        elif option == 6:
            flag = False
        else:
            print("Ingrese una opcion valida")
            print("volviendo al menu anterior")

def print_menu(local):
    string = f"SELECT m.id_menu, m.nombre, m.precio from menus m WHERE m.id_local = {local}"
    cursor.execute(string)
    resultado = cursor.fetchall()
    print(tabulate(resultado, headers=['id', 'nombre', 'precio'], tablefmt="pretty"))


def print_menu_productos(menu):
    string = f"""SELECT m.id_local, m.nombre,p.id_producto,COALESCE(p.id_descuento,-1) from menus m, menus_productos mp, productos p 
WHERE m.id_menu = {menu} and mp.id_menu = {menu} and mp.id_producto = p.id_producto
"""
    cursor.execute(string)
    resultado = cursor.fetchall()
    for linea in resultado:
        aux = linea
        linea = list(linea)
        if linea[3] != -1:

            sub_rutina = f"""SELECT p.nombre,d.monto_descuento, d.porcentaje_descuento FROM productos p, descuentos d
                          WHERE p.id_descuento = d.id_descuento and p.id_producto = {linea[2]}"""
            cursor.execute(sub_rutina)
            sub_rut_res = cursor.fetchall()
            if sub_rut_res[0][1] is not None:
                linea[3] = sub_rut_res[0][1]
            elif sub_rut_res[0][2] is not None:
                linea[3] = sub_rut_res[0][2]
        else:
            sub_rutina = f"""SELECT p.nombre FROM productos p
                          WHERE p.id_producto = {linea[2]}"""
            cursor.execute(sub_rutina)
            sub_rut_res = cursor.fetchall()
            linea[3] = 0

        linea[2] = sub_rut_res[0][0]
        resultado[resultado.index(aux)] = tuple(linea)


    print(tabulate(resultado, headers=['id', 'nombre', 'precio', 'descuento'], tablefmt="pretty"))

def menu_ver_local_ver_menu(local):
    flag = True
    while flag:
        print_menu(local)
        print("Seleccione una de las siguientes opciones:")
        print("(1) Ver menu")
        print("(2) Agregar menu")
        print("(3) Volver al menu anterior")
        option = input()
        option = try_cast(option)
        if option == -1:
            continue
        elif option == 1:
            choice = input("Seleccione el id del menu que desea ver: ")
            choice = try_cast(choice)
            if choice == -1:
                print("Volviendo al menu anterior...")
                continue
            else:
                string = f"SELECT * from menus m WHERE m.id_menu = {choice}"
                cursor.execute(string)
                resultado = cursor.fetchall()
                if len(resultado) == 0:
                    print("Id invalido, volviendo al menu anterior")
                    sleep(1)
                    continue
                else:
                    print_menu_productos(choice)
                    super_ver_menu(choice)

        elif option == 2:
            pass
        elif option == 3:
            flag = False
        else:
            print("Ingrese una opcion valida")
            print("volviendo al menu anterior")


# listo
def menu_editar_local(local):
    flag = True
    while flag:
        print("Seleccione una de las siguientes opciones:")
        print("(1) Editar nombre")
        print("(2) Editar direccion")
        print("(3) Volver al menu anterior")
        option = input()
        option = try_cast(option)
        if option == -1:
            continue
        elif option == 1:
            nombre = input(f"Ingrese el nombre que quiere darle al local de id: {local}")
            string = f"UPDATE locales SET nombre ='{nombre}' WHERE id_local = {local}"
            cursor.execute(string)
            conn.commit()
        elif option == 2:
            direccion = input(f"Ingrese la direccion que quiere darle al local de id: {local}")
            string = f"UPDATE locales SET direccion ='{direccion}' WHERE id_local = {local}"
            cursor.execute(string)
            conn.commit()
        elif option == 3:
            flag = False
        else:
            print("Ingrese una opcion valida")
            print("volviendo al menu anterior")


def menu_ver_local(local):
    flag = True
    while flag:
        print("Seleccione una de las siguientes opciones:")
        print("(1) Editar local")
        print("(2) Eliminar local")
        print("(3) Ver menus")
        print("(4) Ver productos")
        print("(5) Ver categorias")
        print("(6) Ver favoritos")
        print("(7) Ver rating")
        print("(8) Volver al menu anterior")
        option = input()
        option = try_cast(option)
        if option == -1:
            continue
        elif option == 1:
            menu_editar_local(local)
        elif option == 2:
            pass
        elif option == 3:
            menu_ver_local_ver_menu(local)
        elif option == 4:
            pass
        elif option == 5:
            pass
        elif option == 6:
            pass
        elif option == 7:
            pass
        elif option == 8:
            flag = False
        else:
            print("Ingrese una opcion valida")
            print("volviendo al menu anterior")


def menu_local():
    flag = True
    while flag:
        # clear()
        print_locales()
        print("Seleccione una de las siguientes opciones:")
        print("(1) Ver local")
        print("(2) Agregar local")
        print("(3) Volver al menu anterior")
        option = input()
        option = try_cast(option)
        if option == -1:
            continue
        elif option == 1:  # Ver local
            local = ver_local()
            menu_ver_local(local)
        elif option == 2:  # Anadir local
            anadir_local()
        elif option == 3:
            flag = False
        else:
            print("Ingrese una opcion valida")
            print("Volviendo al menu anterior")
            sleep(1)

def print_repartidores():
    string = "SELECT r.id_repartidor,r.nombre, r.patente from repartidores r "
    cursor.execute(string)
    resultado = cursor.fetchall()
    print(tabulate(resultado, headers=['numero', 'nombre', 'patente'], tablefmt="pretty"))

def eliminar_repartidor(id_repartidor):
    string = f"DELETE FROM repartidores r WHERE r.id_repartidor = {id_repartidor}"
    cursor.execute(string)
    conn.commit()
    print("Repartidor eliminado con exito")

def editar_repartidor(id_repartidor):
    flag = True
    while flag:
        print("Seleccione una de las siguientes opciones:")
        print("(1) Editar nombre del repartidor")
        print("(2) Editar teléfono del repartidor")
        print("(3) Editar vehículo/patente del repartidor") #Acá editamos la patente y el vehículo, ya una implica la otra
        print("(4) Volver al menu anterior")
        option = input()
        option = try_cast(option)
        if option == -1:
            continue
        elif option == 1:
            nombre = input("Ingrese el nuevo nombre de su repartidor: ")
            string1 = f"SELECT * FROM repartidores r WHERE r.nombre = '{nombre}'"
            cursor.execute(string1)
            resultado = cursor.fetchall()
            if len(resultado) != 0:
                print("Este nombre ya existe, volviendo...")
            else:
                string2 = f"UPDATE repartidores SET nombre='{nombre}' WHERE id_repartidor={id_repartidor}"
                cursor.execute(string2)
                conn.commit()
                print("Nombre actualizado correctamente")
        elif option == 2:
            telefono=input("Ingrese el nuevo telefono de su repartidor: ")
            string1 = f"SELECT * FROM repartidores r WHERE r.telefono = '{telefono}'"
            cursor.execute(string1)
            resultado = cursor.fetchall()
            if len(resultado)!=0:
                print("Este telefono ya existe, volviendo...")
            else:
                string2 = f"UPDATE repartidores SET telefono='{telefono}' WHERE id_repartidor={id_repartidor}"
                cursor.execute(string2)
                conn.commit()
                print("Telefono actualizado correctamente")
        elif option == 3:
            #Asumimos que distintas personas pueden usar un mismo vehículo
            patente=input("Ingrese la nueva patente de su vehículo: ")
            vehiculo=input("Ingrese el nuevo tipo de vehiculo: ")
            string2 = f"UPDATE repartidores SET patente='{patente}' WHERE id_repartidor={id_repartidor}"
            cursor.execute(string2)
            string3 = f"UPDATE repartidores SET vehiculo='{vehiculo}' WHERE id_repartidor={id_repartidor}"
            cursor.execute(string3)
            conn.commit()
            print("Vehículo actualizado correctamente")
        elif option == 4:
            flag = False
        else:
            print("Ingrese una opcion valida")
            print("volviendo al menu")

def sub_repartidores(id_repartidor):
    flag = True
    while flag:
        print("Seleccione una de las siguientes opciones:")
        print("(1) Editar repartidor")
        print("(2) Eliminar repartidor")
        print("(3) Volver al menu anterior")
        option = input()
        option = try_cast(option)
        if option == -1:
            continue
        elif option == 1:
            editar_repartidor(id_repartidor)
        elif option == 2:
            eliminar_repartidor(id_repartidor)
            flag=False
        elif option == 3:
            flag = False
        else:
            print("Ingrese una opcion valida")
            print("volviendo al menu")

def agregar_repartidor():
    nombre=input("Ingrese el nombre del nuevo repartidor")
    telefono=input("Ingrese el telefono del nuevo repartidor")
    patente=input("Ingrese la patente del vehiculo del nuevo repartidor")
    vehiculo=input("Ingrese el tipo de vehivulo del nuevo repartidor")

    string1 = f"SELECT * FROM repartidores r WHERE r.nombre = '{nombre}'"
    cursor.execute(string1)
    string2 = f"SELECT * FROM repartidores r WHERE r.telefono = '{telefono}'"
    cursor.execute(string2)
    if len(string1)!=0 or len(string2)!=0:
        print("Teléfono o nombre ya existentes, volviendo...")
    else:
        sub_rutina = "SELECT r.id_repartidor FROM repartidores r ORDER BY r.id_repartidor DESC limit 1"
        cursor.execute(sub_rutina)
        resultado = cursor.fetchall()
        resultado = resultado[0][0] + 1

        string3 = f"INSERT INTO Repartidores (ID_Repartidor,nombre,telefono,vehiculo,patente)values({resultado},'{nombre}','{telefono}','{vehiculo}','{patente}');"
        cursor.execute(string2)
        conn.commit()
        print("Repartidor agregado correctamente")

def repartidores():
    flag = True
    while flag:
        print_repartidores()
        print("Seleccione una de las siguientes opciones:")
        print("(1) Ver repartidor")
        print("(2) Agregar repartidor")
        print("(3) Volver al menu anterior")
        option = input()
        option = try_cast(option)
        if option == -1:
            continue
        elif option == 1:
            choice = input("Seleccione el repartidor que desea ver: ")
            choice = try_cast(choice)
            if choice == -1:
                print("Volviendo al menu anterior...")
                continue
            else:
                string = f"SELECT * from repartidores r WHERE r.id_repartidor = {choice}"
                cursor.execute(string)
                resultado = cursor.fetchall()
                if len(resultado) == 0:
                    print("Id invalido, volviendo al menu anterior")
                    sleep(1)
                    continue
                else:
                    print(tabulate(resultado, headers=['id_repartidor', 'nombre', 'telefono','patente','vehiculo'], tablefmt="pretty"))
                    sub_repartidores(choice)
        elif option == 2:
            agregar_repartidor()
        elif option == 3:
            flag = False
        else:
            print("Ingrese una opcion valida")
            print("volviendo al menu")

def menu_ingresado():
    flag = True
    while flag:
        # clear()
        print("Seleccione una de las siguientes opciones:")
        print("(1) Seccion locales")
        print("(2) Seccion categorias")
        print("(3) Seccion promociones")
        print("(4) Seccion direcciones")
        print("(5) Seccion carrito")
        print("(6) Seccion historial de pedidos")
        print("(7) Seccion repartidores")
        print("(8) Cerrar sesion")
        option = input()
        option = try_cast(option)
        if option == -1:
            flag = True
        elif option == 1:
            menu_local()
        elif option == 7:
            repartidores()
        elif option == 8:
            flag = False
        else:
            print("Ingrese una opcion valida")
            sleep(1)


def menu_inicial():
    flag = True
    while flag:
        # clear()
        print("Seleccione una de las siguientes opciones:")
        print("(1) Iniciar sesion")
        print("(2) Registrarse")
        print("(3) Cerrar el programa")
        option = input()
        option = try_cast(option)
        if option == -1:
            flag = True
            continue
        elif option == 1:
            retorno = iniciar_sesion()
            if retorno == -1:
                continue
            else:
                current_user = retorno
                menu_ingresado()  # Aqui entramos a la aplicacion
        elif option == 2:
            retorno = registrarse()
            if retorno == -1:
                continue
            else:  # Aqui entramos a la aplicacion pero de la otra forma
                current_user = retorno
                menu_ingresado()
        elif option == 3:
            flag = False
        else:
            print("Ingrese una opcion valida")
            sleep(1)


menu_inicial()
conn.commit()
conn.close()
