--EX1
 Name the three modes: IN, OUT, IN OUT;
 The default mode: IN;
 Mode cannot be modified inside the procedure: IN;
 
 --EX2a
 create or replace procedure find_country_region(p_coun in countries.country_id%type,
 p_c out countries.country_name%type,
 p_r out regions.region_name%type)
 is 
 begin
 select country_name, region_name into p_c, p_r 
 from countries, regions 
 where countries.region_id = regions.region_id and country_id = p_coun;
 exception when no_data_found then
 dbms_output.put_line('Country does not exists');
 end find_country_region;
 
 --EX2b
 set serveroutput on;
 declare 
 a_c countries.country_name%type;
 a_r regions.region_name%type;
 begin 
 find_country_region('CA', a_c, a_r);
 dbms_output.put_line(a_r || ' ' || a_c);
 end;
 
 --EX3
 create or replace procedure squer(p_s in out number)
 is 
 begin
 p_s := p_s * p_s;
 end;
 
 set serveroutput on;
 declare 
 v_s number;
 begin
 v_s := -20;
 squer(v_s);
 dbms_output.put_line(v_s);
 end;
 
 --EX4a
 set serveroutput on;
 declare 
 a_coun countries.country_id%type;
 a_c countries.country_name%type;
 a_r regions.region_name%type;
 begin 
 find_country_region(p_coun => 'CA', p_c => a_c, p_r => a_r);
 dbms_output.put_line(a_r);
 dbms_output.put_line(a_c);
 end;
 
 --EX4b
 set serveroutput on;
 declare 
 a_coun countries.country_id%type;
 a_c countries.country_name%type;
 a_r regions.region_name%type;
 begin 
 find_country_region(p_coun => a_coun, p_c => a_c, 'Asia');
 dbms_output.put_line(a_r);
 dbms_output.put_line(a_c);
 end;
 
 --EX4c
 set serveroutput on;
 declare 
 a_coun countries.country_id%type;
 a_c countries.country_name%type;
 a_r regions.region_name%type;
 begin 
 find_country_region('CA', p_c => a_c, p_r => a_r);
 dbms_output.put_line(a_coun||' '||a_c ||' '|| a_r);
 end;

--EX5
DEFAULT - is the mode 'IN'. If we forget write the mode, it automatically will be 'IN';

--EX6
create or replace procedure find_country_region(p_coun in countries.country_id%type default 'CA', 
p_c out countries.country_name%type, 
p_r out regions.region_name%type)
is 
begin 
select country_name, region_name into p_c, p_r
from countries, regions
where countries.region_id = regions.region_id and country_id = p_coun;
exception when no_data_found then
dbms_output.put_line('Country does not exists');
end find_country_region;

set serveroutput on;
declare 
a_coun countries.country_id%type;
a_c countries.country_name%type;
a_r regions.region_name%type;
begin
find_country_region(p_coun => a_coun, p_c => a_c, p_r => a_r);
dbms_output.put_line(a_c||' '||' '||a_r);
end;
 
 --ex7
 out - Returns a value to the caller;
 in - Provides values for a subprogram to process;
 named notation - Lists the actual parameters in arbitrary order and uses the association operator ( ‘=>' which is an equal and an arrow together) to associate a named formal parameter with its actual parameter;
 combination notation - Lists some of the actual parameters as positional (no special operator) and some as named (with the => operator);
 positional notation - Lists the actual parameters in the same order as the formal parameters;
 in out parameter - Supplies an input value, which may be returned as a modified value;