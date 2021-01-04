-- viewing the table
select top 5 * from [dbo].[Employees]

-- max salary by Gender
select gender, max(salary) from [dbo].[Employees]
group by gender

-- dense rank by salary
select *, DENSE_RANK() over (order by salary desc) as denseRank
from [dbo].[Employees]

-- Records with 4th highest salary
select * from
(select *, dense_rank() over (order by salary desc) as denseRank from dbo.Employees)ss
where denseRank = 4

-- 4th highest salary value
select distinct salary from (
select *, DENSE_RANK() over (order by salary desc) as denseRank from dbo.Employees) ss
where denseRank = 4

-- Seeing dense rank by Gender field
select *, DENSE_RANK() over (partition by gender order by salary desc) as denseRank
from [dbo].[Employees]

-- records with 2nd highest salary for each gender
select * from (select *, DENSE_RANK() over (partition by gender order by salary desc) as denseRank
from [dbo].[Employees])ss
where denseRank = 2

-- 2nd highest salary value by Gender
select distinct gender,salary  from
(select *, DENSE_RANK() over (partition by gender order by salary desc) as denseRank
from [dbo].[Employees])ss
where denseRank = 2

--- Dense rank for distinct records (after excluding ID column)
select *, DENSE_RANK() over (partition by gender order by salary desc) as denseRank from
(select distinct FirstName, LastName, Gender,Salary from dbo.Employees)ss

-- Record detail for 2nd highest salary, post distinct
select * from 
(select *, DENSE_RANK() over (partition by gender order by salary desc) as denseRank from
(select distinct FirstName, LastName, Gender,Salary from dbo.Employees)ss)tt
where denseRank = 2

-- table used created from KudVenkat's script : https://csharp-video-tutorials.blogspot.com/2014/05/part-1-how-to-find-nth-highest-salary_17.html
