begin
  for rec in (select table_name 
              from   all_tables 
              where  table_name IN ('ETUDIANTS', 'ENSEIGNANTS', 'SALLES', 'EPREUVES', 'INSCRIPTIONS', 'HORAIRES', 'OCCUPATIONS', 'SURVEILLANCES') 
                    AND all_tables.owner='M1_28'
             )
  loop
    execute immediate 'drop table '||rec.table_name||' CASCADE CONSTRAINTS';
  end loop;             
end;


CREATE TABLE Etudiants (
  NumEtu DECIMAL(10) PRIMARY KEY,
  NomEtu VARCHAR(50) NOT NULL,
  PrenomEtu VARCHAR(50) NOT NULL
);

CREATE TABLE Enseignants(
  NumEns DECIMAL(10) PRIMARY KEY,
  NomEns VARCHAR(50) NOT NULL,
  PrenomEns VARCHAR(50)
);

CREATE TABLE Salles(
  NumSal DECIMAL(10) PRIMARY KEY,
  NomSal VARCHAR(50) NOT NULL,
  CapaciteSal DECIMAL(3)
);

CREATE TABLE Epreuves(
  NumEpr DECIMAL(10) PRIMARY KEY,
  NomEpr VARCHAR(50) NOT NULL,
  DureeEpr INTERVAL DAY TO SECOND(0)
);

CREATE TABLE Inscriptions(
  NumEtu DECIMAL(10) REFERENCES Etudiants,
  NumEpr DECIMAL(10) REFERENCES Epreuves,
  CONSTRAINT pk_inscriptions PRIMARY KEY (NumEtu, NumEpr)
);

CREATE TABLE Horaires(
  NumEpr DECIMAL(10) REFERENCES Epreuves,
  DateHeureDebut TIMESTAMP(0) NOT NULL,
  CONSTRAINT pk_horaires PRIMARY KEY (NumEpr)
);

CREATE TABLE Occupations(
  NumSal DECIMAL(10) REFERENCES Salles,
  NumEpr DECIMAL(10) REFERENCES Epreuves,
  NbPlacesOcc DECIMAL(3) NOT NULL,
  CONSTRAINT pk_occupations PRIMARY KEY (NumSal, NumEpr)
);

CREATE TABLE Surveillances(
  NumEns DECIMAL(10) REFERENCES Enseignants,
  DateHeureDebut TIMESTAMP(0)  NOT NULL,
  NumSal DECIMAL(10)  REFERENCES Salles,
  CONSTRAINT pk_surveillances PRIMARY KEY (NumEns, DateHeureDebut)
);

INSERT INTO Etudiants VALUES (1, 'Smith', 'John');
INSERT INTO Etudiants VALUES (2, 'Cena', 'John');
INSERT INTO Etudiants VALUES (3, 'Hellscream', 'Adam');
INSERT INTO Etudiants VALUES (4, 'Strife', 'Cloud');
INSERT INTO Etudiants VALUES (5, 'Lockheart', 'Tifa');
INSERT INTO Etudiants VALUES (6, 'Valentino', 'Vincent');

INSERT INTO Salles VALUES (1, 'SALLE 01', 100);
INSERT INTO Salles VALUES (2, 'SALLE 02', 150);
INSERT INTO Salles VALUES (3, 'SALLE 03', 50);
INSERT INTO Salles VALUES (4, 'SALLE 04', 200);
INSERT INTO Salles VALUES (5, 'SALLE 05', 100);
INSERT INTO Salles VALUES (6, 'SALLE 06', 100);

INSERT INTO Enseignants VALUES (1, 'Zanetti', 'Javier');
INSERT INTO Enseignants VALUES (2, 'Moratti', 'Massimo');
INSERT INTO Enseignants VALUES (3, 'Toti', 'Francesco');
INSERT INTO Enseignants VALUES (4, 'Toldo', 'Francesco');
INSERT INTO Enseignants VALUES (5, 'Hernan', 'Crespo');
INSERT INTO Enseignants VALUES (6, 'Milito', 'Diego');

INSERT INTO Epreuves VALUES (1, 'Epr 01', INTERVAL '2:30' HOUR TO MINUTE);
INSERT INTO Epreuves VALUES (2, 'Epr 02', INTERVAL '2:30' HOUR TO MINUTE);
INSERT INTO Epreuves VALUES (3, 'Epr 03', INTERVAL '2:30' HOUR TO MINUTE);
INSERT INTO Epreuves VALUES (4, 'Epr 04', INTERVAL '2:30' HOUR TO MINUTE);
INSERT INTO Epreuves VALUES (5, 'Epr 05', INTERVAL '2:30' HOUR TO MINUTE);



/*C1 Deux epreuves aui ont des etudiants en commun ne peuvent pas avoir lieu en meme temps*/

CREATE TRIGGER c1_horaires
  BEFORE INSERT OR UPDATE OF NumEpr ON Horaires
  FOR EACH ROW
  DECLARE
    N BINARY_INTEGER;
  BEGIN
    SELECT 1 INTO N 
      FROM Horaires hor
      WHERE hor.DateHeureDebut=:NEW.DateHeureDebut
        AND hor.NumEpr IN 
          (SELECT DISTINCT NumEpr FROM Inscriptions ins
            WHERE NumEtu IN 
              (SELECT NumEtu FROM Inscriptions WHERE NumEpr=:NEW.NumEpr));
      EXCEPTION
        WHEN TOO_MANY_ROWS
        THEN
          raise_application_error(-20000, 'Already exist other Epreuve with common students and the same time');
  END;
/




