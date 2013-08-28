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
--  DDL for Package FURTHER_PKG
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "FRTHR_FQE"."FURTHER_PKG" AS

  TYPE query_nmspc_ref_cursor IS REF CURSOR RETURN query_nmspc%ROWTYPE;
  
  procedure log_msg( p_module app_log.app_module%type,  p_msg_cd app_log.app_msg_cd%type, p_msg app_log.app_log_msg%type, p_user_id app_log.app_user_id%type );

  procedure get_physical_query( p_query_id query_def.query_id%type );

  procedure build_uuedw_query( p_query_id number );
  
  

END FURTHER_PKG;
 
 

/
