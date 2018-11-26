/* -Opcionalno, rekurzivni dohvat svih relacija do kraja na osnovu uzlaznih parametara
        - Za konfiguraciju: P1 REQ P2, P2 FOR P3, P2 REQ P4
        - Rezultat za ulazni parametar P1 treba biti:
            - Obavezni produkti: P2, P4
            - Zabranjeni produkti: P3
*/
select lpad(' ',7*(level-1))||pdt.id ||'# '||pdt.naziv produkt 
, null produkt_atribut
, pkg_dozvole_zabrane.f_dohvati_pdt_req_for ( pdt.id,'REQ') "Obavezni produkti"
, pkg_dozvole_zabrane.f_dohvati_pdt_req_for ( pdt.id,'FOR') "Zabranjeni produkti"
from produkt pdt
join klasa_produkta kpa on (pdt.kpa_id = kpa.id)
start with pdt.id = :P_ID
connect by prior pdt.id = pdt.pdt_id
union
select lpad(' ',7*(level-1))||pdt.id ||'# '||pdt.naziv produkt
, pat.id ||'# '|| pdt.naziv || ' => ' || abt.naziv || ' - ' || abt.vrijednost produkt_atribut
, pkg_dozvole_zabrane.f_dohvati_pat_req_for ( pat.id,'REQ') "Obavezni produkti"
, pkg_dozvole_zabrane.f_dohvati_pat_req_for ( pat.id,'FOR') "Zabranjeni produkti"
from produkt pdt
join klasa_produkta kpa on (pdt.kpa_id = kpa.id)
join produkt_atribut pat on (pat.pdt_id = pdt.id)
join atribut abt on (pat.abt_id =abt.id)
start with pdt.id = :P_ID
connect by prior pdt.id = pdt.pdt_id
order by 1 desc,2 desc
;