/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    name varchar(100),
    date_of_birth DATE,
    escape_ettempts INT,
    neutered BOOLEAN,
    weigth_kg DECIMAL,
);
ALTER TABLE animals ADD COLUMN species VARCHAR;
