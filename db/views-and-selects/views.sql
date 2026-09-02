-- database: ../lms.sqlite

-- view com informacoes gerais sobre as aulas concluidas, incluindo username, email do usuario, nome do curso e da licao concluida
CREATE VIEW "lessons_completed_infos" AS
SELECT 
    lc.user_id,
    u.username,
    u.email,
    c.title AS "course",
    lc.course_id,
    l.title AS "lesson",
    lc.lesson_id,
    lc.completed
FROM "lessons_completed" AS "lc"
JOIN "users" AS "u" ON u.id = lc.user_id
JOIN "courses" AS "c" ON c.id = lc.course_id
JOIN "lessons" AS "l" ON l.id = lc.lesson_id;

-- view com informacoes completas sobre a emissao de certificados, como o nome, id e duracao do curso, username e email do usuario
CREATE VIEW "certificates_infos" AS
SELECT  
    cert.id AS "certificate_id",
    c.id AS "course_id",
    c.title AS "course",
    c.total_duration AS "course_duration",
    u.username,
    u.email,
    cert.completed
FROM "certificates" AS "cert"
JOIN "users" AS "u" ON u.id = cert.user_id
JOIN "courses" AS "c" ON c.id = cert.course_id;

-- view com informacoes completas de aulas, incluindo informacoes do curso que pertence
CREATE VIEW "lessons_infos" AS
SELECT 
    l.id AS "lesson_id",
    l.slug AS "lesson_slug",
    l.duration AS "lesson_duration",
    l.lesson_order,
    l.free,
    c.id AS "course_id",
    c.slug AS "course_slug",
    c.total_duration AS "course_duration",
    c.lessons_count AS "total_lessons"
FROM "lessons" AS "l"
JOIN "courses" AS "c" ON c.id = l.course_id;

