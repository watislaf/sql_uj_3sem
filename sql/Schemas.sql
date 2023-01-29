create database if not exists sql_uj_3sem;
use sql_uj_3sem;

delimiter //
drop table if exists administration_employees;
drop table if exists student_marks;
drop table if exists course_marks_categories;
drop table if exists student_presence;
drop table if exists lessons;
drop table if exists timetable;
drop table if exists lessons_schedule;
drop table if exists classrooms;
drop table if exists students_attending_courses;
drop table if exists class_courses;
drop table if exists courses;
drop table if exists subjects;
drop table if exists classroom_roles;
drop table if exists students;
drop table if exists class;
drop table if exists teachers;
drop table if exists parents;
drop table if exists people;

drop trigger if exists update_students_counter;
drop trigger if exists insert_students_counter;

drop procedure if exists get_average_mark;
drop procedure if exists get_students_of_teacher;
drop procedure if exists class_timetable;

drop function if exists set_absence_to_student;
drop function  if exists week_day;

create table people(
    id               int         primary key auto_increment,
    name             varchar(32) not null,
    surname          varchar(32) not null,
    pesel            varchar(11) unique,
        -- check (pesel like '___________'), -- sprawdzenie czy pesel ma 11 cyfr
    sex              char        not null check (sex in ('k', 'm')),
    birthday         date        not null
);

-- tabela przechowuje informacje o rodzicach uczniow
create table parents(
    id                 int         not null primary key,
    adress_street      varchar(128),
    adress_city        varchar(128),
    adress_postal_code varchar(6),
    -- constraint good_postal check (adress_postal_code like '[0-9][0-9][-][0-9][0-9][0-9]'),
    phone_number       varchar(9) unique,

    foreign key (id) references people(id)
);

create table teachers(
    id       int       not null primary key,
    adress_street      varchar(128),
    adress_city        varchar(128),
    adress_postal_code varchar(6),
    -- constraint good_postal check (adress_postal_code like '[0-9][0-9][-][0-9][0-9][0-9]'),
    phone_number       varchar(9) unique,
    salary             decimal(10, 2),

    foreign key (id) references people(id)
);

create table class(
    year                int     not null
        check (year between 1 and 4),
    symbol              char    not null,
    admin_teacher_id    int     not null,
    foreign key (admin_teacher_id) references teachers(id),

    primary key (year, symbol)
);

create table students(
    id               int         not null primary key,
    first_parent_id  int,
    second_parent_id int,
    class_year int not null,
    class_symbol char not null,

    foreign key (class_year, class_symbol) references class(year, symbol),
    foreign key (first_parent_id) references parents (id),
    foreign key (second_parent_id) references parents (id),
    foreign key (id) references people(id)
);

-- tabela przechowuje specialne role sal lekcyjnych
create table classroom_roles(
    id          int not null primary key auto_increment,
    description varchar(256)
);

-- reprezentacja ogolnego przedmiotu
create table subjects(
    id          int         not null primary key auto_increment,
    name        varchar(32) not null,
    description varchar(255),
    required_classroom_type int not null,
    foreign key (required_classroom_type) references classroom_roles(id)
);

-- na przyklad jezyk polski z krzystofem k.
create table courses(
    id         int not null primary key auto_increment,
    teacher_id int not null,
    foreign key (teacher_id) references teachers (id),

    subject_id int not null,
    foreign key (subject_id) references subjects (id)
);

create table class_courses(
    class_year int not null,
    class_symbol char not null,
    foreign key (class_year, class_symbol) references class(year, symbol),
    course_id int not null,
    foreign key (course_id) references courses(id),
    primary key (class_year, class_symbol, course_id)
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

# create table amount_of_students_on_the_course
# (
#     course_id int not null primary key,
#     counter   int not null default 0,
#     foreign key (course_id) references courses (id)
# );
#
# create trigger insert_students_counter
#     before insert
#     on students_attending_courses
#     for each row
# begin
#     if exists(select * from amount_of_students_on_the_course where course_id = new.id_of_course) then
#         update amount_of_students_on_the_course set counter = counter + 1 where course_id = new.id_of_course;
#     else
#         insert into amount_of_students_on_the_course(course_id, counter) values (new.id_of_course, 1);
#     end if;
# end //
#
# create trigger update_students_counter
#     before update
#     on students_attending_courses
#     for each row
# begin
#     if old.id_of_course != new.id_of_course then
#         update amount_of_students_on_the_course set counter = counter - 1 where course_id = old.id_of_course;
#         update amount_of_students_on_the_course set counter = counter + 1 where course_id = new.id_of_course;
#     end if;
# end //

-- tabela przechowuje wszelkie dane na temat sal lekcyjnych
create table classrooms
(
    id              int not null primary key, -- jako id traktuje numer sali ktory widnieje na drzwiach, wiec nie ma auto_increment
    capacity        int,                      -- ile uczniow miesci sie w sali
    has_projector   boolean,                  -- czy sala ma projektor multimedialny?
    special_role_id int,
    foreign key (special_role_id) references classroom_roles (id),

    last_renovation date                      -- data ostatniego remontu
);

-- Rozpiska dzwonkow
create table lessons_schedule(
    id int primary key auto_increment,
    week_day int not null,
    check (week_day between 1 and 7),

    lesson_num int not null,
    start_time      time default ('12:00:00'),
    end_time        time default ('13:00:00'),
    check (start_time < end_time)
);

-- Plan lekcji, np. w piatek o 7:30 w sali numer 50 ma lekcje kurs o zadanym ID
create table timetable(
    id int primary key auto_increment,
    id_lessons_schedules int not null,
    id_of_course    int not null,
    id_of_classroom int not null,

    foreign key (id_lessons_schedules) references lessons_schedule(id),
    foreign key (id_of_course) references courses (id),
    foreign key (id_of_classroom) references classrooms (id)
);

-- zajecia same w sobie. maja pointer na harmonogram w ktorym czasie powinny wystepowac
create table lessons(
    id             int  not null primary key auto_increment,
    id_of_schedule int  not null,
    foreign key (id_of_schedule) references timetable (id),

    lesson_date    date not null
);

-- oceny/komentarze/obecnosc studenta na pewnych zajeciach
create table student_presence(
    id_of_lesson  int not null,
    foreign key (id_of_lesson) references lessons (id),
    id_of_student int not null,
    foreign key (id_of_student) references students (id),
    primary key (id_of_lesson, id_of_student),
    was_absent    boolean default true
);

create table course_marks_categories(
    id  int not null primary key auto_increment,
    course_id int not null,
    description varchar(256),
    weight int default 1,
        check (weight >= 0),
    foreign key (course_id) references courses(id)
);
-- oceny studenta na pewnym zajeciu
create table student_marks(
    id            int not null primary key auto_increment,
    mark_category  int not null ,
    foreign key (mark_category) references course_marks_categories (id),

    id_of_student int not null ,
    foreign key (id_of_student) references students (id),

    mark          int,
    check ( mark <= 6 and mark >= 0 )
);


-- tabela przechowuje informacje o pracownikach takich jak: sprzataczka, wozny, sekretarka itd.
create table administration_employees(
    id       int       not null primary key,
    adress_street      varchar(128),
    adress_city        varchar(128),
    adress_postal_code varchar(6),
    phone_number       varchar(9) unique,
    salary             decimal(10, 2),
    role     varchar(128),

    foreign key (id) references people(id)
);
DELIMITER //
/* ------ ------ ------ ------ ------ ------ procedures */
create procedure get_average_mark(in studentId int, in courseId int)
begin
    declare done int default false;
    declare temp_mark int;
    declare temp_weight int default 0;
    declare weight_count int default 0;
    declare result decimal(10,2) default 0;
    declare cur cursor for
        (select sm.mark, cmc.weight from student_marks sm join course_marks_categories cmc on sm.mark_category = cmc.id
        where (sm.id_of_student = studentId) and (cmc.course_id = courseId));
    declare continue handler for not found set done = true;

    open cur;
    read_loop: loop
        fetch cur into temp_mark, temp_weight;
        if done then
            leave read_loop;
        end if;
        SET result = result + (temp_weight * temp_mark);
        SET weight_count = weight_count + temp_weight;
    end loop;

    close cur;
    select result/weight_count as srednia;
end;

create procedure get_students_of_teacher(in teacherId int)
begin
    select distinct students.*
    from students
             left join students_attending_courses on students.id = students_attending_courses.id_of_student
    where id_of_course in (select id from courses where courses.teacher_id = teacherId);
end //

/* ------ ------ ------ ------ ------ ------ functions */
create function set_absence_to_student(lessonDate date, studentId int, wasabsent boolean)
    returns varchar(100)
    reads sql data
begin
    declare foundLessons boolean;
    declare statusNotExists boolean;
    declare lessonId integer;

    set foundLessons = EXISTS(select * from lessons where lesson_date = lessonDate);

    if (not foundLessons) then return 'cannot find lessons at this day' ; end if;

    set lessonId = (select lessons.id from lessons where lesson_date = lessonDate limit 1);
    set statusNotExists =
            (select count(*) = 0 from student_presence where id_of_lesson = lessonId and studentId = id_of_student);

    if statusNotExists then
        insert into student_presence(id_of_lesson, id_of_student, was_absent) values (lessonId, studentId, wasabsent);
        return 'Entry was created';
    end if;

    update student_presence
    set was_absent = wasabsent
    where id_of_lesson = lessonId
      and studentId = id_of_student;
    return 'Entry was updated';
end //

-- Funckja zwraca nazwe dnia tygodnia ktora jest zadana liczba 1-7
create function week_day (day int)
    returns varchar(32) deterministic
begin
    case day
        when 1 then return 'poniedzialek';
        when 2 then return 'wtorek';
        when 3 then return 'sroda';
        when 4 then return 'czwartek';
        when 5 then return 'piatek';
        when 6 then return 'sobota';
        when 7 then return 'niedziela';
    end case;
end //

-- Procedura wyswietla plan lekcji dla zadanej klasy
create procedure class_timetable (year int, symbol char)
begin
    if (year, symbol) in (select c.year, c.symbol from class c) then
        select week_day(ls.week_day), ls.lesson_num, ls.start_time, ls.end_time, s.name, t.id_of_classroom, p.name, p.surname
        from class_courses cc
        join courses c on cc.course_id = c.id
        join subjects s on c.subject_id = s.id
        join timetable t on c.id = t.id_of_course
        join lessons_schedule ls on t.id_lessons_schedules = ls.id
        join people p on c.teacher_id = p.id
        where cc.class_year = year and cc.class_symbol = symbol;
    else
        select 'Podana klasa nie istnieje';
    end if;
end //
