
ALTER TABLE properties RENAME weight TO atomic_mass;
ALTER TABLE properties RENAME melting_point TO melting_point_celsius;
ALTER TABLE properties RENAME boiling_point TO boiling_point_celsius;
ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;
ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;
ALTER TABLE elements ADD CONSTRAINT unique_name UNIQUE(name);
ALTER TABLE elements ADD CONSTRAINT unique_symbol  UNIQUE(symbol);
ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;
ALTER TABLE elements ALTER COLUMN name SET NOT NULL;
ALTER TABLE properties ADD FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number);
CREATE TABLE types (type_id  INT PRIMARY KEY, type VARCHAR(50) NOT NULL);

INSERT INTO types( type_id, type) VALUES(1, 'metal'), (2, 'nonmetal'),(3, 'metalloid');
ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL;
ALTER TABLE properties ADD FOREIGN KEY (type_id) REFERENCES types(type_id);
UPDATE elements SET symbol = INITCAP(symbol);
UPDATE elements SET name = UPPER(LEFT(name, 1)) || LOWER(SUBSTRING(name FROM 2));
INSERT INTO elements VALUES (9,'F', 'Fluorine');
INSERT INTO properties VALUES (9, 'nonmetal', 18.998, -220, -188.1);
INSERT INTO elements VALUES(10, 'Ne', 'Neon');
INSERT INTO properties VALUES(10, 'nonmetal', 20.18, -248.6, -246.1);
ALTER TABLE properties ADD COLUMN type_id INT;
ALTER TABLE properties ADD FOREIGN KEY (type_id) REFERENCES types(type_id);

UPDATE properties SET type_id = 1 WHERE type = 'metal';
UPDATE properties SET type_id = 2 WHERE type = 'nonmetal';
UPDATE properties SET type_id = 3 WHERE type = 'metalloid';

DELETE FROM properties WHERE atomic_number = 1000;
DELETE FROM elements WHERE atomic_number = 1000;
ALTER TABLE properties DROP COLUMN type;






