create
database if not exists sql_uj_3sem;
use
sql_uj_3sem;

drop table if exists lessons_table;
drop table if exists students_attending_groups;
drop table if exists lessons_groups;
drop table if exists students;
drop table if exists teachers;
drop table if exists subjects;
drop table if exists parents;
drop table if exists classrooms;
drop table if exists classroom_roles;
drop table if exists administration_employees;

-- Tabela przechowuje informacje o rodzicach uczniow
CREATE TABLE parents (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name varchar(32) NOT NULL,
    surname varchar(32) NOT NULL,
    pesel varchar(11) NOT NULL UNIQUE,
        CHECK (pesel LIKE '___________'), -- sprawdzenie czy PESEL ma 11 cyfr
    adress_street varchar (128),
    adress_city varchar (128),
    adress_postal_code varchar(6),
        -- CONSTRAINT good_postal CHECK (adress_postal_code LIKE '[0-9][0-9][-][0-9][0-9][0-9]'),
    phone_number varchar(9) UNIQUE
);

create table students
(
    id       int         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name     varchar(32) NOT NULL,
    surname  varchar(32) NOT NULL,
    pesel    varchar(11) NOT NULL UNIQUE,
    sex      char        NOT NULL CHECK (sex in ('k', 'm')),
    birthday DATE        NOT NULL,
    first_parent_id INT,
    FOREIGN KEY (first_parent_id) REFERENCES parents (id),
    second_parent_id INT,
    FOREIGN KEY (second_parent_id) REFERENCES parents (id),

    CONSTRAINT CHECK (pesel LIKE '___________') -- sprawdzenie czy PESEL ma 11 cyfr
    -- CONSTRAINT CHECK (pesel NOT IN (SELECT parents.pesel FROM parents)) -- sprawdzenie czy dziecko nie ma takiego peselu jak ktorys rodzic
);

create table teachers
(
    id       int         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name     varchar(32) NOT NULL,
    surname  varchar(32) NOT NULL,
    sex      char        NOT NULL CHECK (sex in ('k', 'm')),
    birthday DATE
);

-- representacja ogolnego przedmiotu
create table subjects
(
    id      int         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name varchar(32) NOT NULL,
    description varchar(255)
);

create table lessons_groups
(
  id int NOT NULL  PRIMARY KEY  AUTO_INCREMENT,

    teacher_id int NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teachers (id) ON UPDATE CASCADE,

    subject_id int NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES subjects (id) ON UPDATE CASCADE
);


-- pokazuje ktory student chodzi do jakiej grupy
-- many to many
create table students_attending_groups
(
    id_of_student int NOT NULL,
    id_of_group  int NOT NULL,

    PRIMARY KEY (id_of_student, id_of_group),
    FOREIGN KEY (id_of_student) REFERENCES students (id) ON UPDATE CASCADE,
    FOREIGN KEY (id_of_group) REFERENCES lessons_groups (id) ON UPDATE CASCADE
);

-- zajecia, w ktory dzien
create table lessons_table
(
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_of_group int NOT NULL,
    FOREIGN KEY (id_of_group) REFERENCES lessons_groups (id) ON UPDATE CASCADE,

    week_day     int DEFAULT (0),
    CHECK ( week_day BETWEEN 0 AND 7),

    start_time    TIME                             DEFAULT ('12:00:00'),
    end_time      TIME                             DEFAULT ('13:00:00'),
    CHECK ( start_time < end_time )

);

-- Tabela przechowuje specialne role sal lekcyjnych
CREATE TABLE classroom_roles(
    id INT NOT NULL PRIMARY KEY,
    description varchar(128)
);

-- Tabela przechowuje wszelkie dane na temat sal lekcyjnych
CREATE TABLE classrooms(
    id INT NOT NULL PRIMARY KEY, -- jako ID traktuje numer sali ktory widnieje na drzwiach, wiec nie ma AUTO_INCREMENT
    capacity TINYINT, -- ile uczniow miesci sie w sali
    has_projector TINYINT, -- czy sala ma projektor multimedialny?
    special_role TINYINT REFERENCES classroom_roles(id), -- czy sala jest jakas specialna? np. sala gimnastyczna, informatyczna, chemiczna itd.
    last_renovation DATE -- data ostatniego remontu
);

-- Tabela przechowuje informacje o pracownikach takich jak: sprzataczka, wozny, sekretarka itd.
CREATE TABLE administration_employees(
    id       int         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name     varchar(32) NOT NULL,
    surname  varchar(32) NOT NULL,
    pesel    varchar(11) NOT NULL UNIQUE,
    sex      char        NOT NULL CHECK (sex in ('k', 'm')),
    birthday DATE        NOT NULL,
    role     varchar(128),
    salary   DECIMAL(10,2)
)