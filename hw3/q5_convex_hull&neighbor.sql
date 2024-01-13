-- Creating geometries table
CREATE TABLE public.geometries (name varchar, geom geometry);

INSERT INTO geometries VALUES
  ('Point', 'POINT(0 0)'),
  ('Linestring', 'LINESTRING(0 0, 1 1, 2 1, 2 2)'),
  ('Polygon', 'POLYGON((0 0, 1 0, 1 1, 0 1, 0 0))'),
  ('PolygonWithHole', 'POLYGON((0 0, 10 0, 10 10, 0 10, 0 0),(1 1, 1 2, 2 2, 2 1, 1 1))'),
  ('Collection', 'GEOMETRYCOLLECTION(POINT(2 0),POLYGON((0 0, 1 0, 1 1, 0 1, 0 0)))');

--  Verify
SELECT name, ST_AsText(geom) FROM geometries;

-- Creating custom table named 'USC'
CREATE TABLE usc (
    code VARCHAR(20),
    geog GEOGRAPHY(Point)
);

-- Inserting data in the 'USC' table
INSERT INTO usc VALUES ('Leavey Library', 'POINT(-118.2830555556 34.0216666667)');
INSERT INTO usc VALUES ('Doheny Library', 'POINT(-118.2841666667 34.0202777778)');
INSERT INTO usc VALUES ('I&PA Library', 'POINT(-118.2836111111 34.0213888889)');
INSERT INTO usc VALUES ('EVK', 'POINT(-118.2822222222 34.0213888889)');
INSERT INTO usc VALUES ('Panda Express', 'POINT(-118.2841689048 34.0216717730)');
INSERT INTO usc VALUES ('Annenberg Cafe', 'POINT(-118.2872222222 34.0208333333)');
INSERT INTO usc VALUES ('Prentiss', 'POINT(-118.2847222222 34.0205555556)');
INSERT INTO usc VALUES ('Pasty Forrest', 'POINT(-118.2850000000 34.0202777778)');
INSERT INTO usc VALUES ('Leavey Pool', 'POINT(-118.2827777778 34.0213888889)');
INSERT INTO usc VALUES ('Cinematic', 'POINT(-118.2863888889 34.0236111111)');
INSERT INTO usc VALUES ('Annenberg', 'POINT(-118.2866666667 34.0222222222)');
INSERT INTO usc VALUES ('Public Policy', 'POINT(-118.2833333333 34.0197222222)');
INSERT INTO usc VALUES ('Home', 'POINT(-118.2802777778 34.0330555556)');

--  Verify
SELECT code, ST_AsText(usc.geog) FROM usc;

------------ QUERY 1: Calculate CONVEX HULL ------------
WITH convex_hull AS
  (SELECT 1 AS Convex_Hull_Col1,
          ST_AsText(ST_ConvexHull(ST_Collect(ST_AsText(u.geog)))) AS Convex_Hull
   FROM usc AS u
   GROUP BY 1)
SELECT Convex_Hull
FROM convex_hull;

-- output:
-- POLYGON((-118.2833333333 34.0197222222,-118.2872222222 34.0208333333,-118.2863888889 34.0236111111,-118.2802777778 34.0330555556,-118.2822222222 34.0213888889,-118.2833333333 34.0197222222))

-- Get the geometry of Home
SELECT ST_AsEWKT(usc.geog)
FROM usc
WHERE code = 'Home';

-- output:
--  SRID=4326;POINT(-118.2802777778 34.0330555556)

------------ QUERY 2: Get NEAREST NEIGHBORS ------------
SELECT usc.code,
  ST_AsText(ST_Transform(usc.geog::geometry, 4327)),
  ST_Distance(usc.geog, 'SRID=4326;POINT(-118.2802777778 34.0330555556)'::geometry) AS dist
FROM
  usc
ORDER BY
  usc.geog <-> 'SRID=4326;POINT(-118.2802777778 34.0330555556)'::geometry
LIMIT 5;

-- output
--       code      |              st_astext               |     dist      
-- ----------------+--------------------------------------+---------------
--  Home           | POINT(-118.2802777778 34.0330555556) |             0
--  Cinematic      | POINT(-118.2863888889 34.0236111111) | 1189.96147437
--  Leavey Library | POINT(-118.2830555556 34.0216666667) |  1289.0738261
--  EVK            | POINT(-118.2822222222 34.0213888889) | 1306.50079662
--  Panda Express  | POINT(-118.2841689048 34.021671773)  | 1312.86343109
