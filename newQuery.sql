use ibook;

INSERT INTO `authors` VALUES (11,'Kathy Sierra'),(12,'Clifford Pickover'),(13,'Michael Clark');
INSERT INTO `authors` VALUES (14,'Sinnes Bert'),(15,'Robert Charles'),(16,'Michael Jordan');
INSERT INTO `authors` VALUES (17,'Andrew'),(18,'Taschen'),(19,'David Getches');
INSERT INTO `authors` VALUES (20,'K. Iyyer');

INSERT INTO `books` VALUES (7,9,'The Medical Book',1,8,'book8.jpg',2012,'The Medical Book by Clifford Pickover',698);
INSERT INTO `books` VALUES (8,5,'Head First Java',1,9,'book7.jpg',2013,'The Book by Kathy Sierra for Java Beginner',598);
INSERT INTO `books` VALUES (9,9,'Clinical Medicine',0,7,'book9.jpg',2011,'Clinical Medicine by Michael Clark and Praveen Kumar',614);
INSERT INTO `books` VALUES (10,6,'Worlds Best travel experiences',1,9,'book11.jpg',2013,'Worlds Best travel experiences for travel lovers',578);
INSERT INTO `books` VALUES (11,6,'The Travel book',0,8,'book10.jpg',2012,'The Travel book. Journey through every country in world',578);
INSERT INTO `books` VALUES (12,6,'Great escapes around the world',0,8,'book12.jpg',2012,'Great escapes around the world by Andrew',532);

INSERT INTO `books` VALUES (13,7,'Federal Indian Law',0,7,'book13.jpg',2013,'Federal Indian Law by Robert Charles',732);
INSERT INTO `books` VALUES (14,7,'The Indian Law',0,8,'book14.jpg',2012,'The Indian Law by K.Iyyer',532);


INSERT INTO `authors2books` VALUES (11,11,8);
INSERT INTO `authors2books` VALUES (12,12,7);
INSERT INTO `authors2books` VALUES (13,13,9);
INSERT INTO `authors2books` VALUES (14,17,10);
INSERT INTO `authors2books` VALUES (15,16,11);
INSERT INTO `authors2books` VALUES (16,18,12);

INSERT INTO `authors2books` VALUES (17,15,13);
INSERT INTO `authors2books` VALUES (18,20,14);