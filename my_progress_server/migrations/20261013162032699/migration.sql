BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "daily_log" (
    "id" bigserial PRIMARY KEY,
    "subtopicId" bigint NOT NULL,
    "date" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "field" (
    "id" bigserial PRIMARY KEY,
    "subtopicId" bigint NOT NULL,
    "name" text NOT NULL,
    "type" text NOT NULL,
    "position" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "field_value" (
    "id" bigserial PRIMARY KEY,
    "dailyLogId" bigint NOT NULL,
    "fieldId" bigint NOT NULL,
    "value" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "subtopic" (
    "id" bigserial PRIMARY KEY,
    "topicId" bigint NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "topic" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text,
    "createdAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR my_progress
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('my_progress', '20261013162032699', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261013162032699', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
