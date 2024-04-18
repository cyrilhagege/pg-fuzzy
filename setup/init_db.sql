CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE TABLE fuzzy (denomination text);

-- Create index used for sound search
CREATE INDEX ix_s_dm ON fuzzy USING gin (daitch_mokotoff(denomination)) WITH (fastupdate = off);

-- Functions used for sound search in any order of words
CREATE OR REPLACE FUNCTION soundex_tsvector(v_name text) RETURNS tsvector
IMMUTABLE BEGIN ATOMIC
  SELECT to_tsvector('simple',
                     string_agg(array_to_string(daitch_mokotoff(n), ' '), ' '))
  FROM regexp_split_to_table(v_name, '\s+') AS n;
END
;

CREATE OR REPLACE FUNCTION soundex_tsquery(v_name text) RETURNS tsquery
BEGIN ATOMIC
  SELECT string_agg('(' || array_to_string(daitch_mokotoff(n), '|') || ')', '&')::tsquery
  FROM regexp_split_to_table(v_name, '\s+') AS n;
END;

CREATE INDEX ix_s_txt ON fuzzy USING gin (soundex_tsvector(denomination)) WITH (fastupdate = off);

-- Data seed
INSERT INTO fuzzy (denomination) VALUES
  ('Pose placo'),
  ('Pose placo'),
  ('Pose placo'),
  ('Pose placo'),
  ('Pose placo'),
  ('Pose placo'),
  ('Pose placo'),
  ('Pose placo'),
  ('Pose placo'),
  ('Pose placo'),
  ('PLACO'),
  ('Plomberie salle de bain'),
  ('Rénovation salle de bain (plomberie)'),
  ('Un ouvrage autre');
