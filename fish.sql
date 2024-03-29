PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE catch_type (

	catch_type_id INTEGER NOT NULL,

	catch_type_name TEXT NOT NULL,

	CONSTRAINT catch_type_PK PRIMARY KEY (catch_type_id)

);
INSERT INTO catch_type VALUES(1,'trash');
INSERT INTO catch_type VALUES(2,'normal');
INSERT INTO catch_type VALUES(3,'special');
INSERT INTO catch_type VALUES(4,'rare');
INSERT INTO catch_type VALUES(5,'undefined');
CREATE TABLE catch (

	catch_id INTEGER NOT NULL,

	catch_name TEXT NOT NULL,

	"catch_type_id" INTEGER NOT NULL,

	CONSTRAINT catch_PK PRIMARY KEY (catch_id),

	CONSTRAINT catch_FK FOREIGN KEY ("catch_type_id") REFERENCES catch_type(catch_type_id)

);
INSERT INTO catch VALUES(1,'🛒',1);
INSERT INTO catch VALUES(2,'👞',1);
INSERT INTO catch VALUES(3,'📎',1);
INSERT INTO catch VALUES(4,'🔋',1);
INSERT INTO catch VALUES(5,'🔧',1);
INSERT INTO catch VALUES(6,'🐟',2);
INSERT INTO catch VALUES(7,'🐠',3);
INSERT INTO catch VALUES(8,'🐢',4);
INSERT INTO catch VALUES(9,'🐳',4);
INSERT INTO catch VALUES(10,'🐋',4);
INSERT INTO catch VALUES(11,'🐊',4);
INSERT INTO catch VALUES(12,'🐧',4);
INSERT INTO catch VALUES(13,'🐙',4);
INSERT INTO catch VALUES(14,'🦈',4);
INSERT INTO catch VALUES(15,'🦑',4);
INSERT INTO catch VALUES(16,'🦐',4);
INSERT INTO catch VALUES(17,'🐬',4);
INSERT INTO catch VALUES(18,'🦀',4);
INSERT INTO catch VALUES(19,'🐡',4);
CREATE TABLE IF NOT EXISTS "text" (

	text_id INTEGER NOT NULL,

	"text" TEXT NOT NULL,

	CONSTRAINT text_PK PRIMARY KEY (text_id)

);
INSERT INTO text VALUES(1,'Women want me, fish fear me');
INSERT INTO text VALUES(2,'M.I.L.F Man, I love fishing');
INSERT INTO text VALUES(3,'Even though they have an integrated fishing rod, most Angler Fish don''t actually have a fishing License');
INSERT INTO text VALUES(4,'Fishing with the boys, nothing better');
INSERT INTO text VALUES(5,'Looks like the new bait paid off');
INSERT INTO text VALUES(6,'Get in loser, there is a 50% discount at Bass Pro Shop 🚗 ');
INSERT INTO text VALUES(7,'flop flop flop');
INSERT INTO text VALUES(8,'Reel women fish');
INSERT INTO text VALUES(9,'Good things come to those who bait');
INSERT INTO text VALUES(10,'A Sea Bass! That catch is at least a C+');
INSERT INTO text VALUES(11,'Slow down there, bud. You don''t want to empty the lake');
INSERT INTO text VALUES(12,'Yes! They took the bait! Come on, [BEACH BOY] let''s reel them in!');
INSERT INTO text VALUES(13,'Bet you didn''t expect this to be one of the possible mesages');
INSERT INTO text VALUES(14,'Women want fish, me fear me');
INSERT INTO text VALUES(15,'A new pair and one extra');
INSERT INTO text VALUES(16,'What are those?');
INSERT INTO text VALUES(17,'Looking fresh');
INSERT INTO text VALUES(18,'Neither nuts nor bolts will stand in my way');
INSERT INTO text VALUES(19,'Wrenches? Why don''t you instead try to get some wenches on your dick');
INSERT INTO text VALUES(20,'A fine addition to my collection');
INSERT INTO text VALUES(21,'There is still some juice in here');
INSERT INTO text VALUES(22,'Not good for consumption');
INSERT INTO text VALUES(23,'Tastes electrifying');
INSERT INTO text VALUES(24,'Hey it''s that dude from Microsoft');
INSERT INTO text VALUES(25,'This can probably be refashioned into a hook');
INSERT INTO text VALUES(26,'HOFER TIME');
INSERT INTO text VALUES(27,'Will you return the cart even though you gain nothing? ');
INSERT INTO text VALUES(28,'Who keeps dumping this stuff in here?');
INSERT INTO text VALUES(29,'These fish look kinda weird');
INSERT INTO text VALUES(30,replace(replace('Let any fish who meets my gaze learn the true meaning of fear, for I am the harbinger of death, the bane of creatures subaqueous. My rod is true and unwavering as I cast it into the aquatic abyss. A man, scorned by this uncaring earth finds solace in the sea.\r\nMy only friend the worm upon my hook, wriggling, writhing, struggling to surmount the pointlessness that permeates this barren world.\r\nI am alone.\r\nI am empty.\r\nAnd yet,\r\nI fish.','\r',char(13)),'\n',char(10)));
INSERT INTO text VALUES(31,'https://c.tenor.com/GBRaEksaWqQAAAAM/oh-omg.gif');
INSERT INTO text VALUES(32,'Thanks for cleaning up the Lake');
INSERT INTO text VALUES(33,'Now you can almost power your remote :thumbsup:');
INSERT INTO text VALUES(34,'Universally good');
INSERT INTO text VALUES(35,'I''m going shopping, can I get ya''ll something?');
INSERT INTO text VALUES(36,'ohbabyatriple.mp3');
INSERT INTO text VALUES(37,'Three blue fish in a row? Another one for the apocalypse Bingo');
INSERT INTO text VALUES(38,'Thank you Poseidon for these bountiful gifts');
INSERT INTO text VALUES(39,'Thank you Neptune for these bountiful gifts');
INSERT INTO text VALUES(40,'Thank you [insert ocean god here] for these bountiful gifts');
INSERT INTO text VALUES(41,'Guys, I think we finally got all the trash out.');
INSERT INTO text VALUES(42,'A day without fishing probably won''t kill me. - But why take the chance?');
INSERT INTO text VALUES(43,'Gills for days');
INSERT INTO text VALUES(44,'You miss 100% of the fish you don''t bait');
INSERT INTO text VALUES(45,'You think this could be a sign the great old ones are returning?');
INSERT INTO text VALUES(46,'Snatched them up from right under Davy Jones nose!');
INSERT INTO text VALUES(47,'Nice work! Time for another cold one.');
INSERT INTO text VALUES(48,'Guess we really hooked them.');
INSERT INTO text VALUES(49,'Fish go splish');
INSERT INTO text VALUES(50,'Imagine reeling in garbage. Couldn''t be us.');
INSERT INTO text VALUES(51,'That''s three for three baybeee');
INSERT INTO text VALUES(52,'Keeping it reel');
INSERT INTO text VALUES(53,'Feel the sunshine and let all your worries disappear as you cast a line');
INSERT INTO text VALUES(54,'You can tune a guitar, but you can''t guitar a tuna');
INSERT INTO text VALUES(55,'Rod go swoosh');
CREATE TABLE IF NOT EXISTS "_text_catch" (

	id INTEGER NOT NULL,

	"text_id" INTEGER NOT NULL,

	catch_id INTEGER NOT NULL,

	CONSTRAINT "_text_catch_PK" PRIMARY KEY (id),

	CONSTRAINT "_text_catch_FK" FOREIGN KEY ("text_id") REFERENCES "text"(text_id),

	CONSTRAINT "_text_catch_FK_1" FOREIGN KEY (catch_id) REFERENCES catch(catch_id)

);
INSERT INTO _text_catch VALUES(1,35,1);
INSERT INTO _text_catch VALUES(2,26,1);
INSERT INTO _text_catch VALUES(3,27,1);
INSERT INTO _text_catch VALUES(4,15,2);
INSERT INTO _text_catch VALUES(5,16,2);
INSERT INTO _text_catch VALUES(6,17,2);
INSERT INTO _text_catch VALUES(7,34,3);
INSERT INTO _text_catch VALUES(8,24,3);
INSERT INTO _text_catch VALUES(9,25,3);
INSERT INTO _text_catch VALUES(10,33,4);
INSERT INTO _text_catch VALUES(11,21,4);
INSERT INTO _text_catch VALUES(12,22,4);
INSERT INTO _text_catch VALUES(13,23,4);
INSERT INTO _text_catch VALUES(14,18,5);
INSERT INTO _text_catch VALUES(15,19,5);
INSERT INTO _text_catch VALUES(16,20,5);
CREATE TABLE IF NOT EXISTS "_text_catch_type" (

	id INTEGER NOT NULL,

	"text_id" INTEGER NOT NULL,

	"catch_type_id" INTEGER NOT NULL,

	CONSTRAINT "_text_catch_type_PK" PRIMARY KEY (id),

	CONSTRAINT "_text_catch_type_FK" FOREIGN KEY ("text_id") REFERENCES "text"(text_id),

	CONSTRAINT "_text_catch_type_FK_1" FOREIGN KEY ("catch_type_id") REFERENCES catch_type(catch_type_id)

);
INSERT INTO _text_catch_type VALUES(1,30,4);
INSERT INTO _text_catch_type VALUES(2,31,3);
INSERT INTO _text_catch_type VALUES(3,32,1);
INSERT INTO _text_catch_type VALUES(4,28,1);
INSERT INTO _text_catch_type VALUES(5,29,1);
INSERT INTO _text_catch_type VALUES(6,1,2);
INSERT INTO _text_catch_type VALUES(7,2,2);
INSERT INTO _text_catch_type VALUES(8,3,2);
INSERT INTO _text_catch_type VALUES(9,4,2);
INSERT INTO _text_catch_type VALUES(10,5,2);
INSERT INTO _text_catch_type VALUES(11,6,2);
INSERT INTO _text_catch_type VALUES(12,7,2);
INSERT INTO _text_catch_type VALUES(13,8,2);
INSERT INTO _text_catch_type VALUES(14,9,2);
INSERT INTO _text_catch_type VALUES(15,10,2);
INSERT INTO _text_catch_type VALUES(16,11,2);
INSERT INTO _text_catch_type VALUES(17,12,2);
INSERT INTO _text_catch_type VALUES(18,13,2);
INSERT INTO _text_catch_type VALUES(19,14,2);
INSERT INTO _text_catch_type VALUES(20,36,2);
INSERT INTO _text_catch_type VALUES(21,37,2);
INSERT INTO _text_catch_type VALUES(22,38,2);
INSERT INTO _text_catch_type VALUES(23,39,2);
INSERT INTO _text_catch_type VALUES(24,40,2);
INSERT INTO _text_catch_type VALUES(25,41,2);
INSERT INTO _text_catch_type VALUES(26,42,2);
INSERT INTO _text_catch_type VALUES(27,43,2);
INSERT INTO _text_catch_type VALUES(28,44,2);
INSERT INTO _text_catch_type VALUES(29,45,2);
INSERT INTO _text_catch_type VALUES(30,46,2);
INSERT INTO _text_catch_type VALUES(31,47,2);
INSERT INTO _text_catch_type VALUES(32,48,2);
INSERT INTO _text_catch_type VALUES(33,49,2);
INSERT INTO _text_catch_type VALUES(34,50,2);
INSERT INTO _text_catch_type VALUES(35,51,2);
INSERT INTO _text_catch_type VALUES(36,52,2);
INSERT INTO _text_catch_type VALUES(37,53,2);
INSERT INTO _text_catch_type VALUES(38,54,2);
INSERT INTO _text_catch_type VALUES(39,55,2);
CREATE TABLE combo (

	combo_id INTEGER NOT NULL,

	guild INTEGER NOT NULL,

	channel INTEGER NOT NULL,

	catch_id INTEGER NOT NULL,

	count INTEGER NOT NULL,

	CONSTRAINT combo_PK PRIMARY KEY (combo_id),

	CONSTRAINT combo_FK FOREIGN KEY (catch_id) REFERENCES catch(catch_id)

);
COMMIT;
