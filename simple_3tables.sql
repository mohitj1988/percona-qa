START TRANSACTION;
START TRANSACTION;
CREATE TABLE t1 (ID int PRIMARY KEY) ENGINE=InnoDB;
CREATE TABLE t2 (ID int PRIMARY KEY) ENGINE=InnoDB;
CREATE TABLE t3 (ID int PRIMARY KEY) ENGINE=InnoDB;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
CREATE TABLE t1 (ID int PRIMARY KEY) ENGINE=MEMORY;
CREATE TABLE t1 (ID int PRIMARY KEY) ENGINE=MEMORY;
CREATE TABLE t1 (ID int PRIMARY KEY) ENGINE=MEMORY;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
CREATE TABLE t1 (ID int PRIMARY KEY) ENGINE=TokuDB;
CREATE TABLE t2 (ID int PRIMARY KEY) ENGINE=TokuDB;
CREATE TABLE t3 (ID int PRIMARY KEY) ENGINE=TokuDB;
INSERT INTO t1 VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(0);
INSERT INTO t2 VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(0);
INSERT INTO t3 VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(0);
DELETE FROM t1 LIMIT 3;
DELETE FROM t2 LIMIT 3;
DELETE FROM t3 LIMIT 3;
DELETE FROM t1 WHERE ID=5;
DELETE FROM t2 WHERE ID=5;
DELETE FROM t3 WHERE ID=5;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
COMMIT;
COMMIT;
COMMIT;
COMMIT;
COMMIT;
DROP TABLE IF EXISTS t1;
DROP TABLE IF EXISTS t2;
DROP TABLE IF EXISTS t3;
CREATE TABLE t1 (ID int PRIMARY KEY) ENGINE=TokuDB;
CREATE TABLE t2 (ID int PRIMARY KEY) ENGINE=TokuDB;
CREATE TABLE t3 (ID int PRIMARY KEY) ENGINE=TokuDB;
INSERT INTO t1 VALUES (10);
INSERT INTO t1 VALUES (11);
INSERT INTO t1 VALUES (12);
INSERT INTO t1 VALUES (13);
INSERT INTO t1 VALUES (14);
INSERT INTO t1 VALUES (15);
INSERT INTO t2 VALUES (10);
INSERT INTO t2 VALUES (11);
INSERT INTO t2 VALUES (12);
INSERT INTO t2 VALUES (13);
INSERT INTO t2 VALUES (14);
INSERT INTO t2 VALUES (15);
INSERT INTO t3 VALUES (10);
INSERT INTO t3 VALUES (11);
INSERT INTO t3 VALUES (12);
INSERT INTO t3 VALUES (13);
INSERT INTO t3 VALUES (14);
INSERT INTO t3 VALUES (15);
ALTER TABLE t1 DROP PRIMARY KEY;
ALTER TABLE t2 DROP PRIMARY KEY;
ALTER TABLE t3 DROP PRIMARY KEY;
ALTER TABLE t1 ADD PRIMARY KEY pk(ID);
ALTER TABLE t2 ADD PRIMARY KEY pk(ID);
ALTER TABLE t3 ADD PRIMARY KEY pk(ID);
ALTER TABLE t1 DROP PRIMARY KEY;
ALTER TABLE t2 DROP PRIMARY KEY;
ALTER TABLE t3 DROP PRIMARY KEY;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t2 SELECT * FROM t1;
INSERT INTO t3 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t2;
INSERT INTO t2 SELECT * FROM t2;
INSERT INTO t3 SELECT * FROM t2;
INSERT INTO t1 SELECT * FROM t3;
INSERT INTO t2 SELECT * FROM t3;
INSERT INTO t3 SELECT * FROM t3;
DELETE FROM t1 LIMIT 3;
DELETE FROM t2 LIMIT 3;
DELETE FROM t3 LIMIT 3;
ALTER TABLE t1 ENGINE=InnoDB;
ALTER TABLE t1 ENGINE=TokuDB;
ALTER TABLE t1 ENGINE=MEMORY;
ALTER TABLE t2 ENGINE=InnoDB;
ALTER TABLE t2 ENGINE=TokuDB;
ALTER TABLE t2 ENGINE=MEMORY;
ALTER TABLE t3 ENGINE=InnoDB;
ALTER TABLE t3 ENGINE=TokuDB;
ALTER TABLE t3 ENGINE=MEMORY;
CREATE TABLE t1 (ID int PRIMARY KEY) ENGINE=InnoDB;
CREATE TABLE t2 (ID int PRIMARY KEY) ENGINE=InnoDB;
CREATE TABLE t3 (ID int PRIMARY KEY) ENGINE=InnoDB;
UPDATE t1 SET ID=1;
UPDATE t1 SET ID=2;
UPDATE t1 SET ID=3;
UPDATE t2 SET ID=1;
UPDATE t2 SET ID=2;
UPDATE t2 SET ID=3;
UPDATE t3 SET ID=1;
UPDATE t3 SET ID=2;
UPDATE t3 SET ID=3;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;