-- Podac liste studentow i grup do ktorych oni chodza
SELECT sag.id_of_group, DAYNAME(DATE_ADD('2017-06-03', INTERVAL lt.week_day DAY)) as 'day of week',lt.start_time,lt.end_time, s.name,
       CONCAT( students.name,' ',students.surname) as student FROM students
    INNER JOIN students_attending_groups sag on students.id = sag.id_of_student
    INNER JOIN lessons_groups lg on sag.id_of_group = lg.id
    INNER JOIN subjects s on lg.subject_id = s.id
    RIGHT JOIN lessons_table lt on lg.id = lt.id_of_group
-- Podac wszystkie