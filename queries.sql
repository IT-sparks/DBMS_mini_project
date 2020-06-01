--few simple queries

--List the unique teams along with their head coach
		SELECT TEAM_NAME,HEAD_COACH FROM TEAM;	

--list all venues in which Super_kings is the visitor
SELECT VENUE FROM GAME WHERE VISITOR='Super Kings';

--list all players along with their role and skill ,playing for Kolkata Knight Riders
SELECT NAME FROM PLAYER WHERE TEAM ='Kolkata Knight Riders';

--JOIN ON CONDITION query
		--list the skipper name for every corresponding team 
		SELECT team_name,name AS CAPTAIN_NAME from TEAM JOIN PLAYER ON CAPTAIN=FRANCHISE_PLAYER_ID;

--#2.NESTED QUERIES (sub queries)

		--#1.retrieve only the name and skill level of all the batsmen with skill level >=8 ,playing for the team Mumbai Indians --with no injury records in this season.

		SELECT NAME,SKILL AS SKILL_LEVEL FROM ( SELECT * FROM PLAYER WHERE TEAM='Mumbai Indians' AND  POSITION='batsman' AND SKILL>=8 AND FRANCHISE_PLAYER_ID NOT IN(SELECT PLAYER_ID FROM INJURY_RECORD)) AS FINAL_RESULT;

		--#2.list the venue and the opponents of the team 'Super Kings' on all occassions when their team player was injured. 

		CREATE TABLE NEW AS SELECT HOST,VISITOR,VENUE FROM GAME WHERE DATE_OF_GAME IN (SELECT DATE_OF_INJURY FROM PLAYER JOIN INJURY_RECORD ON  TEAM='Super Kings' AND FRANCHISE_PLAYER_ID=PLAYER_ID) AND (HOST='Super Kings' OR VISITOR='Super Kings') ;

		--temporary table is created on fly

		SELECT VENUE,

		CASE 
			WHEN VISITOR ='Super Kings' THEN HOST 
			ELSE VISITOR 

		END AS OPPONENT

		FROM NEW;

--#3.Aggregate and Group-By queries  
 
		--i.what is the total no.of.corporates sponsoring the team 'Super Kings'?

		SELECT COUNT(CORPORATE_NAME) as total_sponsors FROM SPONSOR WHERE TEAM='Super Kings';

		--ii.Retrieve the total amount invested(Millions) on 'Super Kings' franchise.

		SELECT CAST (SUM(FUNDS) AS FLOAT)/1000000 as Funds_millions FROM SPONSOR WHERE TEAM='Super Kings';

		--iii.list the total no.of.sponsors per team along with the team_name

		SELECT COUNT(CORPORATE_NAME) AS NO_OF_SPONSORS ,TEAM FROM SPONSOR GROUP BY TEAM;


--#4. OUTER JOIN
		--i.perform a left outer join on players table and injury_record of players based on their player_id and list the name,id,team_name and injury description.

		SELECT FRANCHISE_PLAYER_ID,TEAM,NAME,DESCRIPTION FROM PLAYER LEFT JOIN INJURY_RECORD ON PLAYER_ID=FRANCHISE_PLAYER_ID;

		--ii.Perform an outer join to list the players' name ,team_name for which they are the capatin.

		select Player.franchise_player_id,Player.name,Team.team_name as skipper_of_team from player left join team on team.Captain=player.franchise_player_id;
		
--#5.Correlated Subqueries

		--i.Select the player with highest skill level in every Participating team along with his skill_level.

		SELECT NAME,SKILL FROM PLAYER AS P WHERE SKILL = ( SELECT MAX(SKILL) FROM PLAYER D WHERE D.TEAM=P.TEAM );









