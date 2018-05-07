QÜESTIÓ 1
El procediment inclòs al fitxer adjunt esborra el departament identificat pel número de departament que es passa com a paràmetre. En cas que no es pugui esborrar el departament, el procediment retorna una excepció. Concretament retorna una excepció en cas que el departament no existeix (El departament no existeix), i en cas que en executar el procediment es produeixi qualsevol error de la base de dades (Error intern).

Es vol que feu canvis en aquest procediment per tal de que:
- Quan es produieix l'error número 1 de la taula missatgesExcepcions, salti una nova excepció amb el missatge corresponent.

Pel joc de proves que trobareu al fitxer adjunt i després de les sentències següents:
SELECT * FROM eliminar_dept(1);
SELECT num_dpt FROM departaments; el resultat ha de l'execució de la segona sentència ha de ser:

Num_dpt
2

CREATE OR REPLACE FUNCTION eliminar_dept(numdept integer) RETURNS void AS $$
DECLARE
   missatge varchar(50);

BEGIN

	if exists (select* from empleats e where numdept = e.num_dpt)then

	SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=1;
        RAISE EXCEPTION '%',missatge;
	end if;

	DELETE FROM departaments WHERE num_dpt = numdept;

     IF NOT FOUND THEN
	   SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=2;
           RAISE EXCEPTION '%',missatge;
     END IF;

EXCEPTION
   WHEN raise_exception THEN
           RAISE EXCEPTION '%',SQLERRM;
   WHEN OTHERS THEN
           SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=3;
           RAISE EXCEPTION '%',missatge;

END;
$$LANGUAGE plpgsql;


QÜESTIÓ 2
En aquest exercici es tracta de simular una asserció a base de definir disparadors. En concret, es demana definir els disparadors necessaris sobre empleats1 (veure definició de la base de dades al fitxer adjunt) per comprovar la restricció següent:
Els valors de l'atribut ciutat1 de la taula empleats1 han d'estar inclosos en els valors de ciutat2 de la taula empleats2
La idea és llançar una excepció en cas que s'intenti executar una sentència sobre EMPLEATS1 que pugui violar aquesta restricció.

Cal informar dels errors a través d'excepcions tenint en compte les situacions tipificades a la taula missatgesExcepcions, que podeu trobar definida i amb els inserts corresponents al fitxer adjunt. Concretament en el vostre procediment heu d'incloure, quan calgui, les sentències:
SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=__ (segons l'error 1,2,...);
RAISE EXCEPTION '%',missatge;
La variable missatge ha de ser una variable definida al vostre procediment.

Pel joc de proves que trobareu al fitxer adjunt i la sentència:
INSERT INTO empleats1 VALUES (1,'joan','mad');
La sortida ha de ser:

Els valors de l'atribut ciutat1 d'empleats1 han d''estar inclosos en els valors de ciutat2

CREATE OR REPLACE FUNCTION inserir() RETURNS trigger AS $$
DECLARE
   missatge varchar(100);

BEGIN

	if not exists (select* from empleats2 e where e.ciutat2 = new.ciutat1)then

	SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=1;
        RAISE EXCEPTION '%',missatge;
	end if;

	return new;

EXCEPTION
   WHEN raise_exception THEN
           RAISE EXCEPTION '%',missatge;
END;
$$LANGUAGE plpgsql;


create trigger inser
before insert or update of ciutat1 on empleats1
for each row execute procedure inserir();
