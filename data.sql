insert into student values
('0998801234', 'Lena', 'Headey'),
('0010784522','Peter','Dinklage'),
('0997733991','Emilia','Clarke'),
('5555555555','Kit','Harrington'),
('1111111111','Sophie','Turner'),
('2222222222','Maisie','Williams');

insert into class values
(1,'room 120','grade 8','Mr Higgins'),
(2,'room 366','grade 5','Miss Nyers');

insert into takes values
('0998801234',1),
('0010784522',1),
('0997733991',1),
('5555555555',1),
('1111111111',1),
('2222222222',2);

insert into question values
(782,'What do you promise when you take the oath of citizenship?','To pledge your loyalty to the Sovereign, Queen Elizabeth II','M'),
(566,'The Prime Minister, Justin Trudeau, is Canada''s Head of State.','False','T'),
(601,'During the "Quiet Revolution," Quebec experienced rapid change. In what
decade did this occur? (Enter the year that began the decade, e.g., 1840.)','1960','N'),
(625,'What is the Underground Railroad?','A network used by slaves who escaped the United States into Canada','M'),
(790,'During the War of 1812 the Americans burned down the Parliament Buildings in
York (now Toronto). What did the British and Canadians do in return?','They burned down the White House in Washington D.C.','M');

insert into quiz values
('Pr1-220310', 1, true ,date '01/10/2017', time '1:30 pm','Citizenship Test Practise Questions');

insert into quiz_questions values
(601,'Pr1-220310', 2),
(566,'Pr1-220310', 1),
(790,'Pr1-220310', 3),
(625,'Pr1-220310', 2);

insert into answers values
(1,true,'To pledge your loyalty to the Sovereign, Queen Elizabeth II',782),
(2,false,'To pledge your allegiance to the flag and fulfill the duties of a Canadian',782),
(3,false,'To pledge your allegiance to the flag and fulfill the duties of a Canadian',782),
(4,false,'To pledge your loyalty to Canada from sea to sea',782),
(5,true,'False',566),
(6,false,'True',566),
(7,true,'1960',625),
(8,false,'1800-1900',601),
(9,false,'2000-2010',601),
(10,false,'2020-3000',601),
(11,true,'They burned down the White House in Washington D.C.',790),
(12,false,'They attacked American merchant ships',790),
(13,false,'They expanded their defence system, including Fort York',790),
(14,false,'They captured Niagara Falls',790),
(15,true,'A network used by slaves who escaped the United States into Canada',625),
(16,false,'The first railway to cross Canada',625),
(17, false, 'The CPR''s secret railway line',625),
(18, false, 'The TTC subway system',625);

insert into hints values
(1,3, 'Think regally.'),
(2,8, 'The Quiet Revolution happened during the 20th 
   Century.'),
(3,9, 'The Quiet Revolution happened some time ago.'),
(4,10, 'The Quiet Revolution has already happened!'),
(5,16,'The Underground Railroad was generally south to north, 
      not east-west.'),
(6,17,'The Underground Railroad was secret, but it had nothing to do 
      with trains.'),
(7,18,'The TTC is relatively recent; the Underground Railroad was 
      in operation over 100 years ago.');

insert into response values
(01,'0998801234',601,9,'Pr1-220310'),
(02,'0998801234',566,5,'Pr1-220310'),
(03,'0998801234',790,13,'Pr1-220310'),
(04,'0998801234',625,15,'Pr1-220310'),
(11,'0010784522',601,7,'Pr1-220310'),
(12,'0010784522',566,5,'Pr1-220310'),
(13,'0010784522',790,11,'Pr1-220310'),
(14,'0010784522',625,15,'Pr1-220310'),
(21,'0997733991',601,7,'Pr1-220310'),
(22,'0997733991',566,6,'Pr1-220310'),
(23,'0997733991',790,11,'Pr1-220310'),
(24,'0997733991',625,17,'Pr1-220310'),
(32,'5555555555',566,5,'Pr1-220310'),
(33,'5555555555',790,14,'Pr1-220310');
