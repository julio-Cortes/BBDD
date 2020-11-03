--Consulta 1
select l.nombre,avg(usl.rating) from usuarios_locales_rating usl,locales l
    where l.id_local=usl.id_local group by l.nombre ORDER BY avg(usl.rating)  DESC Limit 1;

--Consulta 2
select l.nombre,count(usf.id_usuario) from usuarios_locales_favoritos usf,locales l
    where l.id_local=usf.id_local group by l.nombre ORDER BY count(usf.id_usuario)  DESC Limit 1;

--Consulta 3
select r.nombre,avg(p.rating_repartidor) from repartidores r,pedidos p
    where r.id_repartidor=p.id_repartidor group by r.nombre order by avg(p.rating_repartidor) DESC Limit 1;

--Consulta 4
select u.ID_Usuario,u.email,count(usr.rating) from usuarios u, usuarios_locales_rating usr
    where u.id_usuario = usr.id_usuario group by u.email,u.id_usuario order by count (usr.rating) DESC limit 1;

--Consulta 5
select r.nombre from repartidores r, pedidos p
    where r.id_repartidor = p.id_repartidor group by  r.nombre ORDER BY count(p.id_repartidor) DESC Limit 1;

--Consulta 6
select c.nombre, avg(usl.rating) from categorias c, locales_categorias l_c, usuarios_locales_rating usl, locales l
    where l.id_local=usl.id_local and l_c.id_local=l.id_local and c.id_categoria = l_c.id_categoria group by c.nombre ORDER BY  avg(usl.rating)  DESC Limit 1;

--Consulta 7
select c.nombre Categoria, count(*) Pedidos_totales
from (select t3.n1 categoria1, t3.n2 categoria2, t3.ip1, t3.ip2, count (t3.n1) , count(t3.n2) cantidad
    from
        (select t1.id_pedido ip1, t1.id_local il1, t1.id_categoria ic1, t1.nombre n1, t2.id_pedido ip2, t2.id_local il2, t2.id_categoria ic2, t2.nombre n2
            from (select p.id_pedido id_pedido, pr.id_local id_local, lc.id_categoria id_categoria, c.nombre nombre
                from pedidos p, pedidos_productos pp, productos pr, locales l, locales_categorias lc, categorias c
                where p.id_pedido=pp.id_pedido and pp.id_producto=pr.id_producto and l.id_local=pr.id_local
                        and lc.id_local=l.id_local and lc.id_categoria=c.id_categoria
                group by p.id_pedido, pr.id_local, lc.id_categoria, c.nombre) t1
            full outer join (select p.id_pedido id_pedido, m.id_local id_local, lc.id_categoria id_categoria, c.nombre nombre
                from pedidos p, pedidos_menus pm,  menus m,locales l, locales_categorias lc, categorias c
                where p.id_pedido=pm.id_pedido and pm.id_menu=m.id_menu and l.id_local=m.id_local
                        and lc.id_local=l.id_local and lc.id_categoria=c.id_categoria
                group by  p.id_pedido, m.id_local, lc.id_categoria, c.nombre) t2
            on (t1.id_pedido = t2.id_pedido and t1.id_local=t2.id_local)) t3
    where t3.ip1=t3.ip2 or t3.ip2 is null or t3.ip1 is null
    group by t3.n1, t3.n2, t3.ip1, t3.ip2)t4, categorias c
where t4.categoria1 =c.nombre or t4.categoria2=c.nombre
group by c.nombre order by Pedidos_totales desc limit 1;

--Consulta 8
select u.nombre from usuarios u, promociones p, usuarios_promociones u_p, pedidos pe
    where u.id_usuario=u_p.id_usuario and p.codigo=u_p.codigo and pe.id_usuario_promocion = u_p.id_usuario_promocion
        group by u.nombre ORDER BY count(u_p.id_usuario_promocion)  DESC Limit 1;

--Consulta 9
select c.nombre,avg(p.precio) from categorias c,productos p,locales_categorias lc,locales l
    where c.id_categoria=lc.id_categoria and lc.id_local=l.id_local and p.id_local=l.id_local group by c.nombre;

--Consulta 10
select t1.nombre,avg(m.precio) from menus m,
  (select l.ID_Local,l.nombre,avg(usl.rating) avg from usuarios_locales_rating usl,locales l
    where l.id_local=usl.id_local group by l.nombre,l.ID_Local ORDER BY avg(usl.rating)) t1
        where t1.avg>4.5 and t1.ID_Local=m.id_local group by t1.nombre;

--Consulta 11
select pe.id_pedido from pedidos pe
    where (pe.fecha BETWEEN '2020-08-26' AND '2020-09-10');

--Consulta 12
--Cambiar ID_repartidor segun conveniencia
select pe.id_pedido from pedidos pe, repartidores r
    where r.id_repartidor = '0' and r.id_repartidor = pe.id_repartidor ORDER BY pe.fecha DESC Limit 5;

--Consulta 13
--Cambiar ID_Usuario segun conveniencia
select l.nombre locales, u.nombre usuarios
    from
    (select t1.id_u_p usuario1, t1.id_local_p local1, t2.id_local_m local2, t2.id_u_m usuario2
        from (select l.ID_Local id_local_p, u.ID_Usuario id_u_p
            from pedidos p, pedidos_productos pp, productos pr, locales l, usuarios u
                where p.id_pedido=pp.id_pedido and pp.id_producto=pr.id_producto and l.id_local=pr.id_local
                    and p.id_usuario=u.id_usuario and pr.id_descuento is not null
    group by  l.ID_Local, u.ID_Usuario) t1
full outer join
    (select l.ID_Local id_local_m, u.ID_Usuario id_u_m
        from pedidos p, pedidos_menus pm, menus m, locales l, usuarios u
            where p.id_pedido=pm.id_pedido and pm.id_menu=m.id_menu and l.id_local=m.id_local
                and p.id_usuario=u.id_usuario  and m.id_descuento is not null
    group by  l.ID_Local, u.ID_Usuario)t2
    on (t1.id_local_p =t2.id_local_m and t1.id_u_p = t2.id_u_m)) t3, locales l, usuarios u
        where  (t3.local1=l.ID_Local and t3.usuario1='1' and u.id_usuario='1') or (t3.local2=l.ID_Local and t3.usuario2='1' and u.id_usuario='1')
group by l.nombre, u.nombre;

--Consulta 14
--Cambiar ID_Usuario segun conveniencia
Select distinct d.ID_Direccion,d.calle, d.numero, d.departamento_block, d.comuna, d.region promedio,avg(pe.precio) from pedidos pe, direcciones d, usuarios_direcciones ud
    where d.id_direccion = pe.id_direccion and '19'=pe.id_usuario and ud.id_direccion=d.id_direccion  group by d.nombre_identificador,d.id_direccion;

--Consulta 15
--Cambiar ID_Usuario segun conveniencia
select u.ID_Usuario id_usuario, u.nombre , ((count (t8.uso)*100)/t9.total) porcentaje
from
    (select l.ID_Local locales, u.ID_Usuario usuarios , t4.uso_promocion uso, t5.no_uso_promocion no_uso
        from
        (select l.ID_Local locales, u.ID_Usuario usuarios, '1' uso_promocion
            from
            (select t1.id_u_p usuariosp, t1.id_local_p localesp, t2.id_local_m localesm, t2.id_u_m usuariosm
            from (select l.ID_Local id_local_p, u.ID_Usuario id_u_p
                        from pedidos p, pedidos_productos pp, productos pr, locales l, usuarios u, usuarios_locales_favoritos lf
                        where p.id_pedido=pp.id_pedido and pp.id_producto=pr.id_producto and l.id_local=pr.id_local
                                            and p.id_usuario=u.id_usuario and p.id_usuario_promocion is not null and lf.id_usuario=u.id_usuario and lf.id_local=l.id_local
                        group by  l.ID_Local, u.ID_Usuario) t1
                    full outer join(select l.ID_Local id_local_m, u.ID_Usuario id_u_m
                                    from pedidos p, pedidos_menus pm, menus m, locales l, usuarios u, usuarios_locales_favoritos lf
                                    where p.id_pedido=pm.id_pedido and pm.id_menu=m.id_menu and l.id_local=m.id_local
                                            and p.id_usuario=u.id_usuario  and p.id_usuario_promocion is not null and lf.id_usuario=u.id_usuario and lf.id_local=l.id_local
                                    group by  l.ID_Local, u.ID_Usuario) t2
                    on (t1.id_local_p =t2.id_local_m and t1.id_u_p = t2.id_u_m))t3, locales l, usuarios u
            where (l.id_local=t3.localesm and u.id_usuario=t3.usuariosm) or (l.id_local=t3.localesp and u.id_usuario=t3.usuariosp))t4
            full outer join (select l.ID_Local locales, u.ID_Usuario usuarios, '0' no_uso_promocion
                        from
                        (select t1.id_u_p usuariosp, t1.id_local_p localesp, t2.id_local_m localesm, t2.id_u_m usuariosm
                            from (select l.ID_Local id_local_p, u.ID_Usuario id_u_p
                                        from pedidos p, pedidos_productos pp, productos pr, locales l, usuarios u, usuarios_locales_favoritos lf
                                        where p.id_pedido=pp.id_pedido and pp.id_producto=pr.id_producto and p.id_usuario_promocion is null and l.id_local=pr.id_local
                                                            and p.id_usuario=u.id_usuario and lf.id_usuario=u.id_usuario and lf.id_local=l.id_local
                                        group by  l.ID_Local, u.ID_Usuario) t1
                                    full outer join(select l.ID_Local id_local_m, u.ID_Usuario id_u_m
                                                    from pedidos p, pedidos_menus pm, menus m, locales l, usuarios u, usuarios_locales_favoritos lf
                                                    where p.id_pedido=pm.id_pedido and pm.id_menu=m.id_menu and p.id_usuario_promocion is null and l.id_local=m.id_local
                                                            and p.id_usuario=u.id_usuario  and lf.id_usuario=u.id_usuario and lf.id_local=l.id_local
                                                    group by  l.ID_Local, u.ID_Usuario) t2
                                    on (t1.id_local_p =t2.id_local_m and t1.id_u_p = t2.id_u_m))t3, locales l, usuarios u
                        where (l.id_local=t3.localesm and u.id_usuario=t3.usuariosm) or (l.id_local=t3.localesp and u.id_usuario=t3.usuariosp))t5
            on (t4.locales=t5.locales and t4.usuarios=t5.usuarios), locales l, usuarios u
        where (t4.locales= l.id_local and t4.usuarios=u.ID_Usuario) or (t5.locales=l.id_local and t5.usuarios=u.ID_Usuario)) t8, usuarios u, locales l,
        (select u.ID_Usuario, count(ulf.ID_Usuario) total
        from usuarios u, usuarios_locales_favoritos ulf
        where u.id_usuario=ulf.id_usuario
        group by u.ID_Usuario) t9
    where t8.usuarios=u.id_usuario and t9.ID_Usuario=u.id_usuario and t8.locales =l.id_local and u.id_usuario='1'
group by u.ID_Usuario, t9.total;

--Consulta 16
select * from
(select c.nombre, t_productos.cantidad from
(select distinct t1.ID_Local id, t1.nombre nombre, t1.cantidad cantidad from
(select pr.ID_Local, pr.nombre,count (pp.ID_Producto) cantidad from productos pr, pedidos p, pedidos_productos pp
    where pr.id_producto = pp.id_producto and p.ID_Pedido = pp.id_pedido_producto and pr.id_descuento is not null group by pr.nombre,pr.ID_Local) t1
where t1.cantidad>3) t_productos, categorias c,locales_categorias lc
where lc.id_local=t_productos.id and lc.id_categoria = c.id_categoria) t3

UNION

(select c.nombre, t_menu.cantidad from
(select distinct t2.ID_Local id,t2.nombre nombre, t2.cantidad cantidad from
(select m.ID_Local,m.nombre,count (pm.ID_Menu) cantidad from menus m, pedidos p, pedidos_menus pm
    where m.id_menu = pm.id_menu and p.ID_Pedido = pm.id_pedido_menu and m.id_descuento is not NULL  group by m.nombre,m.ID_Local) t2
where t2.cantidad>3) t_menu,categorias c, locales_categorias lc
where lc.id_local=t_menu.id and lc.id_categoria = c.id_categoria) ORDER BY cantidad DESC limit 1;

--Consulta 17
select t1.categoria, t1.nombre, t1.promedio
from
    (select c.nombre categoria, l.nombre nombre, l.ID_Local id_local, avg(ulr.rating) promedio
    from usuarios_locales_rating ulr, locales l, locales_categorias lc, categorias c, usuarios u, (select u.ID_Usuario id_usuario, count(ulr.ID_Usuario) cuenta
    from usuarios u, usuarios_locales_rating ulr
    where u.id_usuario=ulr.ID_Usuario
    group by u.ID_Usuario) t2
    where ulr.id_local=l.id_local and l.id_local = lc.id_local and c.id_categoria=lc.id_categoria and t2.cuenta >= 5 and t2.id_usuario = ulr.id_usuario
    group by l.id_local, c.nombre, l.nombre)t1
group by t1.categoria, t1.nombre,t1.promedio
having t1.promedio =
(select t1.promedio
from
    (select c.nombre categoria, l.nombre nombre, l.ID_Local id_local, avg(ulr.rating) promedio
    from usuarios_locales_rating ulr, locales l, locales_categorias lc, categorias c, usuarios u, (select u.ID_Usuario id_usuario, count(ulr.ID_Usuario) cuenta
    from usuarios u, usuarios_locales_rating ulr
    where u.id_usuario=ulr.ID_Usuario
    group by u.ID_Usuario) t2
    where ulr.id_local=l.id_local and l.id_local = lc.id_local and c.id_categoria=lc.id_categoria and t2.cuenta >= 5 and t2.id_usuario = ulr.id_usuario
    group by l.id_local, c.nombre, l.nombre)t1
group by t1.promedio order by t1.promedio desc limit 1);

--Consulta 18
select * from
(select d.id_direccion id, d.calle calle, d.comuna comuna,d.numero numero, sum(pe.precio) cantidad from direcciones d, pedidos pe
where pe.id_direccion = d.id_direccion group by d.id_direccion, d.calle, d.comuna, d.numero) t1
where t1.cantidad  in (select(max(t2.cantidad)) from (select d.id_direccion id, d.calle calle, d.comuna comuna,d.numero numero, sum(pe.precio) cantidad from direcciones d, pedidos pe
where pe.id_direccion = d.id_direccion group by d.id_direccion, d.calle, d.comuna, d.numero) t2);
