SELECT
	*
FROM fuzzy
WHERE 'plak' % ANY(STRING_TO_ARRAY(denomination,' '))
LIMIT 5;

SELECT * FROM fuzzy WHERE soundex_tsvector(denomination) @@ soundex_tsquery('plomberie bain salle');


WITH fuzzyResult AS (
SELECT
	*
FROM fuzzy
WHERE 'plomerie bain' % ANY(STRING_TO_ARRAY(denomination,' '))
UNION  
SELECT * FROM fuzzy WHERE soundex_tsvector(denomination) @@ soundex_tsquery('plomerie bain')
)
SELECT * FROM fuzzyResult ORDER BY levenshtein(denomination, 'plomerie bain') ASC;

WITH fuzzyResult AS (
SELECT
	*
FROM fuzzy
WHERE 'plonberie bain' % ANY(STRING_TO_ARRAY(denomination,' '))
UNION  
SELECT * FROM fuzzy WHERE soundex_tsvector(denomination) @@ soundex_tsquery('plonberie bain')
)
SELECT * FROM fuzzyResult ORDER BY levenshtein(denomination, 'plonberie bain') ASC;


WITH fuzzyResult AS (
SELECT
	*
FROM fuzzy
WHERE 'plomerie bain' % ANY(STRING_TO_ARRAY(denomination,' '))
)
SELECT * FROM fuzzyResult ORDER BY levenshtein(denomination, 'plomerie bain') ASC;


WITH fuzzyResult AS (
SELECT * FROM fuzzy WHERE soundex_tsvector(denomination) @@ soundex_tsquery('renovation plonberie')
)
SELECT * FROM fuzzyResult ORDER BY levenshtein(denomination, 'renovation plonberie') ASC;


WITH fuzzyResult AS (
SELECT
	*
FROM fuzzy
WHERE 'plako' % ANY(STRING_TO_ARRAY(denomination,' '))
UNION
SELECT * FROM fuzzy WHERE soundex_tsvector(denomination) @@ soundex_tsquery('plako')
)
SELECT * FROM fuzzyResult ORDER BY levenshtein(denomination, 'plako') ASC LIMIT 5;