create database if not exists sql_uj_3sem;
use sql_uj_3sem;

drop table if exists schedule;
drop table if exists students_attending_courses;
drop table if exists courses;
drop table if exists students;
drop table if exists teachers;
drop table if exists subjects;
drop table if exists lessons;
drop table if exists student_makrs;
drop table if exists student_presence;
drop table if exists parents;
drop table if exists classrooms;
drop table if exists classroom_roles;
drop table if exists administration_employees;

-- Tabela przechowuje informacje o rodzicach uczniow
CREATE TABLE parents
(
    id                 int         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name               varchar(32) NOT NULL,
    surname            varchar(32) NOT NULL,
    pesel              varchar(11) NOT NULL UNIQUE,
    CHECK (pesel LIKE '___________'), -- sprawdzenie czy PESEL ma 11 cyfr
    adress_street      varchar(128),
    adress_city        varchar(128),
    adress_postal_code varchar(6),
    -- CONSTRAINT good_postal CHECK (adress_postal_code LIKE '[0-9][0-9][-][0-9][0-9][0-9]'),
    phone_number       varchar(9) UNIQUE
);

create table students
(
    id               int         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name             varchar(32) NOT NULL,
    surname          varchar(32) NOT NULL,
    pesel            varchar(11) NOT NULL UNIQUE,
    sex              char        NOT NULL CHECK (sex in ('k', 'm')),
    birthday         DATE        NOT NULL,

    first_parent_id  INT,
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
    id          int         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name        varchar(32) NOT NULL,
    description varchar(255)
);

-- na przyklad jezyk polski z krzystofem k.
create table courses
(
    id         int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    teacher_id int NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teachers (id),

    subject_id int NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES subjects (id)
);


-- pokazuje ktory student chodzi do jakiej grupy
-- many to many
create table students_attending_courses
(
    id_of_student int NOT NULL,
    id_of_course  int NOT NULL,

    PRIMARY KEY (id_of_student, id_of_course),
    FOREIGN KEY (id_of_student) REFERENCES students (id),
    FOREIGN KEY (id_of_course) REFERENCES courses (id)
);

-- na przyklad (jezyk polski z krzystofem k.) w sali id
create table schedule
(
    id               int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_of_course     int NOT NULL REFERENCES courses (id),
    id_of_courseroom int NOT NULL REFERENCES classrooms (id),

    week_day         int  DEFAULT (0),
    CHECK ( week_day BETWEEN 0 AND 7),

    start_time       TIME DEFAULT ('12:00:00'),
    end_time         TIME DEFAULT ('13:00:00'),
    CHECK ( start_time < end_time )
);

-- zajecia same w sobie. Maja pointer na harmonogram w ktorym czasie powinny wystepowac
create table lessons
(
    id             int  NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_of_schedule int  NOT NULL REFERENCES schedule (id),
    lesson_date    DATE NOT NULL
);

-- oceny/komentarzy/obecnosc studenta na pewnym zajeciu
create table student_presence
(
    id_of_lesson  int NOT NULL REFERENCES lessons (id),
    id_of_student int NOT NULL REFERENCES students (id),
    PRIMARY KEY (id_of_lesson, id_of_student),
    was_absent    boolean DEFAULT TRUE
);

-- oceny studenta na pewnym zajeciu
create table student_makrs
(
    id            int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_of_lesson  int NOT NULL REFERENCES lessons (id), -- na ktorym zajeciu bylo
    id_of_student int NOT NULL REFERENCES students (id),
    mark          int,
    CHECK ( mark <= 5 and mark >= 0 )
);

-- Tabela przechowuje specialne role sal lekcyjnych
CREATE TABLE classroom_roles
(
    id          INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    description varchar(128)
);

-- Tabela przechowuje wszelkie dane na temat sal lekcyjnych
CREATE TABLE classrooms
(
    id              INT NOT NULL PRIMARY KEY,                -- jako ID traktuje numer sali ktory widnieje na drzwiach, wiec nie ma AUTO_INCREMENT
    capacity        TINYINT,                                 -- ile uczniow miesci sie w sali
    has_projector   TINYINT,                                 -- czy sala ma projektor multimedialny?
    special_role_id TINYINT REFERENCES classroom_roles (id), -- czy sala jest jakas specialna? np. sala gimnastyczna, informatyczna, chemiczna itd.
    last_renovation DATE                                     -- data ostatniego remontu
);

-- Tabela przechowuje informacje o pracownikach takich jak: sprzataczka, wozny, sekretarka itd.
CREATE TABLE administration_employees
(
    id       int         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name     varchar(32) NOT NULL,
    surname  varchar(32) NOT NULL,
    pesel    varchar(11) NOT NULL UNIQUE,
    sex      char        NOT NULL CHECK (sex in ('k', 'm')),
    birthday DATE        NOT NULL,
    role     varchar(128),
    salary   DECIMAL(10, 2)
);

/* ------ ------ ------ ------ ------ ------ PROCEDURES */

drop procedure if exists getAverageMark;
create procedure getAverageMark(IN studentId INT, IN subjectId INT)
BEGIN
    SELECT AVG(student_makrs.mark)
    from subjects
             inner join courses on subjects.id = courses.subject_id
             inner join schedule on courses.id = schedule.id_of_course
             inner join lessons l on schedule.id = l.id_of_schedule
             inner join student_makrs on l.id = student_makrs.id_of_lesson and studentId = student_makrs.id_of_student
    where subjectId = courses.subject_id
    group by student_makrs.id;
END;

/* ------ ------ ------ ------ ------ ------ FUNCTIONS */
drop function if exists setAbsenceToStudent;
CREATE FUNCTION setAbsenceToStudent(lessonDate DATE, studentId INT, wasAbsent BOOLEAN)
    RETURNS BOOLEAN
    READS SQL DATA
BEGIN
    DECLARE onlyOneLessonWasFound BOOLEAN;
    DECLARE statusNotExists BOOLEAN;
    DECLARE lessonId INTEGER;

    SET onlyOneLessonWasFound = (SELECT COUNT(*) = 1
                                 FROM lessons
                                 WHERE lesson_date = lessonDate);

    IF not onlyOneLessonWasFound then return onlyOneLessonWasFound ; end if;

    SET lessonId = (SELECT lessons.id FROM lessons WHERE lesson_date = lessonDate);
    SET statusNotExists =
            (SELECT COUNT(*) = 0 FROM student_presence WHERE id_of_lesson = lessonId AND studentId = id_of_student);


    IF statusNotExists then
        INSERT INTO student_presence(id_of_lesson, id_of_student, was_absent) values (lessonId, studentId, wasAbsent);
        RETURN 1;
    end if;

    UPDATE student_presence
    SET was_absent = wasAbsent
    WHERE id_of_lesson = lessonId
      AND studentId = id_of_student;
    RETURN 1;
END;

