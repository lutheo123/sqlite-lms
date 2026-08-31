-- database: ../lms.sqlite

-- tabela que armazena os usuarios, seus niveis de acesso e informacoes pessoais, assim como a data de criacao e ultima atualizacao da conta
CREATE TABLE "users" (
    "id" INTEGER NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL COLLATE NOCASE UNIQUE,
    "password" TEXT NOT NULL,
    "username" TEXT NOT NULL UNIQUE,
    "access_level" TEXT NOT NULL DEFAULT 'student' CHECK ("access_level" IN ('student', 'admin', 'editor')),
    "created" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
) STRICT;

-- tabela de cursos com duracao, descricao, slug no site, numero de aulas e duracao total
CREATE TABLE "courses" (
    "id" INTEGER NOT NULL PRIMARY KEY,
    "author_id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "slug" TEXT NOT NULL COLLATE NOCASE UNIQUE,
    "description" TEXT NOT NULL,
    "lessons_count" INTEGER NOT NULL DEFAULT 0,
    "total_duration" INTEGER NOT NULL DEFAULT 0,
    "created" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY ("author_id") REFERENCES "users" ("id")
) STRICT;

-- tabela das aulas contendo titulo, duracao, descricao, a ordem dentro do curso, link/path para o video e se ele eh disponibilizado de gracao ou nao
CREATE TABLE "lessons" (
    "id" INTEGER NOT NULL PRIMARY KEY,
    "course_id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "duration" INTEGER NOT NULL,
    "slug" TEXT NOT NULL COLLATE NOCASE UNIQUE,
    "description" TEXT,
    "lesson_order" INTEGER NOT NULL,
    "video" TEXT NOT NULL,
    "free" INTEGER NOT NULL DEFAULT 0 CHECK ("free" IN (0, 1)),
    "created" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY ("course_id") REFERENCES "courses" ("id"),
    UNIQUE ("course_id", "slug"),
    UNIQUE ("course_id", "lesson_order")
) STRICT;

-- tabela de controle das licoes concluidas por usuario por curso
CREATE TABLE "lessons_completed" (
    "user_id" INTEGER NOT NULL,
    "lesson_id" INTEGER NOT NULL,
    "course_id" INTEGER NOT NULL,
    "completed" TEXT NOT NULL,

    PRIMARY KEY ("user_id", "lesson_id", "course_id"),
    FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE, 
    FOREIGN KEY ("lesson_id") REFERENCES "lessons" ("id"),
    FOREIGN KEY ("course_id") REFERENCES "courses" ("id")
) WITHOUT ROWID, STRICT;

-- tabela de controle dos certificados emitidos peo site
CREATE TABLE "certificates" (
    "id" TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
    "user_id" INTEGER NOT NULL,
    "course_id" INTEGER NOT NULL,
    "completed" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,

    UNIQUE ("user_id", "course_id"),
    FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE,
    FOREIGN KEY ("course_id") REFERENCES "courses" ("id")
) WITHOUT ROWID, STRICT;

-- tabela que guarda as sessoes de log in de cada usuario
CREATE TABLE "sessions" (
    "token" TEXT PRIMARY KEY,
    "user_id" INTEGER NOT NULL,
    "ip" TEXT NOT NULL,
    "init" INTEGER NOT NULL DEFAULT (STRFTIME('%s', 'NOW')),
    "expires" INTEGER NOT NULL DEFAULT (STRFTIME('%s', 'NOW', '+7 days'))
) WITHOUT ROWID, STRICT;

-- tabela que guarda as sessoes de log in de cada usuario
CREATE TABLE "password_resets" (
    "token" TEXT PRIMARY KEY,
    "user_id" INTEGER NOT NULL,
    "ip" TEXT NOT NULL,
    "init" INTEGER NOT NULL DEFAULT (STRFTIME('%s', 'NOW')),
    "expires" INTEGER NOT NULL
) WITHOUT ROWID, STRICT;

-- tabela das matriculas em cada curso, controlando o acesso da cada usuario aos cursos
CREATE TABLE "enrollments" (
    "user_id" INTEGER NOT NULL,
    "course_id" INTEGER NOT NULL,
    "enrolled" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completed" TEXT, -- back-end preenche quando o aluno completa o curso

    PRIMARY KEY ("user_id", "course_id"),
    FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE,
    FOREIGN KEY ("course_id") REFERENCES "courses" ("id")
) WITHOUT ROWID, STRICT;