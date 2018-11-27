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
  
 function f_dohvati_req_for (p_id number, p_req_for char, recursive boolean default false, p_name varchar2 default null) return varchar2;
 /* Funkcija za dohvat REQUIRED/FORBIDEN vrijednosti za neke produkte prema tablici DOZVOLE_ZABRANE
    PARAMETRI: p_id - id produkta
               p_req_for - vrijednost koja se pretražuje REQ ili FOR
               recursive - varijabla za provjeru rekurzije, true je kad fj. poziva samu sebe, ina?e je dalse
               p_name - za spremanje trenutnog naziva
    ŠTO FUNKCIJA VRACA:  Funkcija vraca string koji se sastoji od zarazeom odjeljenih REQ ili FOR produkata           
 */

 
end pkg_dozvole_zabrane;
/
create or replace package body pkg_dozvole_zabrane as

/* ###########################################################################################
               Funkcija za dohvat ID-a i provjeru postojanja kombinacije produkt/atribut
########################################################################################### */
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


    
/* ###########################################################################################
                Funkcija za dohvat naziva produkta
########################################################################################### */
    
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
    
/* ###########################################################################################
                Funkcija za dohvat naziva produkta i atributa
  ########################################################################################### */    
    function f_dohvati_pat_naziv (p_pat_id number) 
    return varchar2
    is
     v_return   varchar2(100);
    begin
    
    select pdt.naziv || ' => ' || kat.naziv || ' - ' || abt.vrijednost   naziv
    into v_return
    from produkt pdt
    join klasa_produkta kpa on (pdt.kpa_id = kpa.id)
    join produkt_atribut pat on (pat.pdt_id = pdt.id)
    join atribut abt on (pat.abt_id =abt.id)
    join kategorija_atributa kat on (kat.id = abt.kat_id)
    where pat.id = p_pat_id;
    
    return v_return ;
    exception
        when no_data_found then
            return 'Produkt_atribut ne postoji';
        when too_many_rows then
            return 'Vra?eno više redaka za produkt_atribut!';
    end f_dohvati_pat_naziv;
    
/* ###########################################################################################
                Dohvat dozvoljenih i zabranjenih proizvoda za produkt
   ########################################################################################### */
   function f_dohvati_pdt_req_for (p_pdt_id number, p_req_for char) 
   return varchar2
   is
    v_return   varchar2(4000);
    cursor c_dohvat is
        select 
        case
            when dze.req_for_pdt_id is not null then pkg_dozvole_zabrane.f_dohvati_pdt_naziv(dze.req_for_pdt_id)
            when dze.req_for_pat_id is not null then pkg_dozvole_zabrane.f_dohvati_pat_naziv(dze.req_for_pat_id)
        end produkt
        from    dozvole_zabrane dze
        left join produkt pdt1 on ( pdt1.id = dze.pdt_id )
        left join produkt pdt2 on ( pdt2.id = dze.req_for_pdt_id )
        left join produkt_atribut pat1 on ( pat1.id = dze.pat_id )
        left join produkt_atribut pat2 on ( pat2.id = dze.req_for_pat_id )
        where dze.pdt_id  = p_pdt_id
        and dze.req_for = p_req_for ;
   counter number;
   begin
   counter := 0;
    for r_dohvat in c_dohvat loop
       --DBMS_OUTPUT.PUT_LINE(' Poziv F_DOHVATI_PDT_REQ_FOR');
       --DBMS_OUTPUT.PUT_LINE (counter+1 ||' - ' || r_dohvat.produkt);
       if v_return is null then
         v_return := r_dohvat.produkt;
       else
          v_return := v_return || ',' || r_dohvat.produkt;
       end if;
    end loop;
    return v_return;
   end f_dohvati_pdt_req_for;
  
/* ###########################################################################################
        Dohvat dozvoljenih i zabranjenih proizvoda za produkt_atribut
  ########################################################################################### */ 
 function f_dohvati_pat_req_for (p_pat_id number, p_req_for char) 
   return varchar2
   is
    v_return   varchar2(4000);
    cursor c_dohvat is
        select 
        case
            when dze.req_for_pdt_id is not null then pkg_dozvole_zabrane.f_dohvati_pdt_naziv(dze.req_for_pdt_id)
            when dze.req_for_pat_id is not null then pkg_dozvole_zabrane.f_dohvati_pat_naziv(dze.req_for_pat_id)
        end produkt
        from    dozvole_zabrane dze
        left join produkt pdt1 on ( pdt1.id = dze.pdt_id )
        left join produkt pdt2 on ( pdt2.id = dze.req_for_pdt_id )
        left join produkt_atribut pat1 on ( pat1.id = dze.pat_id )
        left join produkt_atribut pat2 on ( pat2.id = dze.req_for_pat_id )
        where dze.pat_id  = p_pat_id
        and dze.req_for = p_req_for ;
   
   counter number;
   begin
    counter := 0;
    for r_dohvat in c_dohvat loop
        --DBMS_OUTPUT.PUT_LINE('                  Poziv F_DOHVATI_PAT_REQ_FOR');
        
        --DBMS_OUTPUT.PUT_LINE (counter+1 ||' - ' || r_dohvat.produkt);
       if v_return is null then
         v_return := r_dohvat.produkt;
       else
          v_return := v_return || ',' || r_dohvat.produkt;
       end if;
    end loop;
    return v_return;
   end f_dohvati_pat_req_for;
   
/* ###########################################################################################
    Funkcija za dohvat REQUIRED/FORBIDEN vrijednosti za neke produkte prema tablici DOZVOLE_ZABRANE
    PARAMETRI: p_id - id produkta
               p_req_for - vrijednost koja se pretražuje REQ ili FOR
               recursive - varijabla za provjeru rekurzije, true je kad fj. poziva samu sebe, ina?e je dalse
               p_name - za spremanje trenutnog naziva
    ŠTO FUNKCIJA VRACA:  Funkcija vraca string koji se sastoji od zarazeom odjeljenih REQ ili FOR produkata           
  ########################################################################################### */ 
   function f_dohvati_req_for (p_id number, p_req_for char, recursive boolean default false, p_name varchar2 default null)
   return varchar2
   is
   
   -- ako je relacija A REQ B ili A FOR B
   cursor c_all is
         select nvl(dze.pdt_id, dze.pat_id) Produkt_A_ID
        , case
            when dze.pdt_id is not null then pkg_dozvole_zabrane.f_dohvati_pdt_naziv(dze.pdt_id)
            when dze.pat_id is not null then pkg_dozvole_zabrane.f_dohvati_pat_naziv(dze.pat_id)
        end produkt_a   
        , dze.req_for
        , nvl(dze.req_for_pdt_id, dze.req_for_pat_id) Produkt_B_ID
        , case
            when dze.req_for_pdt_id is not null then pkg_dozvole_zabrane.f_dohvati_pdt_naziv(dze.req_for_pdt_id)
            when dze.req_for_pat_id is not null then pkg_dozvole_zabrane.f_dohvati_pat_naziv(dze.req_for_pat_id)
        end produkt_b
        , dze.id dze_id
        from    dozvole_zabrane dze
        left join produkt pdt1 on ( pdt1.id = dze.pdt_id )
        left join produkt pdt2 on ( pdt2.id = dze.req_for_pdt_id )
        left join produkt_atribut pat1 on ( pat1.id = dze.pat_id )
        left join produkt_atribut pat2 on ( pat2.id = dze.req_for_pat_id )
        where nvl(dze.pdt_id, dze.pat_id) = p_id
        and dze.req_for = p_req_for 
        ;
        
   v_return   varchar2(4000);
   v_temp_produkt  varchar2(400);
   begin
       
       for r_dohvat in c_all loop     
          v_temp_produkt :=  pkg_dozvole_zabrane.f_dohvati_req_for (r_dohvat.produkt_b_id,p_req_for,true, r_dohvat.produkt_b);
            --ako je result prazan 
            if v_return is null then  
                --provjeri postoje li djeca
                if v_temp_produkt is not null then
                    v_return := v_temp_produkt;   
                end if;
            else
                v_return := v_temp_produkt || ',' || v_return;   
            end if;
        end loop;
    
        
    if v_return is null and recursive = true then
        v_return := p_name;
    else
        if recursive = true then
         v_return := p_name || ',' || v_return;
        end if;
    end if;
    return v_return;
   end f_dohvati_req_for;
   

end pkg_dozvole_zabrane;