-- Codes:
-- 0 : string
-- 1 : place
-- 2 : triple
-- 3 : theory
-- 4 : contents of a place
-- 5 : beginning of a triple
-- 6 : middle of a triple
-- 7 : end of a triple
-- 8 : timeline

CREATE TABLE strings (
   id SERIAL PRIMARY KEY,
   text TEXT NOT NULL UNIQUE
);

CREATE TABLE pairs (
   id SERIAL PRIMARY KEY,
   code1 INT NOT NULL,
   ref1 INT NOT NULL,
   code2 INT NOT NULL,
   ref2 INT NOT NULL,
   UNIQUE (code1, ref1,
           code2, ref2)
);

CREATE TABLE triples (
   id SERIAL PRIMARY KEY,
   code1 INT NOT NULL,
   ref1 INT NOT NULL,
   code2 INT NOT NULL,
   ref2 INT NOT NULL,
   code3 INT NOT NULL,
   ref3 INT NOT NULL,
   UNIQUE (code1, ref1,
           code2, ref2,
           code3, ref3)
);

CREATE TABLE lists (
  id SERIAL PRIMARY KEY,
  head REFERENCES strings(id) UNIQUE
);

-- We'll need a little routine to create the
-- kth list (and perhaps destroy them too, though
-- that's a bit confusing).  The kth list will look
-- like this:

CREATE TABLE listk (
   id SERIAL PRIMARY KEY,
   code INT NOT NULL,
   ref INT NOT NULL
);

-- Timelines:

-- To create a timeline, add a name to 'timeline', and
-- then create table "timelinek" (where k is the number
-- equal to the new maximum value of 'id' in 'theories').

-- Timelines are lists that show the evolution of an
-- "object" over time.  In fact, each timeline can point
-- to any sequence of objects that exist in the system.

CREATE TABLE timelines (
  id SERIAL PRIMARY KEY,
  name INT REFERENCES strings(id) UNIQUE
);

--* CREATE TABLE timelinek (
--*  local_id SERIAL PRIMARY KEY,
--*  code INT,
--*  reference INT
--* );

-- Theories:

-- To create a timeline, add a name to 'theories', and
-- then create tables "stringsk", "placesk", "triplesk",
-- "timelinesk" and "theoriesk" (where k is the number
-- equal to the new maximum value of 'id' in 'theories').

-- Then, to add to the theory k, add to the table
-- appropriate to whatever type you're adding.

-- We use the convention that contents of theory k will be
-- indicated by the ordered pairs (10k+code, reference).

CREATE TABLE theories (
  id SERIAL PRIMARY KEY,
  name INT REFERENCES strings(id) UNIQUE
);

--* CREATE TABLE stringsk (
--*   local_id SERIAL PRIMARY KEY,
--*   id int REFERENCES strings UNIQUE
--* );

--* CREATE TABLE placesk (
--*   local_id SERIAL PRIMARY KEY,
--*   id int REFERENCES places UNIQUE
--* );

--* CREATE TABLE triplesk (
--*   local_id SERIAL PRIMARY KEY,
--*   id int REFERENCES triples UNIQUE
--* );

--* CREATE TABLE timelinesk (
--*   local_id SERIAL PRIMARY KEY,
--*   id int REFERENCES timelines UNIQUE
--* );

--* CREATE TABLE theoriesk (
--*   local_id SERIAL PRIMARY KEY,
--*   id REFERENCES theories UNIQUE
--* );


-- Controllers:

-- These aren't necessarily going to be database objects,
-- but rather, sets of instructions that tell you what to
-- do with other objects.  E.g. you might have a
-- controller associated with a timeline that says, "add
-- each item on the list, in order, to a given theory".