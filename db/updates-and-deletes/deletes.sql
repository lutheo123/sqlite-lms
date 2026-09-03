-- database: ../lms.sqlite

-- limpa sessoes expiradas
DELETE FROM "sessions" 
WHERE expires < STRFTIME('%s', 'NOW');

-- limpa pedidos de redefinicao de senha expirados
DELETE FROM "password_resets" 
WHERE expires < STRFTIME('%s', 'NOW');

-- cancela matriculas
DELETE FROM "enrollments" 
WHERE user_id = 3 AND course_id = 2;