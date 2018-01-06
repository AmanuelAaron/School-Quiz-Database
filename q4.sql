SET SEARCH_PATH TO quizschema;
drop table if exists q4 cascade;

create table q4(
sID varchar(10),
questionID INT,
questionText text
);

DROP VIEW IF EXISTS higgins_quiz CASCADE;
DROP VIEW IF EXISTS test_responses CASCADE;
DROP VIEW IF EXISTS test_takers CASCADE;
DROP VIEW IF EXISTS test_taker_questions CASCADE;
DROP VIEW IF EXISTS unaswered CASCADE;
DROP VIEW IF EXISTS unanswered_with_text CASCADE;

CREATE VIEW higgins_quiz AS
SELECT *
FROM quiz_questions
WHERE quiz_questions.quizID='Pr1-220310';

CREATE VIEW test_responses AS
SELECT takes.sID, response.questionID
FROM response, takes, quiz
WHERE response.sID=takes.sID and takes.classID=quiz.classID and response.quizID=quiz.id;

CREATE VIEW test_takers AS
SELECT takes.sID
FROM takes, quiz
WHERE takes.classID=quiz.classID;

CREATE VIEW test_taker_questions AS
SELECT *
FROM higgins_quiz,test_takers;

CREATE VIEW unanswered AS
SELECT test_taker_questions.*
FROM test_taker_questions LEFT JOIN test_responses ON test_taker_questions.sID=test_responses.sID and test_taker_questions.questionID=test_responses.questionID
WHERE test_responses.questionID IS NULL;

CREATE VIEW unanswered_with_text AS
SELECT *
FROM unanswered JOIN question ON question.id=unanswered.questionID;

insert into q4 select sID, questionID, left(questionText, 50) from unanswered_with_text;

select * from q4;
