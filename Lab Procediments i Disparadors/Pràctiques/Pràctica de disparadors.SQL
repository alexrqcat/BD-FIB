QÜESTIÓ 1
Implementar mitjançant disparadors la restricció d'integritat següent:
No es pot esborrar l'empleat 123 ni modificar el seu número d'empleat.

Cal informar dels errors a través d'excepcions tenint en compte les situacions tipificades a la taula missatgesExcepcions, que podeu trobar definida (amb els inserts corresponents) al fitxer adjunt. Concretament en el vostre procediment heu d'incloure, quan calgui, les sentències:
SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=__; (el número que sigui, depenent de l'error)
RAISE EXCEPTION '%',missatge;
La variable missatge ha de ser una variable definida al vostre procediment, i del mateix tipus que l'atribut corresponent de l'esquema de la base de dades.

Pel joc de proves que trobareu al fitxer adjunt i la instrucció:
DELETE FROM empleats WHERE nempl=123;
La sortida ha de ser:

No es pot esborrar l'empleat 123 ni modificar el seu número d'empleat


create or replace function funcio () returns
trigger as $$
declare
missatge varchar(100);
begin
IF(old.nempl = 123) then
	SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=1;
	RAISE EXCEPTION '%',missatge;
end IF;
	if (TG_OP = 'delete')then return old;
	else return new;
	end if;
end;
$$ language plpgsql;


create trigger disp2 before delete or update of nempl on empleats for each row
execute procedure funcio();

QÜESTIÓ 2
Implementar mitjançant disparadors la restricció d'integritat següent:
No es poden esborrar empleats el dijous
Tigueu en compte que:
- Les restriccions d'integritat definides a la BD (primary key, foreign key,...) es violen amb menys freqüència que la restricció comprovada per aquests disparadors.
- El dia de la setmana serà el que indiqui la única fila que hi ha d'haver sempre insertada a la taula "dia". Com podreu veure en el joc de proves que trobareu al fitxer adjunt, el dia de la setmana és el 'dijous'. Per fer altres proves podeu modificar la fila de la taula amb el nom d'un altre dia de la setmana. IMPORTANT: Tant en el programa com en la base de dades poseu el nom del dia de la setmana en MINÚSCULES.

Cal informar dels errors a través d'excepcions tenint en compte les situacions tipificades a la taula missatgesExcepcions, que podeu trobar definida (amb els inserts corresponents) al fitxer adjunt. Concretament en el vostre procediment heu d'incloure, quan calgui, les sentències:
SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=__;(el número que sigui, depenent de l'error)
RAISE EXCEPTION '%',missatge;
La variable missatge ha de ser una variable definida al vostre procediment, i del mateix tipus que l'atribut corresponent de l'esquema de la base de dades.'

Pel joc de proves que trobareu al fitxer adjunt i la instrucció:
DELETE FROM empleats WHERE salari<=1000
la sortida ha de ser:

No es poden esborrar empleats el dijous


create or replace function func () returns trigger as $$
declare
missatge varchar(50);
dia1 char(10);
begin
	SELECT dia INTO dia1 FROM dia;
	if (dia1 = 'dijous') then
		SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=1;
		RAISE EXCEPTION '%',missatge;
	end if;
	return old;
end;
$$ language plpgsql;

create trigger dijous
before delete on empleats
for each statement execute procedure func();

QÜESTIÓ 3
Implementar mitjançant disparadors la restricció d'integritat següent:
La suma dels sous dels empleats esborrats en una instrucció delete, no pot ser superior a la suma dels sous dels empleats que queden a la BD després de l'esborrat.
Tigueu en compte que:
- Per resoldre aquest exercici podeu utilitzar la taula temporal que trobareu al fitxer adjunt.

Cal informar dels errors a través d'excepcions tenint en compte les situacions tipificades a la taula missatgesExcepcions, que podeu trobar definida (amb els inserts corresponents) al fitxer adjunt. Concretament en el vostre procediment heu d'incloure, quan calgui, les sentències:
SELECT texte INTO missatge FROM missatgesExcepcions WHERE num=__;(el número que sigui, depenent de l'error)
RAISE EXCEPTION '%',missatge;
La variable missatge ha de ser una variable definida al vostre procediment, i del mateix tipus que l'atribut corresponent de l'esquema de la base de dades.

Pel joc de proves que trobareu al fitxer adjunt i la instrucció:
DELETE FROM empleats WHERE salari<=2500
la sortida ha de ser:

Suma sous esborrats > Suma sous que queden '


CREATE OR REPLACE FUNCTION calcul_sou_abans() RETURNS trigger AS $$
BEGIN
    DELETE FROM temp;
    INSERT INTO temp(x, y) SELECT SUM(salari), 0 FROM empleats;
    RETURN NULL;
END $$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION check_condition3() RETURNS trigger AS $$
DECLARE
    sou_abans1 INTEGER;
    suma_esb INTEGER;
    missatge VARCHAR(50);
BEGIN
    UPDATE temp
    SET y = y + OLD.salari;
    SELECT x, y INTO sou_abans1, suma_esb FROM temp;
    IF (suma_esb >= (sou_abans1 - suma_esb)) THEN
        SELECT texte INTO missatge FROM missatgesExcepcions WHERE num = 1;
        RAISE EXCEPTION '%', missatge;
    END IF;
    RETURN OLD;
END $$ LANGUAGE plpgsql;

CREATE TRIGGER trigger4 BEFORE DELETE ON empleats
FOR EACH STATEMENT EXECUTE PROCEDURE calcul_sou_abans();

CREATE TRIGGER trigger3 BEFORE DELETE ON empleats
FOR EACH ROW EXECUTE PROCEDURE check_condition3();
