PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "catch_type" (
	name TEXT NOT NULL,
	CONSTRAINT catch_type_PK PRIMARY KEY (name)
);
INSERT INTO catch_type VALUES('normal');
INSERT INTO catch_type VALUES('rare');

CREATE TABLE combo_text (
	"text" TEXT NOT NULL,
	CONSTRAINT combo_text_PK PRIMARY KEY ("text")
);
INSERT INTO combo_text VALUES('I''m going shopping, can I get ya''ll something?');
INSERT INTO combo_text VALUES('Thanks for cleaning out the lake');
INSERT INTO combo_text VALUES('Universally good');
INSERT INTO combo_text VALUES('Now you can almost power your remote :thumbsup: ');
INSERT INTO combo_text VALUES('Women want me, fish fear me');
INSERT INTO combo_text VALUES('https://c.tenor.com/GBRaEksaWqQAAAAM/oh-omg.gif ');
INSERT INTO combo_text VALUES(replace(replace('Let any fish who meets my gaze learn the true meaning of fear, for I am the harbinger of death, the bane of creatures subaqueous. My rod is true and unwavering as I cast it into the aquatic abyss. A man, scorned by this uncaring earth finds solace in the sea.\r\nMy only friend - the worm upon my hook, wriggling, writhing, struggling to surmount the pointlessness that permeates this barren world.\r\nI am alone.\r\nI am empty.\r\nAnd yet,\r\nI fish.','\r',char(13)),'\n',char(10)));

CREATE TABLE combo (
	guild INTEGER NOT NULL
, channel INTEGER NOT NULL, catch TEXT NOT NULL, count INTEGER NOT NULL);

CREATE TABLE catch (
	name TEXT NOT NULL,
	"type" TEXT NOT NULL,
	CONSTRAINT catch_PK PRIMARY KEY (name),
	CONSTRAINT catch_FK FOREIGN KEY ("type") REFERENCES catch_type(name)
);
INSERT INTO catch VALUES('🛒','normal');
INSERT INTO catch VALUES('👞','normal');
INSERT INTO catch VALUES('📎','normal');
INSERT INTO catch VALUES('🔋','normal');
INSERT INTO catch VALUES('🐟','normal');
INSERT INTO catch VALUES('🐠','normal');
INSERT INTO catch VALUES('🐢','rare');
INSERT INTO catch VALUES('🐳','rare');
INSERT INTO catch VALUES('🐋','rare');
INSERT INTO catch VALUES('🐊','rare');
INSERT INTO catch VALUES('🐧','rare');
INSERT INTO catch VALUES('🐙','rare');
INSERT INTO catch VALUES('🦈','rare');
INSERT INTO catch VALUES('🦑','rare');
INSERT INTO catch VALUES('🦐','rare');
INSERT INTO catch VALUES('🐬','rare');
INSERT INTO catch VALUES('🦀','rare');
INSERT INTO catch VALUES('🐡','rare');
INSERT INTO catch VALUES('🔧','normal');

CREATE TABLE catch_text (
	catch TEXT NOT NULL,
	"text" TEXT NOT NULL,
	CONSTRAINT catch_text_FK FOREIGN KEY (catch) REFERENCES catch(name),
	CONSTRAINT catch_text_FK_1 FOREIGN KEY ("text") REFERENCES combo_text("text")
);
INSERT INTO catch_text VALUES('🐢',replace(replace('Let any fish who meets my gaze learn the true meaning of fear, for I am the harbinger of death, the bane of creatures subaqueous. My rod is true and unwavering as I cast it into the aquatic abyss. A man, scorned by this uncaring earth finds solace in the sea.\r\nMy only friend - the worm upon my hook, wriggling, writhing, struggling to surmount the pointlessness that permeates this barren world.\r\nI am alone.\r\nI am empty.\r\nAnd yet,\r\nI fish.	','\r',char(13)),'\n',char(10)));
INSERT INTO catch_text VALUES('🐳',replace(replace('Let any fish who meets my gaze learn the true meaning of fear, for I am the harbinger of death, the bane of creatures subaqueous. My rod is true and unwavering as I cast it into the aquatic abyss. A man, scorned by this uncaring earth finds solace in the sea.\r\nMy only friend - the worm upon my hook, wriggling, writhing, struggling to surmount the pointlessness that permeates this barren world.\r\nI am alone.\r\nI am empty.\r\nAnd yet,\r\nI fish.	','\r',char(13)),'\n',char(10)));
INSERT INTO catch_text VALUES('🐋',replace(replace('Let any fish who meets my gaze learn the true meaning of fear, for I am the harbinger of death, the bane of creatures subaqueous. My rod is true and unwavering as I cast it into the aquatic abyss. A man, scorned by this uncaring earth finds solace in the sea.\r\nMy only friend - the worm upon my hook, wriggling, writhing, struggling to surmount the pointlessness that permeates this barren world.\r\nI am alone.\r\nI am empty.\r\nAnd yet,\r\nI fish.	','\r',char(13)),'\n',char(10)));
INSERT INTO catch_text VALUES('🐊',replace(replace('Let any fish who meets my gaze learn the true meaning of fear, for I am the harbinger of death, the bane of creatures subaqueous. My rod is true and unwavering as I cast it into the aquatic abyss. A man, scorned by this uncaring earth finds solace in the sea.\r\nMy only friend - the worm upon my hook, wriggling, writhing, struggling to surmount the pointlessness that permeates this barren world.\r\nI am alone.\r\nI am empty.\r\nAnd yet,\r\nI fish.	','\r',char(13)),'\n',char(10)));
INSERT INTO catch_text VALUES('🐧',replace(replace('Let any fish who meets my gaze learn the true meaning of fear, for I am the harbinger of death, the bane of creatures subaqueous. My rod is true and unwavering as I cast it into the aquatic abyss. A man, scorned by this uncaring earth finds solace in the sea.\r\nMy only friend - the worm upon my hook, wriggling, writhing, struggling to surmount the pointlessness that permeates this barren world.\r\nI am alone.\r\nI am empty.\r\nAnd yet,\r\nI fish.	','\r',char(13)),'\n',char(10)));
INSERT INTO catch_text VALUES('🐙',replace(replace('Let any fish who meets my gaze learn the true meaning of fear, for I am the harbinger of death, the bane of creatures subaqueous. My rod is true and unwavering as I cast it into the aquatic abyss. A man, scorned by this uncaring earth finds solace in the sea.\r\nMy only friend - the worm upon my hook, wriggling, writhing, struggling to surmount the pointlessness that permeates this barren world.\r\nI am alone.\r\nI am empty.\r\nAnd yet,\r\nI fish.	','\r',char(13)),'\n',char(10)));
INSERT INTO catch_text VALUES('🦈',replace(replace('Let any fish who meets my gaze learn the true meaning of fear, for I am the harbinger of death, the bane of creatures subaqueous. My rod is true and unwavering as I cast it into the aquatic abyss. A man, scorned by this uncaring earth finds solace in the sea.\r\nMy only friend - the worm upon my hook, wriggling, writhing, struggling to surmount the pointlessness that permeates this barren world.\r\nI am alone.\r\nI am empty.\r\nAnd yet,\r\nI fish.	','\r',char(13)),'\n',char(10)));
INSERT INTO catch_text VALUES('🦑',replace(replace('Let any fish who meets my gaze learn the true meaning of fear, for I am the harbinger of death, the bane of creatures subaqueous. My rod is true and unwavering as I cast it into the aquatic abyss. A man, scorned by this uncaring earth finds solace in the sea.\r\nMy only friend - the worm upon my hook, wriggling, writhing, struggling to surmount the pointlessness that permeates this barren world.\r\nI am alone.\r\nI am empty.\r\nAnd yet,\r\nI fish.	','\r',char(13)),'\n',char(10)));
INSERT INTO catch_text VALUES('🦐',replace(replace('Let any fish who meets my gaze learn the true meaning of fear, for I am the harbinger of death, the bane of creatures subaqueous. My rod is true and unwavering as I cast it into the aquatic abyss. A man, scorned by this uncaring earth finds solace in the sea.\r\nMy only friend - the worm upon my hook, wriggling, writhing, struggling to surmount the pointlessness that permeates this barren world.\r\nI am alone.\r\nI am empty.\r\nAnd yet,\r\nI fish.	','\r',char(13)),'\n',char(10)));
INSERT INTO catch_text VALUES('🐬',replace(replace('Let any fish who meets my gaze learn the true meaning of fear, for I am the harbinger of death, the bane of creatures subaqueous. My rod is true and unwavering as I cast it into the aquatic abyss. A man, scorned by this uncaring earth finds solace in the sea.\r\nMy only friend - the worm upon my hook, wriggling, writhing, struggling to surmount the pointlessness that permeates this barren world.\r\nI am alone.\r\nI am empty.\r\nAnd yet,\r\nI fish.	','\r',char(13)),'\n',char(10)));
INSERT INTO catch_text VALUES('🦀',replace(replace('Let any fish who meets my gaze learn the true meaning of fear, for I am the harbinger of death, the bane of creatures subaqueous. My rod is true and unwavering as I cast it into the aquatic abyss. A man, scorned by this uncaring earth finds solace in the sea.\r\nMy only friend - the worm upon my hook, wriggling, writhing, struggling to surmount the pointlessness that permeates this barren world.\r\nI am alone.\r\nI am empty.\r\nAnd yet,\r\nI fish.	','\r',char(13)),'\n',char(10)));
INSERT INTO catch_text VALUES('🐡',replace(replace('Let any fish who meets my gaze learn the true meaning of fear, for I am the harbinger of death, the bane of creatures subaqueous. My rod is true and unwavering as I cast it into the aquatic abyss. A man, scorned by this uncaring earth finds solace in the sea.\r\nMy only friend - the worm upon my hook, wriggling, writhing, struggling to surmount the pointlessness that permeates this barren world.\r\nI am alone.\r\nI am empty.\r\nAnd yet,\r\nI fish.	','\r',char(13)),'\n',char(10)));
INSERT INTO catch_text VALUES('🛒','I''m going shopping, can I get ya''ll something?');
INSERT INTO catch_text VALUES('👞','Thanks for cleaning out the lake');
INSERT INTO catch_text VALUES('📎','Universally good');
INSERT INTO catch_text VALUES('🔋','Now you can almost power your remote :thumbsup: ');
INSERT INTO catch_text VALUES('🐟','Women want me, fish fear me');
INSERT INTO catch_text VALUES('🐠','https://c.tenor.com/GBRaEksaWqQAAAAM/oh-omg.gif ');
INSERT INTO catch_text VALUES('🔧','Thanks for cleaning out the lake');
COMMIT;
