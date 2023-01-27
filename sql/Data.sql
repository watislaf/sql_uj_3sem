use sql_uj_3sem;

delete
from students_attending_courses
where true;
delete
from courses
where true;
delete
from schedule
where true;
delete
from lessons
where true;
delete
from student_makrs
where true;
delete
from student_presence
where true;
delete
from classroom_roles
where true;
delete
from classrooms
where true;
delete
from administration_employees
where true;
delete
from students
where true;
delete
from parents
where true;
delete
from teachers
where true;
delete
from subjects
where true;
alter table administration_employees
    auto_increment = 1;
alter table classroom_roles
    auto_increment = 1;
alter table parents
    auto_increment = 1;
alter table students
    auto_increment = 1;
alter table teachers
    auto_increment = 1;
alter table subjects
    auto_increment = 1;
alter table courses
    auto_increment = 1;
alter table students_attending_courses
    auto_increment = 1;
alter table schedule
    auto_increment = 1;
alter table lessons
    auto_increment = 1;
alter table student_makrs
    auto_increment = 1;

INSERT INTO parents (name, surname, pesel, adress_street, adress_city, adress_postal_code, phone_number)
VALUES ('Krzysztof', 'Kowalski', '75201568431', 'ul. Polska 3', 'Krakow', '12-345', '123456789'),
       ('Katarzyna', 'Kowalska', '75206948431', 'ul. Norymberska 21', 'Warszawa', '33-333', '987333321'),
       ('Anna', 'Nowak', '75206999431', 'ul. Katalonska 6', 'Warszawa', '33-333', '987654321'),
       ('Marian', 'Sielanka', '80206948431', 'ul. Pikolska 91', 'Warszawa', '33-333', '494798254'),
       ('Zygmunt', 'Ptak', '75598948431', 'ul. Lipska 6', 'Warszawa', '33-333', '987564991');

insert into students (name, surname, pesel, sex, birthday, first_parent_id, second_parent_id)
values ('Pola', 'Kowalska', '05697865458', 'k', '2005-03-01', 1, 2),
       ('Volodymir', 'Zielenski', '05690215458', 'm', '2005-05-12', 3, 1);


insert into teachers(name, surname, sex)
values ('bob', 'borsucz', 'm');

insert into subjects(name)
values ('matematyka'),
       ('fizyka');

insert into courses( teacher_id, subject_id)
values ( 1, 1),
       ( 1, 2),
       ( 1, 2);
insert into students_attending_courses(id_of_student, id_of_course)
values (1, 1),
       (1, 2),
       (2, 1);

insert into schedule( id_of_course, week_day, start_time, end_time, id_of_courseroom)
values (1, 2, '12:00:00', '13:00:00', 27),
       ( 1, 3, '14:00:00', '15:00:00', 108),
       ( 2, 6, '15:00:00', '18:00:00', 50);


insert into lessons( id_of_schedule, lesson_date)
values ( 3, '2012-12-2'),
       ( 1, '2012-12-5'),
       ( 1, '2012-12-7'),
       ( 2, '2012-12-4');

insert into student_makrs( id_of_lesson, id_of_student, mark)
    value (1, 1, 4),
    ( 2, 2, 3),
    ( 1, 1, 4),
    ( 2, 2, 3),
    ( 4, 2, 5),
    ( 4, 1, 2);


insert into student_presence(id_of_lesson, id_of_student, was_absent)
    value (1, 2, true);

insert into classroom_roles ( description)
values ('brak specialnej roli'),
       ( 'sala gimnastyczna'),
       ( 'pracownia informatyczna'),
       ( 'pracownia chemiczna'),
       ( 'pracownia fizyczna');

insert into classrooms (id, capacity, has_projector, special_role_id, last_renovation)
values (27, 30, 1, 3, '2018-08-01'),
       (108, 100, 0, 1, '2010-04-01'),
       (50, 35, 0, 5, '2005-01-01');

insert into administration_employees (name, surname, pesel, sex, birthday, role, salary)
values ('Maria', 'Milkowska', '91220147192', 'k', '1991-02-11', 'pracownica sekretariatu', 4050.00),
       ('Zygmunt', 'Czyscioch', '70173016310', 'm', '1970-12-22', 'wozny', 2700.00),
       ('Aneta', 'Brudna', '80205639163', 'k', '1980-10-12', 'sprzatakacza', 2700.00);
