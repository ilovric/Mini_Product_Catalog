create user zadatak
 identified by zadatak
 default tablespace users
 temporary tablespace temp;
 
grant connect to zadatak;
grant resource to zadatak;

--drop user zadatak cascade;