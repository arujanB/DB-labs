--ex1
--1. Using an explicit cursor with parameters select department_id, department_name. 
--If the department has employees select their first_name, last_name and salary.
set serveroutput on;
declare 
cursor first_cur is 
select departments.department_id, departments.department_name, employees.first_name, employees.last_name, employees.salary
from departments, employees
where departments.department_id = employees.department_id;
v_did departments.department_id%type;
v_dn departments.department_name%type;
v_f employees.first_name%type;
v_l employees.last_name%type;
v_s employees.salary%type;
begin
open first_cur;
loop
fetch first_cur into v_did, v_dn, v_f, v_l, v_s;
exit when first_cur%NOTFOUND;
dbms_output.put_line(v_did || ' ' || v_dn || ' ' || v_f || ' ' || v_l || ' ' || v_s);
end loop;
close first_cur;
end;

--ex2
set serveroutput on;
declare 
cursor second_cur is
select regions.region_name, count(countries.country_name)
from regions, countries
where regions.region_id = countries.region_id
group by regions.region_name
having count(countries.country_name) >= 6
order by regions.region_name asc;
v_r regions.region_name%type;
v_c countries.country_name%type;
begin
open second_cur;
loop
fetch second_cur into v_r, v_c;
exit when second_cur%notfound;
dbms_output.put_line(v_r || ' '  || v_c);
end loop;
close second_cur;
end;

--ex3
set serveroutput on;
declare 
cursor date_cur is 
select * from employees 
where hire_date >= '08-03-2000';
v_d_record date_cur%rowtype;
--v_d employees.hire_date%type;
begin
open date_cur;
loop
fetch date_cur into v_d_record;
exit when  date_cur%notfound;
dbms_output.put_line(v_d_record.first_name || ' ' || v_d_record.hire_date || ' ' || v_d_record.employee_id);
end loop;
close date_cur;
end;

--ex4
creat table proposed_raises

--ex5
set serveroutput on;
declare
cursor fives_cur(p_rid number) is 
select countries.country_name, locations.location_id
from locations, countries
where locations.country_id = countries.country_id and countries.region_id = p_rid;
v_c countries.country_name%type;
v_l locations.location_id%type;
begin
open fives_cur (3);
loop
fetch fives_cur into v_c, v_l;
exit when fives_cur%notfound;
dbms_output.put_line(v_c || ' ' || v_l);
end loop;
close fives_cur;
end;

--ex6
set serveroutput on;
declare
cursor sixth_cur is
select departments.department_name, count(employees.employee_id) from departments 
left join employees
on departments.department_id = employees.department_id
group by departments.department_name
order by count(employees.employee_id) desc;
v_s_record sixth_cur%rowtype;
v_n employees.employee_id%type;
begin 
open sixth_cur;
loop
fetch sixth_cur into v_s_record;
exit when sixth_cur%rowcount > 5 or sixth_cur%notfound;
dbms_output.put_line(v_s_record.department_name || ' ' || v_n);
end loop;
close sixth_cur;
end;

--ex7
set serveroutput on;
declare
cursor seven_cur is
/*select * from departments
left join employees
on departments.department_id = employees.department_id;*/
select departments.department_name, departments.department_id 
from departments, employees
where departments.department_id = employees.department_id;
--order by departments.department_id asc;

CURSOR eight_cur(p_d departments.department_id%TYPE) is 
select employees.first_name, employees.last_name, employees.salary 
from employees, departments
where departments.department_id = employees.department_id and employees.department_id = p_d;
--order by employees.last_name desc;
begin
for v_s_record in seven_cur loop 
dbms_output.put_line(v_s_record.department_id || ' ' || v_s_record.department_name);
dbms_output.put_line('--------------------------------------');

for v_e_record in eight_cur(v_s_record.department_id) loop
dbms_output.put_line(v_e_record.first_name || ' ' || v_e_record.last_name || ' ' || v_e_record.salary);
end loop;
dbms_output.put_line(' ');
end loop; 
end;

SET SERVEROUTPUT ON;
DECLARE 
CURSOR department_cur IS 
SELECT department_id,department_name 
FROM departments ; 
CURSOR employee_cur(v_dep_id departments.department_id%TYPE) IS 
SELECT first_name, last_name, salary 
FROM employees 
WHERE department_id = v_dep_id ;  
BEGIN 
FOR department_rec IN department_cur LOOP 
DBMS_OUTPUT.PUT_LINE(department_rec.department_id ||' ' || department_rec.department_name); 
DBMS_OUTPUT.PUT_LINE('--------------------------------------'); 
FOR emp_record IN employee_cur (department_rec.department_id) LOOP 
DBMS_OUTPUT.PUT_LINE (emp_record.first_name || ' ' || emp_record.last_name || ' ' || emp_record.salary); 
END LOOP; 
DBMS_OUTPUT.PUT_LINE(' '); 
END LOOP; 
END;