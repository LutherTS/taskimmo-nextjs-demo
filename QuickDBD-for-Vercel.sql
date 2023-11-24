-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

CREATE TABLE Users (
    user_id varchar(200)  NOT NULL ,
    user_username varchar(200)  NOT NULL ,
    user_app_wide_name varchar(200)  NOT NULL ,
    user_full_name varchar(200)  NOT NULL ,
    user_email varchar(200)  NOT NULL ,
    user_password varchar(200)  NOT NULL ,
    PRIMARY KEY (
        user_id
    )
);

CREATE TYPE state AS ENUM ('NONE', 'ONGOING', 'COMPLETED', 'CANCELED');

CREATE TABLE Projects (
    project_id varchar(200)  NOT NULL ,
    user_id varchar(200) REFERENCES users  NOT NULL ,
    project_name varchar(200)  NOT NULL ,
    project_start_date date  NOT NULL ,
    project_end_date date  NOT NULL ,
    project_state state  NOT NULL ,
    PRIMARY KEY (
        project_id
    )
);

CREATE TABLE Categories (
    category_id varchar(200)  NOT NULL ,
    category_name varchar(200)  NOT NULL ,
    PRIMARY KEY (
        category_id
    )
);

CREATE TABLE Tasks (
    task_id varchar(200)  NOT NULL ,
    project_id varchar(200) REFERENCES projects  NOT NULL ,
    category_id varchar(200) REFERENCES categories  NOT NULL ,
    task_name varchar(200)  NOT NULL ,
    task_start_date date  NOT NULL ,
    task_end_date date  NOT NULL ,
    task_state state  NOT NULL ,
    PRIMARY KEY (
        task_id
    )
);

CREATE TYPE type AS ENUM ('NONE', 'COMPANY', 'FRIEND', 'FAMILY');

CREATE TABLE Associates (
    associate_id varchar(200)  NOT NULL ,
    associate_app_wide_name varchar(200)  NOT NULL ,
    associate_full_name varchar(200)  NOT NULL ,
    associate_core_type type  NOT NULL ,
    PRIMARY KEY (
        associate_id
    )
);

CREATE TABLE TaskAssociates (
    taskassociate_id varchar(200)  NOT NULL ,
    task_id varchar(200) REFERENCES tasks  NOT NULL ,
    associate_id varchar(200) REFERENCES associates  NOT NULL ,
    taskassociate_current_type type NOT NULL ,
    PRIMARY KEY (
        taskassociate_id
    )
);

-- Test rapide de la structure des pages via le NextJS App Router
-- Pas besoin de page projets, ils seront sur dashboard.

-- app
---- signup
------ page.tsx
---- signin
------ page.tsx
---- dashboard
------ (overview)
-------- page.tsx
------ projects
-------- [projectid]
---------- tasks
------------ [taskid]
-------------- page.tsx
---------- page.tsx 

-- "Simpler file structure"

-- app
---- (pages)
------ signup
-------- page.tsx
------ signin
-------- page.tsx
------ users
-------- [username]
---------- dashboard
------------ (overview)
-------------- page.tsx
---------- projects
------------ [projectid]
-------------- page.tsx
---------- tasks
------------ [taskid]
-------------- page.tsx

-- Liste des données

INSERT INTO Users
VALUES ('987af2a5-aa97-45ac-9e30-0b3b49e2720c', 'emilie-alt', 'Émilie', 'Émilie Clément', 'e@e.com', '123456');

INSERT INTO Projects
VALUES ('a61fe02f-c260-4128-bc37-e0cdf7910a23', '987af2a5-aa97-45ac-9e30-0b3b49e2720c', 'Le Projet d’Émilie', now(), now(), 'ONGOING');

INSERT INTO Categories
VALUES ('e1d6d831-6533-43c0-b3bd-9db9dc118d59', 'Carrelage');

INSERT INTO Categories
VALUES ('ccc45a8c-1cf6-4c07-959f-ca9557ed316a', 'Peinture');

INSERT INTO Categories
VALUES ('bc1310bc-8510-4452-a09f-bc6a8dca9de8', 'Maçonnerie');

INSERT INTO Tasks
VALUES ('2abd64b9-e8ac-4b33-9fe8-24a597026ea8', 'a61fe02f-c260-4128-bc37-e0cdf7910a23', 'e1d6d831-6533-43c0-b3bd-9db9dc118d59', 'Tâche Une', now(), now(), 'ONGOING');

INSERT INTO Tasks
VALUES ('deb9d70d-18ed-483d-ae77-c1caa1dbe33d', 'a61fe02f-c260-4128-bc37-e0cdf7910a23', 'ccc45a8c-1cf6-4c07-959f-ca9557ed316a', 'Tâche Deux', now(), now(), 'COMPLETED');

INSERT INTO Tasks
VALUES ('e6bfefb7-7b3d-4ef2-86d7-798552b3444a', 'a61fe02f-c260-4128-bc37-e0cdf7910a23', 'bc1310bc-8510-4452-a09f-bc6a8dca9de8', 'Tâche Trois', now(), now(), 'CANCELED');

INSERT INTO Associates
VALUES ('e68ff5ef-5847-47cf-bb5d-d8594598ccc8', 'CSB', 'Carrelage Saint-Brieuc', 'COMPANY');

INSERT INTO Associates
VALUES ('3f6dc322-5a88-48a5-baeb-c985c1495301', 'Florian', 'Florian Forliani', 'FRIEND');

INSERT INTO Associates
VALUES ('1e993990-474f-4a36-838a-25db7765c32f', 'Anthony', 'Anthony Rieux', 'FAMILY');

INSERT INTO TaskAssociates
VALUES ('0808483d-172b-4c92-bd3a-a20845055f35', '2abd64b9-e8ac-4b33-9fe8-24a597026ea8', 'e68ff5ef-5847-47cf-bb5d-d8594598ccc8', 'COMPANY');

INSERT INTO TaskAssociates
VALUES ('1d686f85-bcea-4f8e-ba36-b79b1ba2b53a', '2abd64b9-e8ac-4b33-9fe8-24a597026ea8', '3f6dc322-5a88-48a5-baeb-c985c1495301', 'FRIEND');

INSERT INTO TaskAssociates
VALUES ('f1a0fda3-f744-421f-8b8b-451b709f1024', '2abd64b9-e8ac-4b33-9fe8-24a597026ea8', '1e993990-474f-4a36-838a-25db7765c32f', 'COMPANY');

-- Liste des requêtes

SELECT * FROM users; -- #1

SELECT * FROM projects; -- #2

SELECT * FROM projects
JOIN users ON projects.user_id = users.user_id; -- #3

SELECT * FROM categories; -- #4

SELECT * FROM tasks; -- #5

SELECT * FROM tasks
JOIN projects ON tasks.project_id = projects.project_id
JOIN categories ON tasks.category_id = categories.category_id; -- #6

SELECT * FROM tasks
JOIN projects ON tasks.project_id = projects.project_id
JOIN categories ON tasks.category_id = categories.category_id
JOIN users ON projects.user_id = users.user_id; -- #7

SELECT * FROM associates; -- #8

SELECT * FROM taskassociates; -- #9

SELECT * FROM taskassociates
JOIN tasks ON taskassociates.task_id = tasks.task_id
JOIN associates ON taskassociates.associate_id = associates.associate_id; -- #10

SELECT * FROM taskassociates
JOIN tasks ON taskassociates.task_id = tasks.task_id
JOIN associates ON taskassociates.associate_id = associates.associate_id
JOIN projects ON tasks.project_id = projects.project_id; -- #11

SELECT * FROM taskassociates
JOIN tasks ON taskassociates.task_id = tasks.task_id
JOIN associates ON taskassociates.associate_id = associates.associate_id
JOIN projects ON tasks.project_id = projects.project_id
JOIN users ON projects.user_id = users.user_id; -- #12

-- Schéma de base de données originale au format QuickDBD (tout en commentaires)

-- User
-- -
-- UserID varchar(200) PK
-- Username varchar(200)
-- AppWideName varchar(200)
-- FullName varchar(200)
-- Email varchar(200)
-- Password varchar(200)

-- Project
-- - 
-- ProjectID varchar(200) PK
-- UserID varchar(200) FK >- User.UserID
-- Name varchar(200)
-- StartDate date
-- EndDate date
-- State enum('NONE','ONGOING','COMPLETED','CANCELED')

-- Task
-- -
-- TaskID varchar(200) PK
-- ProjectID varchar(200) FK >- Project.ProjectID
-- CategoryID varchar(200) FK >- Category.CategoryID
-- Name varchar(200)
-- StartDate date
-- EndDate date
-- State enum('NONE','ONGOING','COMPLETED','CANCELED')

-- Category
-- -
-- CategoryID varchar(200) PK
-- Name varchar(200)

-- Associate
-- - 
-- AssociateID varchar(200) PK
-- AppWideName varchar(200)
-- FullName varchar(200)
-- CoreType enum('NONE','COMPANY','FRIEND','FAMILY')

-- TaskAssociate
-- -
-- TaskAssociateID varchar(200) PK
-- TaskID varchar(200) FK >- Task.TaskID
-- AssociateID varchar(200) FK >- Associate.AssociateID
-- CurrentType enum('NONE','COMPANY','FRIEND','FAMILY')

-- Liens utiles

-- https://app.quickdatabasediagrams.com/#/
-- https://www.db-fiddle.com/f/5aexSLZhoqBHKRf1xNbuFp/3
-- http://localhost:3000/
-- http://localhost:3000/signin
-- http://localhost:3000/signup
-- http://localhost:3000/dashboard
-- http://localhost:3000/dashboard/projects/blabla
-- http://localhost:3000/dashboard/projects/blabla/tasks/blablabla

-- Now that I think about it, next time I'll export as Postgres

