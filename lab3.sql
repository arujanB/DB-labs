--ex3
set SERVEROUTPUT ON;
declare
v_word varchar(20) := 'Hello World!';
begin 
dbms_output.put_line(v_word);
end;

--ex4
set serveroutput on;
declare 
v_id NUMBER(10);
begin
select salary 
into v_id
from employees 
where employee_id = '110';
dbms_output.put_line(v_id);
end;

--ex5
set serveroutput on;
declare 
v_firstname varchar(225);
v_lastname varchar(225);
begin
select first_name, last_name 
into v_firstname, v_lastname
from employees
where salary > (select salary from employees where employee_id = 163);
dbms_output.put_line(v_firstname ||' '|| v_lastname);
exception 
when too_many_rows then
dbms_output.put_line('Too many rows');
end;

--ex6
set serveroutput on;
declare
v_max NUMBER(10);
v_min number(10);
begin
select max(salary) into v_max from employees;
select min(salary) into v_min from employees;
dbms_output.put_line(v_max - v_min);
end;

--ex7
set serveroutput on;
declare
v_totaln number(20);
begin
select count(employee_id) into v_totaln from employees where hire_date >= '01.01.1995' and hire_date < '01.01.1999';
dbms_output.put_line(v_totaln);
exception when too_many_rows then 
dbms_output.put_line('Too many rows');
end;

--ex8
set serveroutput on;
declare
v_name varchar2(35);
begin 
select job_title into v_name from jobs where Exists (Select Max(AVG(salary)) from employees);
dbms_output.put_line(v_name);
end;

--ex9
set serveroutput on;
declare
v_ei number(6, 0);
v_ln varchar2(30);
v_s number(8, 2);
begin
select employee_id, last_name, salary into v_ei, v_ln, v_s 
from employees 
where exists ((salary > (Select Avg(salary) from employees)) and 
(select employees.last_name, departments.department_name 
from employees, departments 
where employees.department_id = departments.department_id 
and departments.department_name = 'department' and employees.last_name like '%u%'));
dbms_output.put_line(v_ei || ' ' || v_ln || ' ' || v_s);
exception when too_many_rows then
dbms_output.put_line('Too many rows');
end;