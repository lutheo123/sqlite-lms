-- database: ../lms.sqlite

-- atualiza niveis de acesso
UPDATE "users"
SET access_level = 'student'
WHERE username = 'carlos_o';

-- atualiza a senha 
UPDATE "users"
SET password = 'KA9kKJ1K33hk44j6hH'
WHERE id = (
    SELECT user_id FROM password_resets
    WHERE token = 'token_x' AND expires > STRFTIME('%s', 'NOW')
);

-- atualiza conteudo dos videos
UPDATE "lessons" 
SET video = 'https://cdn.lms.com/videos/py1_novo_2026.mp4', 
    duration = 720
WHERE slug = 'py-01-intro';
