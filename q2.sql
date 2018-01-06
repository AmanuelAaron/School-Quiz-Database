SET SEARCH_PATH TO quizschema;
drop table if exists q2 cascade;

create table q2(
id INT,
questionText text,
count INT
);

DROP VIEW IF EXISTS answer_hints CASCADE;
DROP VIEW IF EXISTS question_hint_count CASCADE;
DROP VIEW IF EXISTS question_hint_count_all CASCADE;
DROP VIEW IF EXISTS final CASCADE;

-- Get all the answers that have hints
CREATE VIEW answer_hints AS
SELECT hints.id as hint, answers.id, answers.answer, answers.questionID
FROM answers, hints
WHERE answers.id=hints.answerID;

-- Count the number of total hints for each question based on the number of answers that have hints for that question
CREATE VIEW question_hint_count AS
SELECT question.id, question.questionText,count(*) as ocount
FROM answer_hints, question
WHERE answer_hints.questionID=question.id
GROUP BY question.id;

-- Get the info for the questions that don't have hints since the previous query doesn't include those
CREATE VIEW question_hint_count_all AS
SELECT question.id, question.questionText, question_hint_count.ocount, question.type
FROM question LEFT JOIN question_hint_count ON question.id=question_hint_count.id;

-- All the true/false questions should have null in there count
CREATE VIEW TrueFalseNull AS
SELECT id, questionText,
	CASE
		WHEN type = 'T' THEN NULL
		WHEN type != 'T' AND ocount IS NULL THEN 0
		ELSE ocount
	END as count
FROM question_hint_count_all;

-- Truncate the question text and put it into our table
insert into q2 select id, left(questionText, 50), count from TrueFalseNull;

select * from q2;
