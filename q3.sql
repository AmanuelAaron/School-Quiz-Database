SET SEARCH_PATH TO quizschema;
drop table if exists q3 cascade;

create table q3(
id varchar(50),
lastName varchar(50),
grade float
);

DROP VIEW IF EXISTS higgins_quiz_weight CASCADE;
DROP VIEW IF EXISTS correct_response CASCADE;
DROP VIEW IF EXISTS correct_response_weight CASCADE;
DROP VIEW IF EXISTS marks CASCADE;
DROP VIEW IF EXISTS grade CASCADE;
DROP VIEW IF EXISTS grade_and_last_name CASCADE;

-- Get the weight of the quiz
CREATE VIEW higgins_quiz_weight AS
SELECT sum(weight)
FROM quiz_questions
WHERE quiz_questions.quizID='Pr1-220310';

-- Get all the responses that were correct for that quiz
CREATE VIEW correct_response AS
SELECT response.sID, response.questionID
FROM response JOIN answers ON answers.id=response.answerID
WHERE quizID='Pr1-220310' and correct;

-- Get the weight for the questions that were answered correctly
CREATE VIEW correct_response_weight AS
SELECT correct_response.sID, correct_response.questionID, quiz_questions.weight
FROM correct_response NATURAL JOIN quiz_questions;

-- Add up the weight for the questions that each student got correct
CREATE VIEW marks AS
SELECT sID, sum(weight)
FROM correct_response_weight
GROUP BY sID;

-- Calculate the grade for each student
CREATE VIEW grade AS
SELECT sID, CAST(sum as float)/cast((select * from higgins_quiz_weight) as float) as grade
FROM marks;

-- Get the last name for each student
CREATE VIEW grade_and_last_name AS
SELECT id, lastName, grade
FROM grade JOIN student ON grade.sID=student.id;

insert into q3 select * from grade_and_last_name;

select * from q3;
