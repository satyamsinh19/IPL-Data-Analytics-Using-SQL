-- Creating Table ipl_matches
CREATE TABLE ipl_matches (
	id INT PRIMARY KEY,	
	season INT,	
	city VARCHAR(50),	
	date DATE,	
	team1 TEXT,	
	team2 TEXT,	
	toss_winner TEXT,	
	toss_decision VARCHAR(10),	
	result VARCHAR(20),	
	dl_applied BOOLEAN,
	winner TEXT,	
	win_by_runs INT,	
	win_by_wickets INT, 
	player_of_match TEXT,	
	venue TEXT, 
	umpire1 VARCHAR(100),
	umpire2 VARCHAR(100)
);


-- The table was imported manually due to a permission denied error encountered when using the SQL COPY command.
-- Fetching all the datas within the table
SELECT * FROM ipl_matches;


-- Basic Queries
-- 1. How many total matches were played?
SELECT COUNT(*) AS total_matches FROM ipl_matches;


-- 2. How many seasons are included in the dataset?
SELECT COUNT(DISTINCT season) AS total_seasons FROM ipl_matches;


-- 3. How many matches were played in each season?
SELECT DISTINCT season, COUNT(*) AS matches_played FROM ipl_matches
GROUP BY season
ORDER BY matches_played;


-- 4. How many unique cities hosted IPL matches?
SELECT COUNT(DISTINCT city) as total_cities FROM ipl_matches;


-- 5. Which city hosted the most matches?
SELECT DISTINCT city, COUNT(*) AS matches_hosted FROM ipl_matches
GROUP BY city
ORDER BY matches_hosted DESC;


-- 6. How many unique venues hosted IPL matches?
SELECT COUNT(DISTINCT venue) as total_venues FROM ipl_matches;


-- 7. Which venue has hosted the highest number of matches?
SELECT DISTINCT venue, COUNT(*) AS matches_hosted FROM ipl_matches
GROUP BY venue
ORDER BY matches_hosted DESC
LIMIT 1;


-- 8. How many matches did each team win?
SELECT DISTINCT winner, COUNT(*) as matches_won FROM ipl_matches
GROUP BY winner
ORDER BY matches_won DESC;


-- 9. How many times did each team win the toss?
SELECT DISTINCT toss_winner, COUNT(*) as tosses_won FROM ipl_matches
GROUP BY toss_winner
ORDER BY tosses_won DESC;


-- 10. What is the frequency of each toss decision (bat vs field)?
SELECT toss_decision, COUNT(*) AS toss_count FROM ipl_matches
GROUP BY toss_decision;


-- 11. How many matches were decided by D/L method?
SELECT COUNT(*) AS matches FROM ipl_matches
WHERE dl_applied = TRUE;


-- 12. Which team has won the most matches while chasing?
SELECT winner, COUNT(*) matches_won FROM ipl_matches
WHERE win_by_wickets>0
GROUP BY winner
ORDER BY matches_won DESC
LIMIT 1;


-- 13. Which team has won the most matches while defending?
SELECT winner, COUNT(*) matches_won FROM ipl_matches
WHERE win_by_runs>0
GROUP BY winner
ORDER BY matches_won DESC
LIMIT 1;


-- 14. What are the top 5 matches with highest win margins by runs?
SELECT team1, team2, winner, win_by_runs FROM ipl_matches
GROUP BY team1, team2, winner, win_by_runs
ORDER BY win_by_runs DESC
LIMIT 5;


-- 15. What are the top 5 matches with highest win margins by wickets?
SELECT team1, team2, winner, win_by_wickets FROM ipl_matches
GROUP BY team1, team2, winner, win_by_wickets
ORDER BY win_by_wickets DESC
LIMIT 5;


-- 16. Which players have won the most "Player of the Match" awards?
SELECT player_of_match, COUNT(*) AS no_of_times FROM ipl_matches
GROUP BY player_of_match
ORDER BY no_of_times DESC
LIMIT 1;


-- 17. Which seasons had the most matches?
SELECT DISTINCT season, COUNT(*) AS total_matches FROM ipl_matches
GROUP BY season
ORDER BY total_matches DESC
LIMIT 1;



-- 18. How many matches ended in a tie or no result?
SELECT COUNT(*) AS total_matches FROM ipl_matches
WHERE result = 'tie' OR result = 'no result';


-- 19. Which team appeared in the most matches?
SELECT team, COUNT(*) AS no_of_appearance
FROM (
    SELECT team1 AS team FROM ipl_matches
    UNION ALL
    SELECT team2 FROM ipl_matches
) AS combined_teams
GROUP BY team
ORDER BY no_of_appearance DESC
LIMIT 1;


-- 20. How many different umpires officiated across all matches?
SELECT COUNT(DISTINCT umpire) AS total_umpires
FROM (
    SELECT umpire1 AS umpire FROM ipl_matches
    UNION ALL
    SELECT umpire2 FROM ipl_matches
) AS all_umpires;




-- 21. What are the most frequent team pairings in IPL history (team1 vs team2)?
SELECT 
    LEAST(team1, team2) AS team_a,
    GREATEST(team1, team2) AS team_b,
    COUNT(*) AS total_matches
FROM ipl_matches
GROUP BY LEAST(team1, team2), GREATEST(team1, team2)
ORDER BY total_matches DESC;


-- Advanced Queries
--- 1. Who was the top "Player of the Match" for each season?
WITH no_of_times AS (
  SELECT season, player_of_match, COUNT(*) AS total_times,
         RANK() OVER (PARTITION BY season ORDER BY COUNT(*) DESC) AS rnk
  FROM ipl_matches
  GROUP BY season, player_of_match
)
SELECT season, player_of_match, total_times
FROM no_of_times
WHERE rnk = 1
ORDER BY season;


-- 2. What is the win percentage of each team (based on total matches they played)?
WITH total_matches AS (
    SELECT team, COUNT(*) AS matches_played
    FROM (
        SELECT team1 AS team FROM ipl_matches
        UNION ALL
        SELECT team2 FROM ipl_matches
    ) AS combined
    GROUP BY team
),
total_wins AS (
    SELECT winner AS team, COUNT(*) AS matches_won
    FROM ipl_matches
    WHERE winner IS NOT NULL
    GROUP BY winner
)
SELECT 
    tm.team,
    tm.matches_played,
    COALESCE(tw.matches_won, 0) AS matches_won,
    ROUND((COALESCE(tw.matches_won, 0)::DECIMAL / tm.matches_played) * 100, 2) AS win_percentage
FROM total_matches tm
LEFT JOIN total_wins tw ON tm.team = tw.team
ORDER BY win_percentage DESC;


-- 3. Which team had the most finals appearances? 
WITH finals AS (
  SELECT DISTINCT ON (season) *
  FROM ipl_matches
  ORDER BY season, date DESC
)
SELECT team, COUNT(*) AS final_appearances
FROM (
    SELECT team1 AS team FROM finals
    UNION ALL
    SELECT team2 FROM finals
) AS final_teams
GROUP BY team
ORDER BY final_appearances DESC;


-- 4. Which venue has had the most variety of winning teams (i.e., most unique winners)?
SELECT venue, COUNT(DISTINCT winner) AS unique_winners FROM ipl_matches
WHERE winner IS NOT NULL
GROUP BY venue
ORDER BY unique_winners DESC;


-- 5. Which seasons had the highest number of different winning teams?
SELECT season, COUNT(DISTINCT winner) AS unique_winners FROM ipl_matches
WHERE winner IS NOT NULL
GROUP BY season
ORDER BY unique_winners DESC;


-- 6. Which team has the highest average margin of victory while chasing?
SELECT winner, ROUND(AVG(win_by_wickets), 2) AS avg_wickets_margin FROM ipl_matches
WHERE win_by_wickets > 0
GROUP BY winner
ORDER BY avg_wickets_margin DESC;


-- 7. Which team has the highest average margin of victory while defending?
SELECT winner, ROUND(AVG(win_by_runs), 2) AS avg_runs_margin
FROM ipl_matches
WHERE win_by_runs > 0
GROUP BY winner
ORDER BY avg_runs_margin DESC;


-- 8. Which team had the most consistent appearances per season?
SELECT team, COUNT(DISTINCT season) AS seasons_played
FROM (
    SELECT season, team1 AS team FROM ipl_matches
    UNION
    SELECT season, team2 FROM ipl_matches
) AS season_teams
GROUP BY team
ORDER BY seasons_played DESC;


-- 9. Which team lost the most matches after winning the toss?
SELECT toss_winner, COUNT(*) AS losses_after_winning_toss FROM ipl_matches
WHERE toss_winner IS NOT NULL
  AND winner IS NOT NULL
  AND toss_winner <> winner
GROUP BY toss_winner
ORDER BY losses_after_winning_toss DESC;


-- 10. Which season had the highest number of D/L affected matches?
SELECT season,  COUNT(*) AS dl_affected_matches FROM ipl_matches
WHERE dl_applied = TRUE
GROUP BY season
ORDER BY dl_affected_matches DESC;


-- 11. Who are the top 3 umpires with most match appearances?
SELECT umpire, COUNT(*) AS matches_officiated
FROM (
    SELECT umpire1 AS umpire FROM ipl_matches
    WHERE umpire1 IS NOT NULL
    UNION ALL
    SELECT umpire2 FROM ipl_matches
    WHERE umpire2 IS NOT NULL
) AS all_umpires
GROUP BY umpire
ORDER BY matches_officiated DESC
LIMIT 3;


-- 12. Find the most dominant season for any team.
WITH season_team_wins AS (
    SELECT 
        season,
        winner AS team,
        COUNT(*) AS wins
    FROM ipl_matches
    WHERE winner IS NOT NULL
    GROUP BY season, winner
)
SELECT *
FROM season_team_wins
ORDER BY wins DESC
LIMIT 1;


-- 13. Which toss winner had the highest win conversion rate?
SELECT 
    toss_winner AS team,
    COUNT(*) AS tosses_won,
    COUNT(CASE WHEN toss_winner = winner THEN 1 END) AS wins_after_toss,
    ROUND(
        COUNT(CASE WHEN toss_winner = winner THEN 1 END)::DECIMAL 
        / COUNT(*) * 100, 2
    ) AS win_conversion_rate
FROM ipl_matches
WHERE toss_winner IS NOT NULL AND winner IS NOT NULL
GROUP BY toss_winner
ORDER BY win_conversion_rate DESC;


-- 14. Which city has hosted IPL matches for the most number of different seasons?
SELECT city, COUNT(DISTINCT season) AS seasons_hosted FROM ipl_matches
WHERE city IS NOT NULL
GROUP BY city
ORDER BY seasons_hosted DESC;









