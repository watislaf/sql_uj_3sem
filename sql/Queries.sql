use sql_uj_3sem;
drop view if exists students_timetable;
drop view if exists candidates_stats;
drop view if exists journal;
drop view if exists lessons_needing_substitution;

create view students_timetable as
    select p.id, p.name, p.surname, s2.name subject_name, t.id_of_classroom, week_day(ls.week_day), ls.start_time, ls.end_time
    from students s
    join people p on s.id = p.id
    join students_attending_courses sac on sac.id_of_student = p.id
    join courses c on sac.id_of_course = c.id
    join subjects s2 on c.subject_id = s2.id
    join timetable t on c.id = t.id_of_course
    join lessons_schedule ls on t.id_lessons_schedules=ls.id
    order by p.id;

-- Wyswietla liste kandydatow z obliczonymi punktami do rekrutacji do szkoly oraz decyzją - czy mają ich dość by się dostać
create view candidates_stats as
    select p.id, p.name, p.surname, candidates_pts(c.id) as points,
        if(candidates_pts(c.id) >= 50, if(candidate_in_top6(c.id), 'Approved', 'Not approved (reserve)'), 'Not approved') as Decision
    from people p
    join candidates c on p.id = c.id
    order by points desc;

create view lessons_needing_substitution as
    select * from lessons l
    where l.needs_substitution = true;

select * from lessons_needing_substitution;

# -- wypisuje wszystkie zajecia z ocenami i obecnosciami
# create view journal as
# select lesson_date, s.name as subject_name, s2.name, ifnull(sp.was_absent, 0) as was_absent, mark
# from lessons
#          inner join schedule on lessons.id = schedule.id
#          inner join courses on courses.id = schedule.id_of_course
#          inner join subjects s on courses.subject_id = s.id
#          inner join students_attending_courses sac on courses.id = sac.id_of_course
#          left join student_presence sp on (sac.id_of_student = sp.id_of_student and sp.id_of_lesson = lessons.id)
#          inner join students s2 on sac.id_of_student = s2.id
#          left join student_makrs sm on sm.id_of_lesson = lessons.id and sm.id_of_student = s2.id;

-- wypisuje srednia ocene dla studenta x i przedmiotu y
call get_average_mark(13, 1);

call get_students_of_teacher(8);

call get_parents_contact_info(6);

call class_timetable(1, 'a');

-- ustawia obecnosc studentowi w pewien dzien
 select set_absence_to_student('2012-12-05', 6, 1);
