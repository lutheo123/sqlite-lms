-- database: ../lms.sqlite

-- USERS
INSERT INTO "users" ("id", "name", "email", "password", "username", "access_level") VALUES
(1, 'Ana Silva', 'ana.silva@email.com', '$2b$12$eImiTXuWVxfM37uY4JANjO', 'anasilva', 'admin'),
(2, 'Carlos Oliveira', 'carlos@email.com', '$2b$12$eImiTXuWVxfM37uY4JANjO', 'carlos_o', 'student'),
(3, 'Beatrys Santos', 'beatrys@email.com', '$2b$12$eImiTXuWVxfM37uY4JANjO', 'beatrys_s', 'student'),
(4, 'Diego Ferreira', 'diego.f@email.com', '$2b$12$eImiTXuWVxfM37uY4JANjO', 'diegof', 'student'),
(5, 'Elena Rostova', 'elena.r@email.com', '$2b$12$eImiTXuWVxfM37uY4JANjO', 'elenar', 'editor'),
(6, 'Fernando Costa', 'fernando.c@email.com', '$2b$12$eImiTXuWVxfM37uY4JANjO', 'fcosta', 'student'),
(7, 'Gabriela Lima', 'gabriela.l@email.com', '$2b$12$eImiTXuWVxfM37uY4JANjO', 'gabilima', 'student');

-- COURSES
INSERT INTO "courses" ("id", "author_id", "title", "slug", "description", "updated") VALUES
(1, 1, 'Python para Iniciantes', 'python-para-iniciantes', 'Aprenda os fundamentos da programação com Python do zero.', CURRENT_TIMESTAMP),
(2, 1, 'SQL e Arquitetura de Banco de Dados', 'sql-e-arquitetura-db', 'Domine modelagem, SQLite, índices e triggers.', CURRENT_TIMESTAMP),
(3, 5, 'JavaScript Moderno e Node.js', 'javascript-moderno-nodejs', 'Construa APIs escaláveis e domine o ecossistema JS.', CURRENT_TIMESTAMP),
(4, 5, 'UX/UI Design para Desenvolvedores', 'ux-ui-design-para-devs', 'Aprenda princípios de interface, prototipagem e acessibilidade.', CURRENT_TIMESTAMP),
(5, 1, 'Git e GitHub do Zero ao Avançado', 'git-github-zero-ao-avancado', 'Gerenciamento de versão, fluxos de trabalho e colaboração.', CURRENT_TIMESTAMP);

-- LESSONS 
INSERT INTO "lessons" ("id", "course_id", "title", "duration", "slug", "description", "lesson_order", "video", "free", "updated") VALUES
-- Curso 1: Python (4 Aulas)
(1, 1, 'Introdução ao Python', 600, 'py-01-intro', 'Visão geral da linguagem e instalação do ambiente.', 1, 'https://cdn.lms.com/videos/py1.mp4', 1, CURRENT_TIMESTAMP),
(2, 1, 'Variáveis e Tipos de Dados', 900, 'py-02-variaveis', 'Aprenda a manipular strings, números e listas.', 2, 'https://cdn.lms.com/videos/py2.mp4', 0, CURRENT_TIMESTAMP),
(3, 1, 'Estruturas de Repetição', 1200, 'py-03-loops', 'Dominando os laços for e while.', 3, 'https://cdn.lms.com/videos/py3.mp4', 0, CURRENT_TIMESTAMP),
(4, 1, 'Funções e Módulos', 1500, 'py-04-funcoes', 'Organizando seu código com funções reutilizáveis.', 4, 'https://cdn.lms.com/videos/py4.mp4', 0, CURRENT_TIMESTAMP),

-- Curso 2: SQL (4 Aulas)
(5, 2, 'Modelagem Relacional Básica', 800, 'sql-01-modelagem', 'Entenda tabelas, chaves primárias e relacionamentos.', 1, 'https://cdn.lms.com/videos/sql1.mp4', 1, CURRENT_TIMESTAMP),
(6, 2, 'Consultas Avançadas com JOINs', 1400, 'sql-02-joins', 'Combinando dados de múltiplas tabelas com eficiência.', 2, 'https://cdn.lms.com/videos/sql2.mp4', 0, CURRENT_TIMESTAMP),
(7, 2, 'Triggers e Performance no SQLite', 1500, 'sql-03-triggers', 'Criando automações nativas diretamente no banco.', 3, 'https://cdn.lms.com/videos/sql3.mp4', 0, CURRENT_TIMESTAMP),
(8, 2, 'Índices e Otimização de Queries', 1100, 'sql-04-indices', 'Entendendo B-Trees, EXPLAIN QUERY PLAN e WITHOUT ROWID.', 4, 'https://cdn.lms.com/videos/sql4.mp4', 0, CURRENT_TIMESTAMP),

-- Curso 3: JS & Node (4 Aulas)
(9, 3, 'Fundamentos do ES6+', 750, 'js-01-es6', 'Arrow functions, destructuring e módulos ES.', 1, 'https://cdn.lms.com/videos/js1.mp4', 1, CURRENT_TIMESTAMP),
(10, 3, 'Programação Assíncrona com Async/Await', 1300, 'js-02-async', 'Promises, event loop e manipulação de requisições.', 2, 'https://cdn.lms.com/videos/js2.mp4', 0, CURRENT_TIMESTAMP),
(11, 3, 'Criando APIs com Fastify/Express', 1800, 'js-03-apis', 'Rotas, middlewares e tratamento de erros.', 3, 'https://cdn.lms.com/videos/js3.mp4', 0, CURRENT_TIMESTAMP),
(12, 3, 'Autenticação JWT e Segurança', 1600, 'js-04-jwt', 'Implementando tokens de acesso e rotas protegidas.', 4, 'https://cdn.lms.com/videos/js4.mp4', 0, CURRENT_TIMESTAMP),

-- Curso 4: UX/UI (3 Aulas)
(13, 4, 'Fundamentos de Visual Design', 900, 'ux-01-fundamentos', 'Cores, tipografia e hierarquia visual.', 1, 'https://cdn.lms.com/videos/ux1.mp4', 1, CURRENT_TIMESTAMP),
(14, 4, 'Design Systems e Componentes', 1400, 'ux-02-design-systems', 'Criando componentes reutilizáveis no Figma.', 2, 'https://cdn.lms.com/videos/ux2.mp4', 0, CURRENT_TIMESTAMP),
(15, 4, 'Acessibilidade Web (WCAG)', 1100, 'ux-03-acessibilidade', 'Tornando interfaces acessíveis para todos.', 3, 'https://cdn.lms.com/videos/ux3.mp4', 0, CURRENT_TIMESTAMP),

-- Curso 5: Git (3 Aulas)
(16, 5, 'Primeiros Passos com Git', 600, 'git-01-primeiros-passos', 'Comandos básicos: init, add, commit e status.', 1, 'https://cdn.lms.com/videos/git1.mp4', 1, CURRENT_TIMESTAMP),
(17, 5, 'Trabalhando com Branches e Merge', 1000, 'git-02-branches', 'Isolando funcionalidades e resolvendo conflitos.', 2, 'https://cdn.lms.com/videos/git2.mp4', 0, CURRENT_TIMESTAMP),
(18, 5, 'Gitflow e Pull Requests no GitHub', 1200, 'git-03-github-flow', 'Colaboração em equipe e revisão de código.', 3, 'https://cdn.lms.com/videos/git3.mp4', 0, CURRENT_TIMESTAMP);

-- ENROLLMENTS
INSERT INTO "enrollments" ("user_id", "course_id", "enrolled", "completed") VALUES
(2, 1, '2026-01-10 10:00:00', NULL),
(2, 2, '2026-01-16 09:00:00', NULL),
(2, 5, '2026-02-01 11:20:00', NULL),
(3, 1, '2026-01-12 15:00:00', NULL),
(3, 3, '2026-02-05 18:00:00', NULL),
(4, 1, '2026-02-10 08:30:00', NULL),
(4, 2, '2026-02-11 14:00:00', NULL),
(4, 4, '2026-02-15 16:45:00', NULL),
(6, 5, '2026-02-18 10:00:00', NULL),
(7, 4, '2026-02-20 13:10:00', NULL);

-- LESSONS_COMPLETED
INSERT INTO "lessons_completed" ("user_id", "lesson_id", "course_id", "completed") VALUES
-- Carlos completou o Curso 1 (Python)
(2, 1, 1, '2026-01-10 11:00:00'),
(2, 2, 1, '2026-01-11 15:30:00'),
(2, 3, 1, '2026-01-13 18:00:00'),
(2, 4, 1, '2026-01-15 14:30:00'),

-- Carlos fez algumas aulas do Curso 2 (SQL)
(2, 5, 2, '2026-01-17 10:15:00'),
(2, 6, 2, '2026-01-19 16:40:00'),

-- Beatrys fez algumas aulas do Curso 1 (Python)
(3, 1, 1, '2026-01-13 10:00:00'),
(3, 2, 1, '2026-01-14 11:20:00'),

-- Beatrys completou o Curso 3 (JavaScript)
(3, 9, 3, '2026-02-06 19:10:00'),
(3, 10, 3, '2026-02-09 21:00:00'),
(3, 11, 3, '2026-02-14 15:30:00'),
(3, 12, 3, '2026-02-20 20:00:00'),

-- Diego fez aula inicial do Curso 1 e Curso 2
(4, 1, 1, '2026-02-10 09:30:00'),
(4, 5, 2, '2026-02-12 15:10:00'),

-- Fernando completou o Curso 5 (Git)
(6, 16, 5, '2026-02-19 11:00:00'),
(6, 17, 5, '2026-02-21 14:20:00'),
(6, 18, 5, '2026-02-25 11:15:00'),

-- Gabriela fez aula 1 de UX/UI
(7, 13, 4, '2026-02-21 10:00:00');

-- SESSIONS
INSERT INTO "sessions" ("token", "user_id", "ip", "init", "expires") VALUES
('tok_sess_carlos_01', 2, '192.168.1.15', STRFTIME('%s', 'NOW', '-2 hours'), STRFTIME('%s', 'NOW', '+7 days')),
('tok_sess_beatrys_01', 3, '200.150.10.5', STRFTIME('%s', 'NOW', '-1 day'), STRFTIME('%s', 'NOW', '+6 days')),
('tok_sess_diego_01', 4, '187.32.110.45', STRFTIME('%s', 'NOW', '-3 hours'), STRFTIME('%s', 'NOW', '+7 days')),
('tok_sess_ana_01', 1, '177.12.80.22', STRFTIME('%s', 'NOW', '-10 minutes'), STRFTIME('%s', 'NOW', '+7 days')),
('tok_sess_fernando_01', 6, '189.44.12.8', STRFTIME('%s', 'NOW', '-4 days'), STRFTIME('%s', 'NOW', '+3 days')),
('tok_sess_gabriela_01', 7, '201.88.99.12', STRFTIME('%s', 'NOW', '-30 minutes'), STRFTIME('%s', 'NOW', '+7 days'));

-- PASSWORD_RESETS
INSERT INTO "password_resets" ("token", "user_id", "ip", "init", "expires") VALUES
('tok_reset_101', 3, '200.150.10.5', STRFTIME('%s', 'NOW', '-2 hours'), STRFTIME('%s', 'NOW', '+1 hour')),
('tok_reset_102', 4, '187.32.110.45', STRFTIME('%s', 'NOW', '-5 hours'), STRFTIME('%s', 'NOW', '-4 hours')),
('tok_reset_103', 6, '189.44.12.8', STRFTIME('%s', 'NOW', '-1 day'), STRFTIME('%s', 'NOW', '-23 hours')),
('tok_reset_104', 7, '201.88.99.12', STRFTIME('%s', 'NOW', '-10 minutes'), STRFTIME('%s', 'NOW', '+50 minutes')),
('tok_reset_105', 2, '192.168.1.15', STRFTIME('%s', 'NOW', '-3 days'), STRFTIME('%s', 'NOW', '-2 days'));