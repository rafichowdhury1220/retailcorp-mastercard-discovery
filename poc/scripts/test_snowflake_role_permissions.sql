-- run as ACCOUNTADMIN or SECURITYADMIN in Snowflake

create or replace database MCST;
use database MCST;
create or replace schema landing;
create or replace schema curated;

-- validate data-eng role can write landing
set ROLE = POC_DATA_ENG;

create or replace table landing.test_row (id int, name string);
insert into landing.test_row values (1, 'test');
select * from landing.test_row;

-- validate analyst role can read curated
set ROLE = POC_ANALYST;

select * from curated.information_schema.tables;
