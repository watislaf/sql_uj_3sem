create database if not exists sql_uj_3sem;
use sql_uj_3sem;

drop table if exists schedule;
drop table if exists students_attending_courses;
drop table if exists amount_of_students_on_the_course;
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

-- tabela przechowuje informacje o rodzicach uczniow
create table parents
(
    id                 int         not null primary key auto_increment,
    name               varchar(32) not null,
    surname            varchar(32) not null,
    pesel              varchar(11) not null unique,
    check (pesel like '___________'), -- sprawdzenie czy pesel ma 11 cyfr
    adress_street      varchar(128),
    adress_city        varchar(128),
    adress_postal_code varchar(6),
    -- constraint good_postal check (adress_postal_code like '[0-9][0-9][-][0-9][0-9][0-9]'),
    phone_number       varchar(9) unique
);

create table students
(
    id               int         not null primary key auto_increment,
    name             varchar(32) not null,
    surname          varchar(32) not null,
    pesel            varchar(11) not null unique,
    sex              char        not null check (sex in ('k', 'm')),
    birthday         date        not null,

    first_parent_id  int,
    foreign key (first_parent_id) references parents (id),
    second_parent_id int,
    foreign key (second_parent_id) references parents (id),

    constraint check (pesel like '___________') -- sprawdzenie czy pesel ma 11 cyfr
    -- constraint check (pesel not in (select parents.pesel from parents)) -- sprawdzenie czy dziecko nie ma takiego peselu jak ktorys rodzic
);

create table teachers
(
    id       int         not null primary key auto_increment,
    name     varchar(32) not null,
    surname  varchar(32) not null,
    sex      char        not null check (sex in ('k', 'm')),
    birthday date
);

-- representacja ogolnego przedmiotu
create table subjects
(
    id          int         not null primary key auto_increment,
    name        varchar(32) not null,
    description varchar(255)
);

-- na przyklad jezyk polski z krzystofem k.
create table courses
(
    id         int not null primary key auto_increment,
    teacher_id int not null,
    foreign key (teacher_id) references teachers (id),

    subject_id int not null,
    foreign key (subject_id) references subjects (id)
);


-- pokazuje ktory student chodzi do jakiej grupy
-- many to many
create table students_attending_courses
(
    id_of_student int not null,
    id_of_course  int not null,

    primary key (id_of_student, id_of_course),
    foreign key (id_of_student) references students (id),
    foreign key (id_of_course) references courses (id)
);

create table amount_of_students_on_the_course
(
    course_id int not null primary key,
    counter   int not null default 0
);

create trigger update_students_counter
    before insert
    on students_attending_courses
    for each row
begin
    if exists(select * from amount_of_students_on_the_course where course_id = new.id_of_course) then
        update amount_of_students_on_the_course set counter = counter + 1 where course_id = new.id_of_course;
    else
        insert into amount_of_students_on_the_course(course_id, counter) values (new.id_of_course, 1);
    end if;
end;


create trigger update_students_counter
    before update
    on students_attending_courses
    for each row
begin
    if exists(old.id_of_course != new.id_of_course) then
        update amount_of_students_on_the_course set counter = counter - 1 where course_id = old.id_of_course;
        update amount_of_students_on_the_course set counter = counter + 1 where course_id = new.id_of_course;
    end if;
end;

-- na przyklad (jezyk polski z krzystofem k.) w sali id
create table schedule
(
    id               int not null primary key auto_increment,
    id_of_course     int not null references courses (id),
    id_of_courseroom int not null references classrooms (id),

    week_day         int  default (0),
    check ( week_day between 0 and 7),

    start_time       time default ('12:00:00'),
    end_time         time default ('13:00:00'),
    check ( start_time < end_time )
);

-- zajecia same w sobie. maja pointer na harmonogram w ktorym czasie powinny wystepowac
create table lessons
(
    id             int  not null primary key auto_increment,
    id_of_schedule int  not null references schedule (id),
    lesson_date    date not null
);

-- oceny/komentarzy/obecnosc studenta na pewnym zajeciu
create table student_presence
(
    id_of_lesson  int not null references lessons (id),
    id_of_student int not null references students (id),
    primary key (id_of_lesson, id_of_student),
    was_absent    boolean default true
);

-- oceny studenta na pewnym zajeciu
create table student_makrs
(
    id            int not null primary key auto_increment,
    id_of_lesson  int not null references lessons (id), -- na ktorym zajeciu bylo
    id_of_student int not null references students (id),
    mark          int,
    check ( mark <= 5 and mark >= 0 )
);

-- tabela przechowuje specialne role sal lekcyjnych
create table classroom_roles
(
    id          int not null primary key auto_increment,
    description varchar(128)
);

-- tabela przechowuje wszelkie dane na temat sal lekcyjnych
create table classrooms
(
    id              int not null primary key,                -- jako id traktuje numer sali ktory widnieje na drzwiach, wiec nie ma auto_increment
    capacity        tinyint,                                 -- ile uczniow miesci sie w sali
    has_projector   tinyint,                                 -- czy sala ma projektor multimedialny?
    special_role_id tinyint references classroom_roles (id), -- czy sala jest jakas specialna? np. sala gimnastyczna, informatyczna, chemiczna itd.
    last_renovation date                                     -- data ostatniego remontu
);

-- tabela przechowuje informacje o pracownikach takich jak: sprzataczka, wozny, sekretarka itd.
create table administration_employees
(
    id       int         not null primary key auto_increment,
    name     varchar(32) not null,
    surname  varchar(32) not null,
    pesel    varchar(11) not null unique,
    sex      char        not null check (sex in ('k', 'm')),
    birthday date        not null,
    role     varchar(128),
    salary   decimal(10, 2)
);

/* ------ ------ ------ ------ ------ ------ procedures */

drop procedure if exists getaveragemark;
create procedure getaveragemark(in studentid int, in subjectid int)
begin
    select avg(student_makrs.mark)
    from subjects
             inner join courses on subjects.id = courses.subject_id
             inner join schedule on courses.id = schedule.id_of_course
             inner join lessons l on schedule.id = l.id_of_schedule
             inner join student_makrs on l.id = student_makrs.id_of_lesson and studentid = student_makrs.id_of_student
    where subjectid = courses.subject_id
    group by student_makrs.id;
end;

/* ------ ------ ------ ------ ------ ------ functions */
drop function if exists setabsencetostudent;
create function setabsencetostudent(lessondate date, studentid int, wasabsent boolean)
    returns boolean
    reads sql data
begin
    declare onlyonelessonwasfound boolean;
    declare statusnotexists boolean;
    declare lessonid integer;

    set onlyonelessonwasfound = (select count(*) = 1
                                 from lessons
                                 where lesson_date = lessondate);

    if not onlyonelessonwasfound then return onlyonelessonwasfound ; end if;

    set lessonid = (select lessons.id from lessons where lesson_date = lessondate);
    set statusnotexists =
            (select count(*) = 0 from student_presence where id_of_lesson = lessonid and studentid = id_of_student);


    if statusnotexists then
        insert into student_presence(id_of_lesson, id_of_student, was_absent) values (lessonid, studentid, wasabsent);
        return 1;
    end if;

    update student_presence
    set was_absent = wasabsent
    where id_of_lesson = lessonid
      and studentid = id_of_student;
    return 1;
end;
