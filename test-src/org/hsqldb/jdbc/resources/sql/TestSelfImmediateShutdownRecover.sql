--/*c4*/SELECT * FROM TABLE1;
--/*c4*/SELECT * FROM TABLE2;
--/*c1*/SELECT * FROM TABLE2 WHERE COLUMN2=15;
---- bug #1110517
--/*rnewdir*/SELECT NAME FROM FILE2;
--DROP TABLE FILE2;
