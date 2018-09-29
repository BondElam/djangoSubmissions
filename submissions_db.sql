START TRANSACTION;
CREATE TABLE dispositions (
  disposition varchar(64) NOT NULL UNIQUE,
  disposition_id serial PRIMARY KEY
);
INSERT INTO dispositions VALUES('Rejected',1);
INSERT INTO dispositions VALUES('Sold',2);
INSERT INTO dispositions VALUES('Rework',3);
INSERT INTO dispositions VALUES('Submitted',4);
INSERT INTO dispositions VALUES('Available',5);
INSERT INTO dispositions VALUES('Withdrawn',6);
INSERT INTO dispositions VALUES('Unsure',7);
INSERT INTO dispositions VALUES('Needs Update',8);
CREATE TABLE publishers (
  publisher varchar(64) NOT NULL UNIQUE,
  publisher_id serial PRIMARY KEY,
  web_address varchar(256) DEFAULT NULL,
  min_words integer DEFAULT NULL,
  max_words integer DEFAULT NULL,
  remarks text
);
INSERT INTO publishers VALUES('Analog',1,'http://www.analogsf.com/contact-us/writers-guidelines/',NULL,NULL,'');
INSERT INTO publishers VALUES('F&SF',2,'https://www.sfsite.com/fsf/glines.htm',NULL,25000,'F&SF has no formula for fiction. The speculative element may be slight, but it should be present.');
INSERT INTO publishers VALUES('Azimov''s',3,'http://www.asimovs.com/contact-us/writers-guidelines/',1000,20000,'');
INSERT INTO publishers VALUES('Daily Science Fiction',4,'http://dailysciencefiction.com/submit/story/guidelines',100,1500,'We need short short fiction, especially flash fiction. Among our featured stories, a shorter tale will get an extra nudge on the scale when weighed against a longer one..');
INSERT INTO publishers VALUES('Strange Horizons',5,'http://www.strangehorizons.com/guidelines/fiction.php',0,10000,'Prefer under 5000 words. Opening to submissions March 6, 2017,');
INSERT INTO publishers VALUES('Clark''s World',6,'http://clarkesworldmagazine.com/submissions/',1000,16000,'Responds within 48 hours.');
INSERT INTO publishers VALUES('Interzone',7,'http://ttapress.com/interzone/guidelines/',NULL,10000,'UK magazine.');
INSERT INTO publishers VALUES('Alfred Hitchcock',8,'https://www.themysteryplace.com/ahmm/guidelines/',NULL,12000,'');
INSERT INTO publishers VALUES('Apex',9,'http://www.apex-magazine.com/submission-guidelines/',NULL,7500,'Currently open to submissoins. Takes about 30 days to respond.');
INSERT INTO publishers VALUES('Flash Fiction Online',10,'http://flashfictiononline.com/main/submission-guidelines/',500,1000,'No personal info in manuscript. Times Roman, not Courier. Automatic paragraph indents.');
INSERT INTO publishers VALUES('Fantastic Stories',11,'http://www.fantasticstoriesoftheimagination.com/submission-guidelines/',NULL,3000,'Closed to submissions 4/4/17.We want stories that cover the entire science fiction and fantasy spectrum. We love everything from magic realism to hard SF. We want a story to surprise us and to take us to unexpected places. We love word play, and would like to see stories with a literary bent, though decidedly not a pretentious bent.');
INSERT INTO publishers VALUES('Lightspeed Magazine',12,'http://www.lightspeedmagazine.com/about/guidelines/',1500,10000,'Accepts 1,500 to 10,000 words. Prefers under 5000 words. Open as of 4/24/17, but only to Fantasy, not Science Fiction.');
INSERT INTO publishers VALUES('Beneath Ceaseless Skys',13,'http://www.beneath-ceaseless-skies.com/submissions/',11000,NULL,'Secondary-World Setting: We want stories set in what Tolkien called a “secondary world”: some other world that is different from our own primary world in some way. It could be different in terms of zoology (non-human creatures), ecology (climate), or physical laws (the presence of magic). It could be set on Earth but an Earth different from our primary world in terms of time (the historical past) or history (alternate history). ');
INSERT INTO publishers VALUES('Terraform ',14,'http://motherboard.vice.com/read/how-to-submit-stories-to-terraform',NULL,2000,'We''re looking especially for nearer-future fiction; think a bit more along the lines of sentient chat bots or climate-changed dystopias and less far-flung alien space opera');
INSERT INTO publishers VALUES('Escape Pod',15,'http://escapepod.org/guidelines/',2000,6000,'We are fairly flexible on what counts as “science” (as we’ll delve into superheroes or steampunk on occasion) and are interested in exploring the range of the genre, but we are not looking for fantasy, magical realism, or more than a tinge of horror.  If your story isn’t centered on science, technology, future projections, alternate history, and how any or all of these things intersect with people, we’re probably not the right market for it.');
INSERT INTO publishers VALUES('Ellery Queen Mystery Magazine',16,'https://www.themysteryplace.com/eqmm/guidelines/',250,8000,'EQMM uses stories of almost every length. 2,500-8,000 words is the preferred range, but we occasionally use stories of up to 12,000 words and we feature one or two short novels (up to 20,000 words) each year, although these spaces are usually reserved for established writers. Shorter stories are also considered, including minute mysteries of as little as 250 words. Our rates for original stories are from 5 to 8 ¢ a word, sometimes higher for established authors.');
INSERT INTO publishers VALUES('Eric Miller',17,'raging@earthlink.net',2500,5000,'For a book to be titled 18 Wheels of Science Fiction');
INSERT INTO publishers VALUES('Allan Kaster',18,'http://www.audiotexttapes.net/',NULL,NULL,'atxtapes@gmail.comsold Chatter of Monkeys');
CREATE TABLE submissions (
  submission_id serial PRIMARY KEY,
  story varchar(45) DEFAULT NULL,
  word_count integer DEFAULT NULL,
  file varchar(25) DEFAULT NULL,
  date_submitted date DEFAULT NULL,
  disposition_date date DEFAULT NULL,
  publisher_id integer NOT NULL,
  disposition_id integer NOT NULL, 
  user_id integer NOT NULL,
  FOREIGN key(Publisher_id) references publishers(publisher_id),
  FOREIGN KEY(disposition_id) references dispositions(disposition_id),
  FOREIGN KEY(user_id) references users(id)
);
INSERT INTO submissions VALUES(1,'El Pajaro',NULL,'pajaro.010','1998-08-08','1998-08-08',1,1,1);
INSERT INTO submissions VALUES(2,'Birds of Prey',NULL,'colony.010','1999-06-29','1999-06-29',2,1,1);
INSERT INTO submissions VALUES(3,'El Pajaro',NULL,'pajaro.010','1999-06-29 ','1999-06-29',2,1,1);
INSERT INTO submissions VALUES(4,'Mariposa',NULL,'mariposa.010','1999-06-29','1999-06-29',2,1,1);
INSERT INTO submissions VALUES(5,'Birds of Prey',NULL,'colony.010','1999-07-15','1999-07-15',3,1,1);
INSERT INTO submissions VALUES(6,'El Pajaro',NULL,'pajaro.010','1999-07-15 ','1999-07-15',3,1,1);
INSERT INTO submissions VALUES(7,'Mariposa',NULL,'mariposa.010','1999-07-15','1999-07-15',3,1,1);
INSERT INTO submissions VALUES(8,'Practical Application',NULL,'gabriela.010','1999-08-30','1999-08-30',2,1,1);
INSERT INTO submissions VALUES(9,'Birds of Prey',NULL,'colony.010','1999-09-03','1999-09-03',1,1,1);
INSERT INTO submissions VALUES(10,'Mariposa',NULL,'mariposa.010','1999-09-03 ','1999-09-03',1,1,1);
INSERT INTO submissions VALUES(11,'Practical Application',NULL,'gabriela.010','1999-09-30','1999-09-30 ',1,1,1);
INSERT INTO submissions VALUES(12,'Calamari Connection',NULL,'spider.030.doc','1999-10-05','1999-10-05',3,1,1);
INSERT INTO submissions VALUES(13,'Calamari Connection',NULL,'spider.030.doc','2000-03-01','2000-03-01',1,1,1);
INSERT INTO submissions VALUES(14,'Leap of Faith',NULL,'yellow.040.doc','2000-03-10','2000-03-10',2,1,1);
INSERT INTO submissions VALUES(15,'Leap of Faith',NULL,'yellow.040.doc','2000-03-21','2000-03-21 ',1,1,1);
INSERT INTO submissions VALUES(16,'The Creator''s Image',NULL,'Creator.030.doc','2000-08-18','2000-08-18',2,1,1);
INSERT INTO submissions VALUES(17,'The Creator''s Image',NULL,'Creator.030.doc','2000-09-06','2000-09-06',1,1,1);
INSERT INTO submissions VALUES(18,'My Blue Gnu',NULL,'Wildebeest.28.doc','2000-11-30','2000-11-30',2,1,1);
INSERT INTO submissions VALUES(19,'The Perils of Precision',NULL,'TimeMachine.030.doc','2000-12-11','2000-12-11',1,1,1);
INSERT INTO submissions VALUES(20,'The Tabby Factor',NULL,'AlienVotes.070.doc','2001-01-05','2001-01-05',1,1,1);
INSERT INTO submissions VALUES(21,'It''s Not Nice to Fool with Father Time',NULL,'LittleChanges.090.doc','2001-01-23','2001-01-23',1,1,1);
INSERT INTO submissions VALUES(22,'The Lady in White',NULL,'FamousArtist.070.doc','2001-03-05','2001-03-05',1,1,1);
INSERT INTO submissions VALUES(23,'It''s Not Nice to Fool with Father Time',NULL,'LittleChanges.090.doc','2001-03-05','2001-03-05',3,1,1);
INSERT INTO submissions VALUES(24,'The Perils of Precision',NULL,'TimeMachine.030.doc','2001-03-05','2001-03-05',2,1,1);
INSERT INTO submissions VALUES(25,'The Tabby Factor',NULL,'AlienVotes.070.doc','2001-03-19','2001-03-19',2,1,1);
INSERT INTO submissions VALUES(26,'The Piper''s Dream',NULL,'Blink.120.doc','2001-05-02','2001-05-02',2,1,1);
INSERT INTO submissions VALUES(27,'The Piper''s Dream',NULL,'Blink.130.doc','2001-05-09','2001-05-09',3,1,1);
INSERT INTO submissions VALUES(28,'The Lady in White',NULL,'FamousArtist.080.doc','2001-05-12','2001-05-12 ',2,1,1);
INSERT INTO submissions VALUES(29,'My Blue Gnu',NULL,'Wildebeest.30.doc','2001-07-16','2001-07-16',2,1,1);
INSERT INTO submissions VALUES(31,'A Bolt From the Blue',NULL,'SupplyDemand.09.doc','2002-01-30','2002-01-30',2,1,1);
INSERT INTO submissions VALUES(32,'The Piper''s Dream',NULL,'Blink.140.doc','2002-03-13','2002-03-13',1,1,1);
INSERT INTO submissions VALUES(33,'Verba Verde',NULL,'SupplyDemand.10.doc','2002-03-13','2002-03-13',3,1,1);
INSERT INTO submissions VALUES(34,'Game of Life',NULL,'GameOfLife.33.doc','2002-03-13','2002-03-13 ',2,1,1);
INSERT INTO submissions VALUES(35,'All That Rises',NULL,'FutureDroid.36.doc','2002-08-19','2002-08-19',2,1,1);
INSERT INTO submissions VALUES(36,'All That Rises',NULL,'FutureDroid.37.doc','2002-09-06','2002-09-06',3,1,1);
INSERT INTO submissions VALUES(37,'The Perils of Poetic License',NULL,'TimeMachine.18.doc','2002-09-06','2002-09-06',2,1,1);
INSERT INTO submissions VALUES(38,'The Perils of Poetic License',NULL,'TimeMachine.18.doc','2002-09-24','2002-09-24',1,1,1);
INSERT INTO submissions VALUES(39,'Marshland Melodies',NULL,'Exploitation.11.doc','2002-09-24','2002-09-24',2,1,1);
INSERT INTO submissions VALUES(40,'A Familiar Story',NULL,'Mariposa.15.doc','2002-10-26','2002-10-26',2,1,1);
INSERT INTO submissions VALUES(41,'Marshland Melodies',NULL,'Exploitation.11.doc','2002-10-28','2002-10-28',3,1,1);
INSERT INTO submissions VALUES(42,'A Familiar Story',NULL,'Mariposa.16.doc','2002-12-18','2002-12-18',3,1,1);
INSERT INTO submissions VALUES(43,'When Might Meets Right',NULL,'FutureRivals.09.doc','2002-12-18','2002-12-18',2,1,1);
INSERT INTO submissions VALUES(44,'All That Rises',NULL,'FutureDroid.41.doc','2002-12-23','2002-12-23',1,1,1);
INSERT INTO submissions VALUES(45,'Marshland Melodies',NULL,'Exploitation.12.doc','2002-12-23','2002-12-23',1,1,1);
INSERT INTO submissions VALUES(46,'When Might Meets Right',NULL,'FutureRivals.11.doc','2003-01-10','2003-01-10',1,1,1);
INSERT INTO submissions VALUES(47,'Contingent Liability',NULL,'Worry.09.doc','2003-01-10','2003-01-10',2,1,1);
INSERT INTO submissions VALUES(48,'Contingent Liability',NULL,'Worry.10.doc','2003-01-21','2003-01-21',1,1,1);
INSERT INTO submissions VALUES(49,'A Kiss from the Queen',NULL,'Dyslexia.33.doc','2003-09-04','2003-09-04',2,1,1);
INSERT INTO submissions VALUES(50,'A Kiss from the Queen',NULL,'Dyslexia.34.doc','2003-09-18','2003-09-18',3,1,1);
INSERT INTO submissions VALUES(51,'Keepers of the Quantum Foam',NULL,'Awakening.36.doc','2003-09-24','2003-09-24',2,1,1);
INSERT INTO submissions VALUES(52,'Keepers of the Quantum Foam',NULL,'Awakening.37.doc','2003-09-30','2003-09-30',3,1,1);
INSERT INTO submissions VALUES(53,'A Kiss from the Queen',NULL,'Dyslexia.35.doc','2004-01-05','2004-01-05',1,1,1);
INSERT INTO submissions VALUES(54,'Keepers of the Quantum Foam',NULL,'Awakening.39.doc','2004-02-02','2004-02-02',1,1,1);
INSERT INTO submissions VALUES(55,'Remembrance of Things to Come',NULL,'NecessaryMortality.29.doc','2004-02-02','2004-02-02',2,1,1);
INSERT INTO submissions VALUES(56,'Remembrance of Things to Come',NULL,'NecessaryMortality.30.doc','2004-02-11','2004-02-11',1,1,1);
INSERT INTO submissions VALUES(57,'Verba Verde',NULL,'Mirror.14.doc','2004-02-17','2004-02-17',2,1,1);
INSERT INTO submissions VALUES(58,'Verba Verde',NULL,'Mirror.15.doc','2004-02-25 ','2004-02-25',1,1,1);
INSERT INTO submissions VALUES(59,'The Honesty of Aldebarans',NULL,'TimeMachine.24.doc','2004-03-02','2004-03-02 ',1,1,1);
INSERT INTO submissions VALUES(60,'Remembrance of Things to Come',NULL,'NecessaryMortality.30.doc','2004-03-11','2004-03-11 ',3,1,1);
INSERT INTO submissions VALUES(61,'The Book of Mildred',NULL,'FieldsOfLord.37.doc','2004-06-24','2004-06-24',2,1,1);
INSERT INTO submissions VALUES(62,'The Honesty of Aldebarans',NULL,'TimeMachine.28.doc','2004-06-30','2004-06-30',2,1,1);
INSERT INTO submissions VALUES(63,'The Honesty of Aldebarans',NULL,'TimeMachine.30.doc','2004-07-29','2004-07-29',1,1,1);
INSERT INTO submissions VALUES(64,'Objects in the Mirror May Not Be There at All',NULL,'Perturbation.21.doc.','2004-07-29','2004-07-29',2,1,1);
INSERT INTO submissions VALUES(65,'The Book of Mildred',NULL,'FieldsOfLord.38.doc','2004-07-30','2004-07-30',1,1,1);
INSERT INTO submissions VALUES(66,'The Big Reboot',NULL,'Perturbation.27.doc','2004-08-18','2004-08-18',1,1,1);
INSERT INTO submissions VALUES(67,'The Many Names of Technology',NULL,'Worry.19.doc','2004-09-07','2004-09-07',1,1,1);
INSERT INTO submissions VALUES(68,'The Eighth Deadly Sin',NULL,'Dopamine.35.doc','2005-03-03','2005-03-03',2,1,1);
INSERT INTO submissions VALUES(69,'The Big Reboot',NULL,'Perturbation.28.doc','2005-03-07','2005-03-07',1,1,1);
INSERT INTO submissions VALUES(70,'A Matter of Perception',NULL,'Worry.30.doc','2005-03-29','2005-03-29 ',2,1,1);
INSERT INTO submissions VALUES(71,'The Eighth Deadly Sin',NULL,'Dopamine.36.doc','2005-03-30','2005-03-30',3,1,1);
INSERT INTO submissions VALUES(72,'A Kiss from the Queen',NULL,'Dyslexia.39.doc','2005-04-28','2005-04-28',2,1,1);
INSERT INTO submissions VALUES(73,'A Kiss from the Queen',NULL,'Dyslexia.40.doc','2005-05-11','2005-05-11',3,1,1);
INSERT INTO submissions VALUES(74,'The Blue-Eyed Brunette',NULL,'KillingGramps.22.doc','2005-05-23','2005-05-23',2,1,1);
INSERT INTO submissions VALUES(75,'A Matter of Perception',NULL,'Worry.34.doc','2005-05-25','2005-05-25',1,1,1);
INSERT INTO submissions VALUES(76,'The Eighth Deadly Sin',NULL,'Dopamine.37.doc','2005-05-25','2005-05-25',1,1,1);
INSERT INTO submissions VALUES(77,'The Book of Mildred',NULL,'FieldsOfLord.42.doc','2005-06-01','2005-06-01',2,1,1);
INSERT INTO submissions VALUES(78,'The Case of the Blue-Eyed Brunette',NULL,'KillingGramps.23.doc','2005-06-03','2005-06-03',1,1,1);
INSERT INTO submissions VALUES(79,'The Book of Mildred',NULL,'FieldsOfLord.43.doc','2005-06-14','2005-06-14',1,1,1);
INSERT INTO submissions VALUES(80,'Design Defect',NULL,'Hominid.16.doc','2005-07-08','2005-07-08',2,1,1);
INSERT INTO submissions VALUES(81,'A Kiss from the Queen',NULL,'Dyslexia.41.doc','2005-07-11','2005-07-11',1,1,1);
INSERT INTO submissions VALUES(82,'The Book of Mildred',NULL,'FieldsOfLord.44.doc','2005-07-11','2005-07-11',3,1,1);
INSERT INTO submissions VALUES(83,'The Eighth Deadly Sin',NULL,'Dopamine.42.doc','2005-07-20','2005-07-20',3,1,1);
INSERT INTO submissions VALUES(84,'The Piper''s Dream',NULL,'BlinkAgain.30.doc','2005-07-24','2005-07-24',1,1,1);
INSERT INTO submissions VALUES(85,'Design Defect',NULL,'Hominid.17.doc','2005-08-02','2005-08-02',1,1,1);
INSERT INTO submissions VALUES(86,'Design Defect',NULL,'Hominid.18.doc ','2005-11-03','2005-11-03 ',3,1,1);
INSERT INTO submissions VALUES(87,'Deus Ex Machina',NULL,'Evolution.34.doc','2005-11-03','2005-11-03',2,1,1);
INSERT INTO submissions VALUES(88,'Deus Ex Machina',NULL,'Evolution.35.doc','2005-11-18','2005-11-18',1,1,1);
INSERT INTO submissions VALUES(89,'Life Everlasting',NULL,'LifeEverlasting.38.doc','2006-01-06','2006-01-06',2,1,1);
INSERT INTO submissions VALUES(90,'Deus Ex Machina',NULL,'Evolution.35.doc','2006-02-02','2006-02-02',3,1,1);
INSERT INTO submissions VALUES(91,'Life Everlasting',NULL,'LifeEverlasting.39.doc','2006-02-08','2006-02-08',3,1,1);
INSERT INTO submissions VALUES(92,'Loose Ends',NULL,'TippingPoint.24.doc','2006-03-02','2006-03-02',2,1,1);
INSERT INTO submissions VALUES(93,'Loose Ends',NULL,'TippingPoint.25.doc','2006-03-17','2006-03-17',1,1,1);
INSERT INTO submissions VALUES(94,'Loose Ends',NULL,'TippingPoint.25.doc','2006-04-21','2006-04-21 ',3,1,1);
INSERT INTO submissions VALUES(95,'Cat Box Capers',NULL,'Schrodinger.22.doc','2006-04-21','2006-04-21',2,1,1);
INSERT INTO submissions VALUES(96,'The Lessons of History',NULL,'Columbus.20.doc','2006-05-10','2006-05-10',2,1,1);
INSERT INTO submissions VALUES(97,'Cat Box Capers',NULL,'Schrodinger.23.doc','2006-05-11','2006-05-11',1,1,1);
INSERT INTO submissions VALUES(98,'Life Everlasting',NULL,'LifeEverlasting.40.doc','2006-05-17','2006-05-17',1,1,1);
INSERT INTO submissions VALUES(99,'The Lessons of History',NULL,'Columbus.22.doc','2006-05-23','2006-05-23',1,1,1);
INSERT INTO submissions VALUES(100,'War Dogs',NULL,'Chromosomes.20.doc','2006-09-06','2006-09-06',1,1,1);
INSERT INTO submissions VALUES(101,'The Other Problem with Time Travel',NULL,'NewTimeMachine.22.doc','2006-09-23 ','2006-09-23',1,1,1);
INSERT INTO submissions VALUES(102,'Patent Pending',NULL,'MyGenes.15.doc','2006-10-19','2006-10-19',1,1,1);
INSERT INTO submissions VALUES(103,'Evolution',NULL,'FutureBots.40.doc','2007-03-13','2007-03-13',1,1,1);
INSERT INTO submissions VALUES(104,'The Lessons of History',NULL,'Columbus.24.doc','2007-03-19','2007-03-19',2,1,1);
INSERT INTO submissions VALUES(105,'War Dogs',NULL,'Chromosomes.21.doc','2007-03-21','2007-03-21',2,1,1);
INSERT INTO submissions VALUES(106,'War Dogs',NULL,'Chromosomes.21.doc','2007-04-02','2007-04-02 ',3,1,1);
INSERT INTO submissions VALUES(107,'Patent Pending',NULL,'MyGenes.20.doc','2007-04-02','2007-04-02',2,1,1);
INSERT INTO submissions VALUES(108,'Tangle',NULL,'SecondChance.34.doc','2007-08-01','2007-08-01',1,1,1);
INSERT INTO submissions VALUES(109,'Patent Pending',NULL,'MyGenes.20.doc','2007-08-21','2007-08-21',3,1,1);
INSERT INTO submissions VALUES(110,'A Plethora of Truth',NULL,'SoulGene.18.doc','2007-08-21','2007-08-21',2,1,1);
INSERT INTO submissions VALUES(111,'A Plethora of Truth',NULL,'SoulGene.20.doc','2007-08-30','2007-08-30',1,2,1);
INSERT INTO submissions VALUES(112,'The Emperor''s Moon',NULL,'DinoDemise.32.doc','2008-01-14','2008-01-14',1,1,1);
INSERT INTO submissions VALUES(113,'Keepers of the Quantum Foam',NULL,'Awakening.50.doc','2008-01-31','2008-01-31',1,1,1);
INSERT INTO submissions VALUES(114,'The Case of the Disconnected Wife',NULL,'HouseOfCards.30.doc','2008-05-13','2008-05-13',1,1,1);
INSERT INTO submissions VALUES(115,'Quark Soup',NULL,'Reboot.19.doc','2008-05-25 ','2008-05-25',1,1,1);
INSERT INTO submissions VALUES(116,'The Other Problem with Time Travel',1000,'NewTimeMachine.24.doc','2008-05-28','2008-05-28',3,1,1);
INSERT INTO submissions VALUES(117,'Evolution',NULL,'FutureBots.41.doc','2008-05-28','2008-05-28',2,1,1);
INSERT INTO submissions VALUES(118,'The Anunnaki''s Legacy',NULL,'Blame.40.docx','2009-01-15','2009-01-15',1,1,1);
INSERT INTO submissions VALUES(119,'Quark Soup',NULL,'Reboot.35.docx','2009-02-09','2009-02-09',1,2,1);
INSERT INTO submissions VALUES(120,'The Anunnaki Legacy',NULL,'Blame.48.docx','2009-06-07','2009-06-07',1,1,1);
INSERT INTO submissions VALUES(121,'The Little Bang Theory',NULL,'TimeTheory.20.docx','2009-07-21','2009-07-21 ',1,1,1);
INSERT INTO submissions VALUES(122,'The Anunnaki Legacy',NULL,'Blame.54.docx','2009-08-07','2009-08-07',1,2,1);
INSERT INTO submissions VALUES(123,'Entitlement',NULL,'ImmortalityInc.40.docx','2010-01-23','2010-01-23',1,1,1);
INSERT INTO submissions VALUES(124,'Blind Spot',NULL,'Memories.40.docx','2010-06-08','2010-06-08',1,2,1);
INSERT INTO submissions VALUES(125,'Life Everlasting',NULL,'MoreImmortal.46.docx','2011-01-06','2011-01-06',1,1,1);
INSERT INTO submissions VALUES(126,'Instinctive Response',NULL,'SanityVirus.43.docx','2012-01-26','2012-01-26',1,1,1);
INSERT INTO submissions VALUES(127,'Instinctive Response',NULL,'SanityVirus.48.docx','2012-03-18','2012-03-18',1,2,1);
INSERT INTO submissions VALUES(128,'Bag of Bones',NULL,'Inevitability.64.docx','2012-09-17','2012-09-17',1,1,1);
INSERT INTO submissions VALUES(129,'Smartphones',NULL,'Extension.10.docx','2012-10-07','2012-10-07',1,1,1);
INSERT INTO submissions VALUES(130,'Flying by Wire',NULL,'FermiBot.17.docx','2013-01-13','2013-01-13',1,1,1);
INSERT INTO submissions VALUES(131,'Persistence of Illusion',NULL,'FingerPrints.28.docx','2013-05-25','2013-05-25',1,1,1);
INSERT INTO submissions VALUES(132,'Unconditional Love',NULL,'Adjustment.19.docx','2013-12-01','2013-12-01',1,1,1);
INSERT INTO submissions VALUES(133,'The Eighth Iteration',NULL,'RobotRebirth.51.docx','2014-02-12','2014-02-12',1,2,1);
INSERT INTO submissions VALUES(134,'A Switch in Time',NULL,'Congruence.30.docx','2014-06-09','2014-06-09',2,1,1);
INSERT INTO submissions VALUES(135,'Dreams of Spanish Gold',NULL,'Mariposa.33.docx','2014-06-27','2014-06-27',2,1,1);
INSERT INTO submissions VALUES(136,'Old Bones',NULL,'Inevitability.75.docx','2014-07-18','2014-07-18',2,1,1);
INSERT INTO submissions VALUES(137,'Dreams of Spanish Gold',NULL,'Mariposa.34.docx','2014-07-23','2014-07-23 ',5,1,1);
INSERT INTO submissions VALUES(138,'Tracks in Time',NULL,'Congruence.39.docx','2014-08-15','2014-08-15',1,1,1);
INSERT INTO submissions VALUES(139,'Dreams of Spanish Gold',NULL,'Mariposa.33.docx','2014-08-15','2014-08-15',6,1,1);
INSERT INTO submissions VALUES(140,'Dreams of Spanish Gold',NULL,'Mariposa.34.docx ','2014-08-17','2014-08-17',1,2,1);
INSERT INTO submissions VALUES(141,'Persistence of Illusion',NULL,'FingerPrints.41.docx','2014-09-10','2014-09-10',2,1,1);
INSERT INTO submissions VALUES(142,'Persistence of Illusion',NULL,'FingerPrints.42.docx','2014-10-28','2014-10-28',6,1,1);
INSERT INTO submissions VALUES(143,'Persistence of Illusion',NULL,'FingerPrints.41.docx','2014-10-31','2014-10-31',3,1,1);
INSERT INTO submissions VALUES(144,'Old Bones',7700,'Inevitability.76.docx','2014-11-01','2014-11-01',1,1,1);
INSERT INTO submissions VALUES(145,'Persistence of Illusion',NULL,'FingerPrints.42.docx','2014-12-25','2014-12-25',7,1,1);
INSERT INTO submissions VALUES(146,'Entangled Lives',NULL,'ShipGoesHuman.36.docx','2014-12-31','2016-02-01',1,6,1);
INSERT INTO submissions VALUES(147,'Persistence of Illusion',NULL,'FingerPrints.42.docx','2015-01-04','2015-01-04',8,1,1);
INSERT INTO submissions VALUES(148,'Heads in the Cloud',NULL,'Consciousness.18.docx','2015-02-18','2015-02-18',2,1,1);
INSERT INTO submissions VALUES(149,'Pinch Points',NULL,'Congruence.58.docx','2015-04-14','2015-04-14',2,1,1);
INSERT INTO submissions VALUES(150,'Pinch Points',NULL,'Congruence.58.docx','2015-05-05','2015-05-05',9,1,1);
INSERT INTO submissions VALUES(151,'Pinch Points',NULL,'Congruence.58.docx','2015-05-05','2015-05-05',7,1,1);
INSERT INTO submissions VALUES(152,'Heads in the Cloud',NULL,'Consciousness.29.docx','2015-05-06','2015-05-06',3,1,1);
INSERT INTO submissions VALUES(153,'Pinch Points',NULL,'Congruence.58.docx','2015-05-07','2015-05-07',1,1,1);
INSERT INTO submissions VALUES(154,'The Chatter of Monkeys',NULL,'SafeWorld.32.doc','2015-11-18','2015-11-18',2,1,1);
INSERT INTO submissions VALUES(155,'The Chatter of Monkeys',6700,'SafeWorld.32.doc','2015-11-20','2015-11-20',3,1,1);
INSERT INTO submissions VALUES(156,'Persistence of Illusion',6700,'FingerPrints.42.docx','2015-11-21','2015-11-21',5,1,1);
INSERT INTO submissions VALUES(157,'Deus ex Machina',2800,'Evolution.37.docx','2015-12-01','2015-12-01',6,1,1);
INSERT INTO submissions VALUES(158,'Deus ex Machina',2800,'Evolution.37.docx','2015-12-02','2015-12-02',11,5,1);
INSERT INTO submissions VALUES(159,'El Pajaro',6700,'Pajaro.040.docx','2015-12-03','2015-12-03',2,5,1);
INSERT INTO submissions VALUES(160,'Persistence of Illusion',6700,'FingerPrints.42.docx','2016-01-02','2016-01-02',9,1,1);
INSERT INTO submissions VALUES(161,'Snake in the Grass',900,'Snake.26.docx','2016-01-02','2016-01-02',6,1,1);
INSERT INTO submissions VALUES(162,'A Safer World',900,'FixerUppers.13.docx','2016-01-02','2016-01-02',10,1,1);
INSERT INTO submissions VALUES(163,'Snake in the Grass',900,'Snake.29.docx','2016-01-08','2016-01-08',4,1,1);
INSERT INTO submissions VALUES(164,'A Safer World',900,'FixerUppers.14.docx','2016-01-20','2016-01-20',11,5,1);
INSERT INTO submissions VALUES(165,'Snake in the Grass',900,'Snake.30.docx','2016-01-22','2016-02-07',10,5,1);
INSERT INTO submissions VALUES(166,'The Chatter of Monkeys',6700,'SafeWorld.39.docx','2016-01-24','2016-02-05',9,1,1);
INSERT INTO submissions VALUES(167,'Heads in the Cloud',6700,'Consciousness.30.docx','2016-01-25','2016-02-12',7,1,1);
INSERT INTO submissions VALUES(168,'The Lessons of History',2100,'ColumbusAgain.04.docx','2016-02-08','2016-02-10',2,5,1);
INSERT INTO submissions VALUES(169,'The Chatter of Monkeys',5900,'SafeWorld.42.docx','2016-02-08','2016-07-14',1,2,1);
INSERT INTO submissions VALUES(174,'A Safer World',900,'FixerUppers.13.docx','2015-11-30','2001-11-30',4,1,1);
INSERT INTO submissions VALUES(175,'Sanctuary',6200,'JurassicBot.28.docx','2016-07-05','2016-07-08',2,1,1);
INSERT INTO submissions VALUES(176,'Sanctuary',7200,'JurassicBot.41.docx','2016-09-19','2016-09-20',6,1,1);
INSERT INTO submissions VALUES(177,'Sanctuary',7400,'JurassicBot.45.docx','2016-12-07','2017-01-08',9,1,1);
INSERT INTO submissions VALUES(178,'Theater of the Mind',4600,'cube.33.docx','2016-12-23','2016-12-29',2,1,1);
INSERT INTO submissions VALUES(179,'A Minor Miscalculation',844,'NewTimeMachine.26.docx','2016-12-26','2016-12-28',10,1,1);
INSERT INTO submissions VALUES(180,'Sanctuary (as Theater)',7400,'JurassicBot.45.docx','2017-01-21','2016-01-27',7,1,1);
INSERT INTO submissions VALUES(181,'Theater of The Mind',4700,'cube.40..docx','2017-01-21','2017-02-28',9,1,1);
INSERT INTO submissions VALUES(182,'A Minor Miscalculation',844,'NewTimeMachine.26.docx','2017-01-21','2017-02-03',4,1,1);
INSERT INTO submissions VALUES(183,'Fine Tuning',987,'aviatrix.19.docx','2017-02-27','2017-04-19',10,1,1);
INSERT INTO submissions VALUES(184,'Theater of the Mind',4700,'cube.41.docx','2017-03-05','2017-03-06',6,1,1);
INSERT INTO submissions VALUES(185,'Theater of the Mind',4700,'cube.41.docx','2017-03-06','2017-03-26',5,1,1);
INSERT INTO submissions VALUES(186,'Sanctuary',7400,'JurassicBot.46.docx','2017-03-15','2017-07-07',3,1,1);
INSERT INTO submissions VALUES(187,'Fine Euning',992,'aviatrix.20.docx','2017-04-23','2017-05-13',4,1,1);
INSERT INTO submissions VALUES(188,'Fine Tuning',1000,'Aviatrix.21.docx','2017-06-05','2017-06-11',2,1,1);
INSERT INTO submissions VALUES(189,'El Pajaro',6600,'Pajaro.042.docx','2017-06-07','2017-06-08',6,1,1);
INSERT INTO submissions VALUES(190,'Sanctuary',4700,'JurassicBot.46.docx','2017-07-11','2018-02-26',1,1,1);
INSERT INTO submissions VALUES(191,'Theater of the Mind',4700,'cube.41.docx','2017-07-13','2017-08-02',3,1,1);
INSERT INTO submissions VALUES(192,'Unmarked Bills',6600,'DogDay.17.docx','2017-08-26','2017-09-05',16,1,1);
INSERT INTO submissions VALUES(193,'Unmarked Bills',6600,'DogDay.17.docx','2017-09-05',NULL,8,4,1);
INSERT INTO submissions VALUES(194,'Fine Tuning',1400,'Aviatrix.26.docx','2017-09-15','2017-09-16',6,1,1);
INSERT INTO submissions VALUES(195,'Fine Tuning',1400,'Aviatrix.26.docx','2017-09-16','2017-10-31',3,1,1);
INSERT INTO submissions VALUES(196,'Voices from the Past',4800,'BotHappy.60.docx','2017-09-21','2017-09-22',2,1,1);
INSERT INTO submissions VALUES(197,'Voices from the Past',4200,'BotHappy.61.docx','2017-09-25','2017-09-26',6,1,1);
INSERT INTO submissions VALUES(198,'Voices from the Past',4200,'BotHappy.61.docx','2017-09-26','2017-11-07',9,1,1);
INSERT INTO submissions VALUES(199,'Fine Tuning',1400,'Aviatrix.26.docx','2017-11-25','2018-02-26',1,2,1);
INSERT INTO submissions VALUES(200,'Voices from the Past',4200,'BotHappy.61.docx','2017-11-25','2018-02-12',3,1,1);
INSERT INTO submissions VALUES(201,'Thin Ice',5000,'Monfort.12.docx','2017-12-07','2017-12-09',17,2,1);
INSERT INTO submissions VALUES(202,'A Day in the Cloud',6900,'Consciousness.42.docx','2017-12-11','2017-12-17',2,1,1);
INSERT INTO submissions VALUES(203,'A Day in the Cloud',6900,'Consciousness.42.docx','2018-01-19','2018-01-20',6,1,1);
INSERT INTO submissions VALUES(204,'A Day in the Cloud',6900,'Consciousness.42.dox','2018-01-22','2018-01-29',9,1,1);
INSERT INTO submissions VALUES(205,'In Reykjavik',4800,'HarrysRibbon.16.docx','2018-02-28','2018-03-07',2,1,1);
INSERT INTO submissions VALUES(206,'Voices from the Past',4200,'BotHappy.61.docx','2018-02-28','2018-08-07',1,1,1);
INSERT INTO submissions VALUES(207,'A Day in the Cloud',6900,'Consciousness.42.docx','2018-02-28','2018-03-01',3,1,1);
INSERT INTO submissions VALUES(208,'A Change of Plan',995,'HusbandsPartner.16.docx','2018-02-28','2018-03-15',10,1,1);
INSERT INTO submissions VALUES(209,'In Reykjavik',4800,'HarrysRibbon.16.docx','2018-03-14','2018-03-24',3,1,1);
INSERT INTO submissions VALUES(210,'The Chatter of Monkeys',5900,'SafeWorld.43.docx','2018-03-14','2018-03-14',18,2,1);
INSERT INTO submissions VALUES(211,'In Reykjavik',4600,'HarrysRibbon16.docx','2018-04-21','2018-07-06',1,1,1);
CREATE VIEW main_view AS 
select s.submission_id, s.Story, s.Word_Count, s.File, p.publisher, s.Date_Submitted, d.disposition, s.Disposition_Date 
from submissions s, dispositions d, publishers p 
where s.Publisher_id = p.publisher_id and s.Disposition_id = d.disposition_id;
COMMIT;
