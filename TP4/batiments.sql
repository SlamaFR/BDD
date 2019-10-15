--
-- Table structure for table 'batiment'
--

DROP TABLE IF EXISTS batiment cascade;
DROP TABLE IF EXISTS type cascade;

CREATE TABLE type (
  ref_type int PRIMARY KEY,
  largeur int DEFAULT NULL,
  couleur varchar(15) DEFAULT NULL
);

CREATE TABLE batiment (
  ref_batiment int PRIMARY KEY,
  hauteur int DEFAULT NULL,
  ref_type int DEFAULT NULL,
  CONSTRAINT batiment_ref_type_fkey FOREIGN KEY (ref_type) REFERENCES type (ref_type)
);

--
-- Dumping data for table batiment
--
INSERT INTO type VALUES (1,15,'black'),(2,32,'red'),(3,20,'black'),(4,15,'purple');
INSERT INTO batiment VALUES (1,100,1),(2,200,3),(3,350,3),(4,40,2),(5,160,4),(6,210,3),(7,130,1),(8,80,2),(9,170,1),(10,300,4),(11,280,3),(12,210,1),(13,320,2),(14,30,4),(15,70,2);
