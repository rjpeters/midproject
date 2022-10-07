USE enrollment;

SELECT * FROM enrollment;

SELECT COUNT(*) FROM enrollment
WHERE Onderwijssoort = "Hoger beroepsonderwijs";

SELECT COUNT(*) FROM enrollment
WHERE Onderwijssoort = "Wetenschappelijk onderwijs";

SELECT COUNT(*) FROM enrollment
WHERE Studierichting = "Totaal";

SELECT Perioden, Freshmen FROM enrollment
WHERE Studierichting = "Totaal"
AND Onderwijssoort = "Hoger beroepsonderwijs";

SELECT Perioden, Freshmen FROM enrollment
WHERE Studierichting = "Totaal"
AND Onderwijssoort = "Wetenschappelijk onderwijs";


-- What I want to see now is breakdowns of the different areas of study: 

-- Category 1: education
SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 01
AND Onderwijssoort = "Wetenschappelijk onderwijs"
GROUP BY Studierichting;

SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 01
AND Onderwijssoort = "Hoger beroepsonderwijs"
GROUP BY Studierichting;
-- In WO, 'education' means (theoretical) pedagogy, in HBO it means vocational training for teachers.


-- Category 2: arts and humanities
SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 02
AND Onderwijssoort = "Wetenschappelijk onderwijs"
GROUP BY Studierichting; 

SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 02
AND Onderwijssoort = "Hoger beroepsonderwijs"
GROUP BY Studierichting;
-- In WO, this is what I would call 'humanities' (including art history and languages).
-- In HBO, it's mostly art school. 


-- Category 3: social sciences and journalism
SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 03
AND Onderwijssoort = "Wetenschappelijk onderwijs"
GROUP BY Studierichting; 

SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 03
AND Onderwijssoort = "Hoger beroepsonderwijs"
GROUP BY Studierichting; 
-- This breaks down into social sciences (economics, psychology, sociology, political science) and journalism.
-- Pretty similar between HBO and WO, except that HBO has no political science (and the numbers are different)


-- Category 4: Law, administration, business
SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 04
AND Onderwijssoort = "Wetenschappelijk onderwijs"
GROUP BY Studierichting; 

SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 04
AND Onderwijssoort = "Hoger beroepsonderwijs"
GROUP BY Studierichting; 

-- This neatly breaks down into 'law' and 'business' in both HBO and WO


-- Category 5: Science
SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 05
AND Onderwijssoort = "Wetenschappelijk onderwijs"
GROUP BY Studierichting; 

SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 05
AND Onderwijssoort = "Hoger beroepsonderwijs"
GROUP BY Studierichting; 
-- I will treat this as one big 'characteristic', since it's all science.


-- Category 6: Computer science
SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 06
AND Onderwijssoort = "Hoger beroepsonderwijs"
GROUP BY Studierichting; 

SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 06
AND Onderwijssoort = "Wetenschappelijk onderwijs"
GROUP BY Studierichting; 
-- OK, category 6 (computer science) does not require a further breakdown.
-- But I'm considering lumping it in with the category 'science', and just to create a big STEM group.



-- CATEGORY 7: Engineering
SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 07
AND Onderwijssoort = "Wetenschappelijk onderwijs"
GROUP BY Studierichting;  

SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 07
AND Onderwijssoort = "Hoger beroepsonderwijs"
GROUP BY Studierichting; 
-- There might be some point in separating architecture/city planning from other kinds of engineering, but I'm not sure. 
-- Other than that, I might also lump this in with STEM subjects. 


-- CATEGORY 8: Agriculture
SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 08
AND Onderwijssoort = "Wetenschappelijk onderwijs"
GROUP BY Studierichting;  

SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 08
AND Onderwijssoort = "Hoger beroepsonderwijs"
GROUP BY Studierichting;  

-- This is a strange and very small category, I think I'll discard it completely


-- Category 9: Medicine and health
SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 09
AND Onderwijssoort = "Wetenschappelijk onderwijs"
GROUP BY Studierichting;  

SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 09
AND Onderwijssoort = "Hoger beroepsonderwijs"
GROUP BY Studierichting;  

-- This is another case where HBO and WO are very very different. 
-- In HBO, there's a lot of education in social service administration.


-- Category 10: Service
SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 10
AND Onderwijssoort = "Wetenschappelijk onderwijs"
GROUP BY Studierichting;  

SELECT Studierichting, SUM(Freshmen) FROM enrollment
WHERE LEFT(Studierichting, 2) = 10
AND Onderwijssoort = "Hoger beroepsonderwijs"
GROUP BY Studierichting;  

-- Another strange category that I may just end up ditching. 

/* In summary, here's what I've learned:
- There is little point in comparing WO and HBO directly - the same categories can mean different things.
    (For example, 'arts and humanities' means art school in HBO, humanities in WO)
- I think I will drop the whole HBO set for my analysis, 
  since it's in university education that the issue of certain disciplines being 'useless' really shows up. 

Here are the categories I think I would want to use (and the current codes): 
- Pedagogy (011)
- Art (art history, music) (021)
- Language (023)
- Other humanities (022)
- Economics (0311)
- Political science (0312)
- Psychology (0313)
- Sociology (0314)
- Journalism (22822)
- Business (041)
- Law (042)
- STEM (05, 06, 07)
- Medicine (09)

I realize that this is a "humanist's eye view" - someone in STEM might lump humanities and social sciences together,
  while maintaining more subtle nuances within STEM. But c'est la vie - I need some way to cut the data down to size, 
  and this seems like a good way to start. 
*/