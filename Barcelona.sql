CREATE DATABASE Barcelona;

USE Barcelona;

CREATE TABLE Admin(
	Name VARCHAR(100),
	Age  INT,
	Sex  VARCHAR(20),
	ID   INT AUTO_INCREMENT PRIMARY KEY,
	Date_of_Joining DATE,
	Club_Priority INT,
	Post VARCHAR(100)

);


CREATE TABLE Teams(
	Name VARCHAR(100) PRIMARY KEY,
	Sport VARCHAR(100),
	Budget INT,
	President_ID INT
);

CREATE TABLE Scouts(
	Name 			VARCHAR(100),
	Age  			INT,
	Sex  			VARCHAR(20),
	ID   			INT AUTO_INCREMENT PRIMARY KEY,
	Date_of_Joining DATE,
	Club_Priority 	INT,
	Area 			VARCHAR(100)
	
);



CREATE TABLE Players(
	Name VARCHAR(100),
	Age  INT,
	Sex  VARCHAR(20),
	ID   INT AUTO_INCREMENT PRIMARY KEY,
	Date_of_Joining DATE,
	Club_Priority INT,
	Position VARCHAR(100),
	Team_Name VARCHAR(100),
	FOREIGN KEY(Team_Name) REFERENCES Teams(Name) ON DELETE CASCADE
	
);
CREATE TABLE Transfer_Data(
	ID INT AUTO_INCREMENT PRIMARY KEY,
	Player_ID INT NOT NUll,
	Transfer_Money INT,
	Scout_ID INT NOT NUll,
	Previous_Club_Priority INT,
	Previous_Club VARCHAR(100),
	FOREIGN KEY(Player_ID) REFERENCES Players(ID) ON DELETE CASCADE,
	FOREIGN KEY(Scout_ID) REFERENCES Scouts(ID) ON DELETE CASCADE
);



CREATE TABLE Scout_Team_Info(
	Scout_ID INT,
	Team_Name VARCHAR(100),
	FOREIGN KEY(Scout_ID) REFERENCES Scouts(ID) ON DELETE CASCADE,
	FOREIGN KEY(Team_Name) REFERENCES Teams(Name) ON DELETE CASCADE

);

INSERT INTO Admin(Name,Age,Club_Priority,Date_of_Joining,Sex,Post) VALUES
			("Josep Bartomeu",56,10,'2014-01-23',"Male","President"),
			("Eric Abidal",	39	,9	,'2018-07-01',	"Male",	"Sporting Director"),
			("Ernesto Valverde"	,55	,10	,"2017-07-01","Male"	,"Manager"),
			('Fran Sanchez',41	,8,'2015-07-01',"Male"	,"Manager"),
			('Svetislav Persic',69,8,'2018-08-10','Male','Manager'),
			("Eugeny Zemeriak",50,7,'2011-07-01',"Male","Manager"),
			("Andreu Plaza",65,9,'2008-07-01',"Male","Manager");

INSERT INTO Teams(Name,Sport,Budget,President_ID) VALUES
			("FC Barcelona","Football",1050000000,1),
			("FC Barcelona Femini","Football",200000000,3),
			("FC Barcelona Basquet","BasketBall",150000000,6),
			("FC Barcelona Futsal","Futsal",60000000,2),
			("FC Barcelona Ice Hockey","Ice Hockey",50000000,7);


INSERT INTO Scouts(Name,Age,Club_Priority,Date_of_Joining,Sex,Area) VALUES
			("Carles Rexach",72,10,"1990-12-10","Male","South America"),
			('Jordi Melero',46,8,'2013-07-01',"Male","Southern Europe"),
			("Miki Albert",38,9,'2011-07-01',"Male","Northern Europe"),
			("Ariedo Braida",72,8,'2015-07-21',	"Male","Europe"),
			("Nino Lema",54,7,'2016-07-07',"Male","North America"),
			("Bojan Krkic",56,8,'2017-09-07',"Male","Europe");

INSERT INTO Scout_Team_Info(Scout_ID,Team_Name) VALUES
			(1,"FC Barcelona"),
			(2,"FC Barcelona"),
			(2,"FC Barcelona Basquet"),
			(3,"FC Barcelona"),
			(4,"FC Barcelona Femini"),
			(4,"FC Barcelona"),
			(5,"FC Barcelona Ice Hockey"),
			(6,"FC Barcelona Futsal");
INSERT INTO Players(Name,Age,Club_Priority,Date_of_Joining,Sex,Position,Team_Name) VALUES
			("Lionel Messi",31,9,"2000-06-01","Male","Right Wing","FC Barcelona"),
			("Marc-Andre ter Stegen",26,8,"2014-07-01","Male","Goalkeeper","FC Barcelona"),
			("Frenkie de jong",21,8,"2019-07-01","Male","Centre Midfield","FC Barcelona"),
			("Philippe Coutinho",26,6,"2018-01-08","Male","Left Wing","FC Barcelona"),
			("Lieke Martens",26,9,"2017-07-15","Female","Centre Midfield","FC Barcelona Femini"),
			("Pangos",26,7,"2018-07-01","Male","Shooting Guard","FC Barcelona Basquet"),
			("Alejandro Urgelles",25,9,"2013-06-01","Male","Left Wing","FC Barcelona Ice Hockey"),
			("Jesus Aicardo",30,7,"2012-07-01","Male","Defender","FC Barcelona Futsal"),
			("Ricard Puig",19,8,"2013-07-01","Male","Centre Midfield","FC Barcelona"),
			("Alexia Putellas",25,8,"2012-07-01","Female","Attacking Midfield","FC Barcelona Femini");


INSERT INTO Transfer_Data(Player_ID,Transfer_Money,Scout_ID,Previous_Club,Previous_Club_Priority) VALUES
			(4,180000000 ,6,"Liverpool",10),
			(10,30000000,4,"Levante Women",9),
			(2,19000000,2,"Borussia Monchengladbach",8),
			(3,90000000,3,"Ajax Amsterdam",10),
			(8,10000000,6,"Lobelle Santiago",8),
			(1,350000000,3,"Barcelona",10),
			(5,50000000,3,"Chelsea",7),
			(7,10000000,5,"Brandon",5),
			(9,50000000,3,"Barcelona",7),
			(6,1000000,1,"Lakers",10);


SELECT Name AS Most_Expensive_Player,Transfer_Money FROM Players JOIN Transfer_Data ON Transfer_Data.Player_ID=Players.ID ORDER BY Transfer_Money DESC LIMIT 1;
-- To get the player having the highest monetory value.

SELECT Name,Club_Priority FROM Players WHERE Name="Lionel Messi";
-- Check for upcoming Updation

UPDATE Players SET Club_Priority=10 WHERE Players.Name=(SELECT Most_Expensive_Player FROM (SELECT Name AS Most_Expensive_Player,Transfer_Money FROM Players JOIN Transfer_Data ON Transfer_Data.Player_ID=Players.ID ORDER BY Transfer_Money DESC LIMIT 1) AS Name2);
-- Giving the most expensive player highest Priority

SELECT Name,Club_Priority FROM Players WHERE Name="Lionel Messi";
-- Check for above done Updation

SELECT Name, Previous_Club_Priority, Club_Priority,Transfer_Money FROM Players JOIN Transfer_Data ON Transfer_Data.Player_ID=Players.ID WHERE
Previous_Club_Priority>Club_Priority AND Transfer_Money > 100000000;
-- players who have transfer value more than 100 million but have lost Club Priority compared to previous Club i.e. potential loss to the Club


SELECT Scouts.Name,DATEDIFF(CURDATE(),Scouts.Date_of_Joining)AS Experience_in_Days ,count(*) AS Number_of_Scoutings FROM Scouts LEFT JOIN Transfer_Data ON 
Scout_ID=Scouts.ID GROUP BY Scouts.ID ORDER BY Experience_in_Days DESC;
-- Experience_in_Days of the Team's Scouts and their number of Scoutings

SELECT Teams.Name,SUM(Transfer_Money) AS Total_Expenditure FROM Transfer_Data JOIN Players ON Transfer_Data.Player_ID=Players.ID JOIN Teams ON players.Team_Name=Teams.Name GROUP BY
Teams.Name ORDER BY Total_Expenditure DESC;
-- Total Expenditure of Each Team from all the tranfers

SELECT Teams.Name, Teams.Budget AS Original_Budget,Budget-Total_Expenditure AS Budget_Left  FROM Teams JOIN (SELECT Teams.Name,SUM(Transfer_Money) AS Total_Expenditure FROM Transfer_Data JOIN Players ON Transfer_Data.Player_ID=Players.ID JOIN Teams ON players.Team_Name=Teams.Name GROUP BY
Teams.Name ORDER BY Total_Expenditure DESC) AS SubQuery ON SubQuery.Name=Teams.Name ;
-- Budget Left after Transfer Window is Closed

SELECT Teams.Name AS Team_Name,count(*) AS Number_of_Scouts FROM Teams JOIN Scout_Team_Info ON Scout_Team_Info.Team_Name=Teams.Name GROUP BY Teams.Name ORDER BY Number_of_Scouts Desc; 
-- Number of Scouts for every Team

SELECT Admin.Name, Teams.Name, Club_Priority, DATEDIFF(CURDATE(),Admin.Date_of_Joining)AS Experience_in_Days FROM Admin LEFT JOIN Teams ON Teams.President_ID=Admin.ID 
ORDER BY Experience_in_Days Desc;
-- Sanity check for Priority of Admin. Also general Information about the Admin

DELETE FROM Admin WHERE Admin.Name=(SELECT Name_Admin FROM (SELECT Admin.Name AS Name_Admin, Teams.Name, Club_Priority, DATEDIFF(CURDATE(),Admin.Date_of_Joining)AS Experience_in_Days FROM Admin LEFT JOIN Teams ON Teams.President_ID=Admin.ID 
ORDER BY Experience_in_Days LIMIT 1) AS Name2);
-- Deleting the Least Experienced Admin


SELECT Admin.Name, Teams.Name, Club_Priority, DATEDIFF(CURDATE(),Admin.Date_of_Joining)AS Experience_in_Days FROM Admin LEFT JOIN Teams ON Teams.President_ID=Admin.ID 
ORDER BY Experience_in_Days Desc;
-- Check for the Above Done Deletion

SELECT * FROM Players WHERE Name="Jesus Aicardo";
-- Check for upcming Deletion

DELETE FROM Players WHERE Players.Name=(SELECT Name2.Name FROM (SELECT Name FROM Players JOIN Transfer_Data ON Transfer_Data.Player_ID=Players.ID WHERE Club_Priority<=7 AND Age>29 AND Transfer_Money>=10000000) AS Name2);
-- Deleting a player who has aged and was expensive and has low club Priority

SELECT * FROM Players WHERE Name="Jesus Aicardo";
-- Check for above done Deletion
