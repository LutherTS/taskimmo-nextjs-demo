-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

CREATE TABLE `User` (
    `UserID` varchar(200)  NOT NULL ,
    `Username` varchar(200)  NOT NULL ,
    `AppWideName` varchar(200)  NOT NULL ,
    `FullName` varchar(200)  NOT NULL ,
    `Email` varchar(200)  NOT NULL ,
    `Password` varchar(200)  NOT NULL ,
    PRIMARY KEY (
        `UserID`
    )
);

CREATE TABLE `Project` (
    `ProjectID` varchar(200)  NOT NULL ,
    `UserID` varchar(200)  NOT NULL ,
    `Name` varchar(200)  NOT NULL ,
    `StartDate` date  NOT NULL ,
    `EndDate` date  NOT NULL ,
    `State` enum('NONE','ONGOING','COMPLETED','CANCELED')  NOT NULL ,
    PRIMARY KEY (
        `ProjectID`
    )
);

CREATE TABLE `Task` (
    `TaskID` varchar(200)  NOT NULL ,
    `ProjectID` varchar(200)  NOT NULL ,
    `CategoryID` varchar(200)  NOT NULL ,
    `Name` varchar(200)  NOT NULL ,
    `StartDate` date  NOT NULL ,
    `EndDate` date  NOT NULL ,
    `State` enum('NONE','ONGOING','COMPLETED','CANCELED')  NOT NULL ,
    PRIMARY KEY (
        `TaskID`
    )
);

CREATE TABLE `Category` (
    `CategoryID` varchar(200)  NOT NULL ,
    `Name` varchar(200)  NOT NULL ,
    PRIMARY KEY (
        `CategoryID`
    )
);

CREATE TABLE `Associate` (
    `AssociateID` varchar(200)  NOT NULL ,
    `AppWideName` varchar(200)  NOT NULL ,
    `FullName` varchar(200)  NOT NULL ,
    `CoreType` enum('NONE','COMPANY','FRIEND','FAMILY')  NOT NULL ,
    PRIMARY KEY (
        `AssociateID`
    )
);

CREATE TABLE `TaskAssociate` (
    `TaskAssociateID` varchar(200)  NOT NULL ,
    `TaskID` varchar(200)  NOT NULL ,
    `AssociateID` varchar(200)  NOT NULL ,
    `CurrentType` enum('NONE','COMPANY','FRIEND','FAMILY')  NOT NULL ,
    PRIMARY KEY (
        `TaskAssociateID`
    )
);

ALTER TABLE `Project` ADD CONSTRAINT `fk_Project_UserID` FOREIGN KEY(`UserID`)
REFERENCES `User` (`UserID`);

ALTER TABLE `Task` ADD CONSTRAINT `fk_Task_ProjectID` FOREIGN KEY(`ProjectID`)
REFERENCES `Project` (`ProjectID`);

ALTER TABLE `Task` ADD CONSTRAINT `fk_Task_CategoryID` FOREIGN KEY(`CategoryID`)
REFERENCES `Category` (`CategoryID`);

ALTER TABLE `TaskAssociate` ADD CONSTRAINT `fk_TaskAssociate_TaskID` FOREIGN KEY(`TaskID`)
REFERENCES `Task` (`TaskID`);

ALTER TABLE `TaskAssociate` ADD CONSTRAINT `fk_TaskAssociate_AssociateID` FOREIGN KEY(`AssociateID`)
REFERENCES `Associate` (`AssociateID`);

-- Test rapide de la structure des pages via the NextJS App Router
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

-- Liste des données

INSERT INTO User
VALUES ('987af2a5-aa97-45ac-9e30-0b3b49e2720c', 'emilie-alt', 'Émilie', 'Émilie Clément', 'e@e.com', '123456');

INSERT INTO Project
VALUES ('a61fe02f-c260-4128-bc37-e0cdf7910a23', '987af2a5-aa97-45ac-9e30-0b3b49e2720c', 'Le Project d’Émilie', curdate(), curdate(), 'ONGOING');

INSERT INTO Category
VALUES ('e1d6d831-6533-43c0-b3bd-9db9dc118d59', 'Carrelage');

INSERT INTO Category
VALUES ('ccc45a8c-1cf6-4c07-959f-ca9557ed316a', 'Peinture');

INSERT INTO Category
VALUES ('bc1310bc-8510-4452-a09f-bc6a8dca9de8', 'Maçonnerie');

INSERT INTO Task
VALUES ('2abd64b9-e8ac-4b33-9fe8-24a597026ea8', 'a61fe02f-c260-4128-bc37-e0cdf7910a23', 'e1d6d831-6533-43c0-b3bd-9db9dc118d59', 'Tâche Une', curdate(), curdate(), 'ONGOING');

INSERT INTO Task
VALUES ('deb9d70d-18ed-483d-ae77-c1caa1dbe33d', 'a61fe02f-c260-4128-bc37-e0cdf7910a23', 'ccc45a8c-1cf6-4c07-959f-ca9557ed316a', 'Tâche Deux', curdate(), curdate(), 'COMPLETED');

INSERT INTO Task
VALUES ('e6bfefb7-7b3d-4ef2-86d7-798552b3444a', 'a61fe02f-c260-4128-bc37-e0cdf7910a23', 'bc1310bc-8510-4452-a09f-bc6a8dca9de8', 'Tâche Trois', curdate(), curdate(), 'CANCELED');

INSERT INTO Associate
VALUES ('e68ff5ef-5847-47cf-bb5d-d8594598ccc8', 'CSB', 'Carrelage Saint-Brieuc', 'COMPANY');

INSERT INTO Associate
VALUES ('3f6dc322-5a88-48a5-baeb-c985c1495301', 'Florian', 'Florian Forliani', 'FRIEND');

INSERT INTO Associate
VALUES ('1e993990-474f-4a36-838a-25db7765c32f', 'Anthony', 'Anthony Rieux', 'FAMILY');

INSERT INTO TaskAssociate
VALUES ('0808483d-172b-4c92-bd3a-a20845055f35', '2abd64b9-e8ac-4b33-9fe8-24a597026ea8', 'e68ff5ef-5847-47cf-bb5d-d8594598ccc8', 'COMPANY');

INSERT INTO TaskAssociate
VALUES ('1d686f85-bcea-4f8e-ba36-b79b1ba2b53a', '2abd64b9-e8ac-4b33-9fe8-24a597026ea8', '3f6dc322-5a88-48a5-baeb-c985c1495301', 'FRIEND');

INSERT INTO TaskAssociate
VALUES ('f1a0fda3-f744-421f-8b8b-451b709f1024', '2abd64b9-e8ac-4b33-9fe8-24a597026ea8', '1e993990-474f-4a36-838a-25db7765c32f', 'COMPANY');

-- Liste des requêtes

SELECT * FROM User; -- #1
SELECT * FROM Project; -- #2
SELECT * FROM Category; -- #3
SELECT * FROM Task; -- #4
SELECT * FROM Associate; -- #5
SELECT * FROM TaskAssociate; -- #6
SELECT * FROM Project
WHERE UserID='987af2a5-aa97-45ac-9e30-0b3b49e2720c'; -- #7
SELECT * FROM Task
JOIN Category ON Task.CategoryID = Category.CategoryID; -- #8

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



