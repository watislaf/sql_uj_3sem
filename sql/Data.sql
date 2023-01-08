use
sql_uj_3sem;

INSERT INTO parents (name, surname, pesel, adress_street, adress_city, adress_postal_code, phone_number)
VALUES  ('Krzysztof', 'Kowalski', '75201568431', 'ul. Polska 3', 'Krakow', '12-345','123456789'),
        ('Katarzyna', 'Kowalska', '75206948431', 'ul. Norymberska 21', 'Warszawa', '33-333','987333321'),
        ('Anna', 'Nowak', '75206999431', 'ul. Katalonska 6', 'Warszawa', '33-333','987654321'),
        ('Marian', 'Sielanka', '80206948431', 'ul. Pikolska 91', 'Warszawa', '33-333','494798254'),
        ('Zygmunt', 'Ptak', '75598948431', 'ul. Lipska 6', 'Warszawa', '33-333','987564991');

insert into students (name, surname, pesel, sex, birthday, first_parent_id, second_parent_id)
values ('Pola', 'Kowalska', '05697865458', 'k', '2005-03-01', 1, 2),
       ('Volodymir', 'Zielenski', '05690215458', 'm', '2005-05-12', 3, NULL);

insert into teachers(name, surname, sex)
values ('Bob','Borsucz','m');

insert into subjects(name)
values ('Jezyk polski'),
       ('Matematyka');


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

INSERT INTO classroom_roles (id, description)
VALUES  (0, 'brak specialnej roli'),
        (1, 'sala gimnastyczna'),
        (2, 'pracownia informatyczna'),
        (3, 'pracownia chemiczna'),
        (4, 'pracownia fizyczna');

INSERT INTO classrooms (id, capacity, has_projector, special_role, last_renovation)
VALUES (27, 30, 1, 0, '2018-08-01'),
       (108, 100, 0, 1, '2010-04-01'),
       (50, 35, 0, 0, '2005-01-01');

INSERT INTO administration_employees (name, surname, pesel, sex, birthday, role, salary)
VALUES  ('Maria', 'Milkowska', '91220147192', 'k', '1991-02-11', 'pracownica sekretariatu', 4050.00),
        ('Zygmunt', 'Czyscioch', '70173016310', 'm', '1970-12-22', 'wozny', 2700.00),
        ('Aneta', 'Brudna', '80205639163', 'k', '1980-10-12', 'sprzatakacza', 2700.00);
       