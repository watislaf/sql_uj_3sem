create
database if not exists sql_uj_3sem;
use
sql_uj_3sem;

drop table if exists students_attending_lessons;
drop table if exists students;
drop table if exists lessons;


create table students
(
    id      int         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name    varchar(10) NOT NULL,
    surname varchar(10) NOT NULL
);

create table lessons
(
    id      int         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    subject varchar(10) NOT NULL
);

create table "students attending lessons"
(
    id_of_student int NOT NULL,
    id_of_lesson  int NOT NULL,
    PRIMARY KEY (id_of_student, id_of_lesson),
    FOREIGN KEY (id_of_student) REFERENCES students (id) ON UPDATE CASCADE,
    FOREIGN KEY (id_of_lesson) REFERENCES lessons (id) ON UPDATE CASCADE
);