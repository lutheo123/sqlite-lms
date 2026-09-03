-- database: ../lms.sqlite

PRAGMA foreign_keys = 1; -- habilita chaves estrangeiras
PRAGMA journal_mode = WAL; -- configuracao que permite maior quantidade de leitores/editores no banco de dados ao mesmo tempo
PRAGMA synchronous = NORMAL; -- define a forma que o SQLite sincroniza informacoes no disco
PRAGMA busy_timeout = 5000; -- maximo de tempo que uma conexao pode demorar a acontecer
PRAGMA cache_size = 2000; -- tamanho do cache
PRAGMA temp_store = memory; -- armazenamento de indices e tabelas temporarias
PRAGMA optimize; -- uma vez por dia ou quando criar index novo