REM INSERTING into KATEGORIJA_ATRIBUTA
SET DEFINE OFF;
Insert into KATEGORIJA_ATRIBUTA (ID,NAZIV) values ('1','Podrijetlo');
Insert into KATEGORIJA_ATRIBUTA (ID,NAZIV) values ('2','Trajanje ugovora');
Insert into KATEGORIJA_ATRIBUTA (ID,NAZIV) values ('3','Brzina');
Insert into KATEGORIJA_ATRIBUTA (ID,NAZIV) values ('4','Materijal izrade');
Insert into KATEGORIJA_ATRIBUTA (ID,NAZIV) values ('5','Boja');
Insert into KATEGORIJA_ATRIBUTA (ID,NAZIV) values ('6','Vrsta uređaja');
commit;

REM INSERTING into ATRIBUT
SET DEFINE OFF;
Insert into ATRIBUT (ID,VRIJEDNOST,KAT_ID) values ('1','Dalmacija','1');
Insert into ATRIBUT (ID,VRIJEDNOST,KAT_ID) values ('2','Istra','1');
Insert into ATRIBUT (ID,VRIJEDNOST,KAT_ID) values ('3','24mj','2');
Insert into ATRIBUT (ID,VRIJEDNOST,KAT_ID) values ('4','12mj','2');
Insert into ATRIBUT (ID,VRIJEDNOST,KAT_ID) values ('5','100Mbps','3');
Insert into ATRIBUT (ID,VRIJEDNOST,KAT_ID) values ('6','200Mbps','3');
Insert into ATRIBUT (ID,VRIJEDNOST,KAT_ID) values ('7','Drvo','4');
Insert into ATRIBUT (ID,VRIJEDNOST,KAT_ID) values ('8','Metal','4');
Insert into ATRIBUT (ID,VRIJEDNOST,KAT_ID) values ('9','Crvena','5');
Insert into ATRIBUT (ID,VRIJEDNOST,KAT_ID) values ('10','Crna','5');
Insert into ATRIBUT (ID,VRIJEDNOST,KAT_ID) values ('11','Plava','5');
Insert into ATRIBUT (ID,VRIJEDNOST,KAT_ID) values ('12','Bežični ','6');
commit;

REM INSERTING into KLASA_PRODUKTA
SET DEFINE OFF;
Insert into KLASA_PRODUKTA (ID,NAZIV,OPIS) values ('1','Telekomunikacije','Razni tipovi tarifa');
Insert into KLASA_PRODUKTA (ID,NAZIV,OPIS) values ('2','Uređaji',null);
Insert into KLASA_PRODUKTA (ID,NAZIV,OPIS) values ('3','Prehrana',null);
Insert into KLASA_PRODUKTA (ID,NAZIV,OPIS) values ('4','Razno',null);
commit;


REM INSERTING into PRODUKT
SET DEFINE OFF;
Insert into PRODUKT (ID,NAZIV,OPIS,DATUM_OD,DATUM_DO,KPA_ID,PDT_ID) values ('1','TEL+TV+INT','Produkt s uključenim telefonom, TV-om i internetom',to_date('27.11.18 13:19:11','DD.MM.RR HH24:MI:SS'),null,'1',null);
Insert into PRODUKT (ID,NAZIV,OPIS,DATUM_OD,DATUM_DO,KPA_ID,PDT_ID) values ('2','TEL+INT',null,to_date('25.11.18 13:27:30','DD.MM.RR HH24:MI:SS'),null,'1','1');
Insert into PRODUKT (ID,NAZIV,OPIS,DATUM_OD,DATUM_DO,KPA_ID,PDT_ID) values ('3','Internet',null,to_date('25.11.18 13:28:27','DD.MM.RR HH24:MI:SS'),null,'1','2');
Insert into PRODUKT (ID,NAZIV,OPIS,DATUM_OD,DATUM_DO,KPA_ID,PDT_ID) values ('4','Telefon',null,to_date('25.11.18 13:28:27','DD.MM.RR HH24:MI:SS'),null,'1','2');
Insert into PRODUKT (ID,NAZIV,OPIS,DATUM_OD,DATUM_DO,KPA_ID,PDT_ID) values ('5','Televizija',null,to_date('25.11.18 13:28:27','DD.MM.RR HH24:MI:SS'),null,'1','1');
Insert into PRODUKT (ID,NAZIV,OPIS,DATUM_OD,DATUM_DO,KPA_ID,PDT_ID) values ('6','Osnovnih 5 kanala','HRT, NOVA TV, RTL, DOMA, CMC',to_date('25.11.18 13:34:47','DD.MM.RR HH24:MI:SS'),null,'1','5');
Insert into PRODUKT (ID,NAZIV,OPIS,DATUM_OD,DATUM_DO,KPA_ID,PDT_ID) values ('7','HBO programi',null,to_date('25.11.18 13:34:47','DD.MM.RR HH24:MI:SS'),null,'1','5');
Insert into PRODUKT (ID,NAZIV,OPIS,DATUM_OD,DATUM_DO,KPA_ID,PDT_ID) values ('8','Snimalica',null,to_date('25.11.18 13:35:15','DD.MM.RR HH24:MI:SS'),null,'1','5');
Insert into PRODUKT (ID,NAZIV,OPIS,DATUM_OD,DATUM_DO,KPA_ID,PDT_ID) values ('10','Fiksni telefon',null,to_date('25.11.18 13:36:22','DD.MM.RR HH24:MI:SS'),null,'2','4');
Insert into PRODUKT (ID,NAZIV,OPIS,DATUM_OD,DATUM_DO,KPA_ID,PDT_ID) values ('11','Mobitel',null,to_date('25.11.18 13:36:22','DD.MM.RR HH24:MI:SS'),null,'2','4');
Insert into PRODUKT (ID,NAZIV,OPIS,DATUM_OD,DATUM_DO,KPA_ID,PDT_ID) values ('12','Maska za mobitel',null,to_date('27.11.18 13:45:53','DD.MM.RR HH24:MI:SS'),null,'4','11');
Insert into PRODUKT (ID,NAZIV,OPIS,DATUM_OD,DATUM_DO,KPA_ID,PDT_ID) values ('13','Tablet',null,to_date('25.11.18 14:00:07','DD.MM.RR HH24:MI:SS'),null,'2',null);
Insert into PRODUKT (ID,NAZIV,OPIS,DATUM_OD,DATUM_DO,KPA_ID,PDT_ID) values ('14','Maska za tablet',null,to_date('25.11.18 14:12:21','DD.MM.RR HH24:MI:SS'),null,'4','13');
Insert into PRODUKT (ID,NAZIV,OPIS,DATUM_OD,DATUM_DO,KPA_ID,PDT_ID) values ('15','Laptop',null,to_date('25.11.18 14:12:21','DD.MM.RR HH24:MI:SS'),null,'4',null);
commit;


REM INSERTING into PRODUKT_ATRIBUT
SET DEFINE OFF;
Insert into PRODUKT_ATRIBUT (ID,PDT_ID,ABT_ID) values ('16','11','10');
Insert into PRODUKT_ATRIBUT (ID,PDT_ID,ABT_ID) values ('17','11','11');
Insert into PRODUKT_ATRIBUT (ID,PDT_ID,ABT_ID) values ('18','1','6');
Insert into PRODUKT_ATRIBUT (ID,PDT_ID,ABT_ID) values ('19','2','5');
Insert into PRODUKT_ATRIBUT (ID,PDT_ID,ABT_ID) values ('20','2','6');
Insert into PRODUKT_ATRIBUT (ID,PDT_ID,ABT_ID) values ('21','4','12');
Insert into PRODUKT_ATRIBUT (ID,PDT_ID,ABT_ID) values ('22','12','8');
Insert into PRODUKT_ATRIBUT (ID,PDT_ID,ABT_ID) values ('23','12','9');
Insert into PRODUKT_ATRIBUT (ID,PDT_ID,ABT_ID) values ('25','3','5');
Insert into PRODUKT_ATRIBUT (ID,PDT_ID,ABT_ID) values ('26','3','6');
commit;



REM INSERTING into DOZVOLE_ZABRANE
SET DEFINE OFF;
Insert into DOZVOLE_ZABRANE (ID,REQ_FOR,PDT_ID,PAT_ID,REQ_FOR_PDT_ID,REQ_FOR_PAT_ID) values ('1','REQ',null,'18','13',null);
Insert into DOZVOLE_ZABRANE (ID,REQ_FOR,PDT_ID,PAT_ID,REQ_FOR_PDT_ID,REQ_FOR_PAT_ID) values ('2','FOR','1',null,'13',null);
Insert into DOZVOLE_ZABRANE (ID,REQ_FOR,PDT_ID,PAT_ID,REQ_FOR_PDT_ID,REQ_FOR_PAT_ID) values ('3','FOR','13',null,'15',null);
Insert into DOZVOLE_ZABRANE (ID,REQ_FOR,PDT_ID,PAT_ID,REQ_FOR_PDT_ID,REQ_FOR_PAT_ID) values ('4','REQ','13',null,'14',null);
Insert into DOZVOLE_ZABRANE (ID,REQ_FOR,PDT_ID,PAT_ID,REQ_FOR_PDT_ID,REQ_FOR_PAT_ID) values ('5','REQ','1',null,null,'17');
Insert into DOZVOLE_ZABRANE (ID,REQ_FOR,PDT_ID,PAT_ID,REQ_FOR_PDT_ID,REQ_FOR_PAT_ID) values ('6','REQ','4',null,null,'21');
Insert into DOZVOLE_ZABRANE (ID,REQ_FOR,PDT_ID,PAT_ID,REQ_FOR_PDT_ID,REQ_FOR_PAT_ID) values ('7','FOR',null,'21',null,'22');
Insert into DOZVOLE_ZABRANE (ID,REQ_FOR,PDT_ID,PAT_ID,REQ_FOR_PDT_ID,REQ_FOR_PAT_ID) values ('8','FOR','1',null,null,'23');
Insert into DOZVOLE_ZABRANE (ID,REQ_FOR,PDT_ID,PAT_ID,REQ_FOR_PDT_ID,REQ_FOR_PAT_ID) values ('9','FOR','1',null,'7',null);
Insert into DOZVOLE_ZABRANE (ID,REQ_FOR,PDT_ID,PAT_ID,REQ_FOR_PDT_ID,REQ_FOR_PAT_ID) values ('10','REQ','3',null,'8',null);
commit;


REM INSERTING into KLASA_CIJENE
SET DEFINE OFF;
Insert into KLASA_CIJENE (ID,NAZIV,OPIS) values ('1','Jednokratno','Plaćanje odjednom');
Insert into KLASA_CIJENE (ID,NAZIV,OPIS) values ('2','Mjesečno','Plaćanje po mjesecu');
Insert into KLASA_CIJENE (ID,NAZIV,OPIS) values ('3','Popust','Popust na plaćanje');
commit;


Insert into CIJENA (ID,OPIS,DATUM_OD,IZNOS,KCE_ID,PDT_ID,PAT_ID) values ('1','TRIO paket',to_date('25.11.18 00:00:00','DD.MM.RR HH24:MI:SS'),'169','2',null,'18');
Insert into CIJENA (ID,OPIS,DATUM_OD,IZNOS,KCE_ID,PDT_ID,PAT_ID) values ('2','DUO 200Mbps',to_date('25.11.18 00:00:00','DD.MM.RR HH24:MI:SS'),'139','2',null,'20');
Insert into CIJENA (ID,OPIS,DATUM_OD,IZNOS,KCE_ID,PDT_ID,PAT_ID) values ('3','DUO 100Mbps',to_date('25.11.18 00:00:00','DD.MM.RR HH24:MI:SS'),'119','2',null,'19');
Insert into CIJENA (ID,OPIS,DATUM_OD,IZNOS,KCE_ID,PDT_ID,PAT_ID) values ('4','Start plus',to_date('25.11.18 00:00:00','DD.MM.RR HH24:MI:SS'),'109','2','2',null);
Insert into CIJENA (ID,OPIS,DATUM_OD,IZNOS,KCE_ID,PDT_ID,PAT_ID) values ('6','Uzmi HP',to_date('01.12.18 00:00:00','DD.MM.RR HH24:MI:SS'),'5999','1','15',null);
commit;
