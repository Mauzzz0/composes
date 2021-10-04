
CREATE TABLE IF NOT EXISTS "public"."Organization"
(
    "Id" integer NOT NULL UNIQUE,
    "Name" character varying(50) NOT NULL,
    "Tel" character varying(20),
    "Fax" character varying(50),
    "Address" character varying(100),
    "Email" character varying(50),
    "AlreadyClient" boolean NOT NULL,
    PRIMARY KEY ("Id")
);

COMMENT ON TABLE "public"."Organization"
    IS 'Таблица организации';

CREATE TABLE IF NOT EXISTS "public"."ContactPerson"
(
    "Id" integer NOT NULL UNIQUE,
    "OrganizationId" integer NOT NULL,
    "Name" character varying,
    "Surname" character varying,
    "Tel" character varying,
    "Email" character varying,
    PRIMARY KEY ("Id")
);

COMMENT ON TABLE "public"."ContactPerson"
    IS 'Таблица контактных лиц организаций';

CREATE TABLE IF NOT EXISTS "public"."Role"
(
    "Id" integer NOT NULL UNIQUE,
    "Name" character varying(50) NOT NULL,
    PRIMARY KEY ("Id", "Name")
);

COMMENT ON TABLE "public"."Role"
    IS 'Таблица ролей';

CREATE TABLE IF NOT EXISTS "public"."Employee"
(
    "Id" integer NOT NULL UNIQUE,
    "Nickname" character varying,
    "Password" character varying,
    "RoleId" integer,
    PRIMARY KEY ("Id")
);

COMMENT ON TABLE "public"."Employee"
    IS 'Таблица сотрудников';

CREATE TABLE IF NOT EXISTS "public"."Task"
(
    "Id" integer NOT NULL UNIQUE,
    "CreatedAt" timestamp without time zone,
    "EndedAt" timestamp without time zone,
    "Deadline" timestamp without time zone,
    "OwnerId" integer,
    "AssigneeId" integer,
    "OrganizationId" integer,
    "ContactPersonId" integer,
    "TypeId" integer,
    "PriorityId" integer,
    "Description" text,
    "AdditionalData" jsonb,
    "IsDone" boolean,
    PRIMARY KEY ("Id")
);

COMMENT ON TABLE "public"."Task"
    IS 'Таблица задач нашей компании';

CREATE TABLE IF NOT EXISTS "public"."TaskType"
(
    "Id" integer NOT NULL UNIQUE,
    "Name" character varying(50) NOT NULL,
    PRIMARY KEY ("Id", "Name")
);

COMMENT ON TABLE "public"."TaskType"
    IS 'Таблица типов дел';

CREATE TABLE IF NOT EXISTS "public"."Priority"
(
    "Id" integer NOT NULL UNIQUE,
    "Name" character varying(50) NOT NULL,
    PRIMARY KEY ("Id", "Name")
);

COMMENT ON TABLE "public"."Priority"
    IS 'Таблица приоритетов';

ALTER TABLE "public"."ContactPerson"
    ADD FOREIGN KEY ("OrganizationId")
    REFERENCES "public"."Organization" ("Id")
    NOT VALID;


ALTER TABLE "public"."Task"
    ADD FOREIGN KEY ("ContactPersonId")
    REFERENCES "public"."ContactPerson" ("Id")
    NOT VALID;


ALTER TABLE "public"."Employee"
    ADD FOREIGN KEY ("RoleId")
    REFERENCES "public"."Role" ("Id")
    NOT VALID;


ALTER TABLE "public"."Task"
    ADD FOREIGN KEY ("AssigneeId")
    REFERENCES "public"."Employee" ("Id")
    NOT VALID;


ALTER TABLE "public"."Task"
    ADD FOREIGN KEY ("OwnerId")
    REFERENCES "public"."Employee" ("Id")
    NOT VALID;


ALTER TABLE "public"."Task"
    ADD FOREIGN KEY ("OrganizationId")
    REFERENCES "public"."Organization" ("Id")
    NOT VALID;


ALTER TABLE "public"."Task"
    ADD FOREIGN KEY ("TypeId")
    REFERENCES "public"."TaskType" ("Id")
    NOT VALID;


ALTER TABLE "public"."Task"
    ADD FOREIGN KEY ("PriorityId")
    REFERENCES "public"."Priority" ("Id")
    NOT VALID;



create role Manager;
create role Worker;

create user manager1 in group manager;
create user worker1 in group worker;