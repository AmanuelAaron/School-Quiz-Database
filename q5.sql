SET SEARCH_PATH TO quizschema;
drop table if exists q5 cascade;

create table q5(
questionID INT,
correct INT,
incorrect INT,
unanswered INT
);

DROP VIEW IF EXISTS higgins_quiz CASCADE;
DROP VIEW IF EXISTS test_responses CASCADE;
DROP VIEW IF EXISTS test_takers CASCADE;
DROP VIEW IF EXISTS test_taker_questions CASCADE;
DROP VIEW IF EXISTS unaswered CASCADE;
DROP VIEW IF EXISTS unanswered_count CASCADE;
DROP VIEW IF EXISTS correct_count CASCADE;
DROP VIEW IF EXISTS incorrect_count CASCADE;
DROP VIEW IF EXISTS total_count CASCADE;

-- THIS IS THE QUERY FROM Q4(it gets the questions that a student didn't answer)
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- THE REST IS NEW STUFF
-- For each question, get the number of students that haven't answered
CREATE VIEW unanswered_count AS
SELECT questionID, count(*) as unanswered
FROM unanswered
GROUP BY questionID;

-- For each question, get the number fo students that have answered correctly
CREATE VIEW correct_count AS
SELECT response.questionID, count(*) as correct
FROM response JOIN answers ON answers.id=response.answerID
WHERE quizID='Pr1-220310' and correct
GROUP BY response.questionID;

-- For each question, get the number fo students that have answered incorrectly
CREATE VIEW incorrect_count AS
SELECT response.questionID, count(*) as incorrect
FROM response JOIN answers ON answers.id=response.answerID
WHERE quizID='Pr1-220310' and (not correct)
GROUP BY response.questionID;

-- Combine all 3
insert into q5 SELECT * FROM correct_count NATURAL JOIN incorrect_count NATURAL JOIN unanswered_count;

select * from q5;
