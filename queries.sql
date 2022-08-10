/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name from animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Augmon' OR name =  'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name NOT LIKE '%Gabumon%';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3 OR weight_kg = 10.4 OR weight_kg = 17.3;
BEGIN;
UPDATE animals SET species = 'unespecified';
ROLLBACK;
UPDATE animals SET species = 'Digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'Pokemon' WHERE name NOT LIKE '%mon';
DELETE FROM animals;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT first_delete;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO first_delete;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT COUNT(*) FROM animals;
SELECT neutered, MAX(escape_attempts) AS escapeAttempts FROM animals GROUP BY neutered;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, COUNT(*) FROM animals GROUP BY neutered;
SELECT species, MAX(weight_kg) AS maxWeight, MIN(weight_kg) AS minWeight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS avgscapes FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;