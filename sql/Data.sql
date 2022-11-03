use
sql_uj_3sem;

insert into students(name, surname)
values ('Pola', 'Kekańskaa'),
       ('Volodymir', 'Zieleński');

insert into lessons(subject)
values ('Polak'),
       ('Matematyk');


insert into students_attending_lessons(id_of_student, id_of_lesson)
values (1, 1),
       (1, 2),
       (2, 1);