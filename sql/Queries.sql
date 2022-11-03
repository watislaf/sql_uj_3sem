-- Get student and lessons he attends
SELECT students.name, l.subject
FROM students
         INNER JOIN students_attending_lessons sal
                    on students.id = sal.id_of_student
         INNER JOIN lessons l on sal.id_of_lesson = l.id