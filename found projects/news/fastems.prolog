/******************************************************************************

	Demonstration of fast ems load/save

  Compile to DOS code. Install EMS and run it


 อออออออออออออออหออออออหออออออออออออออออออออออออออออออออออออออออออออออออออออ
  Date Modified,บ By,  บ  Comments.
 อออออออออออออออฮออออออฮออออออออออออออออออออออออออออออออออออออออออออออออออออ
                บ      บ
******************************************************************************/

DOMAINS
  DB_SELECTOR = dba

PREDICATES
  write_dba(INTEGER)

CLAUSES
  write_dba(0):-!.
  write_dba(N):-
	chain_inserta(dba,"chain1",string,"PDC Prolog",_),
	N1=N-1,
	write_dba(N1).

GOAL	
	write("Create a database with 10000 records"),nl,
	db_create(dba,"emsdba",in_ems),
	write_dba(10000),
	db_close(dba),
	write("Save the database in a file"),nl,
	db_saveems("emsdba","dd.dat"),
	db_delete("emsdba",in_ems),

	write("Open the database in the file"),nl,
	db_open(dba,"dd.dat",in_file),
	db_close(dba),

	write("Copy the database back to EMS"),nl,
	db_loadems("dd.dat","emsdba"),
	db_open(dba,"emsdba",in_ems),
	db_close(dba),
	write("Save the database in a new file"),nl,
	db_saveems("emsdba","dd1.dat"),
	db_delete("emsdba",in_ems),
	write("Done"),nl.

