create schema projects;
use projects;
select  * from hr;
-- changing the column name of employee_id
alter table hr
change column ï»¿id emp_id varchar(20) null;
describe hr;
select birthdate from hr;

-- changing birthdate from text format to date format
set sql_safe_updates=0;
update hr
set birthdate = case
when birthdate like '%/%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
when birthdate like '%-%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
else null
end;
alter table hr
modify column birthdate date;

-- changing termdate from text format to date format
update hr
set termdate=null
where termdate is null or termdate='' or str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC') is null; 
update  hr
set termdate=date(str_to_date(replace(termdate,'UTC',''),'%Y-%m-%d %H:%i:%s'))
where termdate is not null and termdate !='';
alter table  hr
modify column termdate DATE;

-- changing hire_date from text format to date format
update hr
set hire_date = case
when hire_date like '%/%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
when hire_date like '%-%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
else null
end;
alter table  hr
modify column hire_date DATE;

-- Add age column to the data set
alter table hr add column age int;
update hr
set age=timestampdiff(year,birthdate,curdate()); 

select birthdate,age from hr;

select min(age) as youngest, max(age)as oldest from hr;
-- there are negative values in this age so we need to manipulate it.
select count(*) from hr where age <18;
-- these are the values we not need so we use age criteria while answering our queries.
SELECT COUNT(*) FROM hr WHERE termdate > CURDATE(); 

SELECT COUNT(*) as count
FROM hr
WHERE termdate  is null or trim(termdate)='';
-- these are the employees working in company
