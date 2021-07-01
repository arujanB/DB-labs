//ex1
SELECT
    first_name,
    last_name
FROM
    employees
WHERE
    salary > (
        SELECT
            salary
        FROM
            employees
        WHERE
            employee_id = '163'
    );
    
//ex3
select first_name, last_name, salary, department_id
from employees
where salary in (select min(salary)
from employees
group by department_id); 

//ex4 
select employee_id, first_name, last_name
from employees
where salary > (select Avg(salary)
from employees );

//ex6
select departments.department_name, employees.first_name, employees.last_name, employees.job_id, departments.department_id
from departments, employees
where departments.department_id = employees.department_id and departments.department_name = 'Finance';

//ex7
select * from employees
where manager_id = 121 and salary = 3000;

//ex8
SELECT * FROM
    employees
WHERE
    employee_id IN (
        '134',
        '159',
        '183'
    );

//ex9
SELECT * FROM
    employees
WHERE
    salary > 1000
    AND salary < 3000;
    
//ex10
SELECT
    *
FROM
    employees
WHERE
    salary BETWEEN 2500 AND (
        SELECT
            MIN(salary)
        FROM
            employees
    );

//ex11
select * from employees
where department_id not in (department_id between 100 and 200);
    
//ex16
select employees.first_name, employees.last_name, employees.employee_id, jobs.job_title
from employees, jobs
where employees.job_id = jobs.job_id and departaments.location_id = locations.location_id and locations.state_province = 'Toronto';

//ex17
select employees.employee_id, employees.first_name, employees.last_name, employees.job_id 
from employees
where employees.salary < (select salary
from employees
where job_id = 'MK_MAN');

//ex20 
select job_id, first_name, last_name, employee_id
from employees 
where salary > (select avg(salary) from employees group by department_id);

//ex21
select first_name, last_name, department_id
from employees 
where exists(select * from employees where salary > 3700);

//ex14
select employee_id, first_name, last_name
from employees 
where department_id(select department_id from employees where first_name like '%T%');

//ex28 
select * from employees
where salary > (Select Avg(salary) from employees) and (select department_name from departments where deparmnet_name = 'IT');

//ex29
select * from employees
where salary > (select max(salary) from employees where last_name = 'Ozer');

//ex32
select * from employees
where exists (select * from departaments where employee_id = manager_id);

//ex33
select * from employees
where employee_id = any (select manager_id from departments);

//ex26
select department_name 
from departments 
where department_id in (select distinct(department_id) from employees);