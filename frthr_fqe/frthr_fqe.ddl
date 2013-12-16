--------------------------------------------------------
--  File created - Friday-December-13-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence APP_LOG_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "FRTHR_FQE"."APP_LOG_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1345587 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence CAS_LOG_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "FRTHR_FQE"."CAS_LOG_ID_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 14826 CACHE 100 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence HIBERNATE_SEQUENCE
--------------------------------------------------------

   CREATE SEQUENCE  "FRTHR_FQE"."HIBERNATE_SEQUENCE"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1495337 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence OBJ_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "FRTHR_FQE"."OBJ_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 27686618 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence QUERY_CRITERIA_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "FRTHR_FQE"."QUERY_CRITERIA_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 3 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence QUERY_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "FRTHR_FQE"."QUERY_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 259370 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SUBQUERY_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "FRTHR_FQE"."SUBQUERY_ID_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table APP_LOG
--------------------------------------------------------

  CREATE TABLE "FRTHR_FQE"."APP_LOG" 
   (	"APP_LOG_ID" NUMBER, 
	"APP_MODULE" VARCHAR2(255), 
	"APP_MSG_CD" VARCHAR2(255), 
	"APP_LOG_MSG" CLOB, 
	"APP_LOG_DTS" DATE, 
	"APP_USER_ID" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Table AUDIT_LOG
--------------------------------------------------------

  CREATE TABLE "FRTHR_FQE"."AUDIT_LOG" 
   (	"AUDIT_LOG_ID" NUMBER(19,0), 
	"AUTHORIZATION_BODY" VARCHAR2(255 CHAR), 
	"AUTHORIZATION_DETAIL" VARCHAR2(255 CHAR), 
	"EVENT_DTS" TIMESTAMP (6), 
	"EVENT_DSC" CLOB, 
	"EVENT_SOURCE" VARCHAR2(255 CHAR), 
	"EVENT_STATUS_CD" VARCHAR2(255 CHAR), 
	"EVENT_TYPE_CD" VARCHAR2(255 CHAR), 
	"USER_ID" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table COM_AUDIT_TRAIL
--------------------------------------------------------

  CREATE TABLE "FRTHR_FQE"."COM_AUDIT_TRAIL" 
   (	"ID" NUMBER(*,0), 
	"AUD_USER" VARCHAR2(100), 
	"AUD_CLIENT_IP" VARCHAR2(50), 
	"AUD_SERVER_IP" VARCHAR2(50), 
	"AUD_RESOURCE" VARCHAR2(100), 
	"AUD_ACTION" VARCHAR2(100), 
	"APPLIC_CD" VARCHAR2(5), 
	"AUD_DATE" TIMESTAMP (6)
   ) ;
--------------------------------------------------------
--  DDL for Table QUERY_ATTR
--------------------------------------------------------

  CREATE TABLE "FRTHR_FQE"."QUERY_ATTR" 
   (	"QUERY_ATTR_ID" NUMBER, 
	"QUERY_ID" NUMBER, 
	"QUERY_ATTR" VARCHAR2(100), 
	"QUERY_ATTR_VALUE" VARCHAR2(100)
   ) ;
--------------------------------------------------------
--  DDL for Table QUERY_CONTEXT
--------------------------------------------------------

  CREATE TABLE "FRTHR_FQE"."QUERY_CONTEXT" 
   (	"QUERY_ID" NUMBER(19,0), 
	"DATASOURCEID" VARCHAR2(255 CHAR), 
	"EXECUTION_ID" VARCHAR2(255 CHAR), 
	"IS_STALE" NUMBER(1,0), 
	"MAXRESPONDINGDATASOURCES" NUMBER(10,0), 
	"MINRESPONDINGDATASOURCES" NUMBER(10,0), 
	"ORIGIN_ID" NUMBER(19,0), 
	"QUEUE_DATE" TIMESTAMP (6), 
	"STALE_DATE" TIMESTAMP (6), 
	"STATE" VARCHAR2(255 CHAR), 
	"TARGETNAMESPACE" NUMBER(19,0), 
	"END_DATE" TIMESTAMP (6), 
	"START_DATE" TIMESTAMP (6), 
	"USER_ID" VARCHAR2(255 CHAR), 
	"ASSOCIATEDRESULT" NUMBER(19,0), 
	"CURRENTSTATUS" NUMBER(19,0), 
	"PARENT" NUMBER(19,0), 
	"RESULTCONTEXT" NUMBER(19,0), 
	"QUERY_TYPE" VARCHAR2(50)
   ) ;
--------------------------------------------------------
--  DDL for Table QUERY_DEF
--------------------------------------------------------

  CREATE TABLE "FRTHR_FQE"."QUERY_DEF" 
   (	"QUERY_ID" VARCHAR2(100), 
	"QUERY_NM" VARCHAR2(200), 
	"QUERY_XML" "SYS"."XMLTYPE" , 
	"CREATE_DTS" DATE, 
	"CREATED_BY_USER_ID" VARCHAR2(100), 
	"QUERY_CONTEXT_ID" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Table QUERY_NMSPC
--------------------------------------------------------

  CREATE TABLE "FRTHR_FQE"."QUERY_NMSPC" 
   (	"QUERY_ID" VARCHAR2(100), 
	"NAMESPACE_ID" NUMBER, 
	"QUERY_XML" "SYS"."XMLTYPE" 
   ) ;
--------------------------------------------------------
--  DDL for Table QUERY_TEMP
--------------------------------------------------------

  CREATE TABLE "FRTHR_FQE"."QUERY_TEMP" 
   (	"QUERY_ID" VARCHAR2(100), 
	"NAMESPACE_ID" NUMBER, 
	"QUERY_XML" "SYS"."XMLTYPE" 
   ) ;
--------------------------------------------------------
--  DDL for Table QUERY_TEMP_ATTR
--------------------------------------------------------

  CREATE TABLE "FRTHR_FQE"."QUERY_TEMP_ATTR" 
   (	"NAMESPACE_ID" NUMBER, 
	"QUERY_ID" NUMBER, 
	"ATTR_NAME" VARCHAR2(1000)
   ) ;
--------------------------------------------------------
--  DDL for Table QUERY_TEST_ASSERTION
--------------------------------------------------------

  CREATE TABLE "FRTHR_FQE"."QUERY_TEST_ASSERTION" 
   (	"QUERY_ID" NUMBER, 
	"NAMESPACE_ID" NUMBER, 
	"EXPECTED_RESULT_CD" VARCHAR2(20), 
	"TEST_MSG" VARCHAR2(1000)
   ) ;
--------------------------------------------------------
--  DDL for Table QUERY_TEST_RESULT
--------------------------------------------------------

  CREATE TABLE "FRTHR_FQE"."QUERY_TEST_RESULT" 
   (	"QUERY_ID" NUMBER, 
	"NAMESPACE_ID" NUMBER, 
	"TEST_CD" VARCHAR2(20), 
	"ERROR_MSG" VARCHAR2(1000), 
	"TEST_DTS" DATE
   ) ;
--------------------------------------------------------
--  DDL for Table QUERY_TEST_SET
--------------------------------------------------------

  CREATE TABLE "FRTHR_FQE"."QUERY_TEST_SET" 
   (	"QUERY_ID" NUMBER, 
	"QUERY_XML" "SYS"."XMLTYPE" , 
	"COMMENTS" VARCHAR2(1000)
   ) ;
--------------------------------------------------------
--  DDL for Table RESULT_CONTEXT
--------------------------------------------------------

  CREATE TABLE "FRTHR_FQE"."RESULT_CONTEXT" 
   (	"ID" NUMBER(19,0), 
	"NUMRECORDS" NUMBER(19,0), 
	"ROOT_ENTITY_CLASS" VARCHAR2(255 CHAR), 
	"TRANSFER_OBJ_CLASS" VARCHAR2(255 CHAR)
   ) ;
--------------------------------------------------------
--  DDL for Table RESULT_VIEWS
--------------------------------------------------------

  CREATE TABLE "FRTHR_FQE"."RESULT_VIEWS" 
   (	"VIEW_ID" NUMBER(19,0), 
	"INTERSECTIONINDEX" NUMBER(10,0), 
	"TYPE" VARCHAR2(20 CHAR), 
	"VALUE" NUMBER(19,0), 
	"QUERY_CONTEXT_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table SEARCH_QUERY
--------------------------------------------------------

  CREATE TABLE "FRTHR_FQE"."SEARCH_QUERY" 
   (	"SEARCH_QUERY_ID" NUMBER(19,0), 
	"QID" NUMBER(19,0), 
	"QUERYXML" CLOB, 
	"QUERYCONTEXT" NUMBER(19,0), 
	"ROOT_OBJECT" VARCHAR2(255)
   ) ;
--------------------------------------------------------
--  DDL for Table STATUS_META_DATA
--------------------------------------------------------

  CREATE TABLE "FRTHR_FQE"."STATUS_META_DATA" 
   (	"ID" NUMBER(19,0), 
	"DATASOURCEID" VARCHAR2(255 CHAR), 
	"DURATION" NUMBER(19,0), 
	"STATUS" VARCHAR2(255 CHAR), 
	"STATUS_DATE" TIMESTAMP (6), 
	"QUERYCONTEXT" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for Table VIRTUAL_OBJ_ID_MAP
--------------------------------------------------------

  CREATE TABLE "FRTHR_FQE"."VIRTUAL_OBJ_ID_MAP" 
   (	"VIRTUAL_OBJ_ID_MAP_ID" NUMBER(19,0), 
	"VIRTUAL_OBJ_ATTR" VARCHAR2(255 CHAR), 
	"FED_OBJ_ID" NUMBER(19,0), 
	"CREATE_DTS" TIMESTAMP (6), 
	"CREATED_BY_CD" VARCHAR2(255 CHAR), 
	"DEACTIVATE_DTS" TIMESTAMP (6), 
	"VIRTUAL_OBJ_NAME" VARCHAR2(255 CHAR), 
	"SRC_OBJ_ATTR" VARCHAR2(255 CHAR), 
	"SRC_OBJ_ID" VARCHAR2(255 CHAR), 
	"SRC_OBJ_NAME" VARCHAR2(255 CHAR), 
	"SRC_OBJ_NMSPC_ID" NUMBER(19,0), 
	"VIRTUAL_OBJ_ID" NUMBER(19,0)
   ) ;
--------------------------------------------------------
--  DDL for View QUERY_V
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "FRTHR_FQE"."QUERY_V" ("QUERY_ID", "QUERY_NM", "NAMESPACE_ID", "ANALYTICAL_QUERY", "PHYSICAL_QUERY", "EXEC_DTS", "USER_ID") AS 
  select q.query_id, q.query_nm, qn.namespace_id, q.query_xml analytical_query, qn.query_xml physical_query, q.create_dts exec_dts, q.created_by_user_id user_id
from query_def q, query_nmspc qn
where q.query_id = qn.query_id
 
 ;
--------------------------------------------------------
--  DDL for Index CAS_AUDIT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_FQE"."CAS_AUDIT_PK" ON "FRTHR_FQE"."COM_AUDIT_TRAIL" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index QUERY_DEF_INDEX1
--------------------------------------------------------

  CREATE INDEX "FRTHR_FQE"."QUERY_DEF_INDEX1" ON "FRTHR_FQE"."QUERY_DEF" ("QUERY_NM") 
  ;
--------------------------------------------------------
--  DDL for Index QUERY_DEF_UK1
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_FQE"."QUERY_DEF_UK1" ON "FRTHR_FQE"."QUERY_DEF" ("QUERY_CONTEXT_ID") 
  ;
--------------------------------------------------------
--  DDL for Index QUERY_TEMP_ATTR_INDEX1
--------------------------------------------------------

  CREATE INDEX "FRTHR_FQE"."QUERY_TEMP_ATTR_INDEX1" ON "FRTHR_FQE"."QUERY_TEMP_ATTR" ("NAMESPACE_ID") 
  ;
--------------------------------------------------------
--  DDL for Index QUERY_TEMP_ATTR_INDEX2
--------------------------------------------------------

  CREATE INDEX "FRTHR_FQE"."QUERY_TEMP_ATTR_INDEX2" ON "FRTHR_FQE"."QUERY_TEMP_ATTR" ("QUERY_ID") 
  ;
--------------------------------------------------------
--  DDL for Index QUERY_TEMP_ATTR_INDEX3
--------------------------------------------------------

  CREATE INDEX "FRTHR_FQE"."QUERY_TEMP_ATTR_INDEX3" ON "FRTHR_FQE"."QUERY_TEMP_ATTR" ("ATTR_NAME") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0023769
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_FQE"."SYS_C0023769" ON "FRTHR_FQE"."APP_LOG" ("APP_LOG_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0023771
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_FQE"."SYS_C0023771" ON "FRTHR_FQE"."AUDIT_LOG" ("AUDIT_LOG_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0023777
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_FQE"."SYS_C0023777" ON "FRTHR_FQE"."QUERY_ATTR" ("QUERY_ATTR_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0023785
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_FQE"."SYS_C0023785" ON "FRTHR_FQE"."QUERY_CONTEXT" ("QUERY_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0023786
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_FQE"."SYS_C0023786" ON "FRTHR_FQE"."QUERY_DEF" ("QUERY_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0023788
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_FQE"."SYS_C0023788" ON "FRTHR_FQE"."QUERY_NMSPC" ("QUERY_ID", "NAMESPACE_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0023789
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_FQE"."SYS_C0023789" ON "FRTHR_FQE"."QUERY_TEST_ASSERTION" ("QUERY_ID", "NAMESPACE_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0023790
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_FQE"."SYS_C0023790" ON "FRTHR_FQE"."QUERY_TEST_SET" ("QUERY_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0023792
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_FQE"."SYS_C0023792" ON "FRTHR_FQE"."RESULT_CONTEXT" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0023794
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_FQE"."SYS_C0023794" ON "FRTHR_FQE"."RESULT_VIEWS" ("VIEW_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0023796
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_FQE"."SYS_C0023796" ON "FRTHR_FQE"."SEARCH_QUERY" ("SEARCH_QUERY_ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0023798
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_FQE"."SYS_C0023798" ON "FRTHR_FQE"."STATUS_META_DATA" ("ID") 
  ;
--------------------------------------------------------
--  DDL for Index SYS_C0023800
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_FQE"."SYS_C0023800" ON "FRTHR_FQE"."VIRTUAL_OBJ_ID_MAP" ("VIRTUAL_OBJ_ID_MAP_ID") 
  ;
--------------------------------------------------------
--  Constraints for Table APP_LOG
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."APP_LOG" ADD PRIMARY KEY ("APP_LOG_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table AUDIT_LOG
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."AUDIT_LOG" MODIFY ("AUDIT_LOG_ID" NOT NULL ENABLE);
 
  ALTER TABLE "FRTHR_FQE"."AUDIT_LOG" ADD PRIMARY KEY ("AUDIT_LOG_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table COM_AUDIT_TRAIL
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."COM_AUDIT_TRAIL" ADD CONSTRAINT "CAS_AUDIT_PK" PRIMARY KEY ("ID") ENABLE;
 
  ALTER TABLE "FRTHR_FQE"."COM_AUDIT_TRAIL" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "FRTHR_FQE"."COM_AUDIT_TRAIL" MODIFY ("AUD_USER" NOT NULL ENABLE);
 
  ALTER TABLE "FRTHR_FQE"."COM_AUDIT_TRAIL" MODIFY ("AUD_ACTION" NOT NULL ENABLE);
 
  ALTER TABLE "FRTHR_FQE"."COM_AUDIT_TRAIL" MODIFY ("AUD_DATE" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table QUERY_ATTR
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."QUERY_ATTR" ADD PRIMARY KEY ("QUERY_ATTR_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table QUERY_CONTEXT
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."QUERY_CONTEXT" MODIFY ("QUERY_ID" NOT NULL ENABLE);
 
  ALTER TABLE "FRTHR_FQE"."QUERY_CONTEXT" MODIFY ("EXECUTION_ID" NOT NULL ENABLE);
 
  ALTER TABLE "FRTHR_FQE"."QUERY_CONTEXT" MODIFY ("IS_STALE" NOT NULL ENABLE);
 
  ALTER TABLE "FRTHR_FQE"."QUERY_CONTEXT" MODIFY ("MAXRESPONDINGDATASOURCES" NOT NULL ENABLE);
 
  ALTER TABLE "FRTHR_FQE"."QUERY_CONTEXT" MODIFY ("MINRESPONDINGDATASOURCES" NOT NULL ENABLE);
 
  ALTER TABLE "FRTHR_FQE"."QUERY_CONTEXT" MODIFY ("STALE_DATE" NOT NULL ENABLE);
 
  ALTER TABLE "FRTHR_FQE"."QUERY_CONTEXT" MODIFY ("STATE" NOT NULL ENABLE);
 
  ALTER TABLE "FRTHR_FQE"."QUERY_CONTEXT" ADD PRIMARY KEY ("QUERY_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table QUERY_DEF
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."QUERY_DEF" ADD CONSTRAINT "QUERY_DEF_UK1" UNIQUE ("QUERY_CONTEXT_ID") ENABLE;
 
  ALTER TABLE "FRTHR_FQE"."QUERY_DEF" ADD PRIMARY KEY ("QUERY_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table QUERY_NMSPC
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."QUERY_NMSPC" ADD PRIMARY KEY ("QUERY_ID", "NAMESPACE_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table QUERY_TEST_ASSERTION
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."QUERY_TEST_ASSERTION" ADD PRIMARY KEY ("QUERY_ID", "NAMESPACE_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table QUERY_TEST_SET
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."QUERY_TEST_SET" ADD PRIMARY KEY ("QUERY_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table RESULT_CONTEXT
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."RESULT_CONTEXT" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "FRTHR_FQE"."RESULT_CONTEXT" ADD PRIMARY KEY ("ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table RESULT_VIEWS
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."RESULT_VIEWS" MODIFY ("VIEW_ID" NOT NULL ENABLE);
 
  ALTER TABLE "FRTHR_FQE"."RESULT_VIEWS" ADD PRIMARY KEY ("VIEW_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table SEARCH_QUERY
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."SEARCH_QUERY" MODIFY ("SEARCH_QUERY_ID" NOT NULL ENABLE);
 
  ALTER TABLE "FRTHR_FQE"."SEARCH_QUERY" ADD PRIMARY KEY ("SEARCH_QUERY_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table STATUS_META_DATA
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."STATUS_META_DATA" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "FRTHR_FQE"."STATUS_META_DATA" ADD PRIMARY KEY ("ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table VIRTUAL_OBJ_ID_MAP
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."VIRTUAL_OBJ_ID_MAP" MODIFY ("VIRTUAL_OBJ_ID_MAP_ID" NOT NULL ENABLE);
 
  ALTER TABLE "FRTHR_FQE"."VIRTUAL_OBJ_ID_MAP" ADD PRIMARY KEY ("VIRTUAL_OBJ_ID_MAP_ID") ENABLE;
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
--  DDL for Trigger GET_CAS_LOG_ID
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "FRTHR_FQE"."GET_CAS_LOG_ID" 
  BEFORE INSERT ON COM_AUDIT_TRAIL
  FOR EACH ROW
BEGIN
  SELECT CAS_LOG_ID_SEQ.nextval
    INTO :new.id
    FROM dual;
END;


/
ALTER TRIGGER "FRTHR_FQE"."GET_CAS_LOG_ID" ENABLE;
--------------------------------------------------------
--  DDL for Function CAN_QUERY
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."CAN_QUERY" ( p_namespace_str varchar2, p_query_context_id number ) RETURN number AS 

  v_query_id number;
  v_namespace_id number;
  v_error_msg varchar2(4000);

BEGIN

  v_namespace_id := to_number( p_namespace_str );
  v_query_id := prepare_analytical_query( v_namespace_id, p_query_context_id );

  if ( v_namespace_id = const.get_uuedw_namespace_id and can_query_uuedw( v_query_id ) = 1 ) then
  
    return 1;
    
  elsif ( v_namespace_id = const.get_uuedw_apo_namespace_id  and can_query_uuedw_apo( v_query_id ) = 1 ) then
  
    return 1;
    
  elsif ( v_namespace_id = const.get_ih_apo_namespace_id  and can_query_ih_apo( v_query_id ) = 1) then
  
    return 1;
    
  elsif ( v_namespace_id = const.get_updbl_namespace_id  and can_query_updbl( v_query_id ) = 1) then
  
    return 1;
    
  else
  
    return 0;
  
  end if;

  RETURN 0;
  
END CAN_QUERY;

/
--------------------------------------------------------
--  DDL for Function CAN_QUERY_IH_APO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."CAN_QUERY_IH_APO" ( p_query_id number ) return number AS

  v_intro_msg varchar2(50);
  
BEGIN

  v_intro_msg := 'QUERY( UPDBL:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  prepare_new_query( const.get_ih_apo_namespace_id, p_query_id );
  
  /* --------------------------------------------- */
  /* Translate person - root attributes (no alias) */
  /* --------------------------------------------- */
  
  TRANS_QUERY_DEMOG_IH_APO( p_query_id );
  
  /* ----------------------- */
  /* Translate observations  */
  /* ----------------------- */
  
  TRANS_QUERY_OBS_IH_APO( p_query_id );
  
  /* ------------------------------ */
  /* Remove namespace attr criteria */
  /* ------------------------------ */
        
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'DELETE *NamespaceId',1);

  update query_temp q
  set q.query_xml = deleteXML( q.query_xml, '//criteria[parameters/parameter[ora:contains(text(),"%NamespaceId")>0]]', const.get_query_xml_namespace )
  where query_id = p_query_id
    and namespace_id = const.get_ih_apo_namespace_id;
    
  TRANS_QUERY_SUBQ( const.get_ih_apo_namespace_id, p_query_id );

  check_translated_query( const.get_ih_apo_namespace_id, p_query_id );
  
  delete query_temp where query_id = p_query_id and namespace_id = const.get_ih_apo_namespace_id;
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END',1);
  
  return 1;
  
END CAN_QUERY_IH_APO;

/
--------------------------------------------------------
--  DDL for Function CAN_QUERY_UPDBL
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."CAN_QUERY_UPDBL" ( p_query_id number ) return number AS

  v_intro_msg varchar2(50);
  
BEGIN

  v_intro_msg := 'QUERY( UPDBL:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  prepare_new_query( const.get_updbl_namespace_id, p_query_id );
  
  /* --------------------------------------------- */
  /* Translate person - root attributes (no alias) */
  /* --------------------------------------------- */
  
  TRANS_QUERY_DEMOG_UPDBL( p_query_id );
  
  /* ----------------------- */
  /* Translate locations     */
  /* ----------------------- */
  
  TRANS_QUERY_LCTN_UPDBL( p_query_id );
  
  /* ----------------------- */
  /* Translate observations  */
  /* ----------------------- */
  
  TRANS_QUERY_OBS_UPDBL( p_query_id );
  
  /* ------------------------------ */
  /* Remove namespace attr criteria */
  /* ------------------------------ */
        
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'DELETE *NamespaceId',1);

  update query_temp q
  set q.query_xml = deleteXML( q.query_xml, '//criteria[parameters/parameter[ora:contains(text(),"%NamespaceId")>0]]', const.get_query_xml_namespace )
  where query_id = p_query_id
    and namespace_id = const.get_updbl_namespace_id;
    
  TRANS_QUERY_SUBQ( const.get_updbl_namespace_id, p_query_id );

  check_translated_query( const.get_updbl_namespace_id, p_query_id );
  
  delete query_temp where query_id = p_query_id and namespace_id = const.get_updbl_namespace_id;
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END',1);
  
  return 1;
  
END CAN_QUERY_UPDBL;

/
--------------------------------------------------------
--  DDL for Function CAN_QUERY_UUEDW
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."CAN_QUERY_UUEDW" ( p_query_id number ) RETURN number AS

  v_intro_msg varchar2(50);
  
BEGIN

  v_intro_msg := 'QUERY( UUEDW:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  
  prepare_new_query( const.get_uuedw_namespace_id, p_query_id );

  /* ------------------------------------ */
  /* Translate all the observations first */
  /* ------------------------------------ */
  trans_query_obs_uuedw( p_query_id );      
      
  /* ------------------------ */
  /* Translate all the orders */
  /* ------------------------ */
  trans_query_order_uuedw( p_query_id );      
      
  /* ------------------------ */
  /* Translate locations */
  /* ------------------------ */
  trans_query_lctn_uuedw( p_query_id );      
      
  /* ------------------------ */
  /* Translate encounters */
  /* ------------------------ */
  trans_query_encntr_uuedw( p_query_id );      
      
  /* --------------------------------------------- */
  /* Translate person - root attributes (no alias) */
  /* --------------------------------------------- */
  trans_query_demog_uuedw( p_query_id );      
  
  /* ---------------------- */
  /* Remove namespace attrs */
  /* ---------------------- */
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'DELETE *Namespace',1);

  update query_temp q
  set q.query_xml = deleteXML( q.query_xml, '//criteria[parameters/parameter[ora:contains(text(),"%NamespaceId")>0]]', const.get_query_xml_namespace )
  where query_id = p_query_id
    and namespace_id = const.get_uuedw_namespace_id;
  
  check_translated_query( const.get_uuedw_namespace_id, p_query_id );
  
  delete query_temp where query_id = p_query_id and namespace_id = const.get_uuedw_namespace_id;
  
  return 1;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END',1);
    
END CAN_QUERY_UUEDW;

/
--------------------------------------------------------
--  DDL for Function CAN_QUERY_UUEDW_APO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."CAN_QUERY_UUEDW_APO" ( p_query_id number ) RETURN number AS

  v_intro_msg varchar2(50);
  
BEGIN

  v_intro_msg := 'QUERY( UUEDW_APO:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
    
  return 1;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END',1);
    
END CAN_QUERY_UUEDW_APO;

/
--------------------------------------------------------
--  DDL for Function GET_ALIAS_FROM_ATTRIBUTE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."GET_ALIAS_FROM_ATTRIBUTE" ( p_attr_name varchar2) RETURN VARCHAR2 AS 
  v_alias varchar2(100);
BEGIN

  v_alias := substr(p_attr_name, 1, instr(p_attr_name, '.')-1);
  
  if const.get_debug = 1 then dbms_output.put_line( 'GET_ALIAS_FROM_ATTRIBUTE: attribute=' || p_attr_name || ' alias=' || v_alias ); end if;
  
  RETURN v_alias;
  
END GET_ALIAS_FROM_ATTRIBUTE;

/
--------------------------------------------------------
--  DDL for Function GET_ALIAS_LCTN_TYPE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."GET_ALIAS_LCTN_TYPE" ( p_query_id query_def.query_id%type, p_alias varchar2 ) RETURN VARCHAR2 AS 

  v_type_str varchar2(100);
  v_alias varchar2(100);
  v_type varchar2(100);
  
BEGIN

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG','query_id=' || p_query_id || ', alias=' || p_alias || '',1);

  select plctn_type_str, plctn_alias, plctn_type into v_type_str, v_alias, v_type from (
      select distinct
             extract(column_value, '//parameter[ora:contains(text(),"personLocationType")>0]/text()', const.get_query_xml_namespace).getstringval() plctn_type_str,
             substr( extract(column_value, '//parameter[ora:contains(text(),"personLocationType")>0]/text()', const.get_query_xml_namespace).getstringval()
                    ,1
                    ,instr( extract(column_value, '//parameter[ora:contains(text(),"personLocationType")>0]/text()', const.get_query_xml_namespace).getstringval(),'.')-1 ) plctn_alias,
             extract(column_value, '//parameter[3]/text()', const.get_query_xml_namespace).getstringval() plctn_type
      from query_def q
          ,table(xmlsequence( q.query_xml.extract('//criteria[parameters/parameter[ora:contains(text(),"personLocationType")>0]]', const.get_query_xml_namespace) ) )
      where query_id = p_query_id
  )
  where plctn_alias = p_alias;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG','RESULT Type=' || v_type_str || ', alias=' || v_alias || ', Type Value=' || v_type || ')',1);
  
  RETURN v_type;
  
END GET_ALIAS_LCTN_TYPE;

/
--------------------------------------------------------
--  DDL for Function GET_ATTR_ASSOC_PROP
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."GET_ATTR_ASSOC_PROP" ( p_obj_asset_id number, p_attr_asset_label varchar2, p_prop_name varchar2 ) RETURN VARCHAR2 AS 

  v_prop_val fmdr.asset_assoc_prop.prop_val%type;

BEGIN

  select prop_val into v_prop_val
  from fmdr.asset_assoc_prop ap
  where ap.asset_assoc_id in
  (
    select asset_assoc_id
    from fmdr.asset_assoc_v
    where ls_asset_id = p_obj_asset_id
      and assoc_asset_id = 227
      and rs_asset_label = p_attr_asset_label
  )
  and prop_name = p_prop_name;

  return v_prop_val;

  exception when no_data_found then return null;

END GET_ATTR_ASSOC_PROP;

/
--------------------------------------------------------
--  DDL for Function GET_ATTR_NAME_FROM_OBJ_ATTR
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."GET_ATTR_NAME_FROM_OBJ_ATTR" ( p_obj_attr varchar2) RETURN VARCHAR2 AS 
  v_attr varchar2(100);
BEGIN

  v_attr := substr(p_obj_attr, instr(p_obj_attr, '.')+1, length(p_obj_attr));

  RETURN v_attr;
  
END GET_ATTR_NAME_FROM_OBJ_ATTR;

/
--------------------------------------------------------
--  DDL for Function GET_ATTR_SEARCH_TYPE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."GET_ATTR_SEARCH_TYPE" ( p_query_id number, p_attr varchar2, p_attr_index number ) RETURN VARCHAR2 AS 

  v_search_type varchar2(50);
  
BEGIN

  select extract( q.query_xml,'(//*[parameters/parameter[text()="' || p_attr || '"]])[' || p_attr_index || ']' || '/searchType/text()', const.get_query_xml_namespace).getstringval()
  into v_search_type
  from query_def q
  where query_id = p_query_id;

  return v_search_type;

END GET_ATTR_SEARCH_TYPE;

/
--------------------------------------------------------
--  DDL for Function GET_ATTR_SIMPLE_OPERATOR
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."GET_ATTR_SIMPLE_OPERATOR" ( p_query_id number, p_attr varchar2, p_attr_index number ) RETURN VARCHAR2 AS 

  v_search_type varchar2(50);
  
BEGIN

  select extract( q.query_xml,'(//*[parameters/parameter[text()="' || p_attr || '"]])[' || p_attr_index || ']' ||
                              '/searchType[text()="SIMPLE"]/../parameters/parameter[1]/text()'
                              , const.get_query_xml_namespace).getstringval() oper
  into v_search_type
  from query_def q
  where query_id = p_query_id;

  return v_search_type;

END GET_ATTR_SIMPLE_OPERATOR;

/
--------------------------------------------------------
--  DDL for Function GET_OBJECT_BY_ALIAS
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."GET_OBJECT_BY_ALIAS" ( p_alias varchar2, p_query_id number) RETURN VARCHAR2 AS 
  v_obj_nm varchar2(100);
BEGIN

  select extract( query_xml, '//aliases/alias[key="'|| p_alias || '"]/value/text()', const.get_query_xml_namespace).getstringval()
  into v_obj_nm
  from query_def
  where query_id = p_query_id;

  if const.get_debug = 1 then dbms_output.put_line( 'GET_OBJECT_BY_ALIAS: alias=' || p_alias || '   object=' || v_obj_nm || '   query_id=' || p_query_id ); end if;

  RETURN v_obj_nm;
  
END GET_OBJECT_BY_ALIAS;

/
--------------------------------------------------------
--  DDL for Function GET_QUERY_OBS_PHRASE_NMSPC_ID
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."GET_QUERY_OBS_PHRASE_NMSPC_ID" ( p_query_id query_def.query_id%type, p_nmspc_attr varchar2,  p_attr_name varchar2, p_attr_value varchar2, p_attr_index number) RETURN NUMBER AS

  v_nmspc_id varchar2(100);
  v_intro_msg varchar2(100);
  loop_cnt number;
  v_last_val varchar2(100);
  
BEGIN

  v_intro_msg := 'QUERY( ' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'NMSPC= ' || p_nmspc_attr || ' ATTR= ' || p_attr_name || ' ATTR_VAL=' || p_attr_value, 1);
  
  select q.query_xml.extract('(//criteria[parameters//parameter/text()="' || p_attr_name || '"' ||
                  ' and parameters//parameter/text()="' || p_attr_value || '"])['|| p_attr_index ||']' ||
                  '/../criteria[parameters/parameter/text()="' || p_nmspc_attr || '"]/parameters/parameter[3]/text()'
                  ,const.get_query_xml_namespace).getstringval() into v_nmspc_id
  from query_def q
  where q.query_id = p_query_id;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'ATTR= ' || p_attr_name || ' ATTR_VAL=' || p_attr_value || ' NMPC=' || v_nmspc_id, 1);

  RETURN to_number( v_nmspc_id );

END GET_QUERY_OBS_PHRASE_NMSPC_ID;

/
--------------------------------------------------------
--  DDL for Function GET_SIMPLE_QUERY_ATTR_VALUE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."GET_SIMPLE_QUERY_ATTR_VALUE" ( p_query_id query_def.query_id%type, p_alias varchar2, p_attr_name varchar2 ) RETURN VARCHAR2 AS 

  v_str varchar2(100);
  v_alias varchar2(100);
  v_val varchar2(100);
  
BEGIN

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG','query_id=' || p_query_id || ', ALIAS=' || p_alias || ' ATTR=' || p_attr_name,1);

  select q_str, q_alias, q_val into v_str, v_alias, v_val from (
      select distinct
             extract(column_value, '//parameter[ora:contains(text(),"' || p_attr_name || '")>0]/text()', const.get_query_xml_namespace).getstringval() q_str,
             substr( extract(column_value, '//parameter[ora:contains(text(),"' || p_attr_name || '")>0]/text()', const.get_query_xml_namespace).getstringval()
                    ,1
                    ,instr( extract(column_value, '//parameter[ora:contains(text(),"' || p_attr_name || '")>0]/text()', const.get_query_xml_namespace).getstringval(),'.')-1 ) q_alias,
             extract(column_value, '//parameter[3]/text()', const.get_query_xml_namespace).getstringval() q_val
      from query_def q
          ,table(xmlsequence( q.query_xml.extract('//criteria[parameters/parameter[ora:contains(text(),"' || p_attr_name || '")>0]]', const.get_query_xml_namespace) ) )
      where query_id = p_query_id
  )
  where q_alias = p_alias;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG','RESULT ATTR=' || v_str || ', ALIAS=' || v_alias || ', VALUE=' || v_val ,1);
  
  RETURN v_val;
  
END GET_SIMPLE_QUERY_ATTR_VALUE;

/
--------------------------------------------------------
--  DDL for Function GET_SIMPLE_QUERY_ATTR_VALUE_N
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."GET_SIMPLE_QUERY_ATTR_VALUE_N" ( p_query_id query_def.query_id%type, p_alias varchar2, p_attr_name varchar2, p_attr_index number ) RETURN VARCHAR2 AS 

  v_str varchar2(100);
  v_alias varchar2(100);
  v_val varchar2(100);
  
BEGIN

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG','query_id=' || p_query_id || ', ALIAS=' || p_alias || ' ATTR=' || p_attr_name,1);

  select q.query_xml.extract('(//criteria[searchType/text()="SIMPLE" and parameters/parameter[2]/text()="' || p_alias || '.' || p_attr_name || '"])[' || p_attr_index || ']/parameters/parameter[3]/text()', const.get_query_xml_namespace).getstringval() into v_val
  from query_def q
  where query_id = p_query_id;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG','RESULT ATTR=' || v_str || ', ALIAS=' || v_alias || ', VALUE=' || v_val ,1);
  
  RETURN v_val;
  
END GET_SIMPLE_QUERY_ATTR_VALUE_N;

/
--------------------------------------------------------
--  DDL for Function GET_STRING_VALUE_BY_XPATH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."GET_STRING_VALUE_BY_XPATH" ( p_namespace_id number, p_query_id number, p_xpath varchar2) RETURN VARCHAR2 AS 

  v_text_val varchar2(4000);

BEGIN

  begin
    
    select q.query_xml.extract(p_xpath,const.get_query_xml_namespace).getstringval() into v_text_val 
    from query_temp q
    where q.query_id = p_query_id 
      and q.namespace_id = p_namespace_id;

  end;

  RETURN v_text_val;
END GET_STRING_VALUE_BY_XPATH;

/
--------------------------------------------------------
--  DDL for Function GET_TRANSLATED_ATTRIBUTE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."GET_TRANSLATED_ATTRIBUTE" ( p_from_obj_asset_id number, p_to_obj_asset_id number, p_from_attr_nm varchar2) RETURN VARCHAR2 AS 
  v_attr varchar2(100);
BEGIN

  select a1.rs_asset_label into v_attr
  from fmdr.asset_assoc_v a1
  where a1.assoc_asset_id = 363
    and a1.ls_asset_id in (select a2.rs_asset_id from fmdr.asset_assoc_v a2 where a2.ls_asset_id = p_from_obj_asset_id and a2.assoc_asset_id = 227)
    and a1.rs_asset_id in (select a3.rs_asset_id from fmdr.asset_assoc_v a3 where a3.ls_asset_id = p_to_obj_asset_id and a3.assoc_asset_id = 227)
    and a1.ls_asset_label = p_from_attr_nm;

  RETURN v_attr;
END GET_TRANSLATED_ATTRIBUTE;

/
--------------------------------------------------------
--  DDL for Function GET_TRANS_ASSOC_PROP
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."GET_TRANS_ASSOC_PROP" ( p_from_obj_asset_id number, p_to_obj_asset_id number, p_from_attr_nm varchar2, p_prop_nm varchar2) RETURN VARCHAR2 AS 
  v_prop_val varchar2(100);
BEGIN

  select p.prop_val into v_prop_val
  from fmdr.asset_assoc_prop p
  where p.asset_assoc_id in (
   select a1.asset_assoc_id
    from fmdr.asset_assoc_v a1
    where a1.assoc_asset_id = 363
      and a1.ls_asset_id in (select a2.rs_asset_id from fmdr.asset_assoc_v a2 where a2.ls_asset_id = p_from_obj_asset_id and a2.assoc_asset_id = 227)
      and a1.rs_asset_id in (select a3.rs_asset_id from fmdr.asset_assoc_v a3 where a3.ls_asset_id = p_to_obj_asset_id   and a3.assoc_asset_id = 227)
      and a1.ls_asset_label = p_from_attr_nm
  )
    and p.prop_name = p_prop_nm;

  RETURN v_prop_val;
  
  exception when no_data_found then return null;
  
END GET_TRANS_ASSOC_PROP;

/
--------------------------------------------------------
--  DDL for Function GET_VALUE_BY_XPATH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."GET_VALUE_BY_XPATH" ( p_namespace_id number, p_query_id number, xpath varchar2) RETURN VARCHAR2 AS 
BEGIN






  RETURN NULL;
END GET_VALUE_BY_XPATH;

/
--------------------------------------------------------
--  DDL for Function IS_NUMERIC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."IS_NUMERIC" ( p_string varchar2 ) RETURN number AS

 v_number number;

BEGIN
  v_number := p_string;
  return 1;
  
  exception
    when others then
      return 0;
      
END IS_NUMERIC;

/
--------------------------------------------------------
--  DDL for Function IS_SUBQUERY
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."IS_SUBQUERY" ( p_query_id number, p_attr_name varchar2 ) RETURN number AS 

  v_criteria xmltype;

BEGIN

  select q.query_xml.extract('//criteria[parameters/parameter[text()="' || p_attr_name || '"] ' ||
                             'and query/rootCriterion//parameter[string-length(text())>0]]', const.get_query_xml_namespace) into v_criteria
  from query_def q
  where q.query_id = p_query_id;

  if v_criteria is null then 
    return 0;  
  end if;

  return 1;
  
  exception when no_data_found then return 0;
  
END IS_SUBQUERY;

/
--------------------------------------------------------
--  DDL for Function IS_TRANS_ATTR
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."IS_TRANS_ATTR" ( p_from_obj_asset_id number, p_to_obj_asset_id number, p_from_attr_name varchar2 ) RETURN number AS 

  v_attr_trans_func fmdr.asset_assoc_prop.prop_val%type;

BEGIN

  v_attr_trans_func := get_trans_assoc_prop( p_from_obj_asset_id, p_to_obj_asset_id, p_from_attr_name, const.get_attr_trans_prop_nm );
  
  if ( v_attr_trans_func is null ) then
  
    return -1;
  
  elsif ( v_attr_trans_func = const.get_attr_trans_func ) then
  
    return 1;
    
  end if;

  return 0;
END IS_TRANS_ATTR;

/
--------------------------------------------------------
--  DDL for Function IS_TRANS_ATTR_DATA_TYPE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."IS_TRANS_ATTR_DATA_TYPE" ( p_from_obj_asset_id number, p_to_obj_asset_id number, p_from_attr_name varchar2 ) RETURN number AS 

  v_val fmdr.asset_assoc_prop.prop_val%type;

BEGIN

  v_val := get_trans_assoc_prop( p_from_obj_asset_id, p_to_obj_asset_id, p_from_attr_name, 'ATTR_VALUE_TRANS_TO_DATA_TYPE' );
  
  if ( v_val is not null ) then
  
    return 1;
  
  end if;

  return 0;
END IS_TRANS_ATTR_DATA_TYPE;

/
--------------------------------------------------------
--  DDL for Function IS_TRANS_ATTR_VALUE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."IS_TRANS_ATTR_VALUE" ( p_query_id number, p_from_obj_asset_id number, p_to_obj_asset_id number, p_from_attr_name varchar2 ) RETURN number AS 

  v_attr_trans_func fmdr.asset_assoc_prop.prop_val%type;

BEGIN

  if is_subquery( p_query_id, p_from_attr_name ) = 1 then
    return 0; 
  end if; 

  v_attr_trans_func := get_trans_assoc_prop( p_from_obj_asset_id, p_to_obj_asset_id, p_from_attr_name, const.get_attr_val_trans_prop_nm );
  
  if ( v_attr_trans_func is not null and v_attr_trans_func <> 'noTranslation' ) then 
  
    return 1;
    
  end if;

  return 0;
END IS_TRANS_ATTR_VALUE;

/
--------------------------------------------------------
--  DDL for Function IS_VALID_ATTR
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."IS_VALID_ATTR" ( p_obj_asset_id number, p_attr_name varchar2 ) RETURN number AS 

  v_cnt number;
 
BEGIN

  select count(1) into v_cnt
  from fmdr.asset_assoc_v
  where ls_asset_id = p_obj_asset_id
    and assoc_asset_id = 227
    and rs_asset_label = p_attr_name;
    
  if ( v_cnt = 1 ) then 
  
    return 1;
    
  end if;

  return 0;
END IS_VALID_ATTR;

/
--------------------------------------------------------
--  DDL for Function PREPARE_ANALYTICAL_QUERY
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "FRTHR_FQE"."PREPARE_ANALYTICAL_QUERY" ( p_namespace_id number, p_query_context_id number )  RETURN number AS 

  v_query_count number;
  v_query_id number;
  v_analytical_query_uuid varchar2(255);
  v_query_context_id varchar2(255);
  v_namespace_str varchar2(100);
  v_user_id varchar2(100);
  v_query_xml_clob clob;
  v_query_xml xmltype;
  v_intro_msg varchar2(100);
  
BEGIN

  v_intro_msg := 'QUERY( ' || p_namespace_id || ':' || p_query_context_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);

  -- get the query namespace and parent id that contains analytical query data
  select qc.user_id into v_user_id
  from query_context qc
  where qc.query_id = p_query_context_id;
  --where qc.execution_id = p_query_context_uuid;

  -- get the query
  select sq.queryxml into v_query_xml_clob
  from search_query sq
  where sq.querycontext = p_query_context_id;

  v_query_id := query_id_seq.nextval;
  insert into query_def values( v_query_id, null, xmltype( v_query_xml_clob), sysdate, v_user_id, p_query_context_id );
  commit;
    
  return v_query_id;

  exception 
    when DUP_VAL_ON_INDEX then 
    select query_id into v_query_id
    from query_def qd
    where qd.query_context_id = p_query_context_id;
    
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'END',1);
    
  return v_query_id;

END PREPARE_ANALYTICAL_QUERY;

/
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
--------------------------------------------------------
--  DDL for Package Body CONST
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "FRTHR_FQE"."CONST" AS

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
    return 'xmlns="http://further.utah.edu/core/query" xmlns:ora="http://xmlns.oracle.com/xdb" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xp20="http://www.oracle.com/XSL/Transform/java/oracle.tip.pc.services.functions.Xpath20"';
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

  CREATE OR REPLACE PACKAGE BODY "FRTHR_FQE"."FURTHER_PKG" AS

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
--------------------------------------------------------
--  DDL for Procedure ADD_QUERY_OBJECT_ALIAS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."ADD_QUERY_OBJECT_ALIAS" ( p_namespace_id number, p_query_id number, p_old_alias varchar2, p_new_alias varchar2, p_new_object varchar2) AS 
   v_new_alias_xml varchar2(1000);
   is_existing_alias number;
BEGIN

  select count(1) into is_existing_alias
  from query_temp q
  where q.query_id = p_query_id
    and q.namespace_id = p_namespace_id
    and q.query_xml.existsNode( '//aliases/alias[key="' || p_new_alias || '"]/key/text()', const.get_query_xml_namespace) = 1;
    
  if ( is_existing_alias = 0 ) then -- does not exist, create 
    
     v_new_alias_xml := 
'<alias>
   <key>' || p_new_alias || '</key>
   <value>' || p_new_object || '</value>
</alias>';

     update query_temp q 
     set query_xml = insertChildXML( q.query_xml
                      , '//aliases[alias/key[text()="' || p_old_alias || '"]]'
                      , 'alias', XMLType( v_new_alias_xml )
                      , const.get_query_xml_namespace ) 
     where q.query_id = p_query_id
       and q.namespace_id = p_namespace_id;

  end if;  
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG','UPDATE ALIAS old=' || p_old_alias || ' new alias=' || p_new_alias || ' exisited=' || is_existing_alias,1);
  
END ADD_QUERY_OBJECT_ALIAS;
 

/
--------------------------------------------------------
--  DDL for Procedure CHECK_TRANSLATED_QUERY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."CHECK_TRANSLATED_QUERY" ( p_namespace_id number, p_query_id number ) AS 

  v_error_msg varchar2(4000); 

BEGIN

  v_error_msg := '';

  for crs in (
    select extract(column_value, '/criteria/searchType/text()', const.get_query_xml_namespace).getstringval() exp_type,
           extract(column_value, '/criteria/parameters/parameter[1]/text()', const.get_query_xml_namespace).getstringval() param1,
           extract(column_value, '/criteria/parameters/parameter[2]/text()', const.get_query_xml_namespace).getstringval() param2,
           extract(column_value, '/criteria/parameters/parameter[3]/text()', const.get_query_xml_namespace).getstringval() param3
    from query_temp q
        ,table(xmlsequence( q.query_xml.extract('//criteria[parameters/untouched]', const.get_query_xml_namespace) ) )
    where query_id = p_query_id 
      and namespace_id = p_namespace_id
  ) loop
  
    v_error_msg := v_error_msg || 'CRITERION NOT SUPPORTED BY ' || const.get_namespace_label( p_namespace_id ) || ': searchType=' || crs.exp_type || ' parameter[1]=' || crs.param1 || ' parameter[2]=' || crs.param2 || ' parameter[3]=' || crs.param3 || ' ';
  
  end loop;
  
  for cr in (
    select extract(column_value, '/alias/key/text()', const.get_query_xml_namespace).getstringval() vkey,
           extract(column_value, '/alias/value/text()', const.get_query_xml_namespace).getstringval() vvalue
    from query_temp q
        ,table(xmlsequence( q.query_xml.extract('//alias[./untouchedAlias]', const.get_query_xml_namespace) ) )
    where query_id = p_query_id 
      and namespace_id = p_namespace_id
  ) loop
  
    v_error_msg := v_error_msg || 'ALIAS NOT UTILIZED IN QUERY for alias key=' || cr.vkey || ' value=' || cr.vvalue || ' ';
  
  end loop;

  
  if length(v_error_msg) > 1  then
    
    v_error_msg := 'QUERY ERRORS - ' || v_error_msg;
    further_pkg.log_msg($$PLSQL_UNIT,'ERROR', 'QUERY(' || p_namespace_id || ':' || p_query_id || ') ' || v_error_msg, 1);
    RAISE_APPLICATION_ERROR(-20000, v_error_msg );
  
  end if;


END CHECK_TRANSLATED_QUERY;
 

/
--------------------------------------------------------
--  DDL for Procedure DELETE_QUERY_ELEMENTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."DELETE_QUERY_ELEMENTS" ( p_namespace_id query_temp.namespace_id%type, p_query_id query_temp.query_id%type, p_xpath varchar2 ) AS 

  v_intro_msg varchar2(50);
  
BEGIN

  v_intro_msg := 'QUERY(' || p_namespace_id || ':' || p_query_id || ') ';

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || ' DELETE XPATH=' || p_xpath ,1);

  update query_temp
  set query_xml = deletexml(
     query_xml
    ,p_xpath
    ,const.get_query_xml_namespace
  )
  where query_id = p_query_id
    and namespace_id = p_namespace_id;
      

END DELETE_QUERY_ELEMENTS;
 

/
--------------------------------------------------------
--  DDL for Procedure GET_PHYSICAL_QUERY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."GET_PHYSICAL_QUERY" 
  (
    p_sys_refcur OUT SYS_REFCURSOR,
    p_namespace_str          VARCHAR2,
    p_query_context_id     NUMBER)
AS

  v_query_id number;
  v_namespace_str varchar2(100);
  v_namespace_id number;
  v_error_msg varchar2(4000);

BEGIN

  v_namespace_id := to_number( p_namespace_str );
  v_query_id := prepare_analytical_query( v_namespace_id, p_query_context_id );
  
  IF ( V_namespace_id = const.get_uuedw_namespace_id ) THEN -- UUEDW
    TRANS_QUERY_UUEDW( v_query_id );
  ELSIF ( V_namespace_id = const.get_updbl_namespace_id ) THEN -- UPDB
    TRANS_QUERY_UPDBL( v_query_id );
  ELSIF ( V_namespace_id = const.get_uuedw_apo_namespace_id ) THEN -- UUEDW_APO
    TRANS_QUERY_UUEDW_APO( v_query_id );
  ELSIF ( V_namespace_id = const.get_ih_apo_namespace_id ) THEN -- IH_APO
    TRANS_QUERY_IH_APO( v_query_id );
  ELSE
  
    v_error_msg := 'QUERY CONTEXT_UUID="' || p_query_context_id || '" NAMESPACE="' ||  v_namespace_str || '" not supported';
    further_pkg.log_msg($$PLSQL_UNIT,'ERROR', v_error_msg, 1);
    RAISE_APPLICATION_ERROR(-20000, v_error_msg );
  
  END IF;
  
  OPEN p_sys_refcur FOR SELECT * FROM query_nmspc WHERE query_id = v_query_id AND namespace_id = v_namespace_id;
  
END GET_PHYSICAL_QUERY;

/
--------------------------------------------------------
--  DDL for Procedure PREPARE_NEW_QUERY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."PREPARE_NEW_QUERY" ( p_namespace_id number, p_query_id number)  AS 
BEGIN

  delete query_temp  where query_id = p_query_id and namespace_id = p_namespace_id;
  delete query_temp_attr  where query_id = p_query_id and namespace_id = p_namespace_id;
  delete query_nmspc where query_id = p_query_id and namespace_id = p_namespace_id;

  /* copy query to query_nmspc to prepare for editting, add untouched */ 
  insert into query_temp   
  select q.query_id
       , p_namespace_id
       , insertChildXML( q.query_xml
                      , '//criteria/parameters[parameter[last()]]'
                      , 'untouched', XMLType('<untouched/>')
                      , const.get_query_xml_namespace ) 
  from query_def q
  where q.query_id = p_query_id;
  
  /* touch all the aliases */
  update query_temp q 
  set query_xml = insertChildXML( q.query_xml
                      , '//alias'
                      , 'untouchedAlias', XMLType('<untouchedAlias/>')
                      , const.get_query_xml_namespace ) 
  where q.query_id = p_query_id
    and q.namespace_id = p_namespace_id;

  /* remove the queryId criteria */
  update query_temp q
  set q.query_xml = deleteXML( q.query_xml, '//criteria[parameters/parameter/text()="id.queryId"]'
                                          , const.get_query_xml_namespace )
  where query_id = p_query_id
    and namespace_id = p_namespace_id;

  /* remove the sortCriteria */
  update query_temp q
  set q.query_xml = deleteXML( q.query_xml, '//sortCriteria'
                                          , const.get_query_xml_namespace )
  where query_id = p_query_id
    and namespace_id = p_namespace_id;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', 'QUERY(' || p_namespace_id || ':' || p_query_id || ') TEMP QUERY PREPARED',1);

END PREPARE_NEW_QUERY;

/
--------------------------------------------------------
--  DDL for Procedure RUN_QUERY_TRANS_TEST_SUITE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."RUN_QUERY_TRANS_TEST_SUITE" as
  v_can_query_uuedw number;
  v_can_query_updbl number;
  v_error_msg varchar2(1000);
  v_error_out varchar2(1000);
  v_test_cd varchar2(20);
  v_test_function varchar2(100);
  v_failures number;

begin

  -- prepare query tables for testing
  -- 1. Remove test queries
  delete query_def where query_id in ( select tst.query_id from query_test_set tst );
  delete query_temp where query_id in ( select tst.query_id from query_test_set tst );
  delete query_nmspc where query_id in ( select tst.query_id from query_test_set tst );
  delete query_temp_attr where query_id in ( select tst.query_id from query_test_set tst );
  delete query_test_result;
  
  -- 2. Re-insert test queries
  insert into query_def (query_id, query_xml, create_dts, created_by_user_id) 
    select query_id, query_xml, sysdate, 'TEST_PROCEDURE' from query_test_set;
  
  commit;

  for c in (
    select q.query_id, q.namespace_id, q.expected_result_cd
    from query_test_assertion q -- where q.query_id in (-679944, -678950, -678943, -676750, -676748, -670242, -670239, -670238)
  ) loop

    v_can_query_uuedw := 0;

    if c.namespace_id = const.get_uuedw_namespace_id then
      begin  
        v_can_query_uuedw := can_query_uuedw( c.query_id );
        exception
        when others then
          v_error_msg := SQLERRM;
          v_can_query_uuedw := 0;
      end;

      if (c.expected_result_cd = 'P' and v_can_query_uuedw = 1) or (c.expected_result_cd = 'F' and v_can_query_uuedw = 0)  then
        insert into query_test_result values( c.query_id, c.namespace_id, 'PASSED', null, sysdate);
      else
        insert into query_test_result values( c.query_id, c.namespace_id, 'FAILED', null, sysdate);    
      end if;

    end if;
    
    v_can_query_updbl := 0;
    if c.namespace_id = const.get_updbl_namespace_id then
      begin  
        v_can_query_updbl := can_query_updbl( c.query_id );
        exception
        when others then
          v_error_msg := SQLERRM;
          v_can_query_updbl := 0;
      end;

      if (c.expected_result_cd = 'P' and v_can_query_updbl = 1) or (c.expected_result_cd = 'F' and v_can_query_updbl = 0)  then
        insert into query_test_result values( c.query_id, c.namespace_id, 'PASSED', null, sysdate);
      else
        insert into query_test_result values( c.query_id, c.namespace_id, 'FAILED', null, sysdate);    
      end if;      
      
    end if;
    commit;    
    --dbms_output.put_line('=========>' || c.query_id || ':' || c.expected_result_cd || ':' || v_test_cd);
  end loop;

  commit;
  
  select count(1) into v_failures
  from query_test_result
  where test_cd = 'FAILED';
  
  if v_failures > 0 then 
  
    RAISE_APPLICATION_ERROR(-20000, v_failures || ' TESTS FAILED: See details in table QUERY_TEST_RESULT' );  
  
  end if;

end run_query_trans_test_suite;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_DEMOG_IH_APO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_DEMOG_IH_APO" ( p_query_id number ) AS

  v_namespace_id number;
  v_ih_apo_person_asset_id number;
  v_is_trans_attr number;
  v_is_trans_attr_value number;
  v_is_valid_attr number;

  v_trgt_attr varchar2(100);
  v_trnsltn_func varchar2(100);
  v_trnsltn_to_type varchar2(100);
  v_nmspc_id number;
  v_prop_name varchar2(100);
  v_trgt_value varchar2(100);
  v_xpath varchar2(4000);
  v_search_type varchar2(50);
  v_oper varchar2(50);
  v_new_oper varchar2(50);
  
  v_error_msg varchar2(4000);
  v_attr_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  i number;
  v_attr_count number;
  
BEGIN

  v_intro_msg := 'QUERY( IH:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  v_namespace_id := const.get_ih_apo_namespace_id ;

  
  for crs in (
    select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() attr_name
    from query_def q
        ,table(xmlsequence( q.query_xml.extract('//parameter[(position()=1 and ../../searchType/text()!="SIMPLE")' ||
                                                        ' or (position()=2 and ../../searchType/text()="SIMPLE")]'
                          , const.get_query_xml_namespace) ) )
    where query_id = p_query_id
  ) loop
  
    select count(1)+1 into v_attr_count -- the nth occurance of this attribute
    from query_temp_attr
    where query_id = p_query_id
      and namespace_id = v_namespace_id
      and attr_name = crs.attr_name;
      
    insert into query_temp_attr values( v_namespace_id, p_query_id, crs.attr_name );
    
    v_is_valid_attr := is_valid_attr( const.get_frthr_person_obj_asset_id, crs.attr_name );
    
    further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '1 CURRENT ATTR: ' || crs.attr_name || '[' || v_attr_count || ']' ,1);
    
    v_ih_apo_person_asset_id := 3138;
   
    if v_is_valid_attr = 1 then
        
      v_is_trans_attr := is_trans_attr( const.get_frthr_person_obj_asset_id, v_ih_apo_person_asset_id , crs.attr_name );
      v_is_trans_attr_value := is_trans_attr_value( p_query_id, const.get_frthr_person_obj_asset_id, v_ih_apo_person_asset_id, crs.attr_name );
      v_trnsltn_to_type := get_trans_assoc_prop( const.get_frthr_person_obj_asset_id, v_ih_apo_person_asset_id, crs.attr_name, 'ATTR_VALUE_TRANS_TO_DATA_TYPE');
  
      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '1.5 TRANSLATION PARAMS: ' || crs.attr_name || '[' || v_attr_count || ']' 
        ||  ' is_trans_attr=' || v_is_trans_attr 
        ||  ' is_trans_attr_value=' || v_is_trans_attr_value 
        ,1);

      v_attr_error_msg := null;
      v_trgt_attr := null;
      v_trgt_value := null;
    
    /* -------------------------
     * Translate Attribute Name
     * -------------------------*/
    if (  v_is_trans_attr = 1 ) then

      v_trgt_attr := get_translated_attribute( const.get_frthr_person_obj_asset_id, v_ih_apo_person_asset_id, crs.attr_name );   
      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '2 TRANSLAING ATTR: ' || crs.attr_name || ' TO: ' || v_trgt_attr || ' NEW TYPE: ' || v_trnsltn_to_type,1);

      update query_temp qn 
         set query_xml = updatexml( 
             qn.query_xml
            ,'(//parameter[text()="' || crs.attr_name || '"])[' || v_attr_count || ']/text()'
            , v_trgt_attr
            , const.get_query_xml_namespace )
      where qn.query_id = p_query_id
        and qn.namespace_id = v_namespace_id;

      if sql%rowcount = 0 then
        v_attr_error_msg := 'ATTR=' || crs.attr_name || ' update failed TRGT_ATTR=' || v_trgt_attr || ' ';
        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '2.1 ' || v_attr_error_msg,1);
      end if;

    end if;
    
    /* -----------------------------
     * Translate Attribute Value(s)
     * ----------------------------- */
    if ( v_is_trans_attr_value  = 1 ) then

      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '3 TRANSLAING ATTR VALUE: ' || crs.attr_name ,1);
      v_trnsltn_func := get_trans_assoc_prop( const.get_frthr_person_obj_asset_id, v_ih_apo_person_asset_id, crs.attr_name, const.get_attr_val_trans_prop_nm);

      i := 0;
      for param in (
        select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() v_value
        from query_def q
            ,table(xmlsequence( q.query_xml.extract('(//criteria[parameters/parameter[text()="' || crs.attr_name || '"]])[' || v_attr_count || ']' ||
                               '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]'
                               , const.get_query_xml_namespace) ) )
        where q.query_id = p_query_id       
      ) loop

          i := i + 1;
          further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '4 TRANSLATE ATTR VALUE[' || i || ']=' || crs.attr_name || ' ATTR_VAL=' || param.v_value ,1);

          if v_trnsltn_func = 'translateCode' then 
          
            v_nmspc_id := get_attr_assoc_prop( const.get_frthr_person_obj_asset_id, crs.attr_name, 'VALUE_SET_NAMESPACE_ID');
            v_prop_name := get_attr_assoc_prop( const.get_frthr_person_obj_asset_id, crs.attr_name, 'VALUE_SET_PROP_NAME');

            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '5 GET_TRANSLATED_CONCEPT_VALUE(' || v_nmspc_id || ', ''' || v_prop_name || ''', ''' || param.v_value || ''', ' || v_namespace_id || ', ''Code'')', 1);

            v_trgt_value := dts.GET_TRANSLATED_CONCEPT_VALUE ( v_nmspc_id, v_prop_name, param.v_value, v_namespace_id, 'Code' );

            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '6 NEW_NMSPC_ID=' || v_namespace_id || ' NEW_CD=' || v_trgt_value,1);
              
          elsif v_trnsltn_func = 'year-from-dateTime' then 

            null; -- v_trgt_value := substr( param.v_value, 1, 4); -- year is the first 4 chars (for the next eight thousand years anyway)         

          end if;
          
          if length(v_trgt_value) > 0 and v_trgt_value is not null then -- trgt_value indicates the value was translated and needs to be updated
  
            v_xpath := '//criteria[parameters//parameter/text()="' || v_trgt_attr || '" and parameters//parameter/text()="' || param.v_value || '"]/parameters/parameter[text()="' || param.v_value || '"]';
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '7 UPDATE QUERY NEW_ATTR=' || v_trgt_attr || ' NEW_ATTR_VALUE=' || v_trgt_value || ' xpath=' || v_xpath,1);
  
            update query_temp qn 
            set query_xml = updatexml( 
              qn.query_xml
              ,v_xpath || '/@xsi:type', 'xs:integer'
              ,v_xpath || '/text()', v_trgt_value
              , const.get_query_xml_namespace)
            where qn.query_id = p_query_id
              and qn.namespace_id = v_namespace_id;
                                                         
          else 
            
            v_attr_error_msg := v_attr_error_msg || 'VALUE TRANSLATION ERROR: attribute=' || crs.attr_name || ' value=' || param.v_value || ' could not be translated. ';

          end if;

      end loop;      
      
    end if; -- is_trans_attr_value
    
    /* -------------------------------
     * Remove untouched from criteria
     * ------------------------------- */
    if ( v_attr_error_msg is null ) then 
                                     
      if ( v_is_trans_attr  = 1) then

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '9 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr || ' VALUE=' || v_trgt_value,1);
        delete_query_elements( v_namespace_id, p_query_id,'//criteria[parameters//parameter/text()="' || v_trgt_attr ||'"]/parameters/untouched');

      elsif ( v_is_trans_attr  = 0 and v_is_trans_attr_value  = 0 and is_valid_attr( const.get_frthr_person_obj_asset_id , crs.attr_name) = 1) then

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '10 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr || ' VALUE=' || v_trgt_value,1);
        delete_query_elements( v_namespace_id, p_query_id,'//criteria[parameters//parameter/text()="' || crs.attr_name || '"]/parameters/untouched');

      end if;
      
    else
      
        further_pkg.log_msg($$PLSQL_UNIT,'ERROR', v_intro_msg || v_attr_error_msg,1);      
     
    end if; -- no error msg
    
    else
    
      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '11 ATTR NOT PROCESSED BY THIS PROC: ' || crs.attr_name ,1);
    
    end if;
    
    v_error_msg := v_error_msg || v_attr_error_msg;
    
  end loop; -- attr loop

  -- delete the female administartive gender crieria when it is female - impled but not supported
  delete_query_elements( v_namespace_id, p_query_id,'//criteria[parameters//parameter/text()="administrativeGender" and parameters//parameter/text()="248153007"]');
  delete query_temp_attr where query_id = p_query_id and namespace_id=v_namespace_id;
  
  /* ----------------------------------------------------------
   * Check for translation errors - throw excpetion when found
   * ----------------------------------------------------------*/
  
  if length( v_error_msg ) > 0 then
    further_pkg.log_msg($$PLSQL_UNIT, v_intro_msg || 'ERROR', v_error_msg, 1);
    RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg );
  end if;

END TRANS_QUERY_DEMOG_IH_APO;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_DEMOG_UPDBL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_DEMOG_UPDBL" ( p_query_id number ) AS

  v_is_trans_attr number;
  v_is_trans_attr_value number;
  v_is_valid_attr number;

  v_trgt_attr varchar2(100);
  v_trnsltn_func varchar2(100);
  v_trnsltn_to_type varchar2(100);
  v_nmspc_id number;
  v_prop_name varchar2(100);
  v_trgt_value varchar2(100);
  v_xpath varchar2(4000);
  v_search_type varchar2(50);
  v_oper varchar2(50);
  v_new_oper varchar2(50);
  
  v_error_msg varchar2(4000);
  v_attr_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  i number;
  v_attr_count number;
  
BEGIN

  v_intro_msg := 'QUERY( UPDB:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  
  for crs in (
    select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() attr_name
    from query_def q
        ,table(xmlsequence( q.query_xml.extract('//parameter[(position()=1 and ../../searchType/text()!="SIMPLE")' ||
                                                        ' or (position()=2 and ../../searchType/text()="SIMPLE")]'
                          , const.get_query_xml_namespace) ) )
    where query_id = p_query_id
  ) loop
  
    select count(1)+1 into v_attr_count -- the nth occurance of this attribute
    from query_temp_attr
    where query_id = p_query_id
      and namespace_id = const.get_updbl_namespace_id
      and attr_name = crs.attr_name;
      
    insert into query_temp_attr values( const.get_updbl_namespace_id, p_query_id, crs.attr_name );
    
    v_is_valid_attr := is_valid_attr( const.get_frthr_person_obj_asset_id, crs.attr_name );
    
    further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '1 CURRENT ATTR: ' || crs.attr_name || '[' || v_attr_count || ']' ,1);
    
    if v_is_valid_attr = 1 then
    
    v_is_trans_attr := is_trans_attr( const.get_frthr_person_obj_asset_id, const.get_updbl_person_obj_asset_id , crs.attr_name );
    v_is_trans_attr_value := is_trans_attr_value( p_query_id, const.get_frthr_person_obj_asset_id, const.get_updbl_person_obj_asset_id, crs.attr_name );
    v_trnsltn_to_type := get_trans_assoc_prop( const.get_frthr_person_obj_asset_id, const.get_updbl_person_obj_asset_id, crs.attr_name, 'ATTR_VALUE_TRANS_TO_DATA_TYPE');

    v_attr_error_msg := null;
    v_trgt_attr := null;
    v_trgt_value := null;
    
    /* -------------------------
     * Translate Attribute Name
     * -------------------------*/
    if (  v_is_trans_attr = 1 ) then

      v_trgt_attr := get_translated_attribute( const.get_frthr_person_obj_asset_id, const.get_updbl_person_obj_asset_id, crs.attr_name );   
      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '2 TRANSLAING ATTR: ' || crs.attr_name || ' TO: ' || v_trgt_attr || ' NEW TYPE: ' || v_trnsltn_to_type,1);

      update query_temp qn 
         set query_xml = updatexml( 
             qn.query_xml
            ,'//parameter[text()="' || crs.attr_name || '"]/text()'
            , v_trgt_attr
            , const.get_query_xml_namespace )
      where qn.query_id = p_query_id
        and qn.namespace_id = const.get_updbl_namespace_id;

      if sql%rowcount = 0 then
        v_attr_error_msg := 'ATTR=' || crs.attr_name || ' update failed TRGT_ATTR=' || v_trgt_attr || ' ';
        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '2.1 ' || v_attr_error_msg,1);
      end if;

    end if;
    
    /* -----------------------------
     * Translate Attribute Value(s)
     * ----------------------------- */
    i := 0;
    if ( v_is_trans_attr_value  = 1 ) then

      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '3 TRANSLAING ATTR VALUE: ' || crs.attr_name ,1);
      v_trnsltn_func := get_trans_assoc_prop( const.get_frthr_person_obj_asset_id, const.get_updbl_person_obj_asset_id, crs.attr_name, const.get_attr_val_trans_prop_nm);

      for param in (
        select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() v_value
        from query_def q
            ,table(xmlsequence( q.query_xml.extract('(//*[parameters/parameter[text()="' || crs.attr_name || '"]])[' || v_attr_count || ']' ||
                               '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]'
                               , const.get_query_xml_namespace) ) )
        where q.query_id = p_query_id       
      ) loop

          i := i + 1;
          further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '4 TRANSLATE ATTR VALUE[' || i || ']=' || crs.attr_name || ' ATTR_VAL=' || param.v_value || ' FUNCTION=' || v_trnsltn_func ,1);

          if v_trnsltn_func = 'translateCode' then 
          
            v_nmspc_id := get_attr_assoc_prop( const.get_frthr_person_obj_asset_id, crs.attr_name, 'VALUE_SET_NAMESPACE_ID');
            v_prop_name := get_attr_assoc_prop( const.get_frthr_person_obj_asset_id, crs.attr_name, 'VALUE_SET_PROP_NAME');

            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '5 GET TRANSLATED CONCEPT VALUE(' || v_nmspc_id || ', ''' || v_prop_name || ''', ''' || param.v_value || ''', ' || const.get_updbl_namespace_id || ', ''Local Code'')', 1);
            v_trgt_value := dts.GET_TRANSLATED_CONCEPT_VALUE ( v_nmspc_id, v_prop_name, param.v_value, const.get_updbl_namespace_id, 'Local Code' );
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '6 NEW_NMSPC_ID=' || const.get_updbl_namespace_id || ' NEW_CD=' || v_trgt_value,1);
              
          elsif v_trnsltn_func = 'year-from-dateTime' then 

            v_trgt_value := substr( param.v_value, 1, 4); -- year is the first 4 chars (for the next eight thousand years)         

          elsif v_trnsltn_func = 'ageToBirthYear' then 

            v_trgt_value := '' || (to_number( to_char( sysdate, 'YYYY' ) ) - to_number( param.v_value));    
            
          end if;
          
          if length(v_trgt_value) > 0 then -- trgt_value indicates the value was translated and needs to be updated
  
            v_xpath := '//*[parameters//parameter/text()="' || v_trgt_attr || '" and parameters//parameter/text()="' || param.v_value || '"]/parameters/parameter[text()="' || param.v_value || '"]';
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '7 UPDATE QUERY NEW_ATTR=' || v_trgt_attr || ' NEW_ATTR_VALUE=' || v_trgt_value || ' xpath=' || v_xpath,1);
        
            if length(v_trnsltn_to_type) > 0 then -- translation type needs to be updated
    
              update query_temp qn 
              set query_xml = updatexml( 
                qn.query_xml
                ,v_xpath || '/@xsi:type', v_trnsltn_to_type
                ,v_xpath || '/text()', v_trgt_value
                , const.get_query_xml_namespace)
              where qn.query_id = p_query_id
                and qn.namespace_id = const.get_updbl_namespace_id;
              
            else -- no type translation required

              update query_temp qn 
              set query_xml = updatexml( 
                qn.query_xml
                ,v_xpath || '/text()'
                ,v_trgt_value
                , const.get_query_xml_namespace)
              where qn.query_id = p_query_id
                and qn.namespace_id = const.get_updbl_namespace_id;
            
            end if;
                                                         
          else 
            
            v_attr_error_msg := v_attr_error_msg || 'VALUE TRANSLATION ERROR: attribute=' || crs.attr_name || ' value=' || param.v_value || ' could not be translated. ';

          end if;

      end loop;      
      
    end if; -- is_trans_attr_value
    
    /* -------------------------------
     * Remove untouched from criteria
     * ------------------------------- */
    if ( v_attr_error_msg is null ) then 
      
      if ( v_is_trans_attr  = 1 and v_is_trans_attr_value  = 0 ) then
      
        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '8 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr,1);
        delete_query_elements( const.get_updbl_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || v_trgt_attr || '"]/parameters/untouched'
                             );
                               
      elsif ( v_is_trans_attr  = 1 and v_is_trans_attr_value  = 1 ) then

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '9 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr || ' VALUE=' || v_trgt_value,1);
        delete_query_elements( const.get_updbl_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || v_trgt_attr || 
                              '" and parameters//parameter/text()="' || v_trgt_value || '"]/parameters/untouched'
                             );

      elsif ( v_is_trans_attr  = 0 and v_is_trans_attr_value  = 0 and is_valid_attr( const.get_updbl_person_obj_asset_id, crs.attr_name) = 1) then

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '10 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr || ' VALUE=' || v_trgt_value,1);
        delete_query_elements( const.get_updbl_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || crs.attr_name || '"]/parameters/untouched'
                             );

      end if;
      
      else
      
        further_pkg.log_msg($$PLSQL_UNIT,'ERROR', v_intro_msg || v_attr_error_msg,1);      
     
    end if; -- no error msg
    
    else
    
      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '11 ATTR NOT PROCESSED BY THIS PROC: ' || crs.attr_name ,1);
    
    end if;
    
    -- if this was an "age BETWEEN" statement the order of the between values needs to be swapped.
    v_search_type := get_attr_search_type(p_query_id, crs.attr_name, v_attr_count );
    further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '12 SEARCH_TYPE for ATTR ' || crs.attr_name || '[' || v_attr_count || ']="' || v_search_type ||'"' ,1);

    if ( crs.attr_name = 'age' and v_search_type = 'BETWEEN' ) then 

      -- duplicate param[2] and add it to end of param list
      update query_temp q 
      set query_xml = insertChildXML( q.query_xml
                      , '(//*[parameters/parameter[text()="' || v_trgt_attr || '"]])[' || v_attr_count || ']/parameters'
                      , 'parameter'
                      , extract( q.query_xml,'(//*[parameters/parameter[text()="' || v_trgt_attr || '"]])[' || v_attr_count || ']' || '//parameter[2]', const.get_query_xml_namespace)
                      , const.get_query_xml_namespace ) 
      where q.query_id = p_query_id
      and q.namespace_id = const.get_updbl_namespace_id;
      
      -- delete param[2] to complete value position swap
      delete_query_elements( const.get_updbl_namespace_id
                             , p_query_id
                             ,'(//*[parameters/parameter[text()="' || v_trgt_attr || '"]])[' || v_attr_count || ']/parameters/parameter[2]'
                             );

    elsif crs.attr_name = 'age' and v_search_type='SIMPLE' then -- need to change operator direction LT becomes GT and vice versa, same with LTE and GTE
    
      v_new_oper := '';
      v_oper := get_attr_simple_operator(p_query_id, crs.attr_name, v_attr_count );

      if v_oper='LT' then 
        v_new_oper:='GT';
      elsif v_oper='GT' then
        v_new_oper:='LT';
      elsif v_oper='LE' then
        v_new_oper:='GE';
      elsif v_oper='GE' then
        v_new_oper:='LE';
      end if;

      if length(v_new_oper) > 0 then -- update the operator

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '13.2 UPDATING QUERY OPERATOR for age[' || v_attr_count || '] FROM ' || v_oper || ' TO ' || v_new_oper,1);
      
        update query_temp q 
        set query_xml = updateXML( q.query_xml
                      , '(//*[parameters/parameter[text()="' || v_trgt_attr || '"]])[' || v_attr_count || ']/parameters/parameter[1]/text()'
                      , v_new_oper
                      , const.get_query_xml_namespace ) 
        where q.query_id = p_query_id
        and q.namespace_id = const.get_updbl_namespace_id;

      end if;

    end if;

    v_error_msg := v_error_msg || v_attr_error_msg;
  end loop; -- attr loop

  delete query_temp_attr where query_id = p_query_id and namespace_id=const.get_uuedw_namespace_id;
  
  /* ----------------------------------------------------------
   * Check for translation errors - throw excpetion when found
   * ----------------------------------------------------------*/
  
  if length( v_error_msg ) > 0 then
    further_pkg.log_msg($$PLSQL_UNIT, v_intro_msg || 'ERROR', v_error_msg, 1);
    RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg );
  end if;

END TRANS_QUERY_DEMOG_UPDBL;
 

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_DEMOG_UUEDW
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_DEMOG_UUEDW" ( p_query_id number ) AS

  v_is_trans_attr number;
  v_is_trans_attr_value number;

  v_trgt_attr varchar2(100);
  v_trnsltn_func varchar2(100);
  v_nmspc_id number;
  v_prop_name varchar2(100);
  v_trgt_value varchar2(100);
  v_xpath varchar2(4000);
  
  v_error_msg varchar2(4000);
  v_attr_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  i number;
  v_attr_count number;
  
BEGIN

  v_intro_msg := 'QUERY( UUEDW:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  
  for crs in (
    select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() attr_name
    from query_def q
        ,table(xmlsequence( q.query_xml.extract('//criteria//parameter[(position()=1 and ../../searchType/text()!="SIMPLE")' ||
                                                                  ' or (position()=2 and ../../searchType/text()="SIMPLE")]'
                          , const.get_query_xml_namespace) ) )
    where query_id = p_query_id
  ) loop
    
    select count(1)+1 into v_attr_count
    from query_temp_attr
    where query_id = p_query_id
      and namespace_id = const.get_uuedw_namespace_id
      and attr_name = crs.attr_name;
      
    insert into query_temp_attr values( const.get_uuedw_namespace_id, p_query_id, crs.attr_name );

    further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '1 CURRENT ATTR: ' || crs.attr_name ,1);
    v_is_trans_attr := is_trans_attr( const.get_frthr_person_obj_asset_id, const.get_uuedw_patient_obj_asset_id, crs.attr_name );
    v_is_trans_attr_value := is_trans_attr_value( p_query_id, const.get_frthr_person_obj_asset_id, const.get_uuedw_patient_obj_asset_id, crs.attr_name );
    v_attr_error_msg := null;
    v_trgt_attr := null;
    v_trgt_value := null;
    
    /* -------------------------
     * Translate Attribute Name
     * -------------------------*/
    if (  v_is_trans_attr = 1 ) then

      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '2 TRANSLAING ATTR: ' || crs.attr_name ,1);
      v_trgt_attr := get_translated_attribute( const.get_frthr_person_obj_asset_id, const.get_uuedw_patient_obj_asset_id, crs.attr_name );   

      update query_temp qn 
         set query_xml = updatexml( 
             qn.query_xml
            ,'//criteria/parameters/parameter[text()="' || crs.attr_name || '"]/text()'
            , v_trgt_attr
            , const.get_query_xml_namespace )
      where qn.query_id = p_query_id
        and qn.namespace_id = const.get_uuedw_namespace_id;

      if sql%rowcount = 0 then
        v_attr_error_msg := 'ATTR=' || crs.attr_name || ' update failed TRGT_ATTR=' || v_trgt_attr;
      end if;

    end if;
    
    /* -----------------------------
     * Translate Attribute Value(s)
     * ----------------------------- */
    if ( v_is_trans_attr_value  = 1 ) then

      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '3 TRANSLAING ATTR VALUE: ' || crs.attr_name ,1);
      v_trnsltn_func := get_trans_assoc_prop( const.get_frthr_person_obj_asset_id, const.get_uuedw_patient_obj_asset_id, crs.attr_name, const.get_attr_val_trans_prop_nm);

      i := 0;
      for param in (
        select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() v_value
        from query_def q
            ,table(xmlsequence( q.query_xml.extract('(//criteria[parameters/parameter[text()="' || crs.attr_name || '"]])[' || v_attr_count || ']' ||
                               '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]'
                               , const.get_query_xml_namespace) ) )
        where q.query_id = p_query_id       
      ) loop

          i := i + 1;
          further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '4 TRANSLATE ATTR VALUE[' || i || ']=' || crs.attr_name || ' ATTR_VAL=' || param.v_value ,1);

          if v_trnsltn_func = 'translateCode' then 
          
            v_nmspc_id := get_attr_assoc_prop( const.get_frthr_person_obj_asset_id, crs.attr_name, 'VALUE_SET_NAMESPACE_ID');
            v_prop_name := get_attr_assoc_prop( const.get_frthr_person_obj_asset_id, crs.attr_name, 'VALUE_SET_PROP_NAME');

            further_pkg.log_msg($$PLSQL_UNIT
              ,'DEBUG'
              , v_intro_msg || '5 GET_TRANSLATED_CONCEPT_VALUE(' || v_nmspc_id || ', ''' || v_prop_name || ''', ''' || param.v_value || ''', ' || const.get_uuedw_namespace_id || ', ''Local Code'')'
              , 1);

            v_trgt_value := dts.GET_TRANSLATED_CONCEPT_VALUE ( v_nmspc_id, v_prop_name, param.v_value, const.get_uuedw_namespace_id, 'Local Code' );

            further_pkg.log_msg($$PLSQL_UNIT
              ,'DEBUG'
              , v_intro_msg || '6 NEW_NMSPC_ID=' || const.get_uuedw_namespace_id || ' NEW_CD=' || v_trgt_value
              ,1);
              
          elsif v_trnsltn_func = 'year-from-dateTime' then 

            v_trgt_value := substr( param.v_value, 1, 4); -- year is the first 4 chars (for the next eight thousand years anyway)         

          end if;
          
          if length(v_trgt_value) > 0 and v_trgt_value is not null then -- trgt_value indicates the value was translated and needs to be updated
  
            v_xpath := '//criteria[parameters//parameter/text()="' || v_trgt_attr || '" and parameters//parameter/text()="' || param.v_value || '"]/parameters/parameter[text()="' || param.v_value || '"]';
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '7 UPDATE QUERY NEW_ATTR=' || v_trgt_attr || ' NEW_ATTR_VALUE=' || v_trgt_value || ' xpath=' || v_xpath,1);
  
            update query_temp qn 
            set query_xml = updatexml( 
              qn.query_xml
              ,v_xpath || '/@xsi:type', 'xs:integer'
              ,v_xpath || '/text()', v_trgt_value
              , const.get_query_xml_namespace)
            where qn.query_id = p_query_id
              and qn.namespace_id = const.get_uuedw_namespace_id;
                                                         
          else 
            
            v_attr_error_msg := v_attr_error_msg || 'VALUE TRANSLATION ERROR: attribute=' || crs.attr_name || ' value=' || param.v_value || ' could not be translated. ';

          end if;

      end loop;      
      
    end if; -- is_trans_attr_value
    
    /* -------------------------------
     * Remove untouched from criteria
     * -------------------------------*/
    if ( v_attr_error_msg is null ) then 
      
      if ( v_is_trans_attr  = 1 and v_is_trans_attr_value  = 0 ) then
      
        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '8 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr,1);
        delete_query_elements( const.get_uuedw_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || v_trgt_attr || '"]/parameters/untouched'
                             );
                               
      elsif ( v_is_trans_attr  = 1 and v_is_trans_attr_value  = 1 ) then

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '9 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr || ' VALUE=' || v_trgt_value,1);
        delete_query_elements( const.get_uuedw_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || v_trgt_attr || 
                              '" and parameters//parameter/text()="' || v_trgt_value || '"]/parameters/untouched'
                             );

      elsif ( v_is_trans_attr  = 0 and v_is_trans_attr_value  = 0 and is_valid_attr( const.get_uuedw_patient_obj_asset_id, crs.attr_name) = 1) then

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '10 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr || ' VALUE=' || v_trgt_value,1);
        delete_query_elements( const.get_uuedw_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || crs.attr_name || '"]/parameters/untouched'
                             );

      end if;
      
      else
      
        further_pkg.log_msg($$PLSQL_UNIT,'ERROR', v_intro_msg || ' 11 ' || v_attr_error_msg,1);      
     
    end if; -- no error msg

    v_error_msg := v_error_msg || v_attr_error_msg;
  end loop; -- attr loop
  

  delete query_temp_attr where query_id = p_query_id and namespace_id=const.get_uuedw_namespace_id;

  /* ----------------------------------------------------------
   * Check for translation errors - throw excpetion when found
   * ----------------------------------------------------------*/
  
    if length( v_error_msg ) > 0 then
      further_pkg.log_msg($$PLSQL_UNIT, v_intro_msg || 'ERROR', '12 ' || v_error_msg, 1);
      RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg );
    end if;

END TRANS_QUERY_DEMOG_UUEDW;
 

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_DEMOG_UUEDW_APO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_DEMOG_UUEDW_APO" ( p_query_id number ) AS

  v_is_trans_attr number;
  v_is_trans_attr_value number;

  v_trgt_attr varchar2(100);
  v_trnsltn_func varchar2(100);
  v_nmspc_id number;
  v_prop_name varchar2(100);
  v_trgt_value varchar2(100);
  v_xpath varchar2(4000);
  
  v_error_msg varchar2(4000);
  v_attr_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  i number;
  v_attr_count number;
  v_namespace_id number;
  
BEGIN

  v_intro_msg := 'QUERY( UUEDW_APO:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  v_namespace_id := const.get_uuedw_apo_namespace_id;
  
  for crs in (
    select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() attr_name
    from query_def q
        ,table(xmlsequence( q.query_xml.extract('//criteria//parameter[(position()=1 and ../../searchType/text()!="SIMPLE")' ||
                                                                  ' or (position()=2 and ../../searchType/text()="SIMPLE")]'
                          , const.get_query_xml_namespace ) ) )
    where query_id = p_query_id
  ) loop
    
    select count(1)+1 into v_attr_count
    from query_temp_attr
    where query_id = p_query_id
      and namespace_id = v_namespace_id
      and attr_name = crs.attr_name;
      
    insert into query_temp_attr values( v_namespace_id, p_query_id, crs.attr_name );

    further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '1 CURRENT ATTR: ' || crs.attr_name ,1);
    
    v_is_trans_attr := is_trans_attr( const.get_frthr_person_obj_asset_id, const.get_uuedw_apo_person_asset_id, crs.attr_name );
    v_is_trans_attr_value := is_trans_attr_value( p_query_id, const.get_frthr_person_obj_asset_id, const.get_uuedw_apo_person_asset_id, crs.attr_name );
    
    v_attr_error_msg := null;
    v_trgt_attr := null;
    v_trgt_value := null;
    
    /* -------------------------
     * Translate Attribute Name
     * -------------------------*/
    if (  v_is_trans_attr = 1 ) then

      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '2 TRANSLAING ATTR: ' || crs.attr_name ,1);
      v_trgt_attr := get_translated_attribute( const.get_frthr_person_obj_asset_id, const.get_uuedw_apo_person_asset_id, crs.attr_name );   

      update query_temp qn 
         set query_xml = updatexml( 
             qn.query_xml
            ,'//criteria/parameters/parameter[text()="' || crs.attr_name || '"]/text()'
            , v_trgt_attr
            , const.get_query_xml_namespace )
      where qn.query_id = p_query_id
        and qn.namespace_id = v_namespace_id;

      if sql%rowcount = 0 then
        v_attr_error_msg := 'ATTR=' || crs.attr_name || ' update failed TRGT_ATTR=' || v_trgt_attr;
      end if;

    end if;
    
    /* -----------------------------
     * Translate Attribute Value(s)
     * ----------------------------- */
    if ( v_is_trans_attr_value  = 1 ) then

      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '3 TRANSLAING ATTR VALUE: ' || crs.attr_name ,1);
      v_trnsltn_func := get_trans_assoc_prop( const.get_frthr_person_obj_asset_id, const.get_uuedw_apo_person_asset_id, crs.attr_name, const.get_attr_val_trans_prop_nm);

      i := 0;
      for param in (
        select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() v_value
        from query_def q
            ,table(xmlsequence( q.query_xml.extract('(//criteria[parameters/parameter[text()="' || crs.attr_name || '"]])[' || v_attr_count || ']' ||
                               '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]'
                               , const.get_query_xml_namespace) ) )
        where q.query_id = p_query_id       
      ) loop

          i := i + 1;
          further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '4 TRANSLATE ATTR VALUE[' || i || ']=' || crs.attr_name || ' ATTR_VAL=' || param.v_value ,1);

          if v_trnsltn_func = 'translateCode' then 
          
            v_nmspc_id := get_attr_assoc_prop( const.get_frthr_person_obj_asset_id, crs.attr_name, 'VALUE_SET_NAMESPACE_ID');
            v_prop_name := get_attr_assoc_prop( const.get_frthr_person_obj_asset_id, crs.attr_name, 'VALUE_SET_PROP_NAME');

            further_pkg.log_msg($$PLSQL_UNIT
              ,'DEBUG'
              , v_intro_msg || '5 GET_TRANSLATED_CONCEPT_VALUE(' || v_nmspc_id || ', ''' || v_prop_name || ''', ''' || param.v_value || ''', ' || v_namespace_id || ', ''Local Code'')'
              , 1);

            v_trgt_value := dts.GET_TRANSLATED_CONCEPT_VALUE ( v_nmspc_id, v_prop_name, param.v_value, v_namespace_id, 'Local Code' );

            further_pkg.log_msg($$PLSQL_UNIT
              ,'DEBUG'
              , v_intro_msg || '6 NEW_NMSPC_ID=' || v_namespace_id || ' NEW_CD=' || v_trgt_value
              ,1);
              
          elsif v_trnsltn_func = 'year-from-dateTime' then 

            v_trgt_value := substr( param.v_value, 1, 4); -- year is the first 4 chars (for the next eight thousand years anyway)         

          end if;
          
          if length(v_trgt_value) > 0 and v_trgt_value is not null then -- trgt_value indicates the value was translated and needs to be updated
  
            v_xpath := '//criteria[parameters//parameter/text()="' || v_trgt_attr || '" and parameters//parameter/text()="' || param.v_value || '"]/parameters/parameter[text()="' || param.v_value || '"]';
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '7 UPDATE QUERY NEW_ATTR=' || v_trgt_attr || ' NEW_ATTR_VALUE=' || v_trgt_value || ' xpath=' || v_xpath,1);
  
            update query_temp qn 
            set query_xml = updatexml( 
              qn.query_xml
              ,v_xpath || '/@xsi:type', 'xs:integer'
              ,v_xpath || '/text()', v_trgt_value
              , v_namespace_id)
            where qn.query_id = p_query_id
              and qn.namespace_id = v_namespace_id;
                                                         
          else 
            
            v_attr_error_msg := v_attr_error_msg || 'VALUE TRANSLATION ERROR: attribute=' || crs.attr_name || ' value=' || param.v_value || ' could not be translated. ';

          end if;

      end loop;      
      
    end if; -- is_trans_attr_value
    
    /* -------------------------------
     * Remove untouched from criteria
     * -------------------------------*/
    if ( v_attr_error_msg is null ) then 
      
      if ( v_is_trans_attr  = 1 and v_is_trans_attr_value  = 0 ) then
      
        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '8 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr,1);
        delete_query_elements( v_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || v_trgt_attr || '"]/parameters/untouched'
                             );
                               
      elsif ( v_is_trans_attr  = 1 and v_is_trans_attr_value  = 1 ) then

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '9 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr || ' VALUE=' || v_trgt_value,1);
        delete_query_elements( v_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || v_trgt_attr || 
                              '" and parameters//parameter/text()="' || v_trgt_value || '"]/parameters/untouched'
                             );

      elsif ( v_is_trans_attr  = 0 and v_is_trans_attr_value  = 0 and is_valid_attr( const.get_uuedw_patient_obj_asset_id, crs.attr_name) = 1) then

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '10 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr || ' VALUE=' || v_trgt_value,1);
        delete_query_elements( v_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || crs.attr_name || '"]/parameters/untouched'
                             );

      end if;
      
      else
      
        further_pkg.log_msg($$PLSQL_UNIT,'ERROR', v_intro_msg || ' 11 ' || v_attr_error_msg,1);      
     
    end if; -- no error msg

    v_error_msg := v_error_msg || v_attr_error_msg;
  end loop; -- attr loop
  

  delete query_temp_attr where query_id = p_query_id and namespace_id=v_namespace_id;

  /* ----------------------------------------------------------
   * Check for translation errors - throw excpetion when found
   * ----------------------------------------------------------*/
  
    if length( v_error_msg ) > 0 then
      further_pkg.log_msg($$PLSQL_UNIT, v_intro_msg || 'ERROR', '12 ' || v_error_msg, 1);
      RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg );
    end if;

END TRANS_QUERY_DEMOG_UUEDW_APO;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_ENCNTR_UUEDW
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_ENCNTR_UUEDW" ( p_query_id number ) AS 

  v_attr varchar2(100);
  v_data_type varchar2(100);
  v_trgt_attr varchar2(100);
  v_attr_count number;
  v_is_valid_attr number;
  v_is_trans_attr number;
  v_is_trans_attr_value number;
  v_is_trans_attr_type number;
  v_new_alias varchar2(100);
  v_translated_attr varchar2(100);
  v_working_aliased_attr varchar2(100);
  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  v_alias_iter number;
  v_length_of_stay_units varchar2(100);
  v_los_units_nmspc_id varchar2(100);

BEGIN

  v_intro_msg := 'QUERY( UUEDW:' || p_query_id || ') ';
  v_alias_iter := 0;

  /* for each encounter alias */
  for c1 in 
    (select extract(column_value, '/alias/key/text()', const.get_query_xml_namespace).getstringval() c_alias,
            extract(column_value, '/alias/value/text()', const.get_query_xml_namespace).getstringval() c_object
     from query_def q
         ,table(xmlsequence( q.query_xml.extract('//aliases/alias[value/text()="encounters"]', const.get_query_xml_namespace) ) )
     where query_id = p_query_id) loop

    further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'START TRANSLATION ALIAS=' || c1.c_alias || ' OBJECT=' || c1.c_object,1);
    v_alias_iter := v_alias_iter + 1;

    -- for each attribute of this alias
    for c2 in (
          select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_aliased_attr
          from query_def q,
            table(xmlsequence
                  (q.query_xml.extract
                    ('//parameter[ora:contains(text(),"' || c1.c_alias || '.")>0]', const.get_query_xml_namespace)
                  )
                )
          where q.query_id = p_query_id
    ) loop 

      v_new_alias := 'nEnc' || v_alias_iter;
      v_attr := get_attr_name_from_obj_attr( c2.c_aliased_attr );
      v_trgt_attr := v_attr;

      v_is_valid_attr := is_valid_attr( const.get_frthr_enc_asset_id, v_attr );
      
      if v_is_valid_attr = 0 then 
        v_error_msg := 'Invalid attribute: ' || c2.c_aliased_attr;
      end if;

      select count(1)+1 into v_attr_count -- the nth occurance of this attribute
      from query_temp_attr
      where query_id = p_query_id
        and namespace_id = const.get_uuedw_namespace_id
        and attr_name = c2.c_aliased_attr;
      
      insert into query_temp_attr values( const.get_uuedw_namespace_id, p_query_id, c2.c_aliased_attr );

      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'PROCESSING ' || c2.c_aliased_attr || '[' || v_attr_count || ']',1);

      v_working_aliased_attr := c2.c_aliased_attr;
              
      v_is_trans_attr := is_trans_attr( const.get_frthr_enc_asset_id, const.get_uuedw_enc_asset_id, v_attr );
      v_is_trans_attr_value := is_trans_attr_value( p_query_id, const.get_frthr_enc_asset_id, const.get_uuedw_enc_asset_id, v_attr );
      v_is_trans_attr_type := is_trans_attr_data_type( const.get_frthr_enc_asset_id, const.get_uuedw_enc_asset_id, v_attr );

      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'TRANSLATION SPECS: ATTR=' || v_attr || ' TRANS ATTR=' 
                || v_is_trans_attr || ' VALUE=' || v_is_trans_attr_value || ' TYPE=' || v_is_trans_attr_type  ,1);

      if v_is_trans_attr = 1 then
      
        v_trgt_attr := get_translated_attribute( const.get_frthr_enc_asset_id, const.get_uuedw_enc_asset_id, v_attr );  
        v_trgt_attr := v_new_alias || '.' || v_trgt_attr;
        v_working_aliased_attr := v_trgt_attr;
        
        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'TRANSLAING ATTR: ' || c2.c_aliased_attr || ' TO: ' || v_trgt_attr, 1);

        update query_temp qn 
           set query_xml = updatexml( 
               qn.query_xml
              ,'//parameter[text()="' || c2.c_aliased_attr || '"][1]/text()'
              , v_trgt_attr
              , const.get_query_xml_namespace )
        where qn.query_id = p_query_id
          and qn.namespace_id = const.get_uuedw_namespace_id;
      
      end if;
      
      if v_is_trans_attr_type = 1 then
      
        v_data_type := get_trans_assoc_prop( const.get_frthr_enc_asset_id, const.get_uuedw_enc_asset_id, v_attr, 'ATTR_VALUE_TRANS_TO_DATA_TYPE' );

        update query_temp q
           set q.query_xml = updatexml( 
                              q.query_xml
                            , '//parameters[parameter/text()="' || v_working_aliased_attr || '"]'
                                       ||' /parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]/@xsi:type'
                            , v_data_type
                            , const.get_query_xml_namespace)
        where q.query_id = p_query_id
          and q.namespace_id = const.get_uuedw_namespace_id;
     
      end if;
      
      -- validation: when there is a length of stay make sure the units are days, otherwise not supported
      if v_attr = 'lengthOfStay' then
      
        v_los_units_nmspc_id := GET_SIMPLE_QUERY_ATTR_VALUE_N(p_query_id, c1.c_alias, 'lengthOfStayUnitsNamespaceId', v_attr_count );
        v_length_of_stay_units := GET_SIMPLE_QUERY_ATTR_VALUE_N(p_query_id, c1.c_alias, 'lengthOfStayUnits', v_attr_count );
        
        -- standard namespace for units is SNOMED, code for days = 258703001
        if v_length_of_stay_units is null or length(v_length_of_stay_units) = 0 then

          v_error_msg := 'Attribute lengthOfStayUnits is a REQUIRED FIELD when querying lengthOfStay';

        elsif v_length_of_stay_units <> '258703001' or v_los_units_nmspc_id <> const.get_snomed_namespace_id  then
        
          v_error_msg := 'UUEDW DOES NOT SUPPORT lengthOfStayUnits namespace=' || v_los_units_nmspc_id || ' value=' || v_length_of_stay_units;
        
        end if;
        
        delete_query_elements( const.get_uuedw_namespace_id
                             , p_query_id
                             ,'(//criteria[parameters/parameter/text()="' || c1.c_alias || '.lengthOfStayUnits"])[' || v_attr_count || ']' );
        
      end if;

      delete_query_elements( const.get_uuedw_namespace_id
                           , p_query_id
                           ,'(//criteria[parameters/parameter[text()="' || v_trgt_attr || '"]])[' || v_attr_count || ']/parameters/untouched' );

      delete_query_elements( const.get_uuedw_namespace_id
                           , p_query_id
                           ,'//alias[key/text()="' || c1.c_alias || '"]/untouchedAlias' );

    
    end loop;
    
    UPDATE_QUERY_OBJECT_ALIAS(const.get_uuedw_namespace_id, p_query_id, c1.c_alias, v_new_alias, c1.c_object);

  end loop;

  if length( v_error_msg ) > 0 then
    RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg);
  end if;
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'END',1);

END TRANS_QUERY_ENCNTR_UUEDW;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_IH_APO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_IH_APO" ( p_query_id number ) AS

  v_intro_msg varchar2(50);
  v_namespace_id number;
  
BEGIN

  v_intro_msg := 'QUERY( IH_APO:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  
  v_namespace_id := const.get_ih_apo_namespace_id ;
  prepare_new_query( v_namespace_id, p_query_id );
  
  /* --------------------------------------------- */
  /* Translate person - root attributes (no alias) */
  /* --------------------------------------------- */
  
  TRANS_QUERY_DEMOG_IH_APO( p_query_id );
  
  TRANS_QUERY_OBS_IH_APO( p_query_id );
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'DELETE *NamespaceId',1);

  update query_temp q
  set q.query_xml = deleteXML( q.query_xml, '//criteria[parameters/parameter[ora:contains(text(),"%NamespaceId")>0]]', const.get_query_xml_namespace )
  where query_id = p_query_id
    and namespace_id = v_namespace_id;

  TRANS_QUERY_SUBQ( v_namespace_id, p_query_id );
  
  check_translated_query( v_namespace_id, p_query_id );
  
  /* --------------------------------------------------------------------- */
  /* Query translation done, add query to query_nmspc for Java interpreter */
  /* --------------------------------------------------------------------- */
  insert into query_nmspc 
    select query_id, v_namespace_id, query_xml 
    from query_temp 
    where query_id = p_query_id
      and namespace_id = v_namespace_id;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END',1);
    
END TRANS_QUERY_IH_APO;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_LCTN_UPDBL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_LCTN_UPDBL" ( p_query_id number ) AS 

  v_iter number;
  v_person_lctn_type varchar2(100);
  v_lctn_val varchar2(255);
  v_lctn_type varchar2(100);
  v_translated_value varchar2(100);
  v_xpath varchar2(1000);
  v_xpath2 varchar2(1000);
  v_attr_update varchar2(100);
  v_val_update varchar2(100);
  v_attr varchar2(100);
  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);


BEGIN

  v_intro_msg := 'QUERY( UPDBL:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'BEGIN',1);
  v_iter := 0;
  /* for each Location alias */
  for cc in 
    (select extract(column_value, '/alias/key/text()', const.get_query_xml_namespace).getstringval() v_alias,
            extract(column_value, '/alias/value/text()', const.get_query_xml_namespace).getstringval() v_object
     from query_def q
         ,table(xmlsequence( q.query_xml.extract('//aliases/alias[value/text()="locations"]', const.get_query_xml_namespace) ) )
     where query_id = p_query_id) loop
     
     v_iter := v_iter + 1;
     v_attr_update := null;
          
     v_person_lctn_type := GET_SIMPLE_QUERY_ATTR_VALUE( p_query_id, cc.v_alias, 'personLocationType');
     v_lctn_type := GET_SIMPLE_QUERY_ATTR_VALUE( p_query_id, cc.v_alias, 'locationType');
     
     further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'PROCESSING ' || cc.v_alias || '.' || cc.v_object || ' TYPE=' || v_person_lctn_type, 1);
     v_attr_update := 'NONE';
     
     if ( v_person_lctn_type = 'CurrentLocation' and v_lctn_type = 'Health District Group' ) then

         v_attr_update := 'current_HDG';

     elsif ( v_person_lctn_type = 'BirthLocation' and v_lctn_type = 'Health District Group' ) then

         v_attr_update := 'birth_HDG';

     -- NOT SUPPORTED 
     --elsif ( v_person_lctn_type = 'DeathLocation' and v_lctn_type = 'Health District Group' ) then

         --v_attr_update := 'death_HDG';

     end if;

     if v_attr_update <> 'NONE' then -- update the attr

       -- update attr 
       update query_temp q
       set q.query_xml = updatexml( 
           q.query_xml
         , '//parameter[text()="' || cc.v_alias || '.location"]/text()'
         , v_attr_update, const.get_query_xml_namespace)
       where q.query_id = p_query_id
         and q.namespace_id = const.get_updbl_namespace_id;       

       if sql%rowcount = 0 then 
         v_error_msg := v_error_msg || 'ATTR UPDATE ERROR: ATTR="' || cc.v_alias || '.location" was NOT updated. ';           
       end if;
       
     else 
         v_error_msg := v_error_msg || 'ATTR TRANSLATION NOT SUPPORTED: personLocationType=' || v_person_lctn_type || ' and locationType=' || v_lctn_type || ' is not supported by UPDBL. ';           
     end if;
     
     /* ------------------------------------- */
     /* Update attr VALUE to UPDBL attr VALUE */
     /* ------------------------------------- */
     -- get and process location value(s) from query
     for attr in (
       SELECT extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() v_value
       FROM query_def q ,
         TABLE(xmlsequence( q.query_xml.extract('//parameters[parameter[text()="' || cc.v_alias || '.location"]] '
                                             || '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]' , const.get_query_xml_namespace) ) )
       WHERE query_id   = p_query_id
     ) loop

         -- get translated location value from DTS
         v_translated_value := dts.GET_TRANSLATED_CONCEPT_VALUE( const.get_further_ontylog_nmspc_id, 'Code in Source', attr.v_value, const.get_updbl_namespace_id , 'Local Code' );
         further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'VALUE TRANSLATION: ATTR="location" OLD_VAL="' || attr.v_value || '" NEW_VAL="' || v_translated_value || '"',1);

         if length(v_translated_value) > 0 then
             
           -- update attr value
           update query_temp q
           set q.query_xml = updatexml( 
               q.query_xml
             , '//parameters[parameter[text()="' || v_attr_update || '"]]/parameter[text()="' || attr.v_value || '"]/text()'
             , v_translated_value, const.get_query_xml_namespace)
           where q.query_id = p_query_id
             and q.namespace_id = const.get_updbl_namespace_id;
             
           if sql%rowcount = 0 then 
             v_error_msg := v_error_msg || 'ATTR VALUE UPDATE ERROR: ATTR="' || v_attr_update || '" VALUE="' || attr.v_value || '" ';           
           end if;

         else
           v_error_msg := v_error_msg || 'VALUE TRANSLATION NOT SUPPORTED: ATTR="' || v_attr_update || '" VALUE="' || attr.v_value || '" ';
         end if;

     end loop;

     delete_query_elements( const.get_updbl_namespace_id
                            , p_query_id, '//criteria/parameters[parameter/text()="' || v_attr_update || '"]/untouched');
            
     -- delete location criteria for this alias - personLocationType and locationType (namespace which is handled later) 
     update query_temp q
       set q.query_xml = deletexml( q.query_xml
                                  , '//criteria[parameters/parameter/text()="' || cc.v_alias || '.personLocationType" ' ||
                                            'or parameters/parameter/text()="' || cc.v_alias || '.locationType"]'
                                  , const.get_query_xml_namespace)
     where q.query_id = p_query_id
         and q.namespace_id = const.get_updbl_namespace_id;
         
     -- delete aliases - the new attrs are root elements ...?
     update query_temp q
       set q.query_xml = deletexml( q.query_xml
                                  , '//alias[key/text()="' || cc.v_alias || '"]'
                                  , const.get_query_xml_namespace)
     where q.query_id = p_query_id
         and q.namespace_id = const.get_updbl_namespace_id;
            
  end loop;      
  
  if length( v_error_msg ) > 0 then
    RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg);
  end if;
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'END',1);

END TRANS_QUERY_LCTN_UPDBL;
 

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_LCTN_UUEDW
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_LCTN_UUEDW" ( p_query_id number ) AS 

  v_iter number;
  v_person_lctn_type varchar2(100);
  v_lctn_val varchar2(255);
  v_lctn_type varchar2(100);
  v_translated_value varchar2(100);
  v_xpath varchar2(1000);
  v_xpath2 varchar2(1000);
  v_attr_update varchar2(100);
  v_val_update varchar2(100);
  v_attr varchar2(100);
  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  v_new_location clob;


BEGIN

  v_intro_msg := 'QUERY( UUEDW:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'BEGIN',1);
  v_iter := 0;
  /* for each locations alias */
  for cc in 
    (select extract(column_value, '/alias/key/text()', const.get_query_xml_namespace).getstringval() v_alias,
            extract(column_value, '/alias/value/text()', const.get_query_xml_namespace).getstringval() v_object
     from query_def q
         ,table(xmlsequence( q.query_xml.extract('//aliases/alias[value/text()="locations"]', const.get_query_xml_namespace) ) )
     where query_id = p_query_id) loop
     
     v_iter := v_iter + 1;
     v_attr_update := null;
          
     v_person_lctn_type := GET_SIMPLE_QUERY_ATTR_VALUE( p_query_id, cc.v_alias, 'personLocationType');
     v_lctn_type := GET_SIMPLE_QUERY_ATTR_VALUE( p_query_id, cc.v_alias, 'locationType');
     
     further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'PROCESSING ' || cc.v_alias || '.' || cc.v_object || ' PERSON LOCATION TYPE=' || v_person_lctn_type || ' LOCATION TYPE=' || v_lctn_type, 1);
     
     /* ------------------------------------------------------ */
     /* Location Type can only be "Current" location for UUEDW */
     /* ------------------------------------------------------ */
     if ( v_person_lctn_type = 'CurrentLocation' ) then

       /* ------------------------- */
       /* Update attr to UUEDW attr */
       /* ------------------------- */
       -- get translated location type from DTS
       -- v_lctn_val := dts.GET_CONCEPT_PROP_VAL( const.get_further_ontylog_nmspc_id , 'Code in Source', attr.v_value, 'Type of Location' );

       v_attr_update := 'NONE';
       
       if v_lctn_type = 'State' then                   
         v_attr_update := 'stateDwid';
       elsif v_lctn_type = 'County' or v_lctn_type = 'Health District Group' then
         v_attr_update := 'countyDwid';       
       end if;
       
       if v_attr_update <> 'NONE' then -- update the attr
       
         if v_lctn_type = 'Health District Group' then -- Build a whole new criteria chunk and update it replaing the old
       
           v_new_location := '<criteria xmlns="http://further.utah.edu/core/query" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><searchType>IN</searchType><parameters><parameter xsi:type="xs:string">' || v_attr_update || '</parameter>';
  
           for param in (
             SELECT extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() val
             FROM query_def q ,
               TABLE(xmlsequence( q.query_xml.extract('//parameters[parameter[text()="' || cc.v_alias || '.location"]] '
                                                || '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]' , const.get_query_xml_namespace) ) )
             WHERE query_id = p_query_id
           ) loop
           
           
             for cparam in (
               select * from table( dts.get_concept_children( 32771, 'Code in Source', param.val , 'HasPart', 0 ) )             
             ) loop

               v_translated_value := dts.GET_TRANSLATED_CONCEPT_VALUE( const.get_further_ontylog_nmspc_id, 'Code in Source', cparam.property_val , const.get_uuedw_namespace_id , 'Local Code' );
               further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'VALUE TRANSLATION: ATTR="location" OLD_VAL="' || cparam.property_val || '" NEW_VAL="' || v_translated_value || '"',1);
                   
               v_new_location := v_new_location || '<parameter xsi:type="xs:integer">' || v_translated_value || '</parameter>';
             
             end loop;
           
           end loop;
  
           v_new_location := v_new_location ||  '</parameters></criteria>';
           
           --further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'UPDATE LOCATION criteria element to: ' || v_new_location,1);

           update query_temp q
           set q.query_xml = updatexml( 
               q.query_xml
             , '//parameter[text()="' || cc.v_alias || '.location"]/../..'
             , xmltype( v_new_location ), const.get_query_xml_namespace)
           where q.query_id = p_query_id
             and q.namespace_id = const.get_uuedw_namespace_id;       
  
         else

           -- update attr 
           update query_temp q
           set q.query_xml = updatexml( 
               q.query_xml
             , '//parameter[text()="' || cc.v_alias || '.location"]/text()'
             , v_attr_update, const.get_query_xml_namespace)
           where q.query_id = p_query_id
             and q.namespace_id = const.get_uuedw_namespace_id;       
  
           if sql%rowcount = 0 then 
             v_error_msg := v_error_msg || 'ATTR UPDATE ERROR: attribute="' || cc.v_alias || '.location" ';           
           end if;
         
         end if;
       
       else 
         v_error_msg := v_error_msg || 'TRANSLATION ERROR: locationType="' || v_lctn_type || '" IS NOT SUPPORTED. ';           
       end if;
     
       /* ------------------------------------- */
       /* Update attr VALUE to UUEDW attr VALUE */
       /* ------------------------------------- */
       -- get and process location value(s) from query
       if v_lctn_type <> 'Health District Group' then
       for attr in (
         SELECT extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() v_value
         FROM query_def q ,
           TABLE(xmlsequence( q.query_xml.extract('//parameters[parameter[text()="' || cc.v_alias || '.location"]] '
                                            || '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]' , const.get_query_xml_namespace) ) )
         WHERE query_id   = p_query_id
       ) loop

         -- get translated location value from DTS
         v_translated_value := dts.GET_TRANSLATED_CONCEPT_VALUE( const.get_further_ontylog_nmspc_id, 'Code in Source', attr.v_value, const.get_uuedw_namespace_id , 'Local Code' );
         further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'VALUE TRANSLATION: ATTR="location" OLD_VAL="' || attr.v_value || '" NEW_VAL="' || v_translated_value || '"',1);

         if length(v_translated_value) > 0 then
             
           -- update attr value
           update query_temp q
           set q.query_xml = updatexml( 
               q.query_xml
             , '//parameters[parameter[text()="' || v_attr_update || '"]]/parameter[text()="' || attr.v_value || '"]/@xsi:type'
             , 'xs:integer'
             , '//parameters[parameter[text()="' || v_attr_update || '"]]/parameter[text()="' || attr.v_value || '"]/text()'
             , v_translated_value, const.get_query_xml_namespace)
           where q.query_id = p_query_id
             and q.namespace_id = const.get_uuedw_namespace_id;
             
           if sql%rowcount = 0 then 
             v_error_msg := v_error_msg || 'ATTR VALUE UPDATE ERROR: attribute="' || v_attr_update || '" value="' || attr.v_value || '" ';           
           end if;

         else
           v_error_msg := v_error_msg || 'VALUE TRANSLATION ERROR: attribute="' || v_attr_update || '" value="' || attr.v_value || '" ';
         end if;

       end loop;
       
       end if;

       -- based on success of updates delete "untouched"
       delete_query_elements( const.get_uuedw_namespace_id
                            , p_query_id, '//criteria[parameters/parameter/text()="' || v_attr_update || '"' ||
                                                ' and ../criteria/parameters/parameter/text()="' || cc.v_alias || '.personLocationType"]/parameters/untouched');
            
       -- delete other location criteria - personLocationType, locationType (except namespace which is handled later) 
         
       update query_temp q
       set q.query_xml = deletexml( q.query_xml
                                  , '//criteria[parameters/parameter/text()="' || cc.v_alias || '.personLocationType" ' ||
                                            'or parameters/parameter/text()="' || cc.v_alias || '.locationType" ' ||
                                            'or parameters/parameter/text()="' || cc.v_alias || '.locationNamespaceId"]'
                                  , const.get_query_xml_namespace)
       where q.query_id = p_query_id
         and q.namespace_id = const.get_uuedw_namespace_id;
         
       -- delete aliases - the attrs are root elements ...?
       update query_temp q
       set q.query_xml = deletexml( q.query_xml
                                  , '//alias[key/text()="' || cc.v_alias || '"]'
                                  , const.get_query_xml_namespace)
       where q.query_id = p_query_id
         and q.namespace_id = const.get_uuedw_namespace_id;
            
     end if;

  end loop;      
  
  if length( v_error_msg ) > 0 then
    RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg);
  end if;
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'END',1);

END TRANS_QUERY_LCTN_UUEDW;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_OBS_IH_APO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_OBS_IH_APO" ( p_query_id number ) AS 

  v_namespace_id number;
  v_iter number;
  v_phrase_index number;
  v_value_index number;
  v_value_type varchar2(20);
  v_trans_value_index number;
  v_chunk_index number;
  v_chunk_xml xmltype;
  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  v_attr_nm varchar2(100);
  v_attr_value varchar2(100);
  v_clob clob;
  v_is_rootCriterion number;

BEGIN

  v_intro_msg := 'QUERY( IH_APO:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'BEGIN',1);
  v_iter := 0;
  v_namespace_id := const.get_ih_apo_namespace_id;
  
  -- for each alias
  for c1 in 
    (select extract(column_value, '/alias/key/text()', const.get_query_xml_namespace).getstringval() c_alias,
            extract(column_value, '/alias/value/text()', const.get_query_xml_namespace).getstringval() c_object
     from query_def q
         ,table(xmlsequence( q.query_xml.extract('//aliases/alias[value/text()="observations"]', const.get_query_xml_namespace) ) )
     where query_id = p_query_id) loop
     
     further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'ALIAS="' || c1.c_alias || '"',1);
          
     v_phrase_index := 0;
     -- for each observation phrase of this alias - extract each observation type for the given alias
     for c2 in (
         select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_obs_type_str
         from query_def q,
           table(xmlsequence
                 (q.query_xml.extract
                   ('//searchType[text()="CONJUNCTION"]/../criteria/parameters/parameter[text()="' || c1.c_alias || '.observationType"]/../parameter[3]', const.get_query_xml_namespace)
                 )
               )
         where q.query_id = p_query_id
     ) loop 

        v_iter := v_iter + 1; -- tracks total number of observation phrases
        v_phrase_index := v_phrase_index + 1;
        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'PROCESSING ' || c1.c_alias || '=' || c2.c_obs_type_str,1);
        
        v_value_index := 0; -- tracks the total number of values in an observation phrase
        v_chunk_index := 0; -- tracks the total number of translated values in an observation phrase - should be GTE v_value_index after translations
        v_clob := null;
        
        -- loop through each observation value in the IN statement and stack the new phrases 
        for c3 in (
          select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_value
          from query_def q
              ,table(xmlsequence( q.query_xml.extract('(//parameters[parameter[text()="' || c1.c_alias || '.observation' ||'"]])[' || v_phrase_index || ']' ||
                                                       '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]'
                                                      ,const.get_query_xml_namespace) ) )
          where query_id = p_query_id
        ) loop
        
          v_value_index := v_value_index + 1;
          v_trans_value_index := 0; -- tracks the number of translations for this value

          further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'PROCESSING value=' || c3.c_value || ' chunk index=' || v_chunk_index || ' value index=' || v_value_index,1);
          
          for c4 in ( -- for each translated value for this logical value
            select rs_attr_label, rs_attr_val
            from fmdr.asset_trans_map_v
            where ls_attr_id = 295
              and ls_attr_val = c3.c_value)
          loop
        
            v_trans_value_index := v_trans_value_index + 1;
            v_chunk_index := v_chunk_index + 1;
            
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'PROCESSING value=' || c3.c_value || ' translation to ' || c4.rs_attr_label || '=' || c4.rs_attr_val || ' DISJUNCTION index=' || v_chunk_index || ' trans value index=' || v_trans_value_index,1);
        
            v_attr_value := null;
            
            if c4.rs_attr_val = '{}' then -- need to fetch the value from the observation phrase
              v_attr_value := get_string_value_by_xpath( v_namespace_id, p_query_id, '(//searchType[text()="CONJUNCTION"]/../../*/criteria/parameters[parameter/text()="' || c1.c_alias || '.valueNumber"])[1]/parameter[3]/text()' ); 
            else
              v_attr_value := c4.rs_attr_val;
            end if;
            
            if is_numeric( v_attr_value ) = 1 then 
              v_value_type := 'xs:long';
            else
              v_value_type := 'xs:string';
            end if;
                    
            v_clob := v_clob ||            
'<criteria xmlns="http://further.utah.edu/core/query" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <searchType>SIMPLE</searchType>
    <parameters>
      <parameter xsi:type="RelationType">EQ</parameter>
			<parameter xsi:type="xs:string">' || c4.rs_attr_label || '</parameter>
			<parameter xsi:type="' || v_value_type || '">' || v_attr_value || '</parameter>
    </parameters>
</criteria>';

          end loop; -- for each translated value
                  
          if v_trans_value_index = 0 then
            v_error_msg := v_error_msg || 'VALUE TRANSLATION ERROR: No translation currently exists for attribute=' || c1.c_alias || '.observation value="' || c3.c_value || '" ';
            --further_pkg.log_msg($$PLSQL_UNIT,'ERROR',v_intro_msg || v_error_msg ,1);       
          end if;
        
       end loop; -- for each observation value

       if v_chunk_index > 1 then 
          
         v_clob := 
'<criteria xmlns="http://further.utah.edu/core/query" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <searchType>DISJUNCTION</searchType>' || v_clob || '</criteria>'; 
  
       end if;
       
       --further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || v_clob ,1);       

       if v_error_msg is null then  

         -- determine if parent node of the observation phase is rootCriterion or criteria
         select count(1) into v_is_rootCriterion
         from query_def q
         where query_id = p_query_id
           and q.query_xml.existsNode('(//searchType[text()="CONJUNCTION"]/../../rootCriterion[criteria/parameters/parameter/text()="' || c1.c_alias || '.observation"])[1]'
                        ,const.get_query_xml_namespace) = 1;

         if v_is_rootCriterion = 1 then

           v_clob := 
  '<rootCriterion xmlns="http://further.utah.edu/core/query" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <searchType>CONJUNCTION</searchType>' || v_clob || '</rootCriterion>'; 

           update query_temp
           set query_xml = 
                updatexml(query_xml
                           ,'(//searchType[text()="CONJUNCTION"]/../../rootCriterion[criteria/parameters/parameter/text()="' || c1.c_alias || '.observation"])[1]'
                           , xmltype(v_clob)
                           , const.get_query_xml_namespace )
           where query_id = p_query_id
             and namespace_id = const.get_ih_apo_namespace_id ;
           
         else
         
           update query_temp
           set query_xml = 
                updatexml(query_xml
                           ,'(//searchType[text()="CONJUNCTION"]/../../*[criteria/parameters/parameter/text()="' || c1.c_alias || '.observation"])[1]'
                           , xmltype(v_clob)
                           , const.get_query_xml_namespace )
           where query_id = p_query_id
             and namespace_id = const.get_ih_apo_namespace_id ;

         end if;

       end if;
       
       --insert into query_temp_chunk values( v_namespace_id, p_query_id, c1.c_alias || '.observation', v_phrase_index, v_value_index, xmltype(v_clob));

     end loop; -- for each alias observation phrase 

     delete_query_elements( v_namespace_id, p_query_id, '//alias[key/text()="' || c1.c_alias || '"]');
     
  end loop; -- for each alias      
  
  if length( v_error_msg ) > 0 then
     RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg);
  end if;
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'END',1);

END TRANS_QUERY_OBS_IH_APO;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_OBS_UPDBL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_OBS_UPDBL" ( p_query_id number ) AS 

  v_iter number;
  v_new_alias varchar2(100);
  v_new_aliased_attr varchar2(100);
  v_xpath varchar2(1000);
  v_xpath2 varchar2(1000);
  v_update varchar2(100);
  v_update2 varchar2(100);
  v_attr varchar2(100);
  v_attr_count number;
  v_icd9_attr_count number;
  v_icd10_attr_count number;
  v_updbl_attr_count number;
  v_time_attr_count number;
  v_is_trans_attr number;
  v_is_trans_attr_value number;
  v_nmspc_id number;
  v_mod_nmspc_id number;
  v_obs_attr varchar2(100);
  v_working_attr varchar2(100);
  v_translated_attr varchar2(100);
  v_translated_mod_attr varchar2(100);
  v_translated_value varchar2(100);
  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  v_obs_type_iter number;
  v_value1 varchar2(4000);
  v_value2 varchar2(4000);

BEGIN

  v_intro_msg := 'QUERY( UPDB:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'BEGIN',1);
  v_iter := 0;
  
  -- for each alias
  for c1 in 
    (select extract(column_value, '/alias/key/text()', const.get_query_xml_namespace).getstringval() c_alias,
            extract(column_value, '/alias/value/text()', const.get_query_xml_namespace).getstringval() c_object
     from query_def q
         ,table(xmlsequence( q.query_xml.extract('//aliases/alias[value/text()="observations"]', const.get_query_xml_namespace) ) )
     where query_id = p_query_id) loop
     
     v_obs_type_iter := 0;
     v_icd9_attr_count := 0;
     v_icd10_attr_count := 0;
     v_updbl_attr_count := 0;
     
     further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'ALIAS="' || c1.c_alias || '"',1);
          
     -- for each observation phrase of this alias - extract each observation type for the given alias
     for c2 in (
         select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_obs_type_str
         from query_def q,
           table(xmlsequence
                 (q.query_xml.extract
                   ('//searchType[text()="CONJUNCTION"]/../criteria/parameters/parameter[text()="' || c1.c_alias || '.observationType"]/../parameter[3]', const.get_query_xml_namespace)
                 )
               )
         where q.query_id = p_query_id
     ) loop 

        v_iter := v_iter + 1; -- tracks total number of observation phrases, not just for this alias 
        v_obs_type_iter := v_obs_type_iter + 1;    
        
        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'PROCESSING ' || c1.c_alias || '=' || c2.c_obs_type_str,1);
     
        /* ---------------------- */
        /* OBSERVATION TYPE = DX  */
        /* ---------------------- */
        if ( c2.c_obs_type_str = const.get_observation_type_dx ) then 
     
           v_nmspc_id := to_number( get_query_obs_phrase_nmspc_id( p_query_id, c1.c_alias || '.observationNamespaceId', c1.c_alias || '.observationType', 'Dx', v_obs_type_iter) ); 
           v_mod_nmspc_id := to_number( get_query_obs_phrase_nmspc_id( p_query_id, c1.c_alias || '.observationModNamespaceId', c1.c_alias || '.observationType', 'Dx', v_obs_type_iter) ); 
           v_translated_mod_attr := '';
       
           if v_nmspc_id = const.get_icd9_namespace_id then 
              v_translated_attr := 'Diagnosis.icd9Code';
              v_icd9_attr_count := v_icd9_attr_count + 1;
           elsif v_nmspc_id = const.get_icd10_namespace_id then
              v_translated_attr := 'Diagnosis.icd10Code';   
              v_icd10_attr_count := v_icd10_attr_count + 1;
           elsif v_nmspc_id = const.get_updbl_namespace_id and v_mod_nmspc_id = const.get_updbl_namespace_id then
              v_translated_attr := 'Diagnosis.icdo_seer';   
              v_translated_mod_attr := 'Diagnosis.cancerBehaviorCode';                 
              v_updbl_attr_count := v_updbl_attr_count + 1;
           else  
              v_error_msg := v_error_msg || 'Invalid namespace id "' || v_nmspc_id || '" declared for UPDB Dx. ';
              v_translated_attr := '';
           end if;
     
           if length( v_translated_attr ) > 0 then
        
              insert into query_temp_attr values ( const.get_updbl_namespace_id, p_query_id, v_translated_attr  );
           
              select count(1) into v_attr_count
              from query_temp_attr q
              where q.query_id = p_query_id 
                and q.namespace_id = const.get_updbl_namespace_id
                and q.attr_name = v_translated_attr;

              further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'ATTR UPDATE FROM ' || c1.c_alias || '.observation TO ' || v_translated_attr ,1);

              /* change <alias>.observation to Diagnosis.<new-attr> */
              update query_temp q
              set q.query_xml = updatexml( 
                q.query_xml
              , '(//parameter[text()="' || c1.c_alias || '.observation"])[1]/text()'
              , v_translated_attr, const.get_query_xml_namespace)
              where q.query_id = p_query_id
                and q.namespace_id = const.get_updbl_namespace_id;

              if length( v_translated_mod_attr ) > 0 then

                update query_temp q
                set q.query_xml = updatexml( 
                  q.query_xml
                , '(//parameter[text()="' || c1.c_alias || '.observationMod"])[1]/text()'
                , v_translated_mod_attr, const.get_query_xml_namespace)
                where q.query_id = p_query_id
                  and q.namespace_id = const.get_updbl_namespace_id;

              end if;
           
              if sql%rowcount = 0 then
                 v_error_msg := v_error_msg || 'UPDATE FROM ' || c1.c_alias || '.observation TO ' || v_translated_attr || ' FAILED. ';
              end if;

              if v_nmspc_id = const.get_icd9_namespace_id then 
                 delete_query_elements( const.get_updbl_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_translated_attr || '"])['|| v_icd9_attr_count ||']/parameters/untouched');
              elsif v_nmspc_id = const.get_icd10_namespace_id then
                 delete_query_elements( const.get_updbl_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_translated_attr || '"])['|| v_icd10_attr_count ||']/parameters/untouched');
              elsif v_nmspc_id = const.get_updbl_namespace_id then
                 delete_query_elements( const.get_updbl_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_translated_attr || '"])['|| v_updbl_attr_count ||']/parameters/untouched');
                 delete_query_elements( const.get_updbl_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_translated_mod_attr || '"])['|| v_updbl_attr_count ||']/parameters/untouched');
              end if;
         
        end if;

        -- get the first (untranslated) time value/range (previous instances are translated already)
        v_value1 := get_string_value_by_xpath( const.get_updbl_namespace_id, p_query_id, '(//parameters[parameter[text()="' || c1.c_alias || '.startDateTime"]])[1]/parameter[(position()=3 and ../../searchType/text()="SIMPLE") or (position()=2 and ../../searchType/text()!="SIMPLE")]/text()');
        v_value2 := get_string_value_by_xpath( const.get_updbl_namespace_id, p_query_id, '(//parameters[parameter[text()="' || c1.c_alias || '.startDateTime"]])[1]/parameter[position()=3 and ../../searchType/text()!="SIMPLE"]/text()');
        
        if length( v_value1 )> 0 then -- implies this observation phrase has time criterion.  
        
           --UPDBL queries do not support multiple observation aliases, they all translate to the same object alias 'Diagnosis' in this case

           insert into query_temp_attr values ( const.get_updbl_namespace_id, p_query_id, 'Diagnosis.diagYr' );
           
           select count(1) into v_time_attr_count
           from query_temp_attr q
           where q.query_id = p_query_id 
             and q.namespace_id = const.get_updbl_namespace_id
             and q.attr_name = 'Diagnosis.diagYr';
                   
           -- update the time attrribute
           update query_temp q
             set q.query_xml = updatexml( 
               q.query_xml
              , '(//parameters[parameter[text()="' || c1.c_alias || '.startDateTime"]])[1]/parameter[(position()=3 and ../../searchType/text()="SIMPLE") or (position()=2 and ../../searchType/text()!="SIMPLE")]/text()'
              , substr( v_value1, 1, 4)
              , '(//parameters[parameter[text()="' || c1.c_alias || '.startDateTime"]])[1]/parameter[position()=3 and ../../searchType/text()!="SIMPLE"]/text()'
              , substr( v_value2, 1, 4)
              , '(//parameters[parameter[text()="' || c1.c_alias || '.startDateTime"]])[1]/parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]/@xsi:type'
              , 'xs:int'
              , '(//parameter[text()="' || c1.c_alias || '.startDateTime"])[1]/text()'
              , 'Diagnosis.diagYr', const.get_query_xml_namespace)
           where q.query_id = p_query_id
             and q.namespace_id = const.get_updbl_namespace_id;
  
           -- delete untouched
           delete_query_elements( const.get_updbl_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="Diagnosis.diagYr"])['|| v_time_attr_count ||']/parameters/untouched');

        end if;
     
        /* --------------------------- */
        /* OBSERVATION TYPE Procedure  */
        /* --------------------------- */
        elsif c2.c_obs_type_str = const.get_observation_type_procedure then
           v_error_msg := v_error_msg || ' FURTHeR does not currently support Procedures for UPDBL.  Coming in a future release.';
        else 
           v_error_msg := v_error_msg || 'Observation type "' || c2.c_obs_type_str || '" is not supported in UPDBL. ';
        end if;

     end loop; -- for each alias observation phrase 

     delete_query_elements( const.get_updbl_namespace_id, p_query_id, '//criteria[parameters//parameter/text()="' || c1.c_alias || '.observationType"]');
     delete_query_elements( const.get_updbl_namespace_id, p_query_id, '//alias[key/text()="' || c1.c_alias || '"]');
     
  end loop; -- for each alias      
  
  if length( v_error_msg ) > 0 then
     RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg);
  end if;
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'END',1);

END TRANS_QUERY_OBS_UPDBL;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_OBS_UUEDW
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_OBS_UUEDW" ( p_query_id number ) AS 

  v_iter number;
  v_obs_type_iter number;
  v_alias_obs_type varchar2(100);
  v_new_alias varchar2(100);
  v_new_alias_obj varchar2(100);
  v_new_dx_alias varchar2(100);
  v_new_dx_alias_obj varchar2(100);
  v_new_lab_alias varchar2(100);
  v_new_lab_alias_obj varchar2(100);
  v_new_aliased_attr varchar2(100);
  v_xpath varchar2(1000);
  v_xpath2 varchar2(1000);
  v_update varchar2(100);
  v_update2 varchar2(100);
  v_attr varchar2(100);
  v_is_trans_attr number;
  v_is_trans_attr_value number;
  v_is_trans_attr_type number;
  v_date_value varchar2(100);
  v_value varchar2(100);
  v_type varchar2(100);
  v_translated_attr varchar2(100);
  v_working_attr varchar2(100);
  v_translated_value varchar2(100);
  v_src_nmspc_id number;
  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  v_from_obj_id number;
  v_to_obj_id number;
  v_dx_nmspc_id number;
  v_alias_lab_iter number;
  v_alias_dx_iter number;
  v_attr_count number;
  v_date_value1 varchar2(50);
  v_new_aliased_time_attr varchar2(100);

BEGIN

   v_intro_msg := 'QUERY( UUEDW:' || p_query_id || ') ';
   further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'BEGIN',1);
   v_iter := 0;
  
   -- for each observation alias
   for c1 in 
    (select extract(column_value, '/alias/key/text()', const.get_query_xml_namespace).getstringval() c_alias,
            extract(column_value, '/alias/value/text()', const.get_query_xml_namespace).getstringval() c_object
     from query_def q
         ,table(xmlsequence( q.query_xml.extract('//aliases/alias[value/text()="observations"]', const.get_query_xml_namespace) ) )
     where query_id = p_query_id) loop
     
      v_obs_type_iter := 0;
      v_alias_dx_iter := 0;
      v_alias_lab_iter := 0;
      v_iter := v_iter + 1;     
      v_new_dx_alias := 'dx' || v_iter;
      v_new_dx_alias_obj := 'diagnoses';
      v_new_lab_alias := 'lb' || v_iter;
      v_new_lab_alias_obj := 'labObservations';
      
      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'START TRANSLATION ALIAS=' || c1.c_alias || ' OBJECT=' || c1.c_object,1);

      -- for each observation phrase of this alias - extract each observation type for the given alias
      for c2 in (
          select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_obs_type_str
          from query_def q,
            table(xmlsequence
                  (q.query_xml.extract
                    ('//searchType[text()="CONJUNCTION"]/../criteria/parameters/parameter[text()="' || c1.c_alias || '.observationType"]/../parameter[3]', const.get_query_xml_namespace)
                  )
                )
          where q.query_id = p_query_id
      ) loop 
       
         v_xpath := null;
         v_xpath2 := null;
         v_update := null;
         v_update2 := null;
         
         v_obs_type_iter := v_obs_type_iter + 1;
         further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'PROCESSING OBSERVATION PHRASE ' || c1.c_alias || '.observationType[' || v_obs_type_iter || ']=' || c2.c_obs_type_str ,1);

         /* ----------------------------------- */
         /* OBSERVATION TYPE = DX OR PROCEDURE  */
         /* ----------------------------------- */
         if ( c2.c_obs_type_str in (const.get_observation_type_dx, const.get_observation_type_procedure) ) then 
        
            v_new_alias := v_new_dx_alias;
            v_new_alias_obj := v_new_dx_alias_obj;
            v_update := v_new_alias || '.id.codeType';
            v_alias_dx_iter := v_alias_dx_iter + 1;
            v_new_aliased_time_attr := v_new_alias || '.admYear'; 

            select q.query_xml.extract( '(//criteria/parameters[parameter/text()="'|| c1.c_alias ||'.observationNamespaceId"])['|| v_obs_type_iter ||']/parameter[3]/text()'
                                      ,const.get_query_xml_namespace ).getnumberval()
            into v_dx_nmspc_id
            from query_def q
            where q.query_id = p_query_id;

            if ( c2.c_obs_type_str = const.get_observation_type_dx ) then 

               -- check to see that the Dx namespace is ICD9 (namespace_id=10), if not set error message.
               if ( v_dx_nmspc_id <> const.get_icd9_namespace_id) then 
                  v_error_msg := v_error_msg || 'UUEDW does not support diagnosis codes from namespace "' || v_dx_nmspc_id || '" ';
               end if;
             
               v_xpath := '(//criteria[parameters//parameter/text()="' || c1.c_alias || '.observationType" ' ||
                            ' and parameters//parameter/text()="Dx"])[1]' || -- in query_temp the updated index is always 1 (previous instances have been translated) 
                             '/parameters/parameter[text()="' || c1.c_alias || '.observationType"]/text()';
               v_xpath2 := '(//criteria[parameters//parameter/text()="' || v_update || '"' ||
                             ' and parameters//parameter/text()="Dx"])[1]/parameters/parameter[text()="Dx"]/text()';
    
               v_update2 := 'ICD9';
           
            elsif ( c2.c_obs_type_str = const.get_observation_type_procedure ) then

               -- check to see that the Dx namespace is ICD9 (namespace_id=10), if not set error message.
               if ( not v_dx_nmspc_id in ( const.get_icd9_namespace_id, const.get_cpt_namespace_id ) ) then -- not ICD9 or CPT4 
                  v_error_msg := v_error_msg || 'UUEDW does not support procedure codes from namespace ' || v_dx_nmspc_id || ' ';
               end if;

               v_xpath := '(//criteria[parameters//parameter/text()="' || c1.c_alias || '.observationType" ' ||
                          ' and parameters//parameter/text()="Procedure"])[1]' || 
                           '/parameters/parameter[text()="' || c1.c_alias || '.observationType"]/text()';
               v_xpath2 := '(//criteria[parameters//parameter/text()="' || v_update || '"' ||
                           ' and parameters//parameter/text()="Procedure"])[1]/parameters/parameter[text()="Procedure"]/text()';
  
               v_update2 := 'CPT4';

            end if;
        
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || v_new_dx_alias || '.observationNamespaceId['|| v_obs_type_iter ||']=' || v_dx_nmspc_id ,1);
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'XPath update "' || v_xpath || '"=' || v_update, 1);
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'XPath2 update "' || v_xpath2 || '"=' || v_update2, 1);

            /* change this observation phrase's observationType=Dx to dianosiscodeType=ICD9 */
            update query_temp q
               set q.query_xml = updatexml( q.query_xml
                                    , v_xpath, v_update
                                    , v_xpath2, v_update2
                                    , const.get_query_xml_namespace)
            where q.query_id = p_query_id
              and q.namespace_id = const.get_uuedw_namespace_id;
           
            delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_update ||'"])['|| v_alias_dx_iter ||']/parameters/untouched');
            delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_update2 ||'"])['|| v_alias_dx_iter ||']/parameters/untouched');
         
            /* change observation to dx code */
            update query_temp q
            set q.query_xml = updatexml( 
              q.query_xml
             , '(//criteria/parameters/parameter[text()="' || c1.c_alias || '.observation"])[1]/text()'
             , v_new_dx_alias || '.id.code', const.get_query_xml_namespace)
            where q.query_id = p_query_id
              and q.namespace_id = const.get_uuedw_namespace_id;
           
            delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_new_dx_alias || '.id.code"])['|| v_alias_dx_iter ||']/parameters/untouched');
           
            /* change observation time */
            update query_temp q
            set q.query_xml = updatexml( 
              q.query_xml
             , '(//criteria/parameters/parameter[text()="' || c1.c_alias || '.startDateTime"])[1]/text()'
             , v_new_dx_alias || '.admYear', const.get_query_xml_namespace)
            where q.query_id = p_query_id
              and q.namespace_id = const.get_uuedw_namespace_id;

            delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_new_dx_alias || '.admYear"])['|| v_alias_dx_iter ||']/parameters/untouched');

         end if;  -- procedure or dx
       
        /* ---------------------------- */
        /* OBSERVATION TYPE = LAB       */
        /* ---------------------------- */
        if ( c2.c_obs_type_str = const.get_observation_type_lab ) then 
        
           v_new_alias := v_new_lab_alias;
           v_new_alias_obj := v_new_lab_alias_obj;
           v_alias_lab_iter := v_alias_lab_iter + 1;
           v_new_aliased_time_attr := v_new_alias || '.observationDtTm'; 
            
           -- loop through all lab-related attributes with this alias
           for c3 in (
              select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_aliased_attr
              from query_def q
                  ,table(xmlsequence( q.query_xml.extract('(//*[searchType="CONJUNCTION" and criteria/parameters/parameter[text()="'|| c1.c_alias ||'.observationType"]/../parameter/text()="Lab"])[' || v_alias_lab_iter || ']/criteria/parameters/parameter[ora:contains(text(),"' || c1.c_alias || '.")>0]', const.get_query_xml_namespace) ) )
              where query_id = p_query_id
           ) loop
       
              v_attr := get_attr_name_from_obj_attr( c3.c_aliased_attr );
              v_working_attr := c3.c_aliased_attr;
              
              v_is_trans_attr := is_trans_attr( const.get_analytical_obs_class_id, const.get_uuedw_lab_obs_class_id, v_attr );
              v_is_trans_attr_value := is_trans_attr_value( p_query_id, const.get_analytical_obs_class_id, const.get_uuedw_lab_obs_class_id, v_attr );
              v_is_trans_attr_type := is_trans_attr_data_type( const.get_analytical_obs_class_id, const.get_uuedw_lab_obs_class_id, v_attr );

              further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'BEGIN TRANSLATION ATTR=' || v_attr || ': TRANSLATE ATTR=' 
                || v_is_trans_attr || ' VALUE=' || v_is_trans_attr_value || ' TYPE=' || v_is_trans_attr_type  ,1);

         
              if v_is_trans_attr = 1 then

                 v_translated_attr := get_translated_attribute( const.get_analytical_obs_class_id, const.get_uuedw_lab_obs_class_id, v_attr );
                 v_new_aliased_attr := v_new_lab_alias || '.' || v_translated_attr;
                 v_working_attr := v_new_aliased_attr;
         
                 v_xpath := '(//*[searchType="CONJUNCTION" and criteria/parameters/parameter[text()="'|| c1.c_alias ||'.observationType"]'
                 || '/../parameter/text()="Lab"])['|| v_alias_lab_iter ||']/criteria/parameters/parameter[text()="' || c3.c_aliased_attr || '"]/text()';

                 -- update attr name
                 update query_temp q
                 set q.query_xml = updatexml( 
                       q.query_xml
                     , v_xpath
                     , v_new_aliased_attr
                     , const.get_query_xml_namespace)
                 where q.query_id = p_query_id
                   and q.namespace_id = const.get_uuedw_namespace_id;
         
                 further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'TRASLATED ATTR "' || c3.c_aliased_attr || '" TO "' || v_new_aliased_attr || '"',1);

               end if;

               if v_is_trans_attr_value = 1 or v_is_trans_attr_type = 1 then
         
                  -- loop through the attribute value codes, translate and update codes and/or data types
                  for c4 in (
                     select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_value
                     from query_temp q
                         ,table(xmlsequence( q.query_xml.extract('(//parameters[parameter[text()="'|| v_working_attr ||'"]])[' || v_alias_lab_iter || ']' ||
                                                           '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]'
                                                          , const.get_query_xml_namespace) ) )
                     where query_id = p_query_id
                       and namespace_id = const.get_uuedw_namespace_id
                  )
                  loop
           
                     v_value := c4.c_value;
                     v_src_nmspc_id := 0;
             
                     if v_is_trans_attr_value = 1 then -- translate value/type 

                        if v_attr in ('observation') then 
                           v_src_nmspc_id := const.get_loinc_namespace_id; -- LOINC
                           v_type := 'xs:integer';
                        elsif v_attr in ('valueType') then 
                           v_src_nmspc_id := const.get_further_namespace_id; -- FURTHER
                           v_type := 'xs:string';
                        else 
                           v_src_nmspc_id := const.get_snomed_namespace_id;  -- SNOMED
                           v_type := 'xs:string';
                        end if;

                        v_translated_value := dts.GET_TRANSLATED_CONCEPT_VALUE( v_src_nmspc_id, 'Code in Source', c4.c_value, const.get_uuedw_namespace_id , 'Local Code' );
                        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'VALUE TRANSLATION: ATTR="' || v_attr || '" FROM VALUE="' || c4.c_value || '" TO VALUE="' || v_translated_value || '"',1);

                        if length(v_translated_value) > 0 then
             
                           -- update attr value and type
                           update query_temp q
                           set q.query_xml = updatexml( 
                                 q.query_xml
                              , '(//parameters[parameter[text()="' || v_working_attr || '"]])[' || v_alias_lab_iter || ']/parameter[text()="' || c4.c_value || '"]/@xsi:type'
                              , v_type
                              , '(//parameters[parameter[text()="' || v_working_attr || '"]])[' || v_alias_lab_iter || ']/parameter[text()="' || c4.c_value || '"]/text()'
                              , v_translated_value, const.get_query_xml_namespace)
                           where q.query_id = p_query_id
                             and q.namespace_id = const.get_uuedw_namespace_id;

                        else
              
                           v_error_msg := v_error_msg || 'VALUE TRANSLATION ERROR: attribute="' || v_attr || '" value="' || c4.c_value || '" ';
             
                        end if;

                     elsif v_is_trans_attr_type = 1 then -- implies only type conversion

                        v_type := get_trans_assoc_prop( const.get_analytical_obs_class_id, const.get_uuedw_lab_obs_class_id, v_attr, 'ATTR_VALUE_TRANS_TO_DATA_TYPE' );

                        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'VALUE TYPE TRANSLATION: attribute="' || v_attr || '" new type=' || v_type,1);

                        update query_temp q
                        set q.query_xml = updatexml( 
                              q.query_xml
                            , '(//parameters[parameter[text()="' || v_working_attr || '"]])[' || v_alias_lab_iter || ']/parameter[text()="' || c4.c_value || '"]/@xsi:type'
                            , v_type
                            , const.get_query_xml_namespace)
                        where q.query_id = p_query_id
                          and q.namespace_id = const.get_uuedw_namespace_id;

                     else
              
                        v_error_msg := v_error_msg || 'TRANSLATION LOGIC ERROR - should never get here.  Translating attribute="' || v_attr || '" value="' || c4.c_value || '" ';
                 
                     end if;
                  end loop; -- translate value codes loop
           
               end if; -- trans attr value or type

               /* -------------------------------
                * Remove untouched from lab criteria if no errors have been encountered (untouched tags are flags for errors)
                * -------------------------------*/
               if ( v_error_msg is null ) then 
        
                  --if ( v_is_trans_attr  = 1 and v_is_trans_attr_value  = 0 ) then
                  if ( v_is_trans_attr  = 1 ) then
        
                     further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'REMOVING(8) untouched for ATTR=' || v_new_aliased_attr,1);
                     delete_query_elements( const.get_uuedw_namespace_id
                               , p_query_id
                               ,'(//criteria[parameters/parameter[text()="' || v_new_aliased_attr || '"]])[' || v_alias_lab_iter || ']/parameters/untouched'
                               );
                                 
                  elsif ( v_is_trans_attr  = 1 and v_is_trans_attr_value  = 1 ) then
  
                     further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'REMOVING(9) untouched for ATTR=' || v_new_aliased_attr || ' VALUE=' || v_translated_value,1);
                     delete_query_elements( const.get_uuedw_namespace_id
                               , p_query_id
                               ,'(//criteria[parameters//parameter/text()="' || v_new_aliased_attr || 
                                '" and parameters//parameter/text()="' || v_translated_value || '"])['|| v_alias_lab_iter ||']/parameters/untouched'
                               );
  
                  elsif ( v_is_trans_attr  = 0 and v_is_trans_attr_value  = 0 ) then
  
                     further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'REMOVING(10) untouched for ATTR=' || v_attr || ' VALUE=' || v_value,1);
                     delete_query_elements( const.get_uuedw_namespace_id
                               , p_query_id
                               ,'(//criteria[parameters//parameter/text()="' || v_attr || '"])['|| v_alias_lab_iter ||']/parameters/untouched'
                               );
  
                  end if;
                  
                  -- May need this if there are gt 1 time variables (shouldn't happen with i2b2 implementation)
                  delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '//criteria[parameters//parameter/text()="' || v_new_aliased_time_attr ||'"]/parameters/untouched');

               else
        
                  further_pkg.log_msg($$PLSQL_UNIT,'ERROR', v_intro_msg || v_error_msg,1);      
       
               end if; -- no error msg

              further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END TRANSLATION ' || c3.c_aliased_attr,1);
           end loop; -- for each lab attr 
       end if;
       
       v_translated_attr := ''; -- reset
       v_new_aliased_attr := ''; -- reset
        
       add_query_object_alias( const.get_uuedw_namespace_id, p_query_id, c1.c_alias, v_new_alias, v_new_alias_obj );

    end loop; -- for each alias obs type loop   
        
    -- delete observation types for curret alias
    delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '//criteria[parameters/parameter/text()="' || c1.c_alias || '.observationType"]');
    
    -- delete current analytical model observation alias
    delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '//aliases/alias[key/text()="' || c1.c_alias || '"]');

  end loop; -- for each alias loop      
  
  if length( v_error_msg ) > 0 then
    RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg);
  end if;
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'END',1);

END TRANS_QUERY_OBS_UUEDW;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_ORDER_UUEDW
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_ORDER_UUEDW" ( p_query_id number ) AS 

  v_iter number;
  v_order_type_iter number;
  v_new_alias varchar2(100);
  v_translated_value varchar2(100);
  v_xpath varchar2(1000);
  v_update varchar2(100);
  
  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);


BEGIN

  v_intro_msg := 'QUERY( UUEDW:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'BEGIN',1);

  v_iter := 0;
  
  /* for each Order alias */
  for c1 in 
    (select extract(column_value, '/alias/key/text()', const.get_query_xml_namespace).getstringval() c_alias,
            extract(column_value, '/alias/value/text()', const.get_query_xml_namespace).getstringval() c_object
     from query_def q
         ,table(xmlsequence( q.query_xml.extract('//aliases/alias[value/text()="orders"]', const.get_query_xml_namespace) ) )
     where query_id = p_query_id) loop
     
     v_iter := v_iter + 1;
     v_order_type_iter := 0;
     
     for c2 in (
         select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_order_type_str
         from query_def q,
           table(xmlsequence
                 (q.query_xml.extract
                   ('//searchType[text()="CONJUNCTION"]/../criteria/parameters/parameter[text()="' || c1.c_alias || '.type"]/../parameter[3]', const.get_query_xml_namespace)
                 )
               )
         where q.query_id = p_query_id
     ) loop 
        
        -- WARNING - v_order_type_iter strategy may NOT be correct in logic below that uses this variable when new order types are added
        v_order_type_iter := v_order_type_iter + 1;
        further_pkg.log_msg($$PLSQL_UNIT, 'DEBUG', v_intro_msg || 'ALIAS: ' || c1.c_alias || '=' || c2.c_order_type_str || ' obj=' || c1.c_object, 1);
     
        /* ------------------- */
        /* ORDER TYPE MED      */
        /* ------------------- */
        if ( c2.c_order_type_str = const.get_order_type_med ) then 
     
           v_new_alias := 'medord' || v_iter;
           
           --update the time parameter for this alias (if there is one)
           update query_temp q
           set q.query_xml = updatexml( 
              q.query_xml
             , '(//criteria/parameters/parameter[text()="' || c1.c_alias || '.orderTime"])[1]/text()'
             , v_new_alias || '.startDate', const.get_query_xml_namespace)
           where q.query_id = p_query_id
             and q.namespace_id = const.get_uuedw_namespace_id;

           delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_new_alias || '.startDate"])['|| v_order_type_iter ||']/parameters/untouched');
           
      
           /* change attr orderItem to multumDCode */
           v_xpath := '(//parameter[text()="' || c1.c_alias || '.orderItem"])[1]/text()';
           v_update := v_new_alias || '.multumDCode';
                         
           further_pkg.log_msg($$PLSQL_UNIT, 'DEBUG','XPATH Update: ' || v_xpath || ' TO ' || v_update, 1);
 
           update query_temp q
           set q.query_xml = updatexml( q.query_xml
                                  , v_xpath
                                  , v_update
                                  , const.get_query_xml_namespace)
           where q.query_id = p_query_id
             and q.namespace_id = const.get_uuedw_namespace_id;
         
           for c3 in (
             select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_value
             from query_temp q
                 ,table(xmlsequence( q.query_xml.extract('(//parameters[parameter[text()="'|| v_update ||'"]])['|| v_order_type_iter ||']' || -- index may NOT be CORRECT WHEN OTHER ORDER TYPES ARE ADDED
                                                     '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]'
                                                     , const.get_query_xml_namespace) ) )
             where query_id = p_query_id
               and namespace_id = const.get_uuedw_namespace_id
           )
           loop
             
              v_translated_value := substr( c3.c_value, 4, 20 ); -- remove the "GN-" and only send the "d0000" segment

              further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'VALUE TRANSLATION: attribute="' || v_update || '" orig-value="' || c3.c_value || '" new-value="' || v_translated_value || '"',1);
             
              if length(v_translated_value) > 0 then
             
                -- update attr value
                update query_temp q
                set q.query_xml = updatexml( 
                 q.query_xml
                 , '(//parameters[parameter[text()="' || v_update || '"]])['|| v_order_type_iter ||']/parameter[text()="' || c3.c_value || '"]/text()'
                 , v_translated_value, const.get_query_xml_namespace)
                where q.query_id = p_query_id
                  and q.namespace_id = const.get_uuedw_namespace_id;

              else
              
                v_error_msg := v_error_msg || 'VALUE TRANSLATION ERROR: attribute="' || v_update || '" value="' || c3.c_value || '" ';
             
              end if;
             
           end loop; -- value codes loop

           delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_update ||'"])['|| v_order_type_iter ||']/parameters/untouched');
              
        end if; -- is a medication order type
        
        add_query_object_alias( const.get_uuedw_namespace_id, p_query_id, c1.c_alias, v_new_alias, 'medicationOrders' );
             
     end loop; -- for each order type alias loop

      delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '//criteria[parameters//parameter/text()="' || c1.c_alias ||'.type"]');
  
      delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '//aliases/alias[key/text()="' || c1.c_alias || '"]');
   
  end loop; -- for each alias 

  if length( v_error_msg ) > 0 then 
     RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg);
  end if;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'END',1);

END TRANS_QUERY_ORDER_UUEDW;
 

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_SUBQ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_SUBQ" (p_namespace_id number, p_query_id number ) AS 

  i number;
  xml xmltype;
  clob_val clob;
  
begin

  i := 1;

  for crs in (
    select extract( column_value, '/criteria/query/rootCriterion/*', const.get_query_xml_namespace ) subquery_criteria
    from query_temp q ,
      TABLE(xmlsequence( extract( q.query_xml, '//criteria[searchType="IN" and parameters/parameter="udistID"]', const.get_query_xml_namespace ) )) 
    where query_id = p_query_id
      and namespace_id = p_namespace_id)
  loop
      
    clob_val := '<criteria xmlns="http://further.utah.edu/core/query">';
    dbms_lob.append( clob_val, crs.subquery_criteria.getclobval() );
    dbms_lob.append( clob_val, '</criteria>' );
    xml := xmltype( clob_val );
    
    update query_temp q
         set q.query_xml = insertXmlAfter( 
             q.query_xml
           , '//criteria[searchType="IN" and parameters/parameter="udistID"][' || i || ']'
           , xml, const.get_query_xml_namespace)
    where q.query_id = p_query_id
      and q.namespace_id = p_namespace_id;
      
    i := i + 1;
    
  end loop;
  
  update query_temp q
         set q.query_xml = deleteXml( 
             q.query_xml
           , '//criteria[searchType="IN" and parameters/parameter="udistID"]'
           , const.get_query_xml_namespace)
    where q.query_id = p_query_id
      and q.namespace_id = p_namespace_id;
  
END TRANS_QUERY_SUBQ;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_UPDBL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_UPDBL" ( p_query_id number ) AS

  v_trgt_attr varchar2(100);
  v_trnsltn_func varchar2(100);
  v_value_set_nmspc varchar2(100);
  v_nmspc_id number;
  v_trgt_value varchar2(100);
  v_translated_attr varchar2(100);
  v_translated_value varchar2(100);
  v_new_aliased_attr varchar2(100);
  v_xpath varchar2(1000);
  v_xpath2 varchar2(1000);

  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  
BEGIN

  v_intro_msg := 'QUERY( UPDBL:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  prepare_new_query( const.get_updbl_namespace_id, p_query_id );
  
  /* --------------------------------------------- */
  /* Translate person - root attributes (no alias) */
  /* --------------------------------------------- */
  
  TRANS_QUERY_DEMOG_UPDBL( p_query_id );
  
  /* ----------------------- */
  /* Translate locations     */
  /* ----------------------- */
  
  TRANS_QUERY_LCTN_UPDBL( p_query_id );
  
  /* ----------------------- */
  /* Translate observations  */
  /* ----------------------- */
  
  TRANS_QUERY_OBS_UPDBL( p_query_id );
  
  /* ------------------------------ */
  /* Remove namespace attr criteria */
  /* ------------------------------ */
        
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'DELETE *NamespaceId',1);

  update query_temp q
  set q.query_xml = deleteXML( q.query_xml, '//criteria[parameters/parameter[ora:contains(text(),"%NamespaceId")>0]]', const.get_query_xml_namespace )
  where query_id = p_query_id
    and namespace_id = const.get_updbl_namespace_id;

  
  if length( v_error_msg ) > 0 then
    further_pkg.log_msg($$PLSQL_UNIT, v_intro_msg || 'ERROR', v_error_msg, 1);
    RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg );
  end if;
  
  TRANS_QUERY_SUBQ(const.get_updbl_namespace_id, p_query_id );
  
  check_translated_query( const.get_updbl_namespace_id, p_query_id );
  
  /* --------------------------------------------------------------------- */
  /* Query translation done, add query to query_nmspc for Java interpreter */
  /* --------------------------------------------------------------------- */
  insert into query_nmspc 
    select query_id, const.get_updbl_namespace_id, query_xml 
    from query_temp 
    where query_id = p_query_id
      and namespace_id = const.get_updbl_namespace_id;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END',1);
    
END TRANS_QUERY_UPDBL ;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_UUEDW
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_UUEDW" ( p_query_id number ) AS

  v_trgt_attr varchar2(100);
  v_trnsltn_func varchar2(100);
  v_value_set_nmspc varchar2(100);
  v_nmspc_id number;
  v_trgt_value varchar2(100);
  v_translated_attr varchar2(100);
  v_translated_value varchar2(100);
  v_new_aliased_attr varchar2(100);

  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  
BEGIN

  v_intro_msg := 'QUERY( UUEDW:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  
  prepare_new_query( const.get_uuedw_namespace_id, p_query_id );

  /* ------------------------------------ */
  /* Translate all the observations first */
  /* ------------------------------------ */
  trans_query_obs_uuedw( p_query_id );      
      
  /* ------------------------ */
  /* Translate all the orders */
  /* ------------------------ */
  trans_query_order_uuedw( p_query_id );      
      
  /* ------------------------ */
  /* Translate locations */
  /* ------------------------ */
  trans_query_lctn_uuedw( p_query_id );      

  /* ------------------------ */
  /* Translate encounters     */
  /* ------------------------ */
  trans_query_encntr_uuedw( p_query_id );      
            
  /* --------------------------------------------- */
  /* Translate person - root attributes (no alias) */
  /* --------------------------------------------- */
  trans_query_demog_uuedw( p_query_id );      
  
  /* ---------------------- */
  /* Remove namespace attrs */
  /* ---------------------- */
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'DELETE *Namespace',1);

  update query_temp q
  set q.query_xml = deleteXML( q.query_xml, '//criteria[parameters/parameter[ora:contains(text(),"%NamespaceId")>0]]', const.get_query_xml_namespace )
  where query_id = p_query_id
    and namespace_id = const.get_uuedw_namespace_id;
  
  /* ---------------------------------------------------------------- */
  /* Check for "untouched" attributes - fail and report when detected */
  /* ---------------------------------------------------------------- */
  check_translated_query( const.get_uuedw_namespace_id, p_query_id );
  
  /* --------------------------------------------------------------------- */
  /* Query translation done, add query to query_nmspc for Java interpreter */
  /* --------------------------------------------------------------------- */
  insert into query_nmspc 
    select query_id, const.get_uuedw_namespace_id, query_xml 
    from query_temp 
    where query_id = p_query_id
      and namespace_id = const.get_uuedw_namespace_id;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END',1);
    
END TRANS_QUERY_UUEDW;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_UUEDW_APO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_UUEDW_APO" ( p_query_id number ) AS

  v_trgt_attr varchar2(100);
  v_trnsltn_func varchar2(100);
  v_value_set_nmspc varchar2(100);
  v_nmspc_id number;
  v_trgt_value varchar2(100);
  v_translated_attr varchar2(100);
  v_translated_value varchar2(100);
  v_new_aliased_attr varchar2(100);

  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  v_namespace_id number;
  
BEGIN

  v_intro_msg := 'QUERY( UUEDW_APO:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  
  v_namespace_id := const.get_uuedw_apo_namespace_id;
  
  /* ----------------------------------------------------------------------------*/
  /* No translation required - add query to query_nmspc for Java interpreter     */
  /* ----------------------------------------------------------------------------*/
  insert into query_nmspc 
    select query_id, v_namespace_id, query_xml 
    from query_def 
    where query_id = p_query_id;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END',1);
    
END TRANS_QUERY_UUEDW_APO;

/
--------------------------------------------------------
--  DDL for Procedure UPDATE_QUERY_OBJECT_ALIAS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."UPDATE_QUERY_OBJECT_ALIAS" ( p_namespace_id number, p_query_id number, p_old_alias varchar2, p_new_alias varchar2, p_new_object varchar2) AS 
BEGIN

/*
	<aliases>
		<alias>
			<key>Observation</key>
			<value>observations</value>
		</alias>
	</aliases>
  
 	<aliases>
		<alias>
			<key>dx</key>
			<value>diagnosis</value>
		</alias>
	</aliases>
*/

  update query_temp qn 
     set query_xml = updatexml( 
         query_xml,
         '//aliases/alias[key="'|| p_old_alias || '"]/key/text()', p_new_alias,        
         '//aliases/alias[key="' || p_new_alias || '"]/value/text()', p_new_object, const.get_query_xml_namespace)         
  where qn.query_id = p_query_id;
  
  delete_query_elements( p_namespace_id, p_query_id, '//alias[key/text()="' || p_new_alias || '"]/untouchedAlias');
  
END UPDATE_QUERY_OBJECT_ALIAS;
 

/
