--  ##----##-##----------###-----######-----###-------########--########---#######--########--##-----##-##----##-########----###----
--  ##---##--##---------##-##---##----##---##-##------##-----##-##-----##-##-----##-##-----##-##-----##-##---##-----##------##-##---
--  ##--##---##--------##---##--##--------##---##-----##-----##-##-----##-##-----##-##-----##-##-----##-##--##------##-----##---##--
--  #####----##-------##-----##--######--##-----##----########--########--##-----##-##-----##-##-----##-#####-------##----##-----##-
--  ##--##---##-------#########-------##-#########----##--------##---##---##-----##-##-----##-##-----##-##--##------##----#########-
--  ##---##--##-------##-----##-##----##-##-----##----##--------##----##--##-----##-##-----##-##-----##-##---##-----##----##-----##-
--  ##----##-########-##-----##--######--##-----##----##--------##-----##--#######--########---#######--##----##----##----##-----##-


create table klasa_produkta
( id        number(10,0) not null
, naziv     varchar2 (250) not null
, opis      varchar2 (4000) 

, constraint kpa_pk primary key (id)
, constraint kpa_uk unique (naziv)
);
/
comment on table klasa_produkta is 'Tablica koja sadrži klasifikacije produkta';
comment on column klasa_produkta.id is 'PK tablice';
comment on column klasa_produkta.naziv is 'Naziv klase produkta';
comment on column klasa_produkta.opis is 'Dodatni opis klase';
/
create sequence kpa_seq
 nomaxvalue
 nominvalue
 nocycle;
/
create or replace trigger bir_klasa_produkta_seq 
before insert on klasa_produkta
    for each row
begin
    if (:new.id is null ) then
        select kpa_seq.nextval
        into :new.id
        from  dual;
    end if;
end;
/

--  ########--########---#######--########--##-----##-##----##-########-
--  ##-----##-##-----##-##-----##-##-----##-##-----##-##---##-----##----
--  ##-----##-##-----##-##-----##-##-----##-##-----##-##--##------##----
--  ########--########--##-----##-##-----##-##-----##-#####-------##----
--  ##--------##---##---##-----##-##-----##-##-----##-##--##------##----
--  ##--------##----##--##-----##-##-----##-##-----##-##---##-----##----
--  ##--------##-----##--#######--########---#######--##----##----##----

create table produkt
( id            number(10,0) not null
, naziv         varchar2 (250) not null
, opis          varchar2 (4000) 
, datum_od      date default sysdate not null
, datum_do      date
, kpa_id        number(10) not null
, pdt_id        number(10)

, constraint pdt_pk primary key (id)
, constraint pdt_uk1 unique (naziv)
, constraint PDT_KPA_FK foreign key(kpa_id) references klasa_produkta(id)
, constraint PDT_PDT_FK foreign key(pdt_id) references produkt (id)
);
/
comment on table produkt is 'Tablica koja sadrži produkte';

comment on column produkt.id is 'PK tablice';
comment on column produkt.naziv is 'Naziv produkta';
comment on column produkt.opis is 'Dodatni opis produkta';
comment on column produkt.datum_od is 'Datum od kad je produkt dostupan na tržištu';
comment on column produkt.datum_DO is 'Datum do kad je produkt dostupan na tržištu';
comment on column produkt.kpa_id is  'FK klasa_produkta';
comment on column produkt.pdt_id is  'FK produkt';
/
create sequence pdt_seq
 nomaxvalue
 nominvalue
 nocycle;
/
create or replace trigger bir_produkt_seq 
before insert on produkt
    for each row
begin
    if (:new.id is null ) then
        select pdt_seq.nextval
        into :new.id
        from  dual;
    end if;
end;
/
 create index pdt_kpa_fk_i on produkt (kpa_id);
 create index pdt_pdt_fk_i on produkt (pdt_id);
/ 

--  ##----##----###----########-########--######----#######--########--####-------##----###---------------###----########-########--####-########--##-----##-########----###----
--  ##---##----##-##------##----##-------##----##--##-----##-##-----##--##--------##---##-##-------------##-##------##----##-----##--##--##-----##-##-----##----##------##-##---
--  ##--##----##---##-----##----##-------##--------##-----##-##-----##--##--------##--##---##-----------##---##-----##----##-----##--##--##-----##-##-----##----##-----##---##--
--  #####----##-----##----##----######---##---####-##-----##-########---##--------##-##-----##---------##-----##----##----########---##--########--##-----##----##----##-----##-
--  ##--##---#########----##----##-------##----##--##-----##-##---##----##--##----##-#########---------#########----##----##---##----##--##-----##-##-----##----##----#########-
--  ##---##--##-----##----##----##-------##----##--##-----##-##----##---##--##----##-##-----##---------##-----##----##----##----##---##--##-----##-##-----##----##----##-----##-
--  ##----##-##-----##----##----########--######----#######--##-----##-####--######--##-----##-#######-##-----##----##----##-----##-####-########---#######-----##----##-----##-
create table  kategorija_atributa 
( id            number(10,0) not null
, naziv         varchar2 (250) not null

, constraint kat_pk primary key (id)
, constraint kat_uk1 unique (naziv)
);
/
comment on table kategorija_atributa is 'Tablica za kategoriju atributa.';

comment on column kategorija_atributa.id is 'PK tablice';
comment on column kategorija_atributa.naziv is 'Naziv kategorije atributa';
/
 create sequence kat_seq
 nomaxvalue
 nominvalue
 nocycle;
 /
create or replace trigger bir_kategorija_atributa_seq 
before insert on kategorija_atributa
    for each row
begin
    if (:new.id is null ) then
        select kat_seq.nextval
        into :new.id
        from  dual;
    end if;
end;
/


--  ---###----########-########--####-########--##-----##-########-
--  --##-##------##----##-----##--##--##-----##-##-----##----##----
--  -##---##-----##----##-----##--##--##-----##-##-----##----##----
--  ##-----##----##----########---##--########--##-----##----##----
--  #########----##----##---##----##--##-----##-##-----##----##----
--  ##-----##----##----##----##---##--##-----##-##-----##----##----
--  ##-----##----##----##-----##-####-########---#######-----##----

create table atribut
( id            number(10,0) not null
--, naziv         varchar2 (250) not null
, vrijednost    varchar2 (50) not null
, kat_id        number(10,0) not null
, constraint abt_pk primary key (id)
--, constraint abt_uk1 unique (naziv,vrijednost)
, constraint abt_kat_fk foreign key(kat_id) references kategorija_atributa (id)
);
/
comment on table atribut is 'Tablica koja sadrži osnovne vrijednosti atributa';
comment on column atribut.id is 'PK tablice';
--comment on column atribut.naziv is 'Naziv atributa';
comment on column atribut.vrijednost is 'Vrijednost koju ima naziv atributa';
comment on column atribut.kat_id is 'PK kategorija_atributa';
/
create sequence abt_seq
 nomaxvalue
 nominvalue
 nocycle;
/
create or replace trigger bir_atribut_seq 
before insert on atribut
    for each row
begin
    if (:new.id is null ) then
        select abt_seq.nextval
        into :new.id
        from  dual;
    end if;
end;
/
create index abt_kat_fk_i on atribut (kat_id);
/
--  ########--########---#######--########--##-----##-##----##-########------------###----########-########--####-########--##-----##-########-
--  ##-----##-##-----##-##-----##-##-----##-##-----##-##---##-----##--------------##-##------##----##-----##--##--##-----##-##-----##----##----
--  ##-----##-##-----##-##-----##-##-----##-##-----##-##--##------##-------------##---##-----##----##-----##--##--##-----##-##-----##----##----
--  ########--########--##-----##-##-----##-##-----##-#####-------##------------##-----##----##----########---##--########--##-----##----##----
--  ##--------##---##---##-----##-##-----##-##-----##-##--##------##------------#########----##----##---##----##--##-----##-##-----##----##----
--  ##--------##----##--##-----##-##-----##-##-----##-##---##-----##------------##-----##----##----##----##---##--##-----##-##-----##----##----
--  ##--------##-----##--#######--########---#######--##----##----##----#######-##-----##----##----##-----##-####-########---#######-----##----

create table produkt_atribut
( id        number(10,0) not null
, pdt_id    number(10,0) not null
, abt_id    number(10,0) not null
, constraint pat_pk primary key (id)
, constraint pat_pdt_abt_uk UNIQUE (pdt_id, abt_id)
, constraint pat_pdt_fk foreign key (pdt_id) references produkt (id)
, constraint pat_abt_fk foreign key (abt_id) references atribut (id)
);
/
comment on table produkt_atribut is 'Tablica koja povezuje produkte s atributima';
comment on column produkt_atribut.id is 'PK tablice';
comment on column produkt_atribut.pdt_id is 'FK produkt';
comment on column produkt_atribut.abt_id is 'FK atribut';
/
create sequence pat_seq
 nomaxvalue
 nominvalue
 nocycle;
 /
create or replace trigger bir_produkt_atribut_seq 
before insert on produkt_atribut
    for each row
begin
    if (:new.id is null ) then
        select pat_seq.nextval
        into :new.id
        from  dual;
    end if;
end;
/
 create index pat_pdt_fk_i on produkt_atribut (pdt_id);
 create index pat_abt_fk_i on produkt_atribut (abt_id);
/


--  ##----##-##----------###-----######-----###-------------######--####-------##-########-##----##-########-
--  ##---##--##---------##-##---##----##---##-##-----------##----##--##--------##-##-------###---##-##-------
--  ##--##---##--------##---##--##--------##---##----------##--------##--------##-##-------####--##-##-------
--  #####----##-------##-----##--######--##-----##---------##--------##--------##-######---##-##-##-######---
--  ##--##---##-------#########-------##-#########---------##--------##--##----##-##-------##--####-##-------
--  ##---##--##-------##-----##-##----##-##-----##---------##----##--##--##----##-##-------##---###-##-------
--  ##----##-########-##-----##--######--##-----##-#######--######--####--######--########-##----##-########-

create table klasa_cijene
( id        number(10,0) not null
, naziv     varchar2 (250) not null 
, opis      varchar2 (4000) 
, constraint kce_pk primary key (id)
, constraint kce_uk unique (naziv)
);
/
comment on table klasa_cijene is 'Tablica koja sadrži klasifikacije cijene';

comment on column klasa_cijene.id is 'PK tablice';
comment on column klasa_cijene.naziv is 'Naziv klase cijene';
comment on column klasa_cijene.opis is 'Opis klase cijene';
/
create sequence kce_seq
 nomaxvalue
 nominvalue
 nocycle;
/
create or replace trigger bir_klasa_cijene_seq 
before insert on klasa_cijene
    for each row
begin
    if (:new.id is null ) then
        select kce_seq.nextval
        into :new.id
        from  dual;
    end if;
end;
/

--  -######--####-------##-########-##----##----###----
--  ##----##--##--------##-##-------###---##---##-##---
--  ##--------##--------##-##-------####--##--##---##--
--  ##--------##--------##-######---##-##-##-##-----##-
--  ##--------##--##----##-##-------##--####-#########-
--  ##----##--##--##----##-##-------##---###-##-----##-
--  -######--####--######--########-##----##-##-----##-                

create table cijena
( id            number(10,0) not null
, opis          varchar2 (4000) 
, datum_od      date default sysdate not null
, iznos         number (10,2) not null  
, kce_id        number (10,0) not null
, pdt_id        number (10,0) 
, pat_id        number (10,0) 

, constraint cna_pk primary key (id)
, constraint cna_kce_fk foreign key (kce_id) references klasa_cijene (id)
, constraint cna_pdt_fk foreign key (pdt_id) references produkt (id)
, constraint cna_pat_fk foreign key (pat_id) references produkt_atribut (id)
);
/
comment on table cijena is 'Tablica sa cijenama proizvoda';
comment on column cijena.id is 'PK tablice';
comment on column cijena.opis is 'Opis cijene';
comment on column cijena.datum_od is 'Datum otkad vrijedi cijena';
comment on column cijena.iznos is 'Iznos';
comment on column cijena.kce_id is 'FK klasa cijene';
comment on column cijena.pdt_id is 'FK produkt';
/
create sequence cna_seq
 nomaxvalue
 nominvalue
 nocycle;
/
create or replace trigger bir_cijena_seq 
before insert on cijena
    for each row
begin
    if (:new.id is null ) then
        select cna_seq.nextval
        into :new.id
        from  dual;
    end if;
end;
/
 create index cna_kce_fk_i on cijena (kce_id);
 create index cna_pdt_fk_i on cijena (pdt_id);
 create index CNA_PAT_FK_i on cijena (pat_id);
/
alter table cijena add constraint cna_pdt_pat_arc_ck check (    ( ( pat_id is not null )  and ( pdt_id is null ) )
                                                            or  ( ( pdt_id is not null )  and ( pat_id is null ) ) 
                                                            );
/ 
--  ########---#######--########-##-----##--#######--##-------########---------########----###----########--########-----###----##----##-########-
--  ##-----##-##-----##------##--##-----##-##-----##-##-------##--------------------##----##-##---##-----##-##-----##---##-##---###---##-##-------
--  ##-----##-##-----##-----##---##-----##-##-----##-##-------##-------------------##----##---##--##-----##-##-----##--##---##--####--##-##-------
--  ##-----##-##-----##----##----##-----##-##-----##-##-------######--------------##----##-----##-########--########--##-----##-##-##-##-######---
--  ##-----##-##-----##---##------##---##--##-----##-##-------##-----------------##-----#########-##-----##-##---##---#########-##--####-##-------
--  ##-----##-##-----##--##--------##-##---##-----##-##-------##----------------##------##-----##-##-----##-##----##--##-----##-##---###-##-------
--  ########---#######--########----###-----#######--########-########-#######-########-##-----##-########--##-----##-##-----##-##----##-########-

create table dozvole_zabrane
( id                number(10,0) not null
, req_for           char(3) default 'FOR'
, pdt_id            number (10,0) 
, pat_id            number (10,0) 
, req_for_pdt_id    number (10,0) 
, req_for_pat_id    number (10,0) 

, constraint dze_pk primary key (id)
, constraint dze_pdt_fk foreign key (pdt_id) references produkt (id)
, constraint dze_pat_fk foreign key (pat_id) references produkt_atribut (id)
, constraint dze_req_for_pdt_fk foreign key (req_for_pdt_id) references produkt (id)
, constraint dze_req_for_pat_fk foreign key (req_for_pat_id) references produkt_atribut (id)
, constraint dze_req_for_CK check (req_for in ('REQ', 'FOR'))
);
/
comment on table dozvole_zabrane is 'Tablica koja kombinaciju dozvoljenih i zabranjenih relacija.';

comment on column dozvole_zabrane.id is 'PK tablice';
comment on column dozvole_zabrane.req_for is 'Oznaka REQ (REQUIRED) - ako je odabran skup A onda mora biti odabran i skup B, 
                                              Oznaka FOR (FORBIDEN) - ako je odabran skup A onda skup B ne može biti odabran' ;
comment on column dozvole_zabrane.pdt_id is 'FK produkt';
comment on column dozvole_zabrane.pat_id is 'FK produkt_atribut';
comment on column dozvole_zabrane.req_for_pdt_id is 'Dozvoljen ili zabranjen produkt za neki produkt ili kombinaciju produkta i atributa';
comment on column dozvole_zabrane.req_for_pat_id is 'Dozvoljen ili zabranjen produkt_atribut za neki produkt ili kombinaciju produkta i atributa';
/
create sequence dze_seq
 nomaxvalue
 nominvalue
 nocycle;
/
create or replace trigger bir_dozvole_zabrane_seq 
before insert on dozvole_zabrane
    for each row
begin
    if (:new.id is null ) then
        select dze_seq.nextval
        into :new.id
        from  dual;
    end if;
end;
/
 create index dze_pdt_fk_i on dozvole_zabrane (pdt_id);
 create index dze_pat_fk_i on dozvole_zabrane (pat_id);
 create index dze_req_for_pdt_fk_i on dozvole_zabrane (req_for_pdt_id);
 create index dze_req_for_pat_fk_i on dozvole_zabrane (req_for_pat_id);
/
alter table dozvole_zabrane add constraint dze_arc_ck 
check (    ( ( pdt_id is not null )  and ( pat_id is null ) and (req_for_pdt_id is not null) and (req_for_pat_id is null) )
       or  ( ( pdt_id is not null )  and ( pat_id is null ) and (req_for_pdt_id is null) and (req_for_pat_id is not null) )
       or  ( ( pdt_id is null )  and ( pat_id is not null ) and (req_for_pdt_id is not null) and (req_for_pat_id is null) )
       or  ( ( pdt_id is null )  and ( pat_id is not null ) and (req_for_pdt_id is null) and (req_for_pat_id is not null) )                                                          
      );