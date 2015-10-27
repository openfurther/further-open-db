
--------------------------------------------------------
--  DDL for Package CONST
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE FRTHR_FQE.CONST AS 

  function get_debug return number;

  function get_query_xml_namespace return varchar2;
  function get_namespace_id_by_string( p_namespace_str varchar2 ) return number;
  function get_uuedw_namespace_id return number;
  function get_updbl_namespace_id return number;
  function get_further_namespace_id return number;
  function get_loinc_namespace_id return number;
  function get_snomed_namespace_id return number;
  function get_icd9_namespace_id return number;
  function get_icd10_namespace_id return number;
  function get_icdO_namespace_id return number;
  function get_cpt_namespace_id return number;
  function get_ih_namespace_id return number;
  function get_uuedw_apo_namespace_id return number;
  function get_ih_apo_namespace_id return number;
  function get_test_namespace_id return number;

  function get_namespace_label ( p_namespace_id number ) return varchar2;

  function get_further_ontylog_nmspc_id return varchar2;

  function get_uuedw_patient_obj_asset_id return number;
  function get_frthr_person_obj_asset_id return number;
  function get_uuedw_apo_person_asset_id return number;
  function get_updbl_person_obj_asset_id return number;
  function get_frthr_enc_asset_id return number;
  function get_uuedw_enc_asset_id return number;
  function get_ih_person_obj_asset_id return number;

  function get_attr_relationship_id return number;
  function is_id( p_var varchar2 ) return number;
  function get_attr_trans_func return varchar2;
  function get_attr_val_trans_func return varchar2;
  function get_attr_trans_prop_nm return varchar2;
  function get_attr_val_trans_prop_nm return varchar2;

  function get_observation_type_dx return varchar2;
  function get_observation_type_lab return varchar2;
  function get_observation_type_procedure return varchar2;
  function get_order_type_med return varchar2;
  
  function get_analytical_obs_class_id return number;
  function get_uuedw_lab_obs_class_id return number;

END CONST;

/
--------------------------------------------------------
--  DDL for Package FURTHER_PKG
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE FRTHR_FQE.FURTHER_PKG AS

  TYPE query_nmspc_ref_cursor IS REF CURSOR RETURN query_nmspc%ROWTYPE;
  
  procedure log_msg( p_module app_log.app_module%type,  p_msg_cd app_log.app_msg_cd%type, p_msg app_log.app_log_msg%type, p_user_id app_log.app_user_id%type );

  procedure get_physical_query( p_query_id query_def.query_id%type );

  procedure build_uuedw_query( p_query_id number );
  
  

END FURTHER_PKG;
 
 

/
--------------------------------------------------------
--  DDL for Package Body CONST
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY FRTHR_FQE.CONST AS

  function get_analytical_obs_class_id return number as 
  begin
    return 179;
  end;

  function get_uuedw_lab_obs_class_id return number as 
  begin
    return 133;
  end;

  function get_further_ontylog_nmspc_id return varchar2 as
  begin
    return 32771;
  end;
  
  function get_test_namespace_id return number as
  begin
    return -1;
  end;
  
  function get_query_xml_namespace return varchar2 as
  begin
    return 'xmlns=http://further.utah.edu/core/query xmlns:ora=http://xmlns.oracle.com/xdb xmlns:xsi=http://www.w3.org/2001/XMLSchema-instance xmlns:xp20=http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.Xpath20';
  end;
  
  function get_frthr_enc_asset_id return number as
  begin
    return 178;
  end;

  function get_uuedw_enc_asset_id return number as
  begin
    return 134;
  end;

  function get_frthr_person_obj_asset_id return number as
  begin
    return 177;
  end;
  
  function get_ih_person_obj_asset_id return number as
  begin
    return 2670;
  end;

  function get_updbl_person_obj_asset_id return number as
  begin
    return 180;
  end;

  function get_uuedw_patient_obj_asset_id return number as
  begin
    return 131;
  end;

  function get_uuedw_apo_person_asset_id return number as
  begin
    return 2850;
  end;

  function get_namespace_id_by_string( p_namespace_str varchar2 ) return number as
  begin
  
    if p_namespace_str = 'UUEDW' then 
    
      return get_uuedw_namespace_id;
      
    elsif p_namespace_str = 'UPDBL' then 
    
      return get_updbl_namespace_id;
      
    elsif p_namespace_str = 'UPDB' then 
    
      return get_updbl_namespace_id;
      
    elsif p_namespace_str = 'FURTHER' then 
    
      return get_further_namespace_id;
      
    elsif p_namespace_str = 'SNOMED' then 
    
      return get_snomed_namespace_id;
      
    elsif p_namespace_str = 'LOINC' then 
    
      return get_loinc_namespace_id;
      
    elsif p_namespace_str = 'ICD9' then 
    
      return get_icd9_namespace_id;
      
    elsif p_namespace_str = 'ICD10' then 
    
      return get_icd10_namespace_id;
      
    elsif p_namespace_str = 'CPT' then 
    
      return get_cpt_namespace_id;
      
    else 
    
      return -1;
      
    end if;
  
  end;
  function get_uuedw_apo_namespace_id return number as
  begin
    return 64901;
  end;

  function get_ih_apo_namespace_id return number as
  begin
    return 64902;
  end;

  function get_ih_namespace_id return number as
  begin
    return 32780;
  end;

  function get_uuedw_namespace_id return number as
  begin
    return 32776;
  end;

  function get_updbl_namespace_id return number as
  begin
    return 32774;
  end;
  
  function get_further_namespace_id return number as
  begin
    return 32769;
  end;
  
  function get_loinc_namespace_id return number as
  begin
    return 5102;
  end;
  
  function get_icd9_namespace_id return number as
  begin
    return 10;
  end;
  
  function get_icd10_namespace_id return number as
  begin
    return 1518;
  end;
  
  function get_icdO_namespace_id return number as
  begin
    return 65043;
  end;
  
  function get_cpt_namespace_id return number as
  begin
    return 20;
  end;
  
  function get_snomed_namespace_id return number as
  begin
    return 30;
  end;
  
  function get_namespace_label ( p_namespace_id number ) return varchar2 as
  begin

    if p_namespace_id = const.get_uuedw_namespace_id then 
      return 'UUEDW';
    elsif p_namespace_id = const.get_updbl_namespace_id then
      return 'UPDBL';
    else 
      return null;
    end if;
  
  end;
  
  function get_attr_relationship_id return number as
  begin
    return 1;
  end;

  function get_debug return number as
  begin
    return 1;
  end;
  
  function is_id( p_var varchar2 ) return number as
  begin
    if ( instr( p_var, 'id.' ) = 1 ) then
      return 1;
    end if;
    return 0;
  end;
  
  function get_attr_trans_prop_nm return varchar2 as
  begin
    return 'ATTR_TRANS_FUNC';
  end;

  function get_attr_val_trans_prop_nm return varchar2 as
  begin
    return 'ATTR_VALUE_TRANS_FUNC';
  end;

  function get_attr_trans_func return varchar2 as
  begin
    return 'translateAttr';
  end;

  function get_attr_val_trans_func return varchar2 as
  begin
    return 'translateCode';
  end;

  function get_observation_type_dx return varchar2 as
  begin
    return 'Dx';
  end;

  function get_observation_type_lab return varchar2 as
  begin
    return 'Lab';
  end;
  
  function get_observation_type_procedure return varchar2 as
  begin
    return 'Procedure';
  end;

  function get_order_type_med return varchar2 as
  begin
    return 'Medication';
  end;



END CONST;

/
--------------------------------------------------------
--  DDL for Package Body FURTHER_PKG
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY FRTHR_FQE.FURTHER_PKG AS

TYPE query_nmspc_ref_cursor IS REF CURSOR RETURN query_nmspc%ROWTYPE;


procedure log_msg( p_module app_log.app_module%type,  p_msg_cd app_log.app_msg_cd%type, p_msg app_log.app_log_msg%type, p_user_id app_log.app_user_id%type ) as
begin

  dbms_output.put_line( to_char( sysdate, 'YYYY-DD-MON HH24:MI:SS') || ' MODULE: ' || p_module || ' CODE: ' || p_msg_cd || ' MSG: ' || p_msg   );
  null;
  --insert into app_log values( app_log_id_seq.nextval, p_module, p_msg_cd, p_msg, sysdate, p_user_id);
end;

procedure get_physical_query( p_query_id query_def.query_id%type ) as
begin
  null;
end;

procedure build_uuedw_query( p_query_id number ) as
begin
  null;
end;

function get_translated_values( p_src_nmspc_id number, p_src_prop_nm varchar2, p_src_prop_val varchar2, p_trgt_nmspc_id number, p_trgt_prop_nm varchar2 ) return varchar2 as 
begin
  null;
end;

function get_translated_concept_value( p_src_nmspc_id number, p_src_prop_nm varchar2, p_src_prop_val varchar2, p_trgt_nmspc_id number, p_trgt_prop_nm varchar2 ) return varchar2 as 
begin
  return  dts.GET_TRANSLATED_CONCEPT_VALUE(  p_src_nmspc_id, p_src_prop_nm, p_src_prop_val, p_trgt_nmspc_id, p_trgt_prop_nm );
end;



END FURTHER_PKG;

/