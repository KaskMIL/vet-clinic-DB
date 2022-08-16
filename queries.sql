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
SELECT name, escape_attempts, neutered FROM animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals) ORDER BY escape_attempts, neutered;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, COUNT(*) FROM animals GROUP BY neutered;
SELECT species, MAX(weight_kg) AS maxWeight, MIN(weight_kg) AS minWeight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS avgscapes FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name LIKE '%Melody Pond%';
SELECT animals.name, species.name FROM animals JOIN species on animals.species_id = species.id WHERE species.name LIKE '%Pokemon%';
SELECT owners.full_name, animals.name FROM owners FULL OUTER JOIN animals ON owners.id = animals.owner_id;
SELECT species.name, COUNT(*) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.id;
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name LIKE '%Jennifer Orwell%' AND animals.species_id = 2;
SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.fu
ll_name LIKE '%Dean Winchester%' AND animals.escape_attempts = 0;
SELECT owners.full_name AS "Owner Name", COUNT(animals.name) AS "Num of Animals" FROM owners JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY COUNT(animals.name) DESC LIMIT 1;

/*Who was the last animal seen by William Tatcher?*/
SELECT vets.name AS "Vet Name", animals.name AS "Animal Name", visits.date FROM vets JOIN visits ON vets.id = visits.vet_id JOIN animals ON animals.id = visits.animal_id WHERE vets.name LIKE '%William Tatcher%' GROUP BY vets.name, animals.name, visits.date ORDER BY visits.date DESC LIMIT 1;

/*How many different animals did Stephanie Mendez see?*/
SELECT COUNT(animals.name) AS "Stephanie Mendez's Animals" FROM animals JOIN visits on animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id WHERE vets.name LIKE '%Stephanie Mendez%';

/*List all vets and their specialties, including vets with no specialties.
*/
SELECT vets.name AS "Vet Name", species.name AS "specialization" FROM vets FULL OUTER JOIN specializations ON vets.id = specializations.vets_id FULL OUTER JOIN species ON species.id = specializations.species_id GROUP BY vets.name, species.name;

/*List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.*/
SELECT animals.name AS "Animal Name", visits.date AS "Date" FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id WHERE vets.name LIKE '%Stephanie Mendez%' AND visits.date BETWEEN '2020-04-01' AND '2020-08-30' GROUP BY animals.name, visits.date;

/*What animal has the most visits to vets?*/
SELECT animals.name AS "Animal Name", COUNT(visits.animal_id) AS "Number of Visits" FROM animals JOIN visits ON animals.id = visits.animal_id GROUP BY animals.name ORDER BY COUNT(visits.animal_id) DESC LIMIT 1;

/*Who was Maisy Smith's first visit?*/
SELECT animals.name AS "Animal name", visits.date AS "Date" FROM animals JOIN visits on animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id WHERE vets.name LIKE '%Maisy Smith%' GROUP BY animals.name, visits.date ORDER BY visits.date ASC LIMIT 1;

/*Details for most recent visit: animal information, vet information, and date of visit.*/
SELECT animals.name AS "Animal Name", animals.date_of_birth AS "Date of Birth", animals.escape_attempts AS "Escape Attemts", animals.neutered AS "Neutered", animals.weight_kg AS "Weight", owners.full_name AS "Owner", species.name AS "Specie", vets.name AS "Vet Name", vets.age AS "Age", vets.date_of_graduation, visits.date AS "Date" FROM animals JOIN owners ON animals.owner_id = owners.id JOIN species ON animals.species_id = species.id JOIN visits ON animals.id = visits.animal_id JOIN vets on visits.vet_id = vets.id GROUP BY animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, owners.full_name, species.name, vets.name, vets.age, vets.date_of_graduation, visits.date ORDER BY visits.date desc LIMIT 1;

/*How many visits were with a vet that did not specialize in that animal's species?*/
SELECT vets.name AS "Vet Name", COUNT(visits.animal_id) FROM vets LEFT JOIN specializations ON vets.id = specializations.vets_id LEFT JOIN species ON species.id = specializations.species_id LEFT JOIN visits ON vets.id = visits.vet_id WHERE species.name IS NULL GROUP BY vets.name;

/*What specialty should Maisy Smith consider getting? Look for the species she gets the most.*/
SELECT species.name AS "Species", COUNT(animals.name) AS "Count" FROM animals JOIN species ON animals.species_id = species.id JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id WHERE vets.name LIKE '%Maisy Smith%' GROUP BY species.name ORDER BY COUNT(animals.name) DESC LIMIT 1;

/*Add indexes*/
CREATE INDEX animal_id_ix ON visits(animal_id ASC);
CREATE INDEX vet_id_ix ON visits(vet_id ASC);
CREATE INDEX owner_email_ix ON owners(email);

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits WHERE vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';