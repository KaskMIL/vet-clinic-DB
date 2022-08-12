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

CREATE TABLE owners (id INT GENERATED BY DEFAULT AS IDENTITY, full_name VARCHAR(100), age INT, PRIMARY KEY(ID));

CREATE TABLE species (id INT GENERATED BY DEFAULT AS IDENTITY, name VARCHAR(100), PRIMARY KEY(id));

ALTER TABLE animals ADD PRIMARY KEY(id);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT CONSTRAINT fk_species REFERENCES SPECIES(ID) ON DELETE SET NULL;

ALTER TABLE animals ADD COLUMN owner_id INT CONSTRAINT fk_owners REFERENCES owners(id) ON DELETE CASCADE;

CREATE TABLE vets (id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY, name VARCHAR(100), age INT, date_of_graduation DATE);

CREATE TABLE specializations (vets_id INT CONSTRAINT fk_vets REFERENCES vets(id) ON DELETE CASCADE, species_id INT CONSTRAINT fk_species REFERENCES species(id) ON DELETE CASCADE, PRIMARY KEY(vets_id, species_id));

CREATE TABLE visits (animal_id INT CONSTRAINT fk_animals REFERENCES animals(id) ON DELETE CASCADE, vet_id INT CONSTRAINT fk_vets REFERENCES vets(id) ON DELETE CASCADE, date DATE NOT NULL, PRIMARY KEY(animal_id, vet_id, date));