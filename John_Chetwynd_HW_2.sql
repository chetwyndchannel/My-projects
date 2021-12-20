/*
Question 1
List the name and height of the actresses who have been married to Tom Cruise
Order by name alphabetically
*/
SELECT
    name,
    height
FROM actors
WHERE spouses_string ILIKE '%tom cruise%'
ORDER BY name;




/*
Question 2
List the name, # of spouses, and # of divorces of the top 5 actors by number of divorces.
If two actors have the same number of divorces, break ties by ordering by name alphabetically
 */
SELECT
    name,
    spouses,
    divorces
FROM actors
ORDER BY divorces DESC, name ASC
LIMIT 5;






/*
Question 3
The original title, year, genre, country, average rating, and number of votes of
the top 5 (by avg_rating) Horror movies made in the USA with at least 10,000 votes.
Break ties in avg_rating with the original_title (alphabetically).
 */
SELECT
    original_title,
    year,
    genre,
    country,
    avg_vote
FROM movies
WHERE movies.votes >= 10000 AND avg_vote >=7
AND genre ILIKE '%Action%'
ORDER BY year DESC, original_title;



/*
Question 4
Name, date of birth, and place of birth of the
top 10 youngest living actors who were born on Feb 29 in the USA.
Order by youngest to oldest, then by name alphabetically.
*/
SELECT
    name,
    date_of_birth,
    place_of_birth
FROM actors
WHERE death_details IS NULL
    AND date_of_birth ILIKE '%-02-29%'
    AND place_of_birth ILIKE'%USA%'
ORDER BY date_of_birth DESC, name ASC
LIMIT 10;





/*
Question 5
What is the original title and duration of the longest movie made by the production company 'Marvel Studios'?
Rename the column 'original_title' to 'movie_title' and 'duration' to 'length_in_minutes'
 */
SELECT
    original_title movie_title,
    duration length_in_minutes
FROM movies
WHERE production_company ILIKE '%marvel studios%'
ORDER BY length_in_minutes DESC
limit 1;


/*
Question 6
Which production companies have made movies with at least an avg_vote of 8.8 over at least 100,000 votes?
Return the list in alphabetical order.
*/
SELECT 
    production_company,
    director,
    avg_vote,
    votes,
    original_title
FROM movies 
WHERE  avg_vote <=3
ORDER BY original_title ASC;

       



/*
Question 7
List the movies published between Christmas 2017 (2017-12-25) and New Years 2018 (2018-01-01)
Only include movies with at least 10,000 votes.
Order them by avg_vote, highest to lowest.
*/
SELECT
    original_title,
    date_published,
    avg_vote
FROM movies
WHERE date_published LIKE '____-07-04'
AND votes >=10000 AND avg_vote <=5
ORDER BY  avg_vote DESC;


/*
Question 8
Find the original_title, year, budget, and world-wide gross income of the
top 5 highest world-wide grossing zombie movies
Hint: You may need to use LTRIM to trim the '$ ' from worldwide_gross_income
*/
SELECT
    original_title,
    year,
    budget,
    worlwide_gross_income
FROM movies
WHERE description ILIKE '%ZOMBIE%'
    AND
      worlwide_gross_income IS NOT NULL
ORDER BY CAST(LTRIM(worlwide_gross_income ,'$')AS integer )DESC
LIMIT 5;



/*
Question 9
Find the top 10 actors by height (order by name, alphabetically, to break ties in height)
List the name, height (renamed to height_cm), and height_ft, which is height in feet/inches (e.g. 6 feet 5 inches),
rounded to the nearest inch.
There are 2.54 cm in 1 inch.  There are 12 inches in one foot.
Exclude any actors with a height >= 300 (as I believe there are some data errors)

Hint: To convert from one data type to another, use CAST(x AS <desired data type>)
You can use VARCHAR (for strings), INT (for integers), NUMERIC or DECIMAL (for floats)
*/
SELECT
    name,
    height AS height_cm,
    concat(FLOOR((height/2.54)/12), ' feet ',ROUND(MOD(height/2.54,12)), ' inches') AS height_ft
FROM actors
WHERE height <300
ORDER BY height DESC, name
limit 10;


/*
Question 10
List the original_title, usa_gross_income, worlwide_gross_income, and pct_gross_income_usa,
defined as the percentage of USA gross income out of total income,
for Tom Hanks movies.  Return the lowest 10 movies only by pct_gross_income_usa (i.e. the 10 movies that
had the lowest pct_gross_income_usa).
Round pct_gross_income_usa to one decimal place.
*/
SELECT
    original_title,
    usa_gross_income,
    worlwide_gross_income,
    ROUND((CAST(LTRIM(usa_gross_income, '$')AS DECIMAL)/CAST(LTRIM(worlwide_gross_income,'$')AS DECIMAL))*100,1)AS pct_gross_income_usa
FROM movies
WHERE actors ILIKE '%tom Hanks%'
AND
   worlwide_gross_income IS NOT NULL
AND
  usa_gross_income IS NOT NULL
ORDER BY pct_gross_income_usa descending
limit 10;


