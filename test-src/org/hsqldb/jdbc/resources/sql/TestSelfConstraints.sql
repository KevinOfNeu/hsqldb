--
-- TestSelfConstraints.txt
--
-- Tests for Constraints
-- bug #733940
-- NOT NULL enforcement
-- IDENTITY can be set to NULL to be regenerated but other NOT NULL columns can't
CREATE CACHED TABLE THEME (idTheme integer NOT NULL IDENTITY,
 libelle VARCHAR(10) CONSTRAINT THEMECOSNT NOT NULL,description VARCHAR(10));
insert into theme(libelle, description) values('ESSAI', 'ESSAI');
/*e*/update theme set libelle = null where idtheme = 0;
/*u1*/update theme set idTheme = null where idtheme = 0;
/*u1*/update theme set idTheme = default where idtheme = 1;

-- bug #722442
create table confignodetype (cnt_nodetypeid numeric(10) not null primary key,
 cnt_parentid numeric(10) not null,cnt_name varchar(40) not null,
 constraint fk_cnt_parentid foreign key (cnt_parentid)
 references confignodetype(cnt_nodetypeid));
/*u1*/INSERT INTO confignodetype VALUES (-1,-1,'prj');

-- bug #1114899
create table mytable(field1 int not null, field2 int);
alter table mytable add constraint pk primary key (field1);
/*e*/alter table mytable add constraint pk foreign key (field2)
 references mytable(field1) ;
alter table mytable add constraint fk foreign key (field2)
 references mytable(field1) ;
/*u1*/insert into mytable values (0,0);
/*u1*/insert into mytable values (1,1);
/*u1*/insert into mytable values (2,1);
/*u1*/delete from mytable where field1= 2;
/*u1*/delete from mytable where field1= 1;
/*u1*/delete from mytable where field1= 0;
/*r0*/select count(*) from mytable;

alter table mytable drop constraint fk;
alter table mytable drop constraint pk;
drop table mytable;

--

CREATE TABLE "Table3" ("ID" INTEGER NOT NULL,"dd" INTEGER, PRIMARY KEY ("ID"));
ALTER TABLE "Table3" ALTER COLUMN "ID" INTEGER IDENTITY;
ALTER TABLE "Table3" ALTER COLUMN "ID" INTEGER;
ALTER TABLE "Table3" DROP PRIMARY KEY;
ALTER TABLE "Table3" ADD PRIMARY KEY("dd");
ALTER TABLE "Table3" ALTER COLUMN "dd" INTEGER IDENTITY;

---
create table a ( a_id varchar(32) primary key );

create table b ( b_id varchar(32) primary key,
 a varchar(33) not null);

insert into a values ('TESTA');
insert into b values ('TESTB','TESTA');

alter table b add constraint b_fk_a foreign key (a) references a (a_id);
drop table a cascade
