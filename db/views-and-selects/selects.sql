-- database: ../lms.sqlite

-- essa consulta seleciona um usuario com base em seu e-mail
SELECT * FROM "users"
WHERE email = 'ana.silva@email.com';

-- essa consulta seleciona todas as aulas de um curso com base no slug do curso
SELECT * FROM "lessons_infos"
WHERE course_slug = 'python-para-iniciantes';

-- essa consulta seleciona todas as aulas de um curso com base no slug da aula
SELECT * FROM "lessons_infos"
WHERE course_slug = (SELECT course_slug FROM "lessons_infos" WHERE lesson_slug = 'git-02-branches');

-- essa consulta acompanha o andamento dos cursos que cada aluno esta fazendo
SELECT 
    lc.user_id,
    u.username,
    lc.course_id,
    c.title AS "course",
    COUNT(*) AS "lessons_done",
    c.lessons_count AS "total_lessons",
    format('%.2f%%', ((COUNT(*) * 1.0) / c.lessons_count) * 100) AS "progress"
FROM "lessons_completed" AS "lc"
JOIN "users" AS "u" ON u.id = lc.user_id
JOIN "courses" AS "c" ON c.id = lc.course_id
GROUP BY lc.user_id, u.username, lc.course_id, c.title, c.lessons_count;


-- essa consulta pega, a partir de um slug, as aulas proxima e anterior de um curso
SELECT * FROM "lessons"
WHERE course_id = (SELECT course_id FROM "lessons" WHERE slug = 'py-03-loops') AND 
    lesson_order IN (
        (SELECT lesson_order FROM "lessons" WHERE slug = 'py-03-loops') - 1,
        (SELECT lesson_order FROM "lessons" WHERE slug = 'py-03-loops'),
        (SELECT lesson_order FROM "lessons" WHERE slug = 'py-03-loops') + 1
    )
ORDER BY lesson_order;

-- essa consulta confere o numero de alunos inscritos em cada curso
SELECT
    courses.title AS "course",
    COUNT(*) AS "enrollments"
FROM "enrollments"
JOIN "courses" ON courses.id = enrollments.course_id 
GROUP BY "course_id";

-- essa consulta lista os estudantes de um curso com base no slug do curso
SELECT 
    username,
    course,
    course_id
FROM "lessons_completed_infos" 
WHERE course_id = (SELECT id FROM "courses" WHERE slug = 'sql-e-arquitetura-db')
GROUP BY username, course_id;

-- essa consulta pega os principais dados de um usuario dado o seu username
SELECT 
    lci.user_id,
    lci.username,
    COUNT(DISTINCT lci.course_id) AS "courses_accessed",
    SUM(l.duration) AS "total_watchtime",
    COUNT(*) AS "lessons_watched",
    COUNT(DISTINCT ci.certificate_id) AS "total_certificates"
FROM "lessons_completed_infos" AS "lci"
JOIN "lessons" AS "l" ON l.id = lci.lesson_id
LEFT JOIN "certificates_infos" AS "ci" ON ci.username = lci.username AND ci.course_id = lci.course_id
WHERE user_id = (SELECT id FROM "users" WHERE username = 'carlos_o')
GROUP BY user_id;

-- essa consulta analisa a taxa de conclusao de cada curso
SELECT 
    c.id AS "course_id",
    c.title AS "course",
    COUNT(DISTINCT e.user_id) AS "total_enrollments",
    COUNT(DISTINCT cert.id) AS "total_certificates",
    CASE 
        WHEN COUNT(DISTINCT e.user_id) > 0
        THEN format('%.2f%%', (COUNT(DISTINCT cert.id) * 1.0 / COUNT(DISTINCT e.user_id)) * 100)
        ELSE '0.00%'
    END AS "completion_rate"
FROM "courses" AS "c"
LEFT JOIN "enrollments" AS "e" ON e.course_id = c.id
LEFT JOIN "certificates" AS "cert" ON cert.course_id = c.id
GROUP BY c.id, c.slug;  