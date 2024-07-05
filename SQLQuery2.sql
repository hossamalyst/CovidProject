SELECT location,
	date,
	total_cases,
	total_deaths,
	(CAST (total_deaths AS FLOAT) / CAST (total_cases AS FLOAT)) *100 AS DeathPercentage
FROM 
    [Covid Project]..CovidVaccation

ORDER BY 
    population;



SELECT location,
	MAX(total_cases) AS HighestInfectionCount,
	MAX((CAST (total_deaths AS FLOAT) / CAST (total_cases AS FLOAT))) *100 AS MAXDeathPercentage
FROM 
    [Covid Project]..CovidVaccation
GROUP BY
	location, population
ORDER BY 
    MAXDeathPercentage;



SELECT location,
	MAX(total_deaths) AS TotalDeasthsCount
FROM
	[Covid Project]..CovidVaccation
GROUP BY
	location
Having 
	MAX(total_deaths) > 0
ORDER BY 
    TotalDeasthsCount desc;



SELECT continent, 
	MAX(total_deaths) AS TotalDeasthsCount
FROM
	[Covid Project]..CovidVaccation
WHERE 
	continent is not NULL
GROUP BY 
	continent
ORDER BY
	TotalDeasthsCount;


SELECT 
	date,
    SUM(new_cases) AS Total_Cases,
    SUM(new_deaths) AS Total_Deaths,
    CASE 
        WHEN SUM(new_cases) = 0 THEN 0
        ELSE (SUM(new_deaths) / SUM(new_cases)) * 100
    END AS DeathPercentage
FROM
    [Covid Project]..CovidVaccation
WHERE
    continent IS NOT NULL
GROUP BY
    date
ORDER BY
    date, Total_Cases;



SELECT TOP 10 dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date)
AS RollingPeopleVaccinated

FROM CovidDeath dea
JOIN CovidVaccation vac
on vac.location = dea.location
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3;