import psycopg2 as pg
from tabulate import tabulate
import os
from time import sleep

clear = lambda: os.system('cls')

### Setup
host_db = '201.238.213.114' #host que les enviamos
port_db = '54321' # puerto que les enviamos
db_name = 'grupo2' # su base datos ej: grupoXX
username_db = 'grupo2' # usario que les mandamos
password = '5S14Kc' #contraseña que les enviamos

conn = pg.connect(dbname=db_name, user=username_db, host=host_db, port=port_db, password = password) ##Creamos la conexión
cursor = conn.cursor()


def try_cast(option):
    converted = -1
    try:
        converted = int(option)
    except ValueError:
        print("Formato invalido")
    return converted

def iniciar_sesion():
    #clear()
    correo = input("Ingrese el correo: ")
    contrasena = input ("Ingrese la contraseña: ")
    string = f"SELECT u.email, u.clave FROM usuarios u WHERE u.email = '{correo}' and u.clave = '{contrasena}'"
    cursor.execute(string)
    resultado = cursor.fetchall()
    if len(resultado) == 0:
        print ("Credenciales erroneas")
        print ("Volviendo al menu....")
        return -1
    else:
        return resultado

def registrarse():
    #clear()
    correo = input("Ingrese el correo: ")
    numero = input("Ingrese su numero: ")
    nombre = input("Ingrese su nombre: ")
    contrasena = input("Ingrese su contrasena: ")
    string = f"SELECT * FROM usuarios u WHERE u.email = '{correo}' or u.numero_telefono = '{numero}'"
    cursor.execute(string)
    resultado = cursor.fetchall()
    if len(resultado) != 0:
        print("El numero telefonico o el correo ya se encuentra registrado")
        return -1
    else:
        sub_rutina = "SELECT u.id_usuario FROM usuarios u ORDER BY u.id_usuario DESC limit 1"
        cursor.execute(sub_rutina)
        resultado = cursor.fetchall()
        resultado = resultado[0][0]+1
        string =f"INSERT INTO Usuarios (id_usuario,Numero_telefono,nombre,clave,email) values('{resultado}','{numero}','{nombre}','{contrasena}','{correo}');"
        cursor.execute(string)
        conn.commit()
        print("Registro realizado con exito")

def menu_local():
    flag = True
    while flag:
        #clear()
        string = "SELECT * from locales"
        cursor.execute(string)
        resultado = cursor.fetchall()
        print(tabulate(resultado, headers=['id', 'nombre', 'direccion']))
        print("Seleccione una de las siguientes opciones:")
        print("(1) Ver local")
        print("(2) Agregar local")
        print("(3) Eliminar local")
        print("(4) Volver al menu anterior")
        option = input()
        option = try_cast(option)
        if option == -1:
            continue
        elif option == 1: #Ver local
            string = "SELECT * from locales"
            cursor.execute(string)
            resultado = cursor.fetchall()
            print(tabulate(resultado, headers=['id', 'nombre', 'direccion']))
            print("Seleccione el id de un local: ")
            choice = input()
            choice = try_cast(choice)
            if choice == -1:
                print("Volviendo al menu anterior")
                sleep(1)
                continue
            else:
                string = f"SELECT * from locales l WHERE l.id_local = {choice}"
                cursor.execute(string)
                resultado = cursor.fetchall()
                if len(resultado) == 0:
                    print("Id invalido, volviendo al menu anterior")
                    sleep(1)
                    continue
                else:
                    menus = f"""Select t1.id_local, t1.nombre, t1.direccion, t1.Cantidad_de_productos, t2.Cantidad_de_menus from ( SELECT l.id_local,l.nombre, l.direccion, count(p.id_producto) Cantidad_de_productos FROM locales l, productos p
WHERE p.id_local = {choice} and l.id_local = p.id_local GROUP BY l.id_local) t1  full outer join
    (SELECT l.id_local,l.nombre, l.direccion, count(m.id_menu) Cantidad_de_menus FROM menus m,locales l
WHERE m.id_local = {choice} and l.id_local=m.id_local GROUP BY l.id_local) t2 on t1.id_local= t2.id_local"""
                    cursor.execute(menus)
                    resultado = cursor.fetchall()
                    print(tabulate(resultado, headers=['id', 'nombre', 'direccion','Cantidad productos','Cantidad menus']))
                    sleep(5)
        elif option == 2:
            nombre = input("Ingrese el nombre del local: ")
            direccion = input("Ingrese la direccion del local: ")
            string = f"SELECT * FROM locales l WHERE l.direccion = '{direccion}'"
            cursor.execute(string)
            resultado = cursor.fetchall()
            if len(resultado) != 0:
                print ("Ya existe un local registrado en esa direccion")
                continue
            else:
                sub_rutina = "SELECT l.id_local FROM locales l ORDER BY l.id_local DESC limit 1"
                cursor.execute(sub_rutina)
                resultado = cursor.fetchall()
                resultado = resultado[0][0] + 1
                string = f"INSERT INTO Locales(ID_Local,nombre,direccion)values({resultado},'{nombre}','{direccion}')"
                cursor.execute(string)
                conn.commit()
                print("Local anadido con exito")
        elif option == 3:
            string = "SELECT * from locales"
            cursor.execute(string)
            resultado = cursor.fetchall()
            print(tabulate(resultado, headers=['id', 'nombre', 'direccion']))
            choice = input("Ingrese el id del local que desea eliminar: ")
            choice = try_cast(choice)
            if choice == -1:
                print("Volviendo al menu anterior")
                sleep(1)
                continue
            else:
                string = f"SELECT * from locales l WHERE l.id_local = {choice}"
                cursor.execute(string)
                resultado = cursor.fetchall()
                if len(resultado) == 0:
                    print("Id invalido, volviendo al menu anterior")
                    sleep(1)
                    continue
                else:
                    string = f"DELETE FROM locales l WHERE l.id_local = {choice}"
                    cursor.execute(string)
                    conn.commit()
                    print ("local eliminado con exito")
                    continue
        elif option == 4:
            flag = False
        else:
            print("Ingrese una opcion valida")
            print("Volviendo al menu anterior")
            sleep(1)





def menu_ingresado():
    flag = True
    while flag:
        #clear()
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
            continue
        elif option == 1:
            menu_local()
            continue
        elif option == 8:
            flag = False
        else:
            print("Ingrese una opcion valida")
            sleep(1)

def menu_inicial():
    flag = True
    while flag:
        #clear()
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
                menu_ingresado() #Aqui entramos a la aplicacion
        elif option == 2:
            retorno = registrarse()
            if retorno == -1:
                continue
            else: #Aqui entramos a la aplicacion pero de la otra forma
                menu_ingresado()
        elif option == 3:
            flag = False
        else:
            print("Ingrese una opcion valida")
            sleep(1)


menu_inicial()
conn.commit()
conn.close()