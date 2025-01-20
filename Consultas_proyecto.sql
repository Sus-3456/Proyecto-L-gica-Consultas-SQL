-- 2. Muestra los nombres de todas las películas con una clasificación por edades de 'R'.
select title from film
where "rating" = 'R';

-- 3. Encuentra los nombres de los actores que tengan un "actor_id" entre 30 y 40
select 
	concat("first_name",' ', "last_name") as Nombre_actor,
	actor_id  
from actor 
where actor_id between 30 and 40;

--4. Obtén las películas cuyo idioma coincide con el idioma original
select * from film


-- 5. Ordena las películas por duración de forma ascendente.
select "title"  from film 
order by "length" asc;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Allen" en su apellido
select 
	concat("first_name", ' ',"last_name") as Nombre_actor 
from actor
where "last_name" like '%ALLEN%';

-- 7. Encuentra la cantidad total de películas en cada claificación de la tabla "film" y muestra la clasificación junto con el recuento

SELECT category.name, COUNT(film.film_id) 
FROM category
JOIN film_category ON category.category_id  = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name;

-- 8. Encuentra el título de todas las películas que son 'PG-13' o tienen una duración mayor a 3 horas en la tabla film.
select  title from  film
where "rating"= 'PG-13' or "length"> '180';


-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.


-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
select 
	min("length"), max("length") 
from film;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select 
	"amount" as "antepenultimo_alquiler_precio"
from payment
order by "payment_date" desc
limit  1 offset 2;
-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.
select 
	"title"
from film
where "rating" <> 'NC-17' and "rating" <>'G';

-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.



-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select 
	"title"
from film 
where "length" > '180';

-- 15. ¿Cuánto dinero ha generado en total la empresa?
select count("amount") as "beneficio"
from payment;

-- 16. Muestra los 10 clientes con mayor valor de id.
select concat("FirstName" , ' ', "LastName" ) as "Cliente"
from "Customer"
order by "CustomerId" desc 
limit 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
select 
	concat("first_name", ' ', "last_name") as "Actors"
from "actor"
join film_actor on film_actor.actor_id = actor.actor_id 
join film on film.film_id = film_actor.film_id 
where film.title = 'EGG IGBY';


-- 18. Selecciona todos los nombres de las películas únicos.

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
select "title" as "Peliculas"
from film 
join film_category on film_category.film_id = film.film_id 
join category on category.category_id = film_category.category_id 
where category.name = 'Comedy' and film.length > 180;


-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.



-- 21. ¿Cuál es la media de duración del alquiler de las películas?
-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
select concat("first_name", ' ', "last_name") as "Actors"
from actor;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select 
	count(rental_id) as "num_rental", date("rental_date")
from rental
group by date("rental_date") 
order by date("rental_date") desc;

-- 24. Encuentra las películas con una duración superior al promedio.
select "title"
from film
where "length" > (select avg("length") from film);
-- 25. Averigua el número de alquileres registrados por mes.
select count("rental_id") as "num_total", extract(month from "rental_date") as mes
from rental
group by extract(month from "rental_date")
order by mes;

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.


-- 27. ¿Qué películas se alquilan por encima del precio medio?
select "title"
from film
where "rental_rate" > (select avg("rental_rate") from film);

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.
select "actor_id"
from film_actor
group by "actor_id"
having count("actor_id") > 40;

-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select "title", count("inventory_id") as "cantidad_disponible"
from film
join inventory on inventory.film_id = film.film_id 
group by "title";

-- 30. Obtener los actores y el número de películas en las que ha actuado.
select 
	concat("first_name", ' ', "last_name") as "actors", 
	count(film_actor."film_id") as "num_peliculas"
from actor
join film_actor on film_actor.actor_id = actor.actor_id 
join film on film.film_id = film_actor.film_id 
group by "actors";

-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select 
    film."title", 
    concat("first_name", ' ', "last_name") as "actors"
from film
left join film_actor on film_actor.film_id = film.film_id
left join actor on actor.actor_id = film_actor.actor_id
order by "title";

-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select 
    concat(actor."first_name", ' ', actor."last_name") as "actor", 
    film."title"
from actor
left join film_actor on film_actor.actor_id = actor.actor_id
left join film on film.film_id = film_actor.film_id
order by concat(actor."first_name", ' ', actor."last_name");

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.
select 
    film."title", 
    rental."rental_id"
from rental
left join inventory on rental."inventory_id" = inventory."inventory_id"
left join film on inventory.film_id = film.film_id;

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select
	concat(customer.first_name, ' ', customer.last_name) as "cliente",
	sum(amount) as "total_gastado"
from payment
join customer on customer.customer_id = payment.customer_id 
group by "cliente";

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select concat("first_name", ' ', "last_name") as "actors"
from actor
where "first_name" = 'JOHNNY';

-- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
alter table actor rename column "first_name" to "Nombre";
alter table actor rename column "last_name" to "Apellido";


-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
select
    min("actor_id") as "id_mas_bajo",
    max("actor_id") as "id_mas_alto"
from "actor";

-- 38. Cuenta cuántos actores hay en la tabla “actor”.
select
	count("actor_id") as "num_total_actors"
from "actor";

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select
	concat("Apellido", ' ', "Nombre") as "actors"
from "actor"
order by "Apellido" asc;

-- 40. Selecciona las primeras 5 películas de la tabla “film”.
select "title"
from film
limit 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
select "Nombre", count("Nombre") as "num_actors"
from actor
group by "Nombre"
order by "num_actors" desc;

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select 
    concat("first_name", ' ', "last_name") as nombre_cliente,
    count(rental."inventory_id") as "alquiler"
from rental
join customer on rental.customer_id = customer.customer_id
group by concat("first_name", ' ', "last_name");

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select 
    concat("first_name", ' ', "last_name") as nombre_cliente,
    count(rental."inventory_id") as "alquiler"
from customer
left join rental on rental.customer_id = customer.customer_id
group by concat("first_name", ' ', "last_name");

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select * 
from film
cross join category;

-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.
select 
    concat(actor."Nombre", ' ', actor."Apellido") as nombre_actor
from actor
join "film_actor" on "actor"."actor_id" = "film_actor"."actor_id"
join "film" on "film_actor"."film_id" = "film"."film_id"
join "film_category" on "film"."film_id" = "film_category"."film_id"
join "category" on "film_category"."category_id" = "category"."category_id"
where "category"."name" = 'Action';

-- 46. Encuentra todos los actores que no han participado en películas.
select 
    concat("actor"."Nombre", ' ', "actor"."Apellido") as "nombre_actor"
from "actor"
left join "film_actor" on "actor"."actor_id" = "film_actor"."actor_id"
where "film_actor"."actor_id" is null;
	
-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select
	concat(actor."Nombre", ' ', actor."Apellido") as nombre_actor
	count(film_actor."film_id") as numero_peliculas
from actor
join film_actor on actor."actor_id" = film_actor."actor_id"
group by actor."actor_id";

-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
create view "actor_num_peliculas" as
select
    concat(actor."Nombre", ' ', actor."Apellido") as "nombre_actor",
    count(film_actor."film_id") as "numero_peliculas"
from "actor"
join "film_actor" on actor."actor_id" = film_actor."actor_id"
group by actor."actor_id";

-- 49. Calcula el número total de alquileres realizados por cada cliente.
select 
    concat(customer."first_name", ' ', customer."last_name") as "cliente",
    count(rental."rental_id") as "total_alquileres"
from "customer"
join "rental" on customer."customer_id" = rental."customer_id"
group by customer."customer_id";

-- 50. Calcula la duración total de las películas en la categoría 'Action'.
select 
    sum(film."length") as "duracion_total_peliculas_action"
from "film"
join "film_category" on film."film_id" = film_category."film_id"
join "category" on film_category."category_id" = category."category_id"
where category."name" = 'Action';

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
create temporary table "cliente_rentas_temporal" as
select 
    customer."customer_id",
    concat(customer."first_name", ' ', customer."last_name") as "nombre_cliente",
    count(rental."rental_id") as "total_alquileres"
from "customer"
join "rental" on customer."customer_id" = rental."customer_id"
group by customer."customer_id";

-- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
create temporary table "peliculas_alquiladas" as
select 
    film."film_id",
    film."title",
    count(rental."rental_id") as "total_alquileres"
from "film"
join "inventory" on film."film_id" = inventory."film_id"
join "rental" on inventory."inventory_id" = rental."inventory_id"
group by film."film_id"
having count(rental."rental_id") >= 10;

-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
select 
    film."title" 
from "rental"
join "customer" on rental."customer_id" = customer."customer_id"
join "inventory" on inventory."inventory_id" = rental."inventory_id" 
join "film" on inventory."film_id" = film."film_id"
where customer."first_name" = 'TAMMY' 
  and customer."last_name" = 'SANDERS'
  and rental."return_date" is null
order by film."title";

-- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
select 
    concat(actor."Nombre", ' ', actor."Apellido") as "actors"
from "actor"
join "film_actor" on actor."actor_id" = film_actor."actor_id"
join "film" on film_actor."film_id" = film."film_id"
join "film_category" on film."film_id" = film_category."film_id"
join "category" on film_category."category_id" = category."category_id"
where category."name" = 'Sci-Fi'
order by actor."Apellido";

-- 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
select 
    concat(actor."Nombre", ' ', actor."Apellido") as "actors"
from "actor"
join "film_actor" on actor."actor_id" = film_actor."actor_id"
join "film" on film_actor."film_id" = film."film_id"
join inventory on film."film_id" = inventory."film_id"
join "rental" on inventory."inventory_id" = rental."inventory_id"
where rental."rental_date" >
    (select min(rental."rental_date")
    from "film"
    join "inventory" on film."film_id" = inventory."film_id"
    join "rental" on inventory.inventory_id = rental.inventory_id 
    where film."title" = 'SPARTACUS CHEAPER')
group by actor."actor_id"
order by actor."Apellido";

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
select
	"Nombre", "Apellido"
from actor
join film_actor on actor.actor_id = film_actor.actor_id
join film_category on film_actor.film_id = film_category.film_id 
join category on film_category.category_id = category.category_id 
where category.name = 'Music';

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select "title"
from film
join inventory on inventory.film_id = film.film_id
join rental on inventory.inventory_id = rental.inventory_id
where extract(day from rental.return_date - rental.rental_date) > 8;

-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
select "title"
from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
where category.name = 'Animation';

-- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
select "title"
from film 
where film.length = (select length
    from film
    where "title" = 'DANCING FEVER')
order by film.title;

-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
select "first_name", "last_name"
from customer
join rental on customer.customer_id = rental.customer_id
join inventory on rental.inventory_id = inventory.inventory_id
group by customer.customer_id
having count(distinct inventory.film_id) >= 7
order by customer.last_name, customer.first_name;

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select 
	category."name" as "nombre_categoria", 
	count(rental.rental_id) as "total_alquileres"
from category
join film_category on category.category_id = film_category.category_id
join inventory on film_category.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by category.category_id;

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.
select 
	category.name as "nombre_categoria", 
	count(film.film_id) as "num_peliculas"
from category
join film_category on category.category_id = film_category.category_id
join film on film_category.film_id = film.film_id
where film.release_year = 2006
group by category.category_id;

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select 
	staff.first_name as "nombre_trabajador", 
	staff.last_name as "apellido_trabajador", 
	store.store_id, store.address_id 
from staff
cross join store;

64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
select 
	customer.customer_id, 
	customer.first_name as "nombre_cliente", 
	customer.last_name as "apellido_cliente", 
	count(rental.rental_id) as "total_alquileres"
from customer
join rental on customer.customer_id = rental.customer_id
group by customer.customer_id;




