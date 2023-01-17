-- Height and Weight - Medalists

SELECT
    event,
    AVG(height) AS win_avg_height,
    AVG(weight) AS win_avg_weight
FROM
    oly_athlete_rowing
WHERE
    medal IN ('Gold', 'Silver', 'Bronze')
    AND year BETWEEN 1980 AND 2020
    AND Sex = "M"
    AND weight >= 68
GROUP BY
    event
ORDER BY
    Event
;

------------------

-- Height and Weight - Non-Medalists
SELECT
    event,
    AVG(height) AS non_win_avg_height,
    AVG(weight) AS non_win_avg_weight
FROM
    oly_athlete_rowing
WHERE
    medal NOT IN ('Gold', 'Silver', 'Bronze')
    AND year BETWEEN 1980 AND 2020
    AND Sex = 'M'
    AND weight >= 69
GROUP BY   
    event
ORDER BY
    Event
;

------------------

-- Difference between Medalists and Non-Medalists Height and Weight

SELECT
    winner.event,
    winner.win_avg_height - loser.lose_avg_height AS Height_Diff,
    winner.win_avg_weight - loser.lose_avg_weight AS Weight_Diff
FROM
(
    SELECT
        event,
        AVG(height) AS win_avg_height,
        AVG(weight) AS win_avg_weight
    FROM
        oly_athlete_rowing
    WHERE
        medal IN ('Gold', 'Silver', 'Bronze')
        AND year BETWEEN 1980 AND 2020
        AND Sex = "M"
        AND weight >= 68
    GROUP BY
        event
) AS winner
FULL OUTER JOIN
(
    SELECT
        event,
        AVG(height) AS lose_avg_height,
        AVG(weight) AS lose_avg_weight
    FROM
        oly_athlete_rowing
    WHERE
        medal NOT IN ('Gold', 'Silver', 'Bronze')
        AND year BETWEEN 1980 AND 2020
        AND Sex = 'M'
        AND weight >= 69
    GROUP BY
        event
) AS loser
ON winner.event = loser.event
GROUP BY
    winner.event,
    Height_Diff,
    Weight_Diff
ORDER BY
    winner.event
;

------------------

-- Medalist Height and Weight over years

SELECT
    year,
    AVG(height) AS win_avg_height,
    AVG(weight) AS win_avg_weight
FROM
    oly_athlete_rowing
WHERE
    medal IN ('Gold', 'Silver', 'Bronze')
    AND year BETWEEN 1980 AND 2020
    AND Sex = "M"
    AND weight >= 68
GROUP BY
    year
ORDER BY
    year
;

------------------

-- Medalist Average Age by Event

SELECT
    event,
    ROUND(AVG(age),1) AS winner_avg_age
FROM
    oly_athlete_rowing
WHERE
    medal IN ('Gold', 'Silver', 'Bronze')
    AND year BETWEEN 1980 AND 2020
    AND Sex = "M"
    AND weight >= 68
    AND event IN ("Rowing Men's Coxed Eights", "Rowing Men's Coxless Fours", 
    "Rowing Men's Coxless Pairs", "Rowing Men's Double Sculls", 
    "Rowing Men's Quadruple Sculls", "Rowing Men's Single Sculls")
GROUP BY
    event
ORDER BY
    winner_avg_age
;

------------------

-- Event Wins by Year and Country w/ Avg Age of Medalists (Can remove DISTINCT) to Count All members of the boat's medals.

SELECT
    team,
    year,
    COUNT(DISTINCT(event)) AS num_event_wins,
    AVG(age) as average_age_of_medalists
FROM
    (
        SELECT
            DISTINCT(team),
            year,
            medal,
            event,
            age
        FROM
            oly_athlete_rowing
        WHERE
            medal IN ('Gold', 'Silver', 'Bronze')
            AND year BETWEEN 1980 AND 2020
            AND Sex = "M"
            AND weight >= 68
            AND event IN ("Rowing Men's Coxed Eights", "Rowing Men's Coxless Fours", 
            "Rowing Men's Coxless Pairs", "Rowing Men's Double Sculls", 
            "Rowing Men's Quadruple Sculls", "Rowing Men's Single Sculls")
        ORDER BY    
            year,
            team
    ) AS event_wins
GROUP BY
    team,
    year
ORDER BY
    year
;


------------------


