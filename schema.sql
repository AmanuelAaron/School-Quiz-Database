drop schema if exists quizschema cascade;
create schema quizschema;
set search_path to quizschema;

-- Represents the three types of quizzes(M = Multiple Choice, T= True/False, N=Numerical)
create domain TestType as varchar(2)
	default 'N'
	check (value in ('M','T','N'));

-- Represents every student in the database
create table student(
	id varchar(10) primary key check(id ~'^[0-9]+$'),
	-- First name of the student
	firstName varchar(50) NOT NULL,
	-- Last name of the student
	lastName varchar(50) NOT NULL
);

-- Represents each class in the database
create table class(
	id INT primary key,
	-- Class room
	room varchar(50) NOT NULL,
	-- Which grade the class is for
	grade varchar(50) NOT NULL,
	-- Teacher for the class
	teacher varchar(50) NOT NULL
);

-- Relation shows which student is taking which class
create table takes(
	-- Identifies the student
	sID varchar(10) references student,
	-- Identifies the class
	classID INT references class,
	unique (sID, classID)
);

-- Represents every question in the database
create table question(
	id INT primary key,
	-- The actual question
	questionText text NOT NULL,
	-- The correct answer to the question
	answer text NOT NULL,
	-- The question type(can be M,T or N)
	type TestType NOT NULL

);

-- Represents every quiz in the database
create table quiz(
	id varchar(100) primary key,
	-- The class that this quiz is for
	classID INT NOT NULL,
	-- True if and only if hints are allowed in this quiz
	hintsAllowed boolean NOT NULL,
	-- The date it is due
	dueDate date NOT NULL,
	-- The time it is due 
	duetime time NOT NULL,
	-- The title of the quiz
	title text NOT NULL

);

-- Relation shows which questions appear on which quiz and what their weight is
create table quiz_questions(
	-- Identifies the question
	questionID INT references question,
	-- Identifies the quiz
	quizID varchar(100) references quiz,
	-- weight of the question
	weight INT NOT NULL,
	unique (questionID, quizID)
);

-- Represents all the possible answers to every question
create table answers(
	id INT primary key,
	-- True if and only if the answer is correct
	correct boolean NOT NULL,
	-- The actual answer
	answer text NOT NULL,
	-- The question that this answer is for
	questionID INT references question
	
);

-- Represetns the all the hints for the answers for each question
create table hints(
	id INT primary key,
	-- The answer that the hint is for
	answerID INT references answers,
	-- The actual hint
	hint text NOT NULL
	
);

-- Every response to a question that a student has made on a quiz(if unanswered then not in this relation)
create table response(
	id INT primary key,
	-- ID of student that made this response
	sID varchar(10) references student,
	-- Question that they are responding to
	questionID INT references question(id),
	-- The response that they made
	answerID INT references answers,
	-- The quiz that the question is on
	quizID varchar(100) references quiz(id)
);

