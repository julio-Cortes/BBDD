---TABLAS

CREATE TABLE Usuarios (
	ID_Usuario serial PRIMARY KEY,
    numero_telefono varchar(11) NOT NULL,
   	clave varchar(50) NOT NULL,
    nombre varchar(50) NOT NULL,
    email varchar(50) NOT NULL
);

CREATE TABLE Promociones(
	Codigo serial PRIMARY KEY,
    fecha_caducidad DATE NOT NULL,
    monto_descuento INTEGER NOT NULL,
    descripcion varchar(200) NOT NULL
);

CREATE TABLE Direcciones(
	ID_Direccion serial PRIMARY KEY,
	region varchar(50) NOT NULL,
	nombre_identificador varchar(50) NOT NULL,
	calle varchar(50) NOT NULL,
	comuna varchar(50) NOT NULL,
	numero INTEGER NOT NULL,
	departamento_block varchar(50)
);

CREATE TABLE Repartidores(
	 ID_Repartidor serial PRIMARY KEY,
   	 nombre varchar(50) NOT NULL,
     telefono varchar(11) NOT NULL,
	 patente varchar(10) NOT NULL,
	 vehiculo varchar(50) NOT NULL
);

CREATE TABLE Locales(
	ID_Local serial PRIMARY KEY,
	nombre varchar(50) NOT NULL,
	direccion varchar(100) NOT NULL
);

CREATE TABLE Categorias(
	ID_Categoria serial PRIMARY KEY,
	nombre varchar(50) NOT NULL
);

CREATE TABLE Descuentos (
	ID_Descuento serial PRIMARY KEY,
    porcentaje_descuento DECIMAL ,
	monto_descuento INTEGER
);

CREATE TABLE Usuarios_Promociones
(
    ID_Usuario_Promocion serial PRIMARY KEY ,
    ID_Usuario INTEGER NOT NULL
        REFERENCES Usuarios (ID_Usuario) ON DELETE CASCADE,
    Codigo INTEGER NOT NULL
        REFERENCES Promociones (Codigo) ON DELETE CASCADE,
    Numero_de_usos INTEGER NOT NULL
);

CREATE TABLE Usuarios_Direcciones(
	ID_Usuario_Direccion serial PRIMARY KEY,
	ID_Usuario INTEGER NOT NULL
		REFERENCES Usuarios(ID_Usuario ) ON DELETE CASCADE,
	ID_Direccion INTEGER NOT NULL
		REFERENCES Direcciones(ID_Direccion  ) ON DELETE CASCADE
);

CREATE TABLE Usuarios_Locales_Rating(
	ID_Usuario_Local_Rating serial PRIMARY KEY,
	ID_Usuario INTEGER NOT NULL
		REFERENCES Usuarios(ID_Usuario) ON DELETE CASCADE,
	ID_Local INTEGER NOT NULL
		REFERENCES Locales(ID_Local) ON DELETE CASCADE,
	rating INTEGER NOT NULL
);

CREATE TABLE Locales_Categorias(
	ID_Local_Categoria serial PRIMARY KEY,
	ID_Local INTEGER NOT NULL
		REFERENCES Locales(ID_Local) ON DELETE CASCADE,
	ID_Categoria INTEGER NOT NULL
		REFERENCES Categorias(ID_Categoria) ON DELETE CASCADE
);


CREATE TABLE Usuarios_Locales_Favoritos(
	ID_Usuario_Local_Favorito serial PRIMARY KEY,
	ID_Usuario INTEGER NOT NULL
		REFERENCES Usuarios(ID_Usuario) ON DELETE CASCADE,
	ID_Local INTEGER NOT NULL
		REFERENCES Locales(ID_Local) ON DELETE CASCADE
);


CREATE TABLE Productos(
	ID_Producto serial PRIMARY KEY,
	ID_Local INTEGER NOT NULL
		REFERENCES Locales(ID_Local) ON DELETE CASCADE,
	ID_Descuento INTEGER
		REFERENCES Descuentos(ID_Descuento),
    nombre varchar(50) NOT NULL,
    precio int NOT NULL
);

CREATE TABLE Menus(
	ID_Menu serial PRIMARY KEY,
	ID_Local INTEGER NOT NULL
		REFERENCES Locales(ID_Local) ON DELETE CASCADE,
	ID_Descuento INTEGER
		REFERENCES Descuentos(ID_Descuento),
    nombre varchar(50) NOT NULL,
    precio int NOT NULL
);

CREATE TABLE Menus_Productos(
	ID_Menu_Producto serial PRIMARY KEY,
	ID_Producto INTEGER NOT NULL
		REFERENCES Productos(ID_Producto) ON DELETE CASCADE,
	ID_Menu INTEGER NOT NULL
		REFERENCES Menus(ID_Menu) ON DELETE CASCADE
);


CREATE TABLE Pedidos(
	ID_Pedido serial PRIMARY KEY,
	ID_Usuario INTEGER NOT NULL
	    REFERENCES Usuarios(ID_Usuario) ON DELETE CASCADE,
	ID_Usuario_Promocion INTEGER
		REFERENCES Usuarios_Promociones(ID_Usuario_Promocion),
    ID_Repartidor INTEGER NOT NULL
        REFERENCES Repartidores(ID_Repartidor) ON DELETE CASCADE,
    precio INTEGER NOT NULL,
    ID_Direccion INTEGER NOT NULL
        REFERENCES Direcciones(ID_Direccion) ON DELETE CASCADE,
	fecha DATE NOT NULL,
	Rating_repartidor INTEGER
);



CREATE TABLE Pedidos_Productos(
	ID_Pedido_Producto serial PRIMARY KEY,
	ID_Pedido INTEGER NOT NULL
		REFERENCES Pedidos(ID_Pedido) ON DELETE CASCADE,
	ID_Producto INTEGER NOT NULL
		REFERENCES Productos(ID_Producto ) ON DELETE CASCADE,
	cantidad INTEGER NOT NULL
);

CREATE TABLE Pedidos_Menus(
	ID_Pedido_Menu serial PRIMARY KEY,
	cantidad INTEGER NOT NULL,
	ID_Pedido INTEGER NOT NULL
		REFERENCES Pedidos(ID_Pedido) ON DELETE CASCADE,
	ID_Menu INTEGER NOT NULL
		REFERENCES Menus(ID_Menu) ON DELETE CASCADE
);

---INSERT

INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0000','56958931626','María José Marfán','0305','mjmarfan@miuandes.cl');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0001','56962067320','María Francisca Binder','9323','mfbinder@uc.cl');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0002','56962067320','María Francisca Binder','1234','mbinder@miuandes.cl');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0003','56922034956','Lucía Echeñique','1123','luciaech@gmail.com');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0004','56998736049','María Francisca Correa','0023','f.correa@csuv.cl');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0005','56968192167','Juan Manuel Medina','kika123','jumedina@uc.cl');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0006','56948573758','Juan Carlos Correa','5678','jccorrea@gmail.com');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0007','56847372739','Ignacio Lopez','il123','ignaciolopez@gmail.com');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0008','56934763878','Ignacia Ecclefield','4576','iecclefield@miuandes.cl');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0009','56943827498','Martina Willer','mwiller456','mwiller@miuandes.cl');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0010','56937424879','Francisca Vergara','7870','fbvergara@miuandes.cl');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0011','56947387297','José Tomás Gutierrez','33421','jgutierrez@miuandes.cl');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0012','56937483274','Benjamin Morgan','43423','bamorgan@miuandes.cl');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0013','56947284294','Rafael Ruiz-Clavijo','rrc433','rruizclavijo@miuandes.cl');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0014','56938983223','Bernardita Perez','45242','bperez@gmail.com');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0015','56943248793','Lucia Long','llong341','lucialong@gmail.com');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0016','56934723472','Juana Maria Grez','43223','jmariagrez@gmail.com');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0017','56942344878','Rodrigo Tellez','233121rr','rrtellez@gmail.com');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0018','56942384831','Cristina Sasco','cs312','cristinasasco@gmail.com');
INSERT INTO Usuarios (ID_Usuario,Numero_telefono,nombre,clave,email)values('0019','56934893413','Ignacio Marfan','23123im','nachomarfan@gmail.com');

INSERT INTO Promociones (Codigo,fecha_caducidad,monto_descuento,descripcion)values('0000','30-09-2020','2000','Compra cualquier hamburguesa y llevate una bebida con $2000 de descuento');
INSERT INTO Promociones (Codigo,fecha_caducidad,monto_descuento,descripcion)values('0001','31-10-2020','3000','3.000 de descuento por compras superiores a 6.000');
INSERT INTO Promociones (Codigo,fecha_caducidad,monto_descuento,descripcion)values('0002','22-10-2021','4000','4.000 de descuento por compras superiores a 10.000');
INSERT INTO Promociones (Codigo,fecha_caducidad,monto_descuento,descripcion)values('0003','10-10-2020','2000','2.000 de descuento en streat ');
INSERT INTO Promociones (Codigo,fecha_caducidad,monto_descuento,descripcion)values('0004','01-09-2020','2000','2.000 de descuento en cualquier restaurant de pizza');

INSERT INTO Locales(ID_Local,nombre,direccion)values('0000','Lomit´s','Av. Providencia 1980');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0001','McDonals','Av. Vitacura 7300');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0002','Fork','Carlos Silva Vildósola 1232');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0003','Kansui','Brown Nte 685, Ñuñoa');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0004','Aromas','Huerfanos 1370');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0005','Sushi Niu','Vitacura 6485');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0006','Chicken Love You','Avenida Ossa 2280');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0007','Quinua','Luis Pasteur 5393');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0008','Uncle Fletch','El rodeo 12850');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0009','Quererte','Cristobal Colón 6560');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0010','La Punta','Los Abedules 3.016, Vitacura');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0011','La Fattoria','Av. Apoquindo 5680');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0012','Burger Home','6 Pte. 150, Viña del Mar, Valparaíso');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0013','Museo Peruano','Av. Vitacura 7132, Vitacura');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0014','Domino ','Av Presidente Kennedy 5413');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0015','Tip y Tap','Av Vitacura 5365');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0016','Il Mercantino','Vitacura 7608, local 7');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0017','Teclados','Av. Manuel Montt 116');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0018','Krossbar','Av San Josemaría Escrivá de Balaguer 6400');
INSERT INTO Locales(ID_Local,nombre,direccion)values('0019','Mestizo','Bicentenario 4050, Vitacura');

INSERT INTO Repartidores (ID_Repartidor,nombre,telefono,vehiculo,patente)values('0000','Julio','56934592354','Camioneta','BN-JG-23');
INSERT INTO Repartidores (ID_Repartidor,nombre,telefono,vehiculo,patente)values('0001','Ignacia','56949067589','Auto','JP-WF-87');
INSERT INTO Repartidores (ID_Repartidor,nombre,telefono,vehiculo,patente)values('0002','Nicolas','56976397569','Bicicleta','GH-DS-67');
INSERT INTO Repartidores (ID_Repartidor,nombre,telefono,vehiculo,patente)values('0003','Francisco','56934234323','Auto','MP-FG-56');
INSERT INTO Repartidores (ID_Repartidor,nombre,telefono,vehiculo,patente)values('0004','Lucia','56934242333','Auto','LP-GM-34');

INSERT INTO Descuentos (ID_Descuento,porcentaje_descuento,monto_descuento)values('0000','20',NULL);
INSERT INTO Descuentos (ID_Descuento,porcentaje_descuento,monto_descuento)values('0001',NULL,'3000');
INSERT INTO Descuentos (ID_Descuento,porcentaje_descuento,monto_descuento)values('0002',NULL,'2000');
INSERT INTO Descuentos (ID_Descuento,porcentaje_descuento,monto_descuento)values('0003','40',NULL);
INSERT INTO Descuentos (ID_Descuento,porcentaje_descuento,monto_descuento)values('0004','60',NULL);
INSERT INTO Descuentos (ID_Descuento,porcentaje_descuento,monto_descuento)values('0005',NULL,'1000');

INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0000','Metropolitana','Casa','Camoens','Vitacura','6561','NULL');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0001','Metropolitana','Casa J','Sebastian Elcano','Las Condes','950','504');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0002','Metropolitana','Casa','Av. el Bosque','Providencia','352','1402');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0003','Metropolitana','Casa','Sebastian Elcano','Las Condes','950','504');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0004','Metropolitana','Oficina','Suecia','Providencia','518','NULL');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0005','Metropolitana','Casa abuelita','Mar Bótanico','Vitacura','221','NULL');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0006','Metropolitana','Casa Mia','Alcantara','Las Condes','1402','140');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0007','Metropolitana','Casa prima','Las compuertas','Lo barnechea','345','NULL');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0008','Metropolitana','Casa ','Presidente Riesco','Las condes','1309','NULL');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0009','Valparaiso','Casa hermano','Pedro Montt','Valparaiso ','567','NULL');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0010','Los lagos','Casa ','Av Alberto','Osorno','1305','NULL');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0011','Metropolitana','Casa mama','Av Las condes','Las condes','234','67');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0012','Metropolitana','Casa','San Pablo','Pudahuel','3456','23');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0013','Metropolitana','Casa abuelo','Del Pincoy','Huechuraba','23445','NULL');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0014','Metropolitana','Casa','Av Quillin','Macul','4567','654');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0015','Metropolitana','Casa papa','Simon Bolivar','Provdencia','3456','NULL');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0016','Metropolitana','Casa','Tobalaba','Provdencia','243','NULL');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0017','Metropolitana','Casa pololo','El rodeo','Lo barnechea','6359','NULL');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0018','Metropolitana','Casa','Colon Sur','San Bernardo','587','90');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0019','Metropolitana','Casa abuela','Santa Marta','San Bernardo','5237','56');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0020','Metropolitana','Casa','Av Eyzaguirre','Puente Alto','3452','NULL');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0021','Metropolitana','Casa hermana','San Pedro','Puente Alto','8674','109');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0022','Metropolitana','Casa','El carmen','Maipu','412','NULL');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0023','Metropolitana','Casa','Av Portales','Maipu','8764','45');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0024','Metropolitana','Casa','El libano','Macul','7354','NULL');
INSERT INTO Direcciones (ID_Direccion,region,nombre_identificador,calle,comuna,numero,departamento_block)values('0025','Metropolitana','Casa','Zañartu','Macul','75742','203');

INSERT INTO Categorias (ID_Categoria,nombre)values('0000','Pizza');
INSERT INTO Categorias (ID_Categoria,nombre)values('0001','Comida rápida');
INSERT INTO Categorias (ID_Categoria,nombre)values('0002','Sushi');
INSERT INTO Categorias (ID_Categoria,nombre)values('0003','Americana');
INSERT INTO Categorias (ID_Categoria,nombre)values('0004','Sanwich');
INSERT INTO Categorias (ID_Categoria,nombre)values('0005','Arabe');
INSERT INTO Categorias (ID_Categoria,nombre)values('0006','China');
INSERT INTO Categorias (ID_Categoria,nombre)values('0007','Saludable');
INSERT INTO Categorias (ID_Categoria,nombre)values('0008','Cafetería');
INSERT INTO Categorias (ID_Categoria,nombre)values('0009','Nacional');
INSERT INTO Categorias (ID_Categoria,nombre)values('0010','Italiana');
INSERT INTO Categorias (ID_Categoria,nombre)values('0011','Peruana');
INSERT INTO Categorias (ID_Categoria,nombre)values('0012','Bar');

INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0000','0005',NULL,'Martes para dos','9900');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0001','0000',NULL,'Menú almuerzo','5000');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0002','0001',NULL,'Menú Junaeb','3900');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0003','0001',NULL,'Cajita feliz','3900');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0004','0009',0005,'Café+pastel','5400');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0005','0002',NULL,'Sopa+pan','3500');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0006','0003',0001,'Ramen+cerveza','9000');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0007','0004',0002,'Almuerzo','3000');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0008','0006',NULL,'Almuerzo','8000');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0009','0007',NULL,'Desayuno','7000');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0010','0008',NULL,'Almuerzo','5900');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0011','0010',0003,'Aperitivo','6000');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0012','0011',0004,'Almuerzo','10000');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0013','0012',NULL,'Para empezar','9990');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0014','0013',NULL,'Almuerzo','11990');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0015','0014',NULL,'Almuerzo','4000');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0016','0015',NULL,'Almuerzo','10000');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0017','0016',NULL,'Almerzo familiar','200000');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0018','0018',NULL,'Con amigos','200000');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0019','0017',NULL,'Para dos','5000');
INSERT INTO Menus (ID_Menu,ID_Local,ID_Descuento,nombre,precio)values('0020','0019',NULL,'Menú ejecutivo','12000');

INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0000','0000',0000,'Lomito italiano','4000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0001','0001',NULL,'Mc Nífica','3600');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0002','0002',NULL,'Crema zanahoria Thai','2990');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0003','0000',NULL,'Chacarero','4600');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0004','0000',NULL,'Bebida lata','1000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0005','0005',0003,'Niu del día','1900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0006','0006',NULL,'¿Qué fue primero?','6400');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0007','0001',NULL,'Papas fritas medianas','2100');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0008','0003',NULL,'Tempura furai','4400');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0009','0003',NULL,'Gyozas variedades','5000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0010','0005',NULL,'Ebi Oriental','3000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0011','0005',NULL,'Avocado Cheese Rol','4900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0012','0005',NULL,'California Tori','5200');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0013','0001',NULL,'Bebida mediana','1600');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0014','0001',NULL,'Bebidia chica','1400');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0015','0001',NULL,'Papas fritas chicas','1900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0016','0009',NULL,'Trozo pastel','4200');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0017','0009',NULL,'Café Caramel','3890');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0018','0009',NULL,'Cheescake','3800');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0019','0006',NULL,'Bebida lata','1000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0020','0006',NULL,'Papas fritas','1600');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0021','0006',NULL,'Browcano','3900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0022','0006',NULL,'Helado de Cornflakes','3200');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0023','0006',NULL,'Flanstagram','3900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0024','0000',NULL,'Lomito chacarero','4600');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0025','0000',0005,'Lomito solo','4200');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0026','0000',NULL,'Shop','3000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0027','0000',NULL,'Papas fritas','2400');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0028','0000',NULL,'Cerveza nacional','2000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0029','0000',NULL,'Helado elección','1800');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0030','0000',0000,'Barro luco','4000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0031','0001',0002,'Cuarto de libra','3200');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0032','0001',NULL,'Papas fritas garndes','2200');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0033','0001',NULL,'Bebida grande','2000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0034','0001',NULL,'Big Mac','3800');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0035','0001',NULL,'Mc FLury','1500');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0036','0002',0001,'Carne mongolania','4990');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0037','0002',0002,'Quiche de alcachofas','11990');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0038','0002',NULL,'Ciabatta','590');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0039','0002',NULL,'Pan masa madre','1990');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0040','0002',NULL,'Mini musse chocoalte bitter','1890');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0041','0002',NULL,'Empanada chupe camarón','990');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0042','0002',NULL,'Empanada queso','1990');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0043','0002',0005,'Sopa zapallo','2990');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0044','0002',NULL,'Caprese al paso','2990');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0045','0003',NULL,'Ramen Shoyu','7800');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0046','0003',NULL,'Ramen Vegetariano','7800');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0047','0003',NULL,'Tantanmen','6800');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0048','0003',NULL,'Ramen Tonkontsu','10000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0049','0003',NULL,'Montesol Amber','3000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0050','0003',NULL,'Montesol Golden','3000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0051','0003',NULL,'Montesol Imperial','3000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0052','0003',0002,'Tiramizu Matcha','3600');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0053','0004',NULL,'Kuchen manzana individual','1500');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0054','0004',NULL,'Kuchen berries individual','1500');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0055','0004',NULL,'Kuchen guinda individual','1500');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0056','0004',NULL,'Kuchen manzana 11p','11000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0057','0004',NULL,'Kuchen berries 11p','11000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0058','0004',NULL,'Kuchen guinda 11p','11000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0059','0004',NULL,'Pie limon individual','1500');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0060','0004',NULL,'Pie limon 12p','11000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0061','0004',NULL,'Repollitos manjar (4u)','1500');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0062','0004',0001,'Empanadas variedades','2000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0063','0005',NULL,'Camarones Niu','4900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0064','0005',NULL,'Tori Balls','4400');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0065','0005',0003,'Empanas Niu Camaron','4600');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0066','0005',0003,'Empanas Niu Champiñon','4500');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0067','0005',NULL,'Gohan','1600');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0068','0005',NULL,'Yakimeshi','1800');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0069','0006',0005,'Tuto pallá, tuto pacá ','5900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0070','0006',NULL,'닭고기가 아니라 박쥐 🇰🇷','6400');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0071','0006',NULL,'¿Por qué la gallina cruzó la calle?','6900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0072','0006',0004,'Vaca y pollito','9900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0073','0007',NULL,'Jugos naturales','2700');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0074','0007',0002,'Kombucha','2900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0075','0007',NULL,'Jugas detox','3500');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0076','0007',NULL,'Tableta nuez manjar','4500');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0077','0007',NULL,'Brownie vegano','4100');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0078','0007',0005,'Flan de coco','3600');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0079','0007',NULL,'Guacamole','5700');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0080','0007',NULL,'Hummus','5100');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0081','0007',NULL,'Buddha Bowl','7700');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0082','0007',NULL,'Burritos','8100');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0083','0008',0001,'Burger BOX- New York Style (4p)','23000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0084','0008',NULL,'Burger BOX- Blue Cheese Supreme (4p)','23000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0085','0008',NULL,'Original 1st Cheeseburger','5900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0086','0008',NULL,'The Fletch’s classic','5400');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0087','0008',NULL,'The New York Style','6200');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0088','0008',NULL,'The Fajitas Burger','6500');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0089','0008',NULL,'The Big Texas','7400');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0090','0008',NULL,'The Monster Truck','9900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0091','0008',NULL,'Papas fritas','1600');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0092','0008',NULL,'Onion Rings','3900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0093','0009',NULL,'Choco Chip Cookies','2190');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0094','0009',0004,'Croissant de Almendras','3890');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0095','0009',NULL,'Porcion queque zanahoria','2890');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0096','0009',NULL,'Cinamon Roll','3590');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0097','0009',0001,'Porcion Kuchen Nuez','4290');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0098','0009',0001,'Te Chai','3290');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0099','0009',NULL,'Cafe mocha Blanco','3890');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0100','0010',NULL,'Empanadas Camarón Queso','1553');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0101','0010',0000,'Ají de gallina','7600');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0102','0010',NULL,'Lasaña Camarón Jaiba','6290');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0103','0010',0000,'Quiche camarón Jaiba','5240');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0104','0010',NULL,'Pollo alcachofa','24850');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0105','0011',0001,'Cesar de pollo','6900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0106','0011',NULL,'Fetuccini ','6700');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0107','0011',NULL,'Rissotto frutos del mar','7600');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0108','0011',NULL,'Brownie ','3500');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0109','0011',0000,'Tabla de queso','8100');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0110','0012',NULL,'Kamikaze Roll','6200');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0111','0012',NULL,'Gyozas (6 unidades)','3800');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0112','0012',NULL,'Parmesano Burger','6200');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0113','0012',NULL,'Papas rancheras','4900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0114','0012',0000,'Doble Cheddar Burger','7900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0115','0013',NULL,'Lomo Saltado','9950');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0116','0013',0002,'Pulpo a la parrilla','10500');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0117','0013',NULL,'Pescado a la minier','9500');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0118','0013',NULL,'Tilapia a lo macho','9950');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0119','0013',NULL,'Brochetas Mixtas','8950');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0120','0014',0005,'Vienesa Alemana','1900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0121','0014',0005,'Vienesa Chacarera','1850');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0122','0014',0004,'As Dominó','2750');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0123','0014',0004,'As Luco','2750');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0124','0014',NULL,'Vitamina naranja-zanahoria','1900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0125','0015',NULL,'Lomito Luco','5000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0126','0015',0000,'Churrasco Completo','5700');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0127','0015',NULL,'Ave chacarero','5200');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0128','0015',NULL,'Lomo a lo pobre','9700');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0129','0015',NULL,'Bebida','2000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0130','0016',NULL,'Pizza Mercantino mediana','10500');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0131','0016',NULL,'Pizza Mercantino familiar','15000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0132','0016',NULL,'Pizza Mercantino gigante','25000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0133','0016',NULL,'Empanadas','1800');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0134','0016',NULL,'Tiramisú grande','7000');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0135','0017',NULL,'Festival Teclados','8050');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0136','0017',NULL,'Crudo Teclados','3150');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0137','0017',NULL,'Teclados Sour','1950');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0138','0017',NULL,'Bacardi Blanco','2150');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0139','0017',NULL,'Martini on the rocks','1900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0140','0018',0002,'Cerveza K110','2900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0141','0018',0001,'Kross Maibock 330 cc','1800');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0142','0018',NULL,'Bombas de pollo','5500');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0143','0018',NULL,'Tabla de quesos','9500');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0144','0018',NULL,'Firca de la casa','8900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0145','0019',NULL,'Ceviche mestizo','12900');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0146','0019',NULL,'Sudado de merluza austral','10200');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0147','0019',NULL,'Atún sellado','14200');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0148','0019',NULL,'Pato a la naranja','11400');
INSERT INTO Productos (ID_Producto,ID_Local,ID_Descuento,Nombre,Precio)values('0149','0019',NULL,'Jugo natural','2300');

INSERT INTO Usuarios_Promociones (ID_Usuario_Promocion,ID_Usuario,codigo,numero_de_usos)values('0000','0001','0000','1');
INSERT INTO Usuarios_Promociones (ID_Usuario_Promocion,ID_Usuario,codigo,numero_de_usos)values('0001','0002','0002','3');
INSERT INTO Usuarios_Promociones (ID_Usuario_Promocion,ID_Usuario,codigo,numero_de_usos)values('0002','0005','0004','2');
INSERT INTO Usuarios_Promociones (ID_Usuario_Promocion,ID_Usuario,codigo,numero_de_usos)values('0003','0003','0001','1');
INSERT INTO Usuarios_Promociones (ID_Usuario_Promocion,ID_Usuario,codigo,numero_de_usos)values('0004','0005','0003','1');
INSERT INTO Usuarios_Promociones (ID_Usuario_Promocion,ID_Usuario,codigo,numero_de_usos)values('0005','0004','0004','5');

INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0000','0001','0000');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0001','0002','0001');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0002','0000','0002');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0003','0005','0003');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0004','0004','0004');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0005','0003','0005');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0006','0006','0008');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0007','0007','0007');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0008','0008','0009');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0009','0009','0006');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0010','0010','0010');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0011','0010','0011');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0012','0012','0012');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0013','0012','0013');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0014','0011','0014');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0015','0011','0015');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0016','0013','0016');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0017','0013','0017');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0018','0014','0018');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0019','0014','0019');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0020','0015','0020');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0021','0015','0021');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0022','0016','0022');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0023','0017','0023');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0024','0018','0024');
INSERT INTO Usuarios_Direcciones (ID_Usuario_Direccion,ID_Usuario,ID_Direccion)values('0025','0019','0025');

INSERT INTO Usuarios_Locales_Favoritos (ID_Usuario_Local_Favorito,ID_Usuario,ID_Local)values('0000','0000','0000');
INSERT INTO Usuarios_Locales_Favoritos (ID_Usuario_Local_Favorito,ID_Usuario,ID_Local)values('0001','0000','0004');
INSERT INTO Usuarios_Locales_Favoritos (ID_Usuario_Local_Favorito,ID_Usuario,ID_Local)values('0002','0005','0002');
INSERT INTO Usuarios_Locales_Favoritos (ID_Usuario_Local_Favorito,ID_Usuario,ID_Local)values('0003','0001','0003');
INSERT INTO Usuarios_Locales_Favoritos (ID_Usuario_Local_Favorito,ID_Usuario,ID_Local)values('0004','19','6');
INSERT INTO Usuarios_Locales_Favoritos (ID_Usuario_Local_Favorito,ID_Usuario,ID_Local)values('0005','18','18');
INSERT INTO Usuarios_Locales_Favoritos (ID_Usuario_Local_Favorito,ID_Usuario,ID_Local)values('0006','01','00');
INSERT INTO Usuarios_Locales_Favoritos (ID_Usuario_Local_Favorito,ID_Usuario,ID_Local)values('0007','02','09');


INSERT INTO Usuarios_Locales_Rating (ID_Usuario_Local_Rating,ID_Usuario,ID_Local,rating)values('0','0000','0001','3');
INSERT INTO Usuarios_Locales_Rating (ID_Usuario_Local_Rating,ID_Usuario,ID_Local,rating)values('1','0001','0000','5');
INSERT INTO Usuarios_Locales_Rating (ID_Usuario_Local_Rating,ID_Usuario,ID_Local,rating)values('2','0002','0002','4');
INSERT INTO Usuarios_Locales_Rating (ID_Usuario_Local_Rating,ID_Usuario,ID_Local,rating)values('3','0003','0001','5');
INSERT INTO Usuarios_Locales_Rating (ID_Usuario_Local_Rating,ID_Usuario,ID_Local,rating)values('4','0003','0002','2');
INSERT INTO Usuarios_Locales_Rating (ID_Usuario_Local_Rating,ID_Usuario,ID_Local,rating)values('5','0004','0001','4');
INSERT INTO Usuarios_Locales_Rating (ID_Usuario_Local_Rating,ID_Usuario,ID_Local,rating)values('6','0004','0002','5');
INSERT INTO Usuarios_Locales_Rating (ID_Usuario_Local_Rating,ID_Usuario,ID_Local,rating)values('7','0005','0000','4');
INSERT INTO Usuarios_Locales_Rating (ID_Usuario_Local_Rating,ID_Usuario,ID_Local,rating)values('8','0005','0000','4');


INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0000','0000','0004');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0001','0001','0001');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0002','0002','0007');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0003','0003','0002');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0004','0003','0006');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0005','0004','0008');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0006','0005','0002');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0007','0006','0001');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0008','0006','0004');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0009','0007','0007');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0010','0008','0001');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0011','0008','0003');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0012','0008','0004');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0013','0009','0008');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0014','0010','0009');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0015','0011','0010');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0016','0012','0000');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0017','0012','0003');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0018','0012','0002');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0019','0012','0004');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0020','0013','0011');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0021','0014','0001');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0022','0015','0004');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0023','0015','0009');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0024','0016','0010');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0025','0017','0012');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0026','0018','0012');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0027','0019','0009');
INSERT INTO Locales_Categorias (ID_Local_Categoria,ID_Local,ID_Categoria)values('0028','0006','0005');


INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0000','0000','0010');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0001','0000','0011');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0002','0000','0012');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0003','0001','0000');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0004','0001','0004');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0005','0002','0013');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0006','0002','0007');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0007','0002','0001');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0008','0003','0015');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0009','0003','0014');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0010','0003','0001');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0011','0004','0016');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0012','0004','0017');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0013','0005','0002');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0014','0005','0038');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0015','0006','0045');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0016','0006','0049');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0017','0007','0053');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0018','0007','0062');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0019','0008','0006');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0020','0008','0019');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0021','0008','0020');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0022','0009','0075');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0023','0009','0076');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0024','0010','0091');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0025','0010','0089');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0026','0011','0100');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0027','0011','0103');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0028','0012','0105');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0029','0012','0108');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0030','0013','0110');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0031','0013','0111');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0032','0014','0119');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0033','0014','0115');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0034','0015','0124');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0035','0015','0123');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0036','0016','0128');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0037','0016','0129');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0038','0017','0132');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0039','0017','0134');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0040','0018','0140');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0041','0018','0141');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0042','0018','0142');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0043','0018','0143');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0044','0019','0136');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0045','0019','0137');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0046','0019','0138');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0047','0020','0148');
INSERT INTO Menus_Productos (ID_Menu_Producto,ID_Menu,ID_Producto)values('0048','0020','0149');

INSERT INTO Pedidos (ID_Pedido,ID_Usuario_Promocion,ID_Usuario,ID_Repartidor,ID_Direccion,fecha,precio,Rating_repartidor)values('0000',0000,'0001','0000','0000','22-08-2020','5500',5);
INSERT INTO Pedidos (ID_Pedido,ID_Usuario_Promocion,ID_Usuario,ID_Repartidor,ID_Direccion,fecha,precio,Rating_repartidor)values('0001',NULL,'0000','0001','0002','23-08-2020','4356',3);
INSERT INTO Pedidos (ID_Pedido,ID_Usuario_Promocion,ID_Usuario,ID_Repartidor,ID_Direccion,fecha,precio,Rating_repartidor)values('0002',0002,'0002','0002','0005','25-08-2020','23050',4);
INSERT INTO Pedidos (ID_Pedido,ID_Usuario_Promocion,ID_Usuario,ID_Repartidor,ID_Direccion,fecha,precio,Rating_repartidor)values('0003',0004,'0005','0000','0003','26-08-2020','50980',4);
INSERT INTO Pedidos (ID_Pedido,ID_Usuario_Promocion,ID_Usuario,ID_Repartidor,ID_Direccion,fecha,precio,Rating_repartidor)values('0004',NULL,'0004','0001','0004','29-08-2020','10500',4);
INSERT INTO Pedidos (ID_Pedido,ID_Usuario_Promocion,ID_Usuario,ID_Repartidor,ID_Direccion,fecha,precio,Rating_repartidor)values('0005',0001,'0003','0002','0001','30-08-2020','6000',2);
INSERT INTO Pedidos (ID_Pedido,ID_Usuario_Promocion,ID_Usuario,ID_Repartidor,ID_Direccion,fecha,precio,Rating_repartidor)values('0006',0003,'0005','0000','0003','01-09-2020','4560',5);
INSERT INTO Pedidos (ID_Pedido,ID_Usuario_Promocion,ID_Usuario,ID_Repartidor,ID_Direccion,fecha,precio,Rating_repartidor)values('0007',NULL,'0003','0001','0001','02-09-2020','9800',4);
INSERT INTO Pedidos (ID_Pedido,ID_Usuario_Promocion,ID_Usuario,ID_Repartidor,ID_Direccion,fecha,precio,Rating_repartidor)values('0008',0004,'0004','0002','0004','15-09-2020','34500',4);
INSERT INTO Pedidos (ID_Pedido,ID_Usuario_Promocion,ID_Usuario,ID_Repartidor,ID_Direccion,fecha,precio,Rating_repartidor)values('0009',0001,'0010','0003','0010','09-09-2020','10000',5);
INSERT INTO Pedidos (ID_Pedido,ID_Usuario_Promocion,ID_Usuario,ID_Repartidor,ID_Direccion,fecha,precio,Rating_repartidor)values('0010',0002,'0011','0004','0015','10-09-2020','38900',5);
INSERT INTO Pedidos (ID_Pedido,ID_Usuario_Promocion,ID_Usuario,ID_Repartidor,ID_Direccion,fecha,precio,Rating_repartidor)values('0011',NULL,'0016','0001','0022','10-09-2020','45690',4);
INSERT INTO Pedidos (ID_Pedido,ID_Usuario_Promocion,ID_Usuario,ID_Repartidor,ID_Direccion,fecha,precio,Rating_repartidor)values('0012',NULL,'0017','0000','0023','11-09-2020','19980',3);
INSERT INTO Pedidos (ID_Pedido,ID_Usuario_Promocion,ID_Usuario,ID_Repartidor,ID_Direccion,fecha,precio,Rating_repartidor)values('0013',NULL,'0018','0003','0024','11-09-2020','200000',5);
INSERT INTO Pedidos (ID_Pedido,ID_Usuario_Promocion,ID_Usuario,ID_Repartidor,ID_Direccion,fecha,precio,Rating_repartidor)values('0014',NULL,'0019','0004','0025','11-09-2020','50000',5);

INSERT INTO Pedidos_Menus (ID_Pedido_Menu,ID_Pedido,ID_Menu,cantidad)values('0000','0000','0001','1');
INSERT INTO Pedidos_Menus (ID_Pedido_Menu,ID_Pedido,ID_Menu,cantidad)values('0002','0001','0000','2');
INSERT INTO Pedidos_Menus (ID_Pedido_Menu,ID_Pedido,ID_Menu,cantidad)values('0003','0002','0004','1');
INSERT INTO Pedidos_Menus (ID_Pedido_Menu,ID_Pedido,ID_Menu,cantidad)values('0007','0004','0002','2');
INSERT INTO Pedidos_Menus (ID_Pedido_Menu,ID_Pedido,ID_Menu,cantidad)values('0008','0005','0001','1');
INSERT INTO Pedidos_Menus (ID_Pedido_Menu,ID_Pedido,ID_Menu,cantidad)values('0009','0006','0000','2');
INSERT INTO Pedidos_Menus (ID_Pedido_Menu,ID_Pedido,ID_Menu,cantidad)values('0017','0008','0003','1');
INSERT INTO Pedidos_Menus (ID_Pedido_Menu,ID_Pedido,ID_Menu,cantidad)values('0018','0009','0016','1');
INSERT INTO Pedidos_Menus (ID_Pedido_Menu,ID_Pedido,ID_Menu,cantidad)values('0021','0012','0013','2');
INSERT INTO Pedidos_Menus (ID_Pedido_Menu,ID_Pedido,ID_Menu,cantidad)values('0022','0013','0018','1');

INSERT INTO Pedidos_Productos (ID_Pedido_Producto, ID_Pedido, ID_Producto,cantidad)values('0000','0000','0000','2');
INSERT INTO Pedidos_Productos (ID_Pedido_Producto, ID_Pedido, ID_Producto,cantidad)values('0001','0000','0004','2');
INSERT INTO Pedidos_Productos (ID_Pedido_Producto, ID_Pedido, ID_Producto,cantidad)values('0002','0001','0010','3');
INSERT INTO Pedidos_Productos (ID_Pedido_Producto, ID_Pedido, ID_Producto,cantidad)values('0003','0002','0018','1');
INSERT INTO Pedidos_Productos (ID_Pedido_Producto, ID_Pedido, ID_Producto,cantidad)values('0004','0003','0018','1');
INSERT INTO Pedidos_Productos (ID_Pedido_Producto, ID_Pedido, ID_Producto,cantidad)values('0005','0003','0017','1');
INSERT INTO Pedidos_Productos (ID_Pedido_Producto, ID_Pedido, ID_Producto,cantidad)values('0006','0003','0016','1');
INSERT INTO Pedidos_Productos (ID_Pedido_Producto, ID_Pedido, ID_Producto,cantidad)values('0010','0006','0004','9');
INSERT INTO Pedidos_Productos (ID_Pedido_Producto, ID_Pedido, ID_Producto,cantidad)values('0011','0007','0006','3');
INSERT INTO Pedidos_Productos (ID_Pedido_Producto, ID_Pedido, ID_Producto,cantidad)values('0012','0007','0019','3');
INSERT INTO Pedidos_Productos (ID_Pedido_Producto, ID_Pedido, ID_Producto,cantidad)values('0013','0007','0020','3');
INSERT INTO Pedidos_Productos (ID_Pedido_Producto, ID_Pedido, ID_Producto,cantidad)values('0014','0007','0021','1');
INSERT INTO Pedidos_Productos (ID_Pedido_Producto, ID_Pedido, ID_Producto,cantidad)values('0015','0007','0022','1');
INSERT INTO Pedidos_Productos (ID_Pedido_Producto, ID_Pedido, ID_Producto,cantidad)values('0016','0007','0023','1');
INSERT INTO Pedidos_Productos (ID_Pedido_Producto, ID_Pedido, ID_Producto,cantidad)values('0019','0010','0034','8');
INSERT INTO Pedidos_Productos (ID_Pedido_Producto, ID_Pedido, ID_Producto,cantidad)values('0020','0011','0145','3');
INSERT INTO Pedidos_Productos (ID_Pedido_Producto, ID_Pedido, ID_Producto,cantidad)values('0023','0014','0132','2');


