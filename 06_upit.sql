/* -Opcionalno, rekurzivni dohvat svih relacija do kraja na osnovu uzlaznih parametara
        - Za konfiguraciju: P1 REQ P2, P2 FOR P3, P2 REQ P4
        - Rezultat za ulazni parametar P1 treba biti:
            - Obavezni produkti: P2, P4
            - Zabranjeni produkti: P3
*/
    with hierarchy_all as (
     select lpad(' ',7*(level-1))||pdt.id ||'# '||pdt.naziv produkt 
     ,    pdt.id  child_product
     ,    pdt.pdt_id first_parent   -- neposredni roditelj
     ,    pdt.naziv  pdt_naziv
     ,    sys_connect_by_path(pdt.naziv, '/') as path    -- cijela putanja
     ,    connect_by_root (pdt.id)  root_parent_name_last    --prvi roditelj id
     ,    connect_by_root (pdt.naziv)  root_parent_name_last    --prvi roditelj name
     ,    connect_by_isleaf   
     ,    level   level_hijerahije
     from produkt pdt
     start with pdt.pdt_id is null
     connect by  prior pdt.id = pdt.pdt_id
     order siblings by pdt.id asc
  )
  select ha.produkt hijerahija
  ,  ha.child_product || '# ' ||ha.pdt_naziv  produkt
  ,  pkg_dozvole_zabrane.f_dohvati_pdt_req_for ( ha.child_product,'REQ')  PRODUCT_REQUIRED
  ,  pkg_dozvole_zabrane.f_dohvati_pdt_req_for ( ha.child_product,'FOR')  PRODUCT_FORBIDEN  
  --,  pkg_dozvole_zabrane.f_dohvati_req_for ( ha.child_product,'REQ')   PRODUCT_REQUIRED_REC  --rekurzivni dohvat
  --,  pkg_dozvole_zabrane.f_dohvati_req_for ( ha.child_product,'FOR')   PRODUCT_FORBIDEN_REC  --rekurzivni dohvat
  ,  pat.id  produkt_atribut_id
  ,  case when pat.id is not null then pat.id || '# ' ||pkg_dozvole_zabrane.f_dohvati_pat_naziv (pat.id)  end  produkt_atribut_naziv
  ,  pkg_dozvole_zabrane.f_dohvati_pat_req_for ( v_produkt_atribut,'REQ') PRODUCT_ATRIBUT_REQUIRED
  ,  pkg_dozvole_zabrane.f_dohvati_pat_req_for ( v_produkt_atribut,'FOR') PRODUCT_ATRIBUT_FORBIDEN
  --,  pkg_dozvole_zabrane.f_dohvati_req_for ( pat.id,'REQ')   PRODUCT_ATRIBUT_REQUIRED_REC
  --,  pkg_dozvole_zabrane.f_dohvati_req_for ( pat.id,'FOR')   PRODUCT_ATRIBUT_FORBIDEN_REC
  from hierarchy_all ha
  left join produkt_atribut pat on (pat.pdt_id = ha.child_product)
  where 1 = 1
  and (ha.child_product = nvl (:P_PRODUKT, ha.child_product) or pat.id = nvl(:P_PRODUKT, pat.id))
;