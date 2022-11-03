use
sql_uj_3sem;

insert into students(name, surname, sex)
values ('Pola', 'Kekańskaa','k'),
       ('Volodymir', 'Zieleński','m');

insert into teachers(name, surname, sex)
values ('Bob','Borsucz','m');

insert into subjects(name)
values ('Polak'),
       ('Matematyk');


insert into lessons_groups(teacher_id,subject_id)
values (1,1),
       (1,2);

insert into students_attending_groups(id_of_student, id_of_group)
values (1,1),
       (1,2),
       (2,1);

insert into lessons_table(id_of_group, week_day, start_time, end_time)
values (1,2,'12:00:00','13:00:00'),
       (1,3,'14:00:00','15:00:00'),
       (2,6,'15:00:00','18:00:00');


