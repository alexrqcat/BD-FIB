CREATE TYPE empl AS
( nom char(30),
  sou integer);

CREATE OR REPLACE FUNCTION empl_departament(numdept integer) RETURNS setof empl AS $$
DECLARE
  e empl;
  missatge varchar(50);
  quants integer;

BEGIN

  quants = 0;
  FOR e IN SELECT nom_empl, sou FROM empleats em WHERE em.num_dpt = numdept and em.ciutat_empl = 'SITGES'
     LOOP
     quants=quants+1;
     RETURN NEXT e;
     END LOOP;

if quants = 0 then
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
