use sql_uj_3sem;

delete from administration_employees where true;
delete from student_marks where true;
delete from course_marks_categories where true;
delete from student_presence where true;
delete from lessons where true;
delete from timetable where true;
delete from lessons_schedule where true;
delete from classrooms where true;
delete from students_attending_courses where true;
delete from courses where true;
delete from subjects where true;
delete from classroom_roles where true;
delete from students where true;
delete from class where true;
delete from teachers where true;
delete from parents where true;
delete from people where true;

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
alter table lessons
    auto_increment = 1;
alter table student_marks
    auto_increment = 1;
alter table people
    auto_increment = 1;

INSERT INTO people (name, surname, pesel, sex, birthday)
VALUES ('Jerzy', 'Kowalski', '75201568431', 'm', '1980-10-12'),
       ('Anna', 'Kowalska', '75287568431', 'k', '1980-10-12'),
       ('Anna', 'Nowak', '75201008431', 'k', '1980-10-12'),
       ('Marian', 'Sielanka', '73201568431', 'm', '1980-10-12'),
       ('Zygmunt', 'Ptak', '75201568031', 'm', '1980-10-12'),
       ('Pola', 'Kowalska', '02201568431', 'k', '1980-10-12'),
       ('Miroslaw', 'Ptak', '02201532431', 'm', '1980-10-12'),
       ('Bob', 'Borsuk', '7520538431', 'm', '1980-10-12'),
       ('Aneta', 'Zalewska', '98220147492', 'k', '1980-10-12'),
       ('Maria', 'Milkowska', '91220147192', 'k', '1991-02-11'),
       ('Zygmunt', 'Czyscioch', '70173016310', 'm', '1970-12-22'),
       ('Aneta', 'Brudna', '80205639163', 'k', '1980-10-12');

INSERT INTO parents (id, adress_street, adress_city, adress_postal_code, phone_number)
VALUES (1, 'ul. Polska 3', 'Krakow', '12-345', '123456789'),
       (2, 'ul. Norymberska 21', 'Warszawa', '33-333', '987333321'),
       (3, 'ul. Katalonska 6', 'Warszawa', '33-333', '987654321'),
       (4, 'ul. Pikolska 91', 'Warszawa', '33-333', '494798254'),
       (5, 'ul. Lipska 6', 'Warszawa', '33-333', '987564991');

insert into teachers (id, adress_street, adress_city, adress_postal_code, phone_number, salary)
values (8, 'ul. Lipska 68', 'Warszawa', '33-333', '987966991', 6300.00),
       (9, 'ul. Mazowiecka 68', 'Warszawa', '33-333', '987968991', 5800.00);

insert into class (year, symbol, admin_teacher_id)
values (1, 'a', 8),
       (1, 'b', 9);

insert into students (id, first_parent_id, second_parent_id, class_year, class_symbol)
values (6, 1, 2, 1, 'a'),
       (7, 5, null, 1, 'b');

insert into classroom_roles (description)
values ('brak specialnej roli'),
       ('sala gimnastyczna'),
       ('pracownia informatyczna'),
       ('pracownia chemiczna'),
       ('pracownia fizyczna');

insert into subjects(name, required_classroom_type)
values ('matematyka', 1),
       ('fizyka', 5);

insert into courses(teacher_id, subject_id)
values (8, 1),
       (8, 2),
       (9, 2);

insert into students_attending_courses(id_of_student, id_of_course)
values (6, 1),
       (6, 2),
       (7, 3);

insert into classrooms (id, capacity, has_projector, special_role_id, last_renovation)
values (27, 30, 1, 3, '2018-08-01'),
       (108, 100, 0, 1, '2010-04-01'),
       (50, 35, 0, 5, '2005-01-01');

insert into lessons_schedule (week_day, lesson_num, start_time, end_time)
values (1, 1, '8:00:00', '8:45:00'),
       (1, 2, '8:55:00', '9:40:00');

insert into timetable(id_lessons_schedules,id_of_course, id_of_classroom)
values (1, 1, 108),
       (1, 3, 50),
       (2, 2, 50);


insert into lessons(id_of_schedule, lesson_date)
values (3, '2012-12-2'),
       (1, '2012-12-5'),
       (1, '2012-12-7'),
       (2, '2012-12-4');

insert into course_marks_categories (course_id, description, weight)
values (1, 'sprawdzian', 3),
       (2, 'kartkowka', 2),
       (1, 'aktywnosc', 1);

insert into student_marks(mark_category, id_of_student, mark)
values (1, 6, 4),
       (2, 6, 6),
       (3, 6, 5);

insert into student_presence(id_of_lesson, id_of_student, was_absent)
values (1, 7, false),
       (2, 6, false),
       (3, 6, true),
       (4, 6, false);

insert into administration_employees (id, adress_street, adress_city, adress_postal_code, phone_number, role, salary)
values (10, 'ul. Katalonska 6', 'Warszawa', '33-333', '987654321', 'pracowniczka sekretariatu', 4050.00),
       (11, 'ul. Katalonska 6', 'Warszawa', '33-333', '987654621', 'wozny', 2700.00),
       (12, 'ul. Katalonska 6', 'Warszawa', '33-333', '986654321', 'sprzatakacza', 2700.00);
