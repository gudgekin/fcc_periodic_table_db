\d
\d elements
\d properties
SELECT * FROM properties;
SELECT * FROM elements;
DELETE FROM properties WHERE atomic_number = 1000;
DELETE FROM elements WHERE atomic_number = 1000;
SELECT * FROM elements;
SELECT * FROM properties;
ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;
ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;
ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;
ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;
SELECT * FROM properties;
SELECT * FROM elements;
\d elements
ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;
ALTER TABLE elements ALTER COLUMN name SET NOT NULL;
ALTER TABLE elements ADD CONSTRAINT unique_symbol UNIQUE(symbol);
ALTER TABLE elements ADD CONSTRAINT unique_name UNIQUE(name);
SELECT * FROM elements;
\d elements
\d properties
SELECT atomic_number FROM properties ORDER BY atomic_number;
SELECT atomic_number FROM elements ORDER BY atomic_number;
ALTER TABLE properties ADD CONSTRAINT fk_properties_atomic_number FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number);
CREATE TABLE types ( type_id SERIAL PRIMARY KEY, type VARCHAR NOT NULL );
INSERT INTO types (type) VALUES ('metal'), ('nonmetal'), ('metalloid');
\d types
ALTER TABLE properties ADD COLUMN type_id INT;
\d properties
UPDATE properties SET type_id = (SELECT type_id FROM types WHERE types.type = properties.type);
SELECT atomic_number, type, type_id FROM properties;
ALTER TABLE properties ADD CONSTRAINT fk_properties_type FOREIGN KEY (type_id) REFERENCES type(type_id);
ALTER TABLE properties ADD CONSTRAING fk_properties_type FOREIGN KEY (type_id) REFERENCES types(type_id);
ALTER TABLE properties ADD CONSTRAINT fk_properties_type FOREIGN KEY (type_id) REFERENCES types(type_id);
\d properties
ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;
\d properties
ALTER TABLE properties DROP COLUMN type;
UPDATE elements SET symbol = INITCAP(symbol);
SELECT * FROM elements;
SELECT atomic_number, atomic_mass FROM properties ORDER BY atomic_number;
ALTER TABLE properties ALTER COLUMN atomic_mass TYPE NUMERIC;
\d properties
UPDATE properties SET atomic_mass = atomic_mass::NUMERIC;
\d properties
SELECT * FROM properties;
UPDATE properties SET atomic_mass = (atomic_mass::NUMERIC(9, 6))::FLOAT;
SELECT * FROM properties;
INSERT INTO elements (atomic_number, symbol, name) VALUES (9, 'F', 'Fluorine');
INSERT INTO properties (atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES (9, 18.998, -220, -188.1, 2);
SELECT * FROM elements;
SELECT * FROM properties;
INSERT INTO elements (atomic_number, symbol, name) VALUES (10, 'Ne', 'Neon');
INSERT INTO properties (atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES (10, 20.18, -248.6, -246.1, 2);
SELECT * FROM elements;
SELECT * FROM properties;
\s periodic_psql.sql
