create or replace package pkg_dozvole_zabrane as

 function f_dohvati_produkt_atribut (p_pdt_id number, p_abt_id number) return number;
 -- Funkcija za dohvat ID-a i provjeru postojanja kombinacije produkt/atribut

 function f_dohvati_pdt_naziv (p_pdt_id number) return varchar2;
 -- Funkcija za dohvat naziva produkta
 
 function f_dohvati_pat_naziv (p_pat_id number) return varchar2;
 -- Funkcija za dohvat naziva produkta i atributa
 
 function f_dohvati_pdt_req_for (p_pdt_id number, p_req_for char) return varchar2;
 -- Dohvat dozvoljenih i zabranjenih proizvoda za produkt
 
 function f_dohvati_pat_req_for (p_pat_id number, p_req_for char) return varchar2;
 -- Dohvat dozvoljenih i zabranjenih proizvoda za produkt_atribut
 
 
end pkg_dozvole_zabrane;
/
create or replace package body pkg_dozvole_zabrane as

/* #########################################################################
               Funkcija za dohvat ID-a i provjeru postojanja kombinacije produkt/atribut
######################################################################### */
    function f_dohvati_produkt_atribut (p_pdt_id number, p_abt_id number) 
    return number
    is
     v_return number;
    begin
        select id
        into v_return
        from produkt_atribut
        where     pdt_id = p_pdt_id
        and abt_id = p_abt_id;
        
       return v_return ; 
    exception
        when NO_DATA_FOUND then
            return 0;
    end f_dohvati_produkt_atribut;


    
/* #########################################################################
                Funkcija za dohvat naziva produkta
######################################################################### */
    
    function f_dohvati_pdt_naziv (p_pdt_id number) return varchar2
    is
     v_return   varchar2(100);
    begin
    
    select pdt.naziv  naziv
    into v_return
    from produkt pdt
    where pdt.id = p_pdt_id ;

    return v_return ;
    exception
        when NO_DATA_FOUND then
            return 'Produkt ne postoji';
        when TOO_MANY_ROWS then
            return 'Vra?eno više redaka za produkt!';
    end f_dohvati_pdt_naziv;
    
/* #########################################################################
                Funkcija za dohvat naziva produkta i atributa
######################################################################### */    
    function f_dohvati_pat_naziv (p_pat_id number) 
    return varchar2
    is
     v_return   varchar2(100);
    begin
    
    select pdt.naziv || ' => ' || abt.naziv || ' - ' || abt.vrijednost   naziv
    into v_return
    from produkt pdt
    join klasa_produkta kpa on (pdt.kpa_id = kpa.id)
    join produkt_atribut pat on (pat.pdt_id = pdt.id)
    join atribut abt on (pat.abt_id =abt.id)
    where pat.id = p_pat_id;
    
    return v_return ;
    exception
        when no_data_found then
            return 'Produkt_atribut ne postoji';
        when too_many_rows then
            return 'Vra?eno više redaka za produkt_atribut!';
    end f_dohvati_pat_naziv;
    
/* #########################################################################
                Dohvat dozvoljenih i zabranjenih proizvoda za produkt
######################################################################### */
   function f_dohvati_pdt_req_for (p_pdt_id number, p_req_for char) 
   return varchar2
   is
    v_return   varchar2(4000);
    cursor c_dohvat is
        select 
        case
            when dze.req_for_pdt_id is not null then pkg_zadatak.p_dohvati_pdt_naziv(dze.req_for_pdt_id)
            when dze.req_for_pat_id is not null then pkg_zadatak.p_dohvati_pat_naziv(dze.req_for_pat_id)
        end produkt
        from    dozvole_zabrane dze
        left join produkt pdt1 on ( pdt1.id = dze.pdt_id )
        left join produkt pdt2 on ( pdt2.id = dze.req_for_pdt_id )
        left join produkt_atribut pat1 on ( pat1.id = dze.pat_id )
        left join produkt_atribut pat2 on ( pat2.id = dze.req_for_pat_id )
        where dze.pdt_id  = p_pdt_id
        and dze.req_for = p_req_for ;
   
   begin
    for r_dohvat in c_dohvat loop
       if v_return is null then
         v_return := r_dohvat.produkt;
       else
          v_return := v_return || ',' || r_dohvat.produkt;
       end if;
    end loop;
    return v_return;
   end f_dohvati_pdt_req_for;
  
/* #########################################################################
        Dohvat dozvoljenih i zabranjenih proizvoda za produkt_atribut
######################################################################### */ 
 function f_dohvati_pat_req_for (p_pat_id number, p_req_for char) 
   return varchar2
   is
    v_return   varchar2(4000);
    cursor c_dohvat is
        select 
        case
            when dze.req_for_pdt_id is not null then pkg_zadatak.p_dohvati_pdt_naziv(dze.req_for_pdt_id)
            when dze.req_for_pat_id is not null then pkg_zadatak.p_dohvati_pat_naziv(dze.req_for_pat_id)
        end produkt
        from    dozvole_zabrane dze
        left join produkt pdt1 on ( pdt1.id = dze.pdt_id )
        left join produkt pdt2 on ( pdt2.id = dze.req_for_pdt_id )
        left join produkt_atribut pat1 on ( pat1.id = dze.pat_id )
        left join produkt_atribut pat2 on ( pat2.id = dze.req_for_pat_id )
        where dze.pat_id  = p_pat_id
        and dze.req_for = p_req_for ;
   
   begin
    for r_dohvat in c_dohvat loop
       if v_return is null then
         v_return := r_dohvat.produkt;
       else
          v_return := v_return || ',' || r_dohvat.produkt;
       end if;
    end loop;
    return v_return;
   end f_dohvati_pat_req_for;

end pkg_dozvole_zabrane;