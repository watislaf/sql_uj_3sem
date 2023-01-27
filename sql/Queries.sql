use sql_uj_3sem;
drop view if exists timetable;
drop view if exists journal;

-- podac liste studentow i ich harmonogram
create view timetable as
select s.name, s.surname, s2.name as subject_name, s3.id_of_courseroom, cr.description, s3.week_day
from students_attending_courses
         inner join students s on students_attending_courses.id_of_student = s.id
         inner join courses c on students_attending_courses.id_of_course = c.id
         inner join subjects s2 on c.subject_id = s2.id
         inner join schedule s3 on students_attending_courses.id_of_course = s3.id_of_course
         inner join classrooms c3 on s3.id_of_courseroom = c3.id
         inner join classroom_roles cr on cr.id = c3.special_role_id;
select *
from timetable;

-- wypisuje wszystkie zajecia z ocenami i obecnosciami
create view journal as
select lesson_date, s.name as subject_name, s2.name, ifnull(sp.was_absent, 0) as was_absent, mark
from lessons
         inner join schedule on lessons.id = schedule.id
         inner join courses on courses.id = schedule.id_of_course
         inner join subjects s on courses.subject_id = s.id
         inner join students_attending_courses sac on courses.id = sac.id_of_course
         left join student_presence sp on (sac.id_of_student = sp.id_of_student and sp.id_of_lesson = lessons.id)
         inner join students s2 on sac.id_of_student = s2.id
         left join student_makrs sm on sm.id_of_lesson = lessons.id and sm.id_of_student = s2.id;
select *
from journal;

SELECT *
FROM amount_of_students_on_the_course;
-- wypisuje srednia ocene dla studenta x i przedmiota y
call getAverageMark(1, 1);

-- ustawia obecnosc studentowi w pewien dzien
select setAbsenceToStudent('2012-12-05', 1, true);
