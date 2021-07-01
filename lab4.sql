--ex1
set serveroutput on;
declare 
v_salary employees.salary%Type;
begin 
select sum(salary) into v_salary
from employees 
where department_id = 60;
if v_salary > 19000 then
dbms_output.put_line(v_salary || ' Is greater than 19000');
elsif v_salary < 19000 then 
dbms_output.put_line(v_salary || ' Is less than 19000');
end if;
end;

--ex2
set serveroutput on;
declare
v_ncountry int(20);
begin
select count(countries.country_name) into v_ncountry 
from countries, regions 
where regions.region_id = countries.region_id and regions.region_name = 'Middle East and Africa';
/*if (v_ncountry > 20) then
dbms_output.put_line('More than 20 countries');
elsif (v_ncountry < 20 and v_ncountry > 10) then
dbms_output.put_line('Between 10 and 20 countries');
elsif (v_ncountry < 10) then
dbms_output.put_line('Fewer than 10 countries');
end if;*/
case 
when v_ncountry > 20 then dbms_output.put_line('More than 20 countries');
when v_ncountry < 20 and v_ncountry > 10 then dbms_output.put_line('Between 10 and 20 countries');
when v_ncountry < 10 then dbms_output.put_line('Fewer than 10 countries');
end case;
end;

--ex3
set serveroutput on;
declare
v_id employees.employee_id%type;
v_firstname employees.first_name%type;
v_counter number := 107;
begin 
loop
select employee_id, first_name into v_id, v_firstname 
from employees
where employee_id = v_counter;
    v_counter := v_counter + 1;
    dbms_output.put_line(v_id || ' ' || v_firstname);
   
    if v_counter > 109 then exit;
    end if;
    --exit when v_counter > 109;
end loop;
end;

--ex4
begin 
for v_ol in 60 .. 65 loop
for v_il in 100 .. 110 loop
dbms_output.put_line(v_ol || ' ' || v_il);
end loop;
end loop;
end;

--ex5.1
/*set serveroutput on;
declare
v_salary employees.salary%type;
v_state locations.STATE_PROVINCE%type;
v_department departments.department_id%type;
begin
select location_id into v_state from locations where state_province = 'California';
select department_id into v_department from departments where location_id = v_state;
select salary into v_salary from employees
where department_id = v_department;
if(v_state = 'Calicornia') then v_salary := v_salary + v_salary * 0.1;
dbms_output.put_line(v_salary);
end if;
exception when too_many_rows then 
  dbms_output.put_line('Too many rows');
end;*/
set serveroutput on;
declare 
v_add int(20) := 0.1;
v_state locations.STATE_PROVINCE%type := 'California';
v_department departments.department_id%type;
begin
update copy_emp2
set salary = salary + salary * v_add
where department_id in(
    select department_id from departments where location_id in 
        (select location_id from locations where state_province = 'California'));
end;

select salary from copy_emp2 
where department_id in(
    select department_id from departments where location_id in 
        (select location_id from locations where state_province = 'California'));
        
--ex5.2
set serveroutput on;
declare
begin
update copy_emp2 set salary = salary + salary/0.1
where salary in (select min(salary) from(select avg(salary) from employees group by depatrment_id));
end;

--ex5.3
alter table copy_emp2 
add status varchar2(30);

set serveroutput on;
declare
v_id copy_emp2.employee_id%type;
begin 
update copy_emp2 set status = 'EMPLOYEE'
where v_id = employee_id;
end;

set serveroutput on;
declare
v_idm copy_emp2.manager_id%type;
begin 
update copy_emp2 set status = 'MANAGER'
where v_idm = manager_id;
end;

begin
update copy_emp2 set status = 'MANAGER'
where (extract(year from sysdate) - extract(year from hire_date)) > 15;
end;

--ex5.4
alter table copy_emp2 
modify email varchar(255);

set serveroutput on;
declare
begin
update copy_emp2
set email = substr(last_name, 1, 1) || first_name || '@' ||
(select lower(department_name) from departments where departments.department_id = copy_emp2.department_id)||'.'||
(select lower(country_id) from locations where location_id = 
(select location_id from departments where departments.department_id = copy_emp2.department_id));
end;

select email from copy_emp2;

--ex5.5
set serveroutput on;
declare
begin
delete from copy_emp where (extract(year from sysdate) - extract(year from hire_date) > 18);
savepoint del;
end;