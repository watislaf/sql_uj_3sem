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


create table students
(
    id       int         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name     varchar(10) NOT NULL,
    surname  varchar(10) NOT NULL,
    sex      char        NOT NULL CHECK (sex in ('k', 'm')),
    birthday DATE
);

create table teachers
(
    id       int         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name     varchar(10) NOT NULL,
    surname  varchar(10) NOT NULL,
    sex      char        NOT NULL CHECK (sex in ('k', 'm')),
    birthday DATE
);

-- representacja ogolnego przedmiotu
create table subjects
(
    id      int         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name varchar(10) NOT NULL,
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