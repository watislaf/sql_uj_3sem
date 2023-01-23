use sql_uj_3sem;

DELETE
FROM students_attending_courses
WHERE true;
DELETE
FROM courses
WHERE true;
DELETE
FROM schedule
WHERE true;
DELETE
FROM lessons
WHERE true;
DELETE
FROM student_makrs
WHERE true;
DELETE
FROM student_presence
WHERE true;
DELETE
FROM classroom_roles
WHERE true;
DELETE
FROM classrooms
WHERE true;
DELETE
FROM administration_employees
WHERE true;
DELETE
FROM students
WHERE true;
DELETE
FROM parents
where true;
DELETE
FROM teachers
WHERE true;
DELETE
FROM subjects
WHERE true;
ALTER TABLE administration_employees
    AUTO_INCREMENT = 1;
ALTER TABLE classroom_roles
    AUTO_INCREMENT = 1;
ALTER TABLE parents
    AUTO_INCREMENT = 1;
ALTER TABLE students
    AUTO_INCREMENT = 1;
ALTER TABLE teachers
    AUTO_INCREMENT = 1;
ALTER TABLE subjects
    AUTO_INCREMENT = 1;
ALTER TABLE courses
    AUTO_INCREMENT = 1;
ALTER TABLE students_attending_courses
    AUTO_INCREMENT = 1;
ALTER TABLE schedule
    AUTO_INCREMENT = 1;
ALTER TABLE lessons
    AUTO_INCREMENT = 1;
ALTER TABLE student_makrs
    AUTO_INCREMENT = 1;

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
values ('Bob', 'Borsucz', 'm');

insert into subjects(name)
values ('Matematyka'),
       ('Fizyka');

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

INSERT INTO classroom_roles ( description)
VALUES ('brak specialnej roli'),
       ( 'sala gimnastyczna'),
       ( 'pracownia informatyczna'),
       ( 'pracownia chemiczna'),
       ( 'pracownia fizyczna');

INSERT INTO classrooms (id, capacity, has_projector, special_role_id, last_renovation)
VALUES (27, 30, 1, 3, '2018-08-01'),
       (108, 100, 0, 1, '2010-04-01'),
       (50, 35, 0, 5, '2005-01-01');

INSERT INTO administration_employees (name, surname, pesel, sex, birthday, role, salary)
VALUES ('Maria', 'Milkowska', '91220147192', 'k', '1991-02-11', 'pracownica sekretariatu', 4050.00),
       ('Zygmunt', 'Czyscioch', '70173016310', 'm', '1970-12-22', 'wozny', 2700.00),
       ('Aneta', 'Brudna', '80205639163', 'k', '1980-10-12', 'sprzatakacza', 2700.00);

