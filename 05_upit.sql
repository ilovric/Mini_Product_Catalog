/* 
Rješenje za dohvat obaveznih i zabranjenih produkata/atributa za ulaznu kombinaciju
produkta/atribut - SQL upit ili PL/SQL funkcija

Za testiranje unos - P_PRODUKT := 1 (TEL+TV+INT)
Ispis:
--Direktno obavezni produkti: Mobitel => Boja - Plava         / 1 produkt
--Direktno zabranjeni produkti: Tablet,Maska za mobitel => Boja - Crvena,HBO programi    /3 produkta
*/



DECLARE
    v_produkt   NUMBER;  
    v_atribut   NUMBER; 
    v_produkt_atribut NUMBER;
BEGIN
    v_produkt := :P_PRODUKT;
    v_atribut := :P_ATRIBUT;
        
    if v_produkt is null then
            dbms_output.put_line( 'Nije unesen produkt.');
    elsif v_produkt is not null and v_atribut is null then    
            dbms_output.put_line( 'PRODUKT: ' || pkg_dozvole_zabrane.f_dohvati_pdt_naziv (v_produkt));
            dbms_output.put_line( 'Direktno obavezni produkti: ' || pkg_dozvole_zabrane.f_dohvati_pdt_req_for ( v_produkt,'REQ'));
            dbms_output.put_line( 'Direktno zabranjeni produkti: ' || pkg_dozvole_zabrane.f_dohvati_pdt_req_for ( v_produkt,'FOR'));  
            dbms_output.new_line;
            dbms_output.put_line( 'Rekurzivno obavezni produkti: '  || pkg_dozvole_zabrane.f_dohvati_req_for ( v_produkt,'REQ'));  
            dbms_output.put_line( 'Rekurzivno zabranjeni produkti: ' || pkg_dozvole_zabrane.f_dohvati_req_for ( v_produkt,'FOR'));
    else
            v_produkt_atribut  := pkg_dozvole_zabrane.f_dohvati_produkt_atribut (v_produkt, v_atribut);
        if v_produkt_atribut != 0 then
            dbms_output.put_line( 'PRODUKT-ATRIBUT: ' || pkg_dozvole_zabrane.f_dohvati_pat_naziv(v_produkt_atribut));
            dbms_output.put_line( 'Direktno obavezni produkti: ' || pkg_dozvole_zabrane.f_dohvati_pat_req_for ( v_produkt_atribut,'REQ'));
            dbms_output.put_line( 'Direktno zabranjeni produkti: ' || pkg_dozvole_zabrane.f_dohvati_pat_req_for ( v_produkt_atribut,'FOR'));
            dbms_output.new_line;      
            dbms_output.put_line( 'Rekurzivno obavezni produkti: '  || pkg_dozvole_zabrane.f_dohvati_req_for ( v_produkt_atribut,'REQ'));
            dbms_output.put_line( 'Rekurzivno zabranjeni produkti: ' || pkg_dozvole_zabrane.f_dohvati_req_for ( v_produkt_atribut,'FOR'));           
        else 
            dbms_output.put_line( 'Ne postoji takva kombinacija produkta i atributa.');
        end if;
    end if;
END;
