--------------------------------------------------------
--  File created - Friday-February-15-2013   
--------------------------------------------------------
--------------------------------------------------------
--  Ref Constraints for Table QUERY_CONTEXT
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."QUERY_CONTEXT" ADD CONSTRAINT "FK2C94AD3857702D39" FOREIGN KEY ("CURRENTSTATUS")
	  REFERENCES "FRTHR_FQE"."STATUS_META_DATA" ("ID") ENABLE;
 
  ALTER TABLE "FRTHR_FQE"."QUERY_CONTEXT" ADD CONSTRAINT "FK2C94AD38647CD91D" FOREIGN KEY ("RESULTCONTEXT")
	  REFERENCES "FRTHR_FQE"."RESULT_CONTEXT" ("ID") ON DELETE CASCADE ENABLE;
 
  ALTER TABLE "FRTHR_FQE"."QUERY_CONTEXT" ADD CONSTRAINT "FK2C94AD387724A79E" FOREIGN KEY ("PARENT")
	  REFERENCES "FRTHR_FQE"."QUERY_CONTEXT" ("QUERY_ID") ON DELETE CASCADE ENABLE;
 
  ALTER TABLE "FRTHR_FQE"."QUERY_CONTEXT" ADD CONSTRAINT "FK2C94AD38A22ADF97" FOREIGN KEY ("ASSOCIATEDRESULT")
	  REFERENCES "FRTHR_FQE"."QUERY_CONTEXT" ("QUERY_ID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table RESULT_VIEWS
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."RESULT_VIEWS" ADD CONSTRAINT "FK1FB8FBCC9C24B876" FOREIGN KEY ("QUERY_CONTEXT_ID")
	  REFERENCES "FRTHR_FQE"."QUERY_CONTEXT" ("QUERY_ID") ENABLE;
 
  ALTER TABLE "FRTHR_FQE"."RESULT_VIEWS" ADD CONSTRAINT "FK1FB8FBCCCBCEE79C" FOREIGN KEY ("VALUE")
	  REFERENCES "FRTHR_FQE"."RESULT_CONTEXT" ("ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table SEARCH_QUERY
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."SEARCH_QUERY" ADD CONSTRAINT "FK1B7D0371DE01CADB" FOREIGN KEY ("QUERYCONTEXT")
	  REFERENCES "FRTHR_FQE"."QUERY_CONTEXT" ("QUERY_ID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table STATUS_META_DATA
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."STATUS_META_DATA" ADD CONSTRAINT "FK82C59197DE01CADB" FOREIGN KEY ("QUERYCONTEXT")
	  REFERENCES "FRTHR_FQE"."QUERY_CONTEXT" ("QUERY_ID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  DDL for Package CONST
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "FRTHR_FQE"."CONST" AS 

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
