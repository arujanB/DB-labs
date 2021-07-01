--ex2a
set serveroutput on;
declare
TYPE t_c is table of countries.country_name%type
index by varchar2(40);
v_country t_c;
begin
for v_rec in (select country_name, country_id
from countries, regions 
where countries.region_id = regions.region_id and regions.region_name = 'Asia' order by countries.country_id asc)
loop
v_country(v_rec.country_id) := v_rec.country_name;
end loop;
end;

--ex2b
set serveroutput on;
declare
TYPE t_c is table of countries.country_name%type
index by varchar2(40);
v_country t_c;
begin
for v_rec in (select country_name, country_id
from countries, regions 
where countries.region_id = regions.region_id and regions.region_name = 'Asia' order by countries.country_id asc)
loop
v_country(v_rec.country_id) := v_rec.country_name;
end loop;
dbms_output.put_line(v_country.first);
dbms_output.put_line(v_country.last);
if v_country.exists ('JP') then
dbms_output.put_line('Exists');
ELSe
dbms_output.put_line('Not exists');
end if;
end;

--ex2c
set serveroutput on;
declare
TYPE t_c is table of countries.country_name%type
index by varchar2(40);
v_country t_c;
begin
for v_rec in (select country_name, country_id
from countries, regions 
where countries.region_id = regions.region_id and regions.region_name = 'Asia' order by countries.country_id asc)
loop
v_country(v_rec.country_id) := v_rec.country_name;
end loop;
dbms_output.put_line(v_country.first);
dbms_output.put_line(v_country.last);
dbms_output.put_line(v_country.count);
end;

--ex3a
set serveroutput on;
declare
cursor first_cur is select employee_id, last_name, job_id, salary from employees order by employee_id asc;
v_cursor first_cur%rowtype;
TYPE t_type is table of first_cur%rowtype index by binary_integer;
v_type t_type;
begin open first_cur;
loop fetch first_cur into v_cursor;
exit when first_cur%notfound;
v_type(v_cursor.employee_id) := v_cursor;
end loop;
close first_cur;
end;

--ex3b
set serveroutput on;
declare 
cursor first_cur is select employee_id, last_name, job_id, salary from employees order by employee_id;
v_cursor first_cur%rowtype;
Type t_emp is table of first_cur%rowtype index by binary_integer;
v_type t_emp;
begin open first_cur;
loop fetch first_cur into v_cursor;
exit when first_cur%notfound;
v_type(v_cursor.employee_id) := v_cursor;
end loop;
dbms_output.put_line(v_type.first);
dbms_output.put_line(v_type.last);
if v_type.exists (100) then
dbms_output.put_line('Exists');
else 
dbms_output.put_line('Not exists');
end if;
/*for i in v_type.first .. v_type.last loop 
if v_type.exists(i)
then dbms_output.put_line(v_type(i).employee_id);
end if;
end loop;*/
close first_cur;
end;