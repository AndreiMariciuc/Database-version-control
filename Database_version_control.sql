use test;
drop procedure if exists modifica_tipul_coloanei;
-- modific tipul unei coloane
-- alter table nume_tabel 
-- modify column nume_coloana data_tip;

delimiter //
create procedure modifica_tipul_coloanei(nume_tabel varchar(45), nume_coloana varchar(45), data_tip varchar(45), data_tip_actual varchar(45))
begin
	set @instr = concat("alter table ", nume_tabel, " modify column ", nume_coloana, " ", data_tip, ";");
    prepare statement from @instr;
    execute statement;
    -- modifica_tipul_coloanei(nume_tabel varchar(45), nume_coloana varchar(45), data_tip varchar(45), data_tip_actual varchar(45))
    set @instr_inversa = concat('call modifica_tipul_coloanei( "', nume_tabel, '" , "', nume_coloana, '" , "' , data_tip_actual, '", "' , data_tip, '");');
    insert into versiune(inversa_apelata) values(@instr_inversa);
     deallocate prepare statement;
end//

drop procedure if exists adauga_valoare_implicita;
-- adaug o valoare implicita
-- alter table nume_tabel
-- alter nume_coloana set default valoare;

delimiter //
create procedure adauga_valoare_implicita(nume_tabel varchar(45), nume_coloana varchar(45), valoare varchar(45))
begin
	set @instr = concat("alter table ", nume_tabel, " alter ", nume_coloana, " set default ", valoare, ";");
    prepare statement from @instr;
    execute statement;
    set @instr_inversa = concat('call inserva_adauga_valoare_impicita("', nume_tabel,'", "', nume_coloana, '" , "',valoare, '");');
    insert into versiune(inversa_apelata) values(@instr_inversa);
     deallocate prepare statement;
end//

drop procedure if exists inversa_adauga_valoare_implicita;
-- sterg valoarea implicita
-- alter table nume_tabel
-- alter nume_coloana drop default;

delimiter // 
create procedure inversa_adauga_valoare_implicita(nume_tabel varchar(45), nume_coloana varchar(45), valoare_schimbata varchar(45))
begin
	set @instr = concat("alter table ", nume_tabel, " alter ", nume_coloana, " drop default;");
    prepare statement from @instr;
    execute statement;
    set @instr_inversa = concat('call adauga_valoare_implicita("', nume_tabel, '", "', nume_coloana, '" ,"',valoare_schimbata, '");');
    insert into versiune(inversa_apelata) values(@instr_inversa);
     deallocate prepare statement;
end//

drop procedure if exists creare_tabel;
-- crearea unui tabel nou
-- create table nume_tabel
-- (
-- nume_id int not null unique
-- );

delimiter //
create procedure creare_tabel(nume_tabel varchar(45), nume_id varchar(45))
begin
	set @instr = concat("create table ", nume_tabel, " ( ", nume_id, " int not null unique " , " );");
    prepare statement from @instr;
    execute statement;
    set @instr_inversa = concat('call inversa_creare_tabel("', nume_tabel, '", "', nume_id, '");');
    insert into versiune(inversa_apelata) values(@instr_inversa);
     deallocate prepare statement;
end//


drop procedure if exists inversa_creare_tabel;
-- stergerea unui tabel nou
-- drop table nume_tabel;

delimiter //
create procedure inversa_creare_tabel(nume_tabel varchar(45), nume_id varchar(45))
begin
	set @instr = concat("drop table ", nume_tabel, ";");
    prepare statement from @instr;
    execute statement;
    set @instr_inversa = concat('call creare_tabel("', nume_tabel,'", "', nume_id, '");');
    insert into versiune(inversa_apelata) values(@instr_inversa);
     deallocate prepare statement;
end//

drop procedure if exists adauga_nou_coloana;
-- adaugarea unei noi coloane
-- ALTER TABLE table_name
-- ADD column_name datatype;

delimiter //
create procedure adauga_nou_coloana(nume_tabel varchar(45), nume_coloana varchar(45), data_tip varchar(45))
begin
	set @instr = concat("alter table ", nume_tabel, " add ", nume_coloana," ", data_tip, ";");
	prepare statement from @instr;
    execute statement;
    set @instr_inversa = concat('call inversa_adauga_nou_coloana("', nume_tabel, '", "', nume_coloana, '", "', data_tip, '");');
    insert into versiune(inversa_apelata) values(@instr_inversa);
	deallocate prepare statement;
end//

drop procedure if exists inversa_adauga_nou_coloana;
-- stergerea coloanei
-- ALTER TABLE table_name
-- DROP COLUMN column_name;

delimiter // 
create procedure inversa_adauga_nou_coloana(nume_tabel varchar(45), nume_coloana varchar(45), data_tip varchar(45))
begin
	set @instr = concat("alter table ", nume_tabel, " drop column ", nume_coloana, ";");
	prepare statement from @instr;
    execute statement;
    set @instr_inversa = concat('call adauga_nou_coloana("', nume_tabel, '", "', nume_coloana, '", "', data_tip, '");');
    insert into versiune(inversa_apelata) values(@instr_inversa);
     deallocate prepare statement;
end//


drop procedure if exists creare_cheie_straina;
-- adaugarea unei key straine
-- ALTER TABLE tabel_strain
-- ADD CONSTRAINT fk_cheie_straina
-- FOREIGN KEY (cheie_straina) REFERENCES tabel_primar(cheie_primara);

delimiter //
create procedure creare_cheie_straina(tabel_strain varchar(45), nume_cheie_straina varchar(45), cheie_straina varchar(45), tabel_primar varchar(45), cheie_primara varchar(45))
begin
	set @instr = concat("alter table ", tabel_strain, " add constraint ", cheie_straina, " foreign key(", cheie_straina, ") references ", tabel_primar, " (", cheie_primara,");");
	prepare statement from @instr;
    execute statement;
    set @instr_inversa = concat('call inversa_creare_cheie_straina("', tabel_strain,'", "', nume_cheie_straina, '","', cheie_straina, '","', tabel_primar, '", "', cheie_primara, '");');
    insert into versiune(inversa_apelata) values(@instr_inversa);
	deallocate prepare statement;
end//

drop procedure if exists inversa_creare_cheie_straina;
-- stergere cheie straina
-- ALTER TABLE tabel
-- DROP FOREIGN KEY fk_cheie_straina;

delimiter //
create procedure inversa_creare_cheie_straina(tabel_strain varchar(45), nume_cheie_straina varchar(45), cheie_straina varchar(45), tabel_primar varchar(45), cheie_primara varchar(45))
begin
	set @instr = concat("alter table ", tabel_strain, " drop foreign key ", cheie_straina, ";");
	prepare statement from @instr;
    execute statement;
    set @instr_inversa = concat('call creare_cheie_straina("', tabel_strain,'", "', nume_cheie_straina, '","', cheie_straina, '","', tabel_primar, '", "', cheie_primara, '");');
    insert into versiune(inversa_apelata) values(@instr_inversa);
	deallocate prepare statement;
end//

#########################################################################################################################################################

drop procedure if exists back_up;

delimiter //
create procedure back_up(versiune_dorita int)
begin
    set @cnt = (select max(versiune.nr) from versiune); 
    -- consider date bune!
	while @cnt != versiune_dorita do
    
    set @instr = (select versiune.inversa_apelata from versiune where versiune.nr = @cnt);
    if @instr is not null then
		SET @s= @instr;
		PREPARE stmt1 FROM @s;
		EXECUTE stmt1;
		DEALLOCATE PREPARE stmt1;
	end if;
    set @cnt = @cnt - 1;
	end while;
end//


##############################################################################################################################################
-- modul de test
drop database if exists test;

create database test;

use test;

drop table if exists primul;

create table primul 
(
	id int not null unique primary key,
    tip_modificat int
);

drop table if exists aldoilea;

create table if not exists aldoilea 
(
	id int not null unique primary key,
    id_primul int
);

drop table if exists versiune;

create table if not exists versiune
(
	nr int not null unique auto_increment,
    inversa_apelata varchar(256)
);

-- modificari!

SELECT * FROM test.versiune;

insert into versiune(inversa_apelata) values ("inceput!");
-- modific tipul coloanei tip_modificat din int -> blob
call test.modifica_tipul_coloanei('primul', 'tip_modificat', 'int', 'blob');

-- adaug o coloana noua numita: 'coloanaNoua' in tabelul: 'primul' de tipul text
call test.adauga_nou_coloana('primul', 'coloanaNoua', 'text');

-- modific tipul coloanei tip_modificat din text -> char(20)
call test.modifica_tipul_coloanei('primul', 'coloanaNoua', 'char(20)', 'text');

-- adaug o coloana noua numita 'nou_decimal' in tabelul: 'aldoilea' de tipul 'decimal(5, 2)'
call test.adauga_nou_coloana('aldoilea', 'nou_decimal', 'decimal(5, 2)');

-- creez un tabel nou
call test.creare_tabel('tabel_nou', 'id_tabel_nou');

-- adaug o cheie straina fk_id_primul din tabeleul aldoilea spre primul prin id_primul
call test.creare_cheie_straina('aldoilea', 'fk_id_primul', 'id_primul', 'primul', 'id');


-- vreau sa ajung in versiunea 5, adica atunci cand nu aveam legaturile de chei straine  si nici tabelul nou creat tabel_nou
call test.back_up(5);
-- starea initiala!
-- call test.back_up(2);

