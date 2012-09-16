CREATE TABLESPACE ts_new_itens
LOGGING DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\ts_new_itens.dbf'
SIZE 32m AUTOEXTEND ON NEXT 32m EXTENT MANAGEMENT LOCAL;

CREATE USER new_itens_owner 
IDENTIFIED BY new_itens_owner 
DEFAULT TABLESPACE ts_new_itens QUOTA UNLIMITED ON ts_new_itens;

GRANT create session, alter session, select_catalog_role, 
      execute_catalog_role, create table, create procedure, 
	  create view, create materialized view, create trigger, 
	  create sequence, create any directory, create type, 
	  create synonym, administer database trigger 
TO new_itens_owner;