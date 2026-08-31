-- database: ../lms.sqlite

-- atualiza os cursos com adicao, delecao ou alteracao de aulas
CREATE TRIGGER "trg_adds_new_lesson"
AFTER INSERT ON "lessons"
BEGIN
    UPDATE "courses"
    SET lessons_count = lessons_count + 1,
        total_duration = total_duration + NEW.duration
    WHERE id = NEW.course_id;
END;

CREATE TRIGGER "trg_deletes_lesson"
AFTER DELETE ON "lessons"
BEGIN
    UPDATE "courses"
    SET lessons_count = lessons_count - 1,
        total_duration = total_duration - OLD.duration
    WHERE id = OLD.course_id;
END;

CREATE TRIGGER "trg_update_lesson"
AFTER UPDATE OF "duration" ON "lessons"
WHEN OLD.duration != NEW.duration
BEGIN
    UPDATE "courses"
    SET total_duration = total_duration - OLD.duration + NEW.duration
    WHERE id = NEW.course_id;
END;

-- atualiza o updated do users, courses e lessons
CREATE TRIGGER "trg_users_update_timestamp"
AFTER UPDATE ON "users"
WHEN OLD.updated = NEW.updated -- Só roda se o campo 'updated' não foi alterado na query original
BEGIN
    UPDATE "users" SET updated = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

CREATE TRIGGER "trg_course_update_timestamp"
AFTER UPDATE ON "courses"
WHEN OLD.updated = NEW.updated -- Só roda se o campo 'updated' não foi alterado na query original
BEGIN
    UPDATE "courses" SET updated = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

CREATE TRIGGER "trg_lesson_update_timestamp"
AFTER UPDATE ON "lessons"
WHEN OLD.updated = NEW.updated -- Só roda se o campo 'updated' não foi alterado na query original
BEGIN
    UPDATE "lessons" SET updated = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

CREATE TRIGGER "trg_update_courses_on_lessons_insert"
AFTER INSERT ON "lessons"
BEGIN
    UPDATE "courses" SET updated = CURRENT_TIMESTAMP WHERE id = NEW.course_id AND updated != CURRENT_TIMESTAMP;
END;

CREATE TRIGGER "trg_update_users_on_password_change"
AFTER INSERT ON "password_resets"
BEGIN
    UPDATE "users" SET updated = CURRENT_TIMESTAMP WHERE id = NEW.user_id AND updated != CURRENT_TIMESTAMP;
END;

-- atualiza a matricula no curso
CREATE TRIGGER "trg_autocomplete_enrollment"
AFTER INSERT ON "lessons_completed"
BEGIN 
    UPDATE "enrollments"
    SET completed = CURRENT_TIMESTAMP
    WHERE user_id = NEW.user_id
      AND course_id = NEW.course_id
      AND completed IS NULL
      AND (
        SELECT COUNT(*) FROM "lessons_completed"
        WHERE user_id = NEW.user_id AND course_id = NEW.course_id
      ) = (
        SELECT lessons_count FROM "courses" WHERE id = NEW.course_id
      );
END;

-- por cascata, com a finalizacao de um curso e atualizacao da matricula, vem a emissao de certificado automatica
CREATE TRIGGER "trg_autoissue_certificate"
AFTER UPDATE OF completed ON "enrollments"
WHEN OLD.completed IS NULL AND NEW.completed IS NOT NULL
BEGIN
    INSERT INTO certificates (user_id, course_id, completed)
    VALUES (NEW.user_id, NEW.course_id, NEW.completed);
END;

-- impede que um usuário conclua uma aula de um curso que ele não tem acesso
CREATE TRIGGER trg_prevent_unenrolled_completion
BEFORE INSERT ON lessons_completed
BEGIN
    SELECT RAISE(ABORT, 'Erro: O usuário não está matriculado neste curso.')
    WHERE NOT EXISTS (
        SELECT 1 FROM enrollments 
        WHERE user_id = NEW.user_id AND course_id = NEW.course_id
    );
END;