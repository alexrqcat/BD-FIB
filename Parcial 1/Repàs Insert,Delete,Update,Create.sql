-----EXERCICI 1 ---NOTA:7
update projectes
set pressupost=pressupost+500000
where exists (select
	from empleats e, projectes p, departaments d
	where e.num_proj=p.num_proj and e.num_dpt=d.num_dpt and d.ciutat_dpt = 'BARCELONA'
	);

------EXERCICI 2 --- NOTA: 10
insert into cost_ciutat
	(select d.ciutat_dpt, sum(e.sou)
		from departaments d, empleats e
		where d.num_dpt=e.num_dpt
		group by ciutat_dpt);

------EXERCICI 3 --- NOTA:10
insert into professors values (1,'alexrqcat',668745,154);
insert into assignacions values(1,'C1',119,20,500);

------EXERCICI 4 --- NOTA:10
insert into professors values(1,'alexrqcat',1714,1714);
insert into despatxos values ('A0','1',50);
insert into despatxos values ('A1','1',50);
insert into assignacions values(1,'A0','1',60,100);
insert into assignacions values(1,'A1','1',60,150);
insert into assignacions values(1,'A0','1',70,100);

-----EXERCICI 5 --- NOTA:10
create table FRANGES_HORARIES
			( INSTANT_INICI integer,
		INSTANT_FI integer check (INSTANT_FI > INSTANT_INICI + 180),
		NUM_EMPL integer ,
		primary key (INSTANT_INICI, INSTANT_FI,NUM_EMPL),
		foreign key (NUM_EMPL) references empleats(NUM_EMPL)
			);

create table TASQUES_REALITZADES
			( NUM_TASCA integer,
		INSTANT_INICI integer not null,
		INSTANT_FI integer not null,
		NUM_EMPL integer not null,
		DESCRIPCIO char(50) not null,
		primary key (NUM_TASCA),
		foreign key (INSTANT_INICI, INSTANT_FI, NUM_EMPL)
			references franges_horaries (INSTANT_INICI, INSTANT_FI, NUM_EMPL));

------EXERCICI 6 ---NOTA:10
create table VENDES
		( NUM_VENDA integer,
		NUM_EMPL integer not null,
		CLIENT char(30),
		primary key (NUM_VENDA),
		UNIQUE(NUM_EMPL, CLIENT),
		foreign key (NUM_EMPL) references empleats (NUM_EMPL));

create table PRODUCTES_VENUTS
		( NUM_VENDA integer,
		PRODUCTE char(20),
		QUANTITAT integer not null default 1,
		IMPORT integer,
		primary key(NUM_VENDA, PRODUCTE),
		foreign key (NUM_VENDA) references VENDES(NUM_VENDA));

------EXERCICI 7 --- NOTA:10

insert into departaments values (1714,'A',1714,'A','A');
insert into projectes values (1714,'A','A',1714);
insert into empleats values (1,'alexrqcat',500,1714,1714);
insert into empleats values (1,'alexrqcat',500,1714,1714);
