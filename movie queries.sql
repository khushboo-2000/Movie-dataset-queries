create database mov;
use mov;

-- editing few table -- 
truncate table rating;
truncate table reviewer;

select *from rating;

insert into rating values (901, 9001, 8.40, 263575),
						(902, 9002, 7.90, 20207),
                        (903, 9003, 8.30 , 202778),
                        (906, 9005, 8.20 , 484746),
						(924, 9006, 7.30 , NULL),
						(908, 9007, 8.60 , 779489),
						(909, 9008, NULL, 227235),
						(910, 9009, 3.00 , 195961),
						(911, 9010, 8.10 , 203875),
						(912, 9011, 8.40 , NULL),
						(914, 9013, 7.00 , 862618),
						(915, 9001, 7.70 , 830095),
						(916, 9014, 4.00 , 642132),
						(925, 9015, 7.70 , 81328),
						(918, 9016, NULL, 580301),
						(920, 9017, 8.10 , 609451),
						(921, 9018, 8.00 , 667758),
						(922, 9019, 8.40 , 511613),
						(923, 9020, 6.70 , 13091);
                        
insert into reviewer values (9001, 'Righty Sock'),
(9002, 'Jack Malvern'),
(9003, 'Flagrant Baronessa'),
(9004, 'Alec Shaw'),
(9005, NULL),
(9006, 'Victor Woeltjen'),
(9007, 'Simon Wright'),
(9008, 'Neal Wruck'),
(9009, 'Paul Monks'),
(9010, 'Mike Salvati'),
(9011, NULL),
(9012, 'Wesley S. Walker'),
(9013, 'Sasha Goldshtein'),
(9014, 'Josh Cates'),
(9015, 'Krug Stillo'),
(9016, 'Scott LeBrun'),
(9017, 'Hannah Steele'),
(9018, 'Vincent Cadena'),
(9019, 'Brandt Sponseller'),
(9020, 'Richard Adams');

# 1. From the following table, write a SQL query to find the name and year of the movies. Return movie title, movie release year.
Select mov_title , mov_year from movie;

#2. From the following table, write a SQL query to find when the movie 'American Beauty' released. Return movie release year.
select mov_year from movie where mov_title = 'American Beauty';


#3. From the following table, write a SQL query to find the movie that was released in 1999. Return movie title.
select mov_title from movie where mov_year = 1999;

#4. From the following table, write a SQL query to find those movies, which were released before 1998. Return movie title. 
select mov_title from movie where mov_year < 1998;


#5. From the following tables, write a SQL query to find the name of all reviewers and movies together in a single list.
select rev_name from reviewer union (select mov_title from movie);

-- #6. From the following table, write a SQL query to find all reviewers who have rated seven or more stars to their rating. Return reviewer name.
select r.rev_name from reviewer as r
left join rating as r1 on r1.rev_id = r.rev_id
where rev_stars > 7 and r.rev_name is not null;


#7. From the following tables, write a SQL query to find the movies without any rating. Return movie title.
 select movie.mov_title from movie
 left join rating on movie.mov_id = rating.mov_id
 where rev_stars is null;
 
 
 #8. From the following table, write a SQL query to find the movies with ID 905 or 907 or 917. Return movie title.
 select mov_title from movie where mov_id in (905,907,917);
 
 #9. From the following table, write a SQL query to find the movie titles that contain the word 'Boogie Nights'. Sort the result-set in ascending order by movie year. 
 # Return movie ID, movie title and movie release year.  
 select mov_id, mov_title, mov_year from movie where mov_title like '%Boogie Nights%' order by mov_year ASC;
 
 
 #10. From the following table, write a SQL query to find those actors with the first name 'Woody' and the last name 'Allen'. Return actor ID.
 select act_id from actor where act_fname = 'woody' and act_lname = 'allen';
 
 ### subquery 
 #1. From the following table, write a SQL query to find the actors who played a role in the movie 'Annie Hall'. Return all the fields of actor table. 
select * from actor where act_id in(select act_id from movie_cast where mov_id in(select mov_id from movie where mov_title = 'Annie Hall'));

#2. From the following tables, write a SQL query to find the director of a film that cast a role in 'Eyes Wide Shut'. Return director first name, last name.
select dir_fname, dir_lname from director where dir_id in (select dir_id from movie_director where mov_id in (select mov_id from movie where mov_title = 'Eyes Wide Shut'));

# 3. From the following table, write a SQL query to find those movies that have been released in countries other than the United Kingdom.
# Return movie title, movie year, movie time, and date of release, releasing country.
select mov_title, mov_year, mov_time, mov_dt_rel, mov_rel_country from movie where mov_rel_country != 'UK';

-- #4. From the following tables, write a SQL query to find for movies whose reviewer is unknown. 
-- # Return movie title, year, release date, director first name, last name, actor first name, last name.
select mov_title, mov_year, mov_dt_rel, dir_fname, dir_lname, act_fname, act_lname from movie as m, director as d, actor as a, movie_director as md, rating as r, reviewer as re, movie_cast as mc
where m.mov_id = md.mov_id
and m.mov_id = mc.mov_id
and m.mov_id = r.mov_id
and md.dir_id = d.dir_id
and r.rev_id = re.rev_id
and a.act_id = mc.act_id
and re.rev_name is null;

#5. From the following tables, write a SQL query to find those movies directed by the director whose first name is Woddy or last name is Allen. Return movie title. 
select mov_title from movie where mov_id in(select mov_id from movie_director where dir_id in (select dir_id from director where dir_fname = 'Woddy' or dir_lname = 'Allen'));

# 6. From the following tables, write a SQL query to determine those years in which there was at least one movie that received a rating of at least three stars.
#  Sort the result-set in ascending order by movie year. Return movie year.
select mov_year from movie where mov_id in (select mov_id from rating where rev_stars > 2) order by mov_year asc;


#7. From the following table, write a SQL query to search for movies that do not have any ratings. Return movie title.
select mov_title from movie where mov_id not in (select mov_id from rating );
desc rating;
select * from rating;

#8. From the following table, write a SQL query to find those reviewers who have not given a rating to certain films. Return reviewer name.
select rev_name from reviewer where rev_id in (select rev_id from rating where rev_stars is null);

# 9. From the following tables, write a SQL query to find movies that have been reviewed by a reviewer and received a rating. 
# Sort the result-set in ascending order by reviewer name, movie title, review Stars. 
# Return reviewer name, movie title, review Stars.
select rev_name, mov_title, rev_stars from reviewer as re, movie as m, rating as r
where  re.rev_id = r.rev_id
and m.mov_id = r.mov_id
and r.rev_stars is not null
and re.rev_name is not null
order by rev_name,mov_title,rev_stars ASC;

-- #10. From the following table, write a SQL query to find movies that have been reviewed by a reviewer and received a rating. 
-- # Group the result set on reviewer’s name, movie title. Return reviewer’s name, movie title.
select rev_name, mov_title from reviewer as re, movie as m, rating as r 
where re.rev_id = r.rev_id
and r.mov_id = m.mov_id
group by rev_name, mov_title having count(*) > 1;


-#11. From the following tables, write a SQL query to find those movies, which have received highest number of stars. 
-- Group the result set on movie title and sorts the result-set in ascending order by movie title. 
-- Return movie title and maximum number of review stars.  
select* from rating;
select mov_title, max(rev_stars)  from movie as m, rating as r  
where r.mov_id = m.mov_id
and r.rev_stars is not null
group by mov_title  
order by mov_title asc;


#12. From the following tables, write a SQL query to find all reviewers who rated the movie 'American Beauty'. Return reviewer name.
select rev_name from reviewer as re, rating as r, movie as m
where re.rev_id = r.rev_id
and r.mov_id = m.mov_id
and m.mov_title = 'American Beauty';


#13. From the following table, write a SQL query to find the movies that have not been reviewed by any reviewer body other than 'Paul Monks'. Return movie title.
select mov_title from movie 
where mov_id in (select mov_id from rating where rev_id not in(select rev_id from reviewer where rev_name = 'Paul Monks'));

#14. From the following table, write a SQL query to find the movies with the lowest ratings. Return reviewer name, movie title, and number of stars for those movies.
SELECT reviewer.rev_name, movie.mov_title, rating.rev_stars
FROM reviewer, movie, rating
WHERE rating.rev_stars = (
SELECT MIN(rating.rev_stars)
FROM rating
)
AND rating.rev_id = reviewer.rev_id
AND rating.mov_id = movie.mov_id;



#  15. From the following tables, write a SQL query to find the movies directed by 'James Cameron'. Return movie title. 
select mov_title from movie where mov_id in (select mov_id from movie_director where dir_id in (select dir_id from director where dir_fname = 'James' and dir_lname = 'Cameron'));

#16. Write a query in SQL to find the movies in which one or more actors appeared in more than one film.
select mov_title from movie where mov_id in (select mov_id from movie_cast where act_id in (select act_id from actor where act_id in (select act_id from movie_cast group by act_id having count(act_id)>1)));



## joins

#1. From the following table, write a SQL query to find all reviewers whose ratings contain a NULL value. Return reviewer name.
select rev_name from reviewer as re
left join rating as r on r.rev_id = re.rev_id 
where rev_stars is null;


# 2. From the following table, write a SQL query to find out who was cast in the movie 'Annie Hall'. Return actor first name, last name and role.
select act_fname, act_lname, role from actor as a
left join movie_cast as mc
on a.act_id = mc.act_id 
left join  movie as m 
on m.mov_id = mc.mov_id
where m.mov_title = 'Annie Hall';

-- #3. From the following table, write a SQL query to find the director who directed a movie that featured a role in 'Eyes Wide Shut'. Return director first name, last name and movie title.
SELECT d.dir_fname, d.dir_lname, m.mov_title
from director as d
join movie_director  as md on md.dir_id = d.dir_id
join movie_cast as mc on md.mov_id = mc.mov_id
join movie as m on m.mov_id = mc.mov_id
where mov_title ='Eyes Wide Shut';



#4. From the following tables, write a SQL query to find the director of a movie that cast a role as Sean Maguire. Return director first name, last name and movie title.

select dir_fname, dir_lname , mov_title
from director as d
join movie_director as md on d.dir_id = md.dir_id
join movie as m on md.mov_id = m.mov_id
join movie_cast as mc on mc.mov_id = m.mov_id
where role= 'Sean Maguire';

#5. From the following table, write a SQL query to find out which actors have not appeared in 
-- any movies between 1990 and 2000 (Begin and end values are included.). Return actor first name, last name, movie title and release year. 
select act_fname, act_lname, mov_title, mov_year 
from actor as a
join movie_cast as mc on a.act_id = mc.act_id
join movie as m on m.mov_id = mc.mov_id 
where m.mov_year not between 1990 and 2000;


# 6. From the following table, write a SQL query to find the directors who have directed films in a variety of genres.
--  Group the result set on director first name, last name and generic title. 
-- Sort the result-set in ascending order by director first name and last name. Return director first name, last name and number of genres movies.

select dir_fname, dir_lname , gen_title,count(gen_title)
from director as d 
join movie_director as md on d.dir_id = md.dir_id 
join movie_genres as mg on mg.mov_id = md.mov_id 
join genres as g on g.gen_id = mg.gen_id
group by dir_fname, dir_lname ,gen_title
order by dir_fname,dir_lname;


#7. From the following table, write a SQL query to  find the movies with year and genres. Return movie title, movie year and generic title. 
select mov_title , mov_year , gen_title
from movie 
natural join movie_genres  
natural join genres ;
select * from movie;


# 8. From the following tables, write a SQL query to find all the movies with year, genres, and name of the director.
select mov_title, mov_year, gen_title, dir_fname, dir_lname
from movie as m
join movie_director as md on m.mov_id = md.mov_id
join director as d on d.dir_id = md.dir_id
join movie_genres as mg on mg.mov_id = md.mov_id
join genres as g on g.gen_id = mg.gen_id;

#9. From the following tables, write a SQL query to find the movies released before 1st January 1989. 
-- Sort the result-set in descending order by date of release.
 -- Return movie title, release year, date of release, duration, and first and last name of the director.

 select mov_title, mov_year, mov_dt_rel, mov_time , dir_fname, dir_lname
 from movie as m 
 join movie_director as md on md.mov_id = m.mov_id
 join director as d on d.dir_id = md.dir_id
 where mov_dt_rel < '01-01-1989'
 order by mov_dt_rel desc;

# 10. From the following table,
-- write a SQL query to calculate the average movie length and count the number of movies in each genre.
-- Return genre title, average time and number of movies for each genre.
select gen_title, avg(mov_time),  gen_title, count(gen_title)
from movie as m
join movie_genres as mg on mg.mov_id = m.mov_id
join genres as g on g.gen_id = mg.gen_id
group by  gen_title;


#11. From the following table, write a SQL query to find movies with the shortest duration. 
-- Return movie title, movie year, director first name, last name, actor first name, last name and role.

select mov_title, mov_year, dir_fname, dir_lname, act_fname, act_lname, role
from movie as m
join movie_director as md on m.mov_id = md.mov_id
join movie_cast as mc on mc.mov_id = md.mov_id
join director as d on md.dir_id = d.dir_id 
join actor as a on a.act_id = mc.act_id 
where mov_time = (select min(mov_time) from movie);


#12. From the following table, 
-- write a SQL query to find the years in which a movie received a rating of 3 or 4. 
-- Sort the result in increasing order on movie year.
select mov_year 
from movie as m
join rating as r on r.mov_id = m.mov_id
where rev_stars in (3,4);

# 13. From the following tables, write a SQL query to get the reviewer name, movie title,
-- and stars in an order that reviewer name will come first, then by movie title, and lastly by number of stars.
select rev_name , mov_title, rev_stars 
from movie as m
join rating as r on r.mov_id = m.mov_id
join reviewer as re on re.rev_id = r.rev_id
where rev_name is not null
order by rev_name, mov_title, rev_stars;

# 14. From the following table, write a SQL query to find 
-- those movies that have at least one rating and received the most stars. 
-- Sort the result-set on movie title. Return movie title and maximum review stars. 

select mov_title, max(rev_stars)
from movie as m 
join rating as r on r.mov_id = m.mov_id
group by mov_title
having max(rev_stars)>0
order by mov_title;

# 15. From the following table, write a SQL query to find out which movies have received ratings.
-- Return movie title, director first name, director last name and review stars. 

select mov_title , dir_fname , dir_lname , rev_stars
from movie as m 
join rating as r on m.mov_id = r.mov_id
join movie_director as md on md.mov_id = r.mov_id
join director as d on d.dir_id = md.dir_id
where rev_stars is not null;


# 16. From the following table, write a SQL query to find movies in which one or 
-- more actors have acted in more than one film. Return movie title, actor first and last name, and the role.
select mov_title , act_fname, act_lname, role
from movie as m
join movie_cast as mc on mc.mov_id = m.mov_id
join actor as a on a.act_id = mc.act_id
where a.act_id in (select act_id 
from movie_cast 
group by act_id having count(*)>=2);


# 17. From the following tables, write a SQL query to find the actor whose first name 
-- is 'Claire' and last name is 'Danes'. 
-- Return director first name, last name, movie title, actor first name and last name, role. 
select dir_fname, dir_lname, mov_title, act_fname, act_lname, role
from movie as m
join movie_cast as mc on m.mov_id = mc.mov_id
join actor as a on a.act_id = mc.act_id
join movie_director as md on md.mov_id = mc.mov_id
join director as d on md.dir_id = d.dir_id
where act_fname= 'Claire' and act_lname = 'Danes';


-- # 18. From the following table, write a SQL query to find for actors whose 
-- films have been directed by them. 
-- Return actor first name, last name, movie title and role.

select act_fname, act_lname, mov_title, role
from movie as m
join movie_cast as mc on mc.mov_id = m.mov_id
join movie_director as md on md.mov_id = mc.mov_id
join actor as a on a.act_id = mc.act_id
join director as d on md.dir_id = d.dir_id
where a.act_fname = d.dir_fname
and a.act_lname = d.dir_lname;


-- # 19. From the following tables, write a SQL query to 
-- find the cast list of the movie ‘Chinatown’. Return first name, last name.

select act_fname, act_lname
from actor as a 
join movie_cast as mc on mc.act_id = a.act_id
join movie as m on m.mov_id = mc.mov_id
where mov_title = 'Chinatown';

-- # 20. From the following tables, write a SQL query to find those movies 
-- where actor’s first name is 'Harrison' and last name is 'Ford'. Return movie title.

select mov_title 
from movie as m
join movie_cast as mc on mc.mov_id = m.mov_id
join actor as a on a.act_id = mc.act_id
where act_fname= 'Harrison' and act_lname = 'Ford';


-- # 21. From the following tables, write a SQL query to find the highest-rated movies. 
-- Return movie title, movie year, review stars and releasing country.

select mov_title, mov_year, rev_stars, mov_rel_country
from movie as m
join rating as r on m.mov_id = r.mov_id
having r.rev_stars = (select max(rev_stars) from rating);

-- # 22. From the following tables, write a SQL query to find the highest-rated ‘Mystery Movies’.
--  Return the title, year, and rating. 
select mov_title, mov_year, rev_stars
from movie as m
join movie_genres as mg on mg.mov_id = m.mov_id 
join genres as g on mg.gen_id = g.gen_id 
join rating as r on r.mov_id = m.mov_id 
where g.gen_title = 'Mystery';


-- # 23. From the following tables, write a SQL query to find the years when most of the ‘Mystery Movies’ 
-- produced. Count the number of generic title and compute their average rating. Group the result set on 
-- movie release year, generic title. 
-- Return movie year, generic title, number of generic title and average rating. 

select mov_year, gen_title, count(gen_title), avg(rev_stars)
from movie as m 
join rating as r on m.mov_id = r.mov_id
join movie_genres as mg on m.mov_id = mg.mov_id
join genres as g on g.gen_id = mg.gen_id
where g.gen_title = 'Mystery'
group by mov_year , gen_title
order by mov_year, gen_title, count(gen_title), avg(rev_stars);


-- # 24. From the following tables, write a query in SQL to generate a report, 
-- which contain the fields movie title, name of the female actor, year of the movie, role,
--  movie genres, the director, date of release, and rating of that movie.

select mov_title, act_fname, act_lname, mov_year, 
role, gen_title, dir_fname, dir_lname, mov_dt_rel , rev_stars
from movie as m 
natural join movie_cast 
natural join actor 
natural join movie_genres 
natural join genres 
natural join movie_director 
natural join director 
natural join rating 
where act_gender = 'F';








