
--EXERCICI 2--
select p.nomprof
from professors p, assignacions a, despatxos d
where p.telefon is not null and p.sou > 2500 or
p.telefon is null and p.dni = a.dni and a.modul = d.modul and a.numero = d.numero and d.superficie >= 20;

--EXERCICI 3---NOTA: 10--
select distinct d.num_dpt, d.nom_dpt
from departaments d, empleats e
where e.num_dpt = d.num_dpt
group by d.num_dpt, e.ciutat_empl
having count(e.ciutat_empl) >= 2;

--EXERCICI 4---NOTA: 10--
SELECT DISTINCT d.num_dpt, d.nom_dpt
FROM departaments d NATURAL INNER JOIN empleats e
WHERE NOT EXISTS (SELECT *
          FROM empleats e1
          WHERE e1.ciutat_empl <> 'MADRID' AND e1.num_dpt = d.num_dpt);

--EXERCICI 5---NOTA: 10--
select distinct d.num_dpt, d.nom_dpt
from departaments d, empleats e
where d.num_dpt = e.num_dpt and exists (select *
		from empleats e1
		where e.ciutat_empl <> e1.ciutat_empl)
		group by d.num_dpt
		having count(e.ciutat_empl)>= 2;

--EXERCICI 6--
select e.ciutat_empl
from empleats e
where not exists (select*
			from departaments d
			where e.ciutat_empl = d.ciutat_dpt);

--EXERCICI 7---NOTA: 10--
select distinct d.num_dpt, d.nom_dpt
from departaments d
where not exists(select*
	from empleats e
	where e.num_dpt = d.num_dpt and e.ciutat_empl = 'MADRID');

--EXERCICI 8---NOTA: 10--
select p.num_proj, p.nom_proj
from projectes p, empleats e
where p.num_proj = e.num_proj
group by p.num_proj
having count(e.num_empl) >=2
order by p.num_proj desc;

--EXERCICI 9---NOTA: 10--
select distinct e.nom_empl
from empleats e
where (select max(sou)
		from empleats) = e.sou
order by e.nom_empl desc;

--EXERCICI 10---NOTA: 10--
select d.num_dpt, d.nom_dpt, avg(e.sou) as SOU
from departaments d, empleats e
where d.num_dpt = e.num_dpt and d.ciutat_dpt = 'MADRID'
group by d.num_dpt;

---EXERCICI 11---NOTA: 10--
select distinct d.num_dpt, d.nom_dpt
from departaments d, empleats e
where e.num_dpt = d.num_dpt and d.ciutat_dpt = 'MADRID' and e.sou > 200000;
