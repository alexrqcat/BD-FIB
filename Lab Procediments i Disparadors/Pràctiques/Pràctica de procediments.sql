CREATE TYPE treballador AS
( dni char(8),
	nom char(30),
	sou real,
	plus real,
	matricula char(10));

CREATE OR REPLACE FUNCTION llistat_treb(dni1 char(8), dni2 char(8)) RETURNS setof treballador AS $$
DECLARE
 	t treballador;
  	missatge varchar(50);
  	num_lloguers integer;
	dni_aux char(8);

BEGIN
  num_lloguers = 0;
  FOR t IN SELECT dni, nom, sou_base, plus FROM treballadors x WHERE x.dni = dni and x.dni >= dni1 and x.dni <= dni2 order by dni asc
    loop
   	dni_aux = t.dni;
	if (5<= (select COUNT(dni)
				from lloguers_actius
				where dni = dni_aux)) then
		FOR t.matricula IN SELECT matricula FROM lloguers_actius ll WHERE  ll.dni = dni_aux order by t.dni, matricula ASC
    	loop
    	return next t;
     	END LOOP;
	else return next t;
	end if;
     END LOOP;
	if t.dni is NULL then
	SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=1;
	RAISE EXCEPTION '%',missatge;
	end if ;
  RETURN;


	exception
		when raise_exception then
			RAISE EXCEPTION '%', missatge;
		when others then
			SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=2;
			RAISE EXCEPTION '%',missatge;

END;
$$LANGUAGE plpgsql;
