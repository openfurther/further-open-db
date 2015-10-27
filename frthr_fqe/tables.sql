/* Tables for FRTHR_FQE Schema */

--------------------------------------------------------
--  DDL for Table APP_LOG
--------------------------------------------------------
CREATE TABLE FRTHR_FQE.APP_LOG 
(
  APP_LOG_ID NUMBER, 
  APP_MODULE VARCHAR2(255), 
  APP_MSG_CD VARCHAR2(255), 
  APP_LOG_MSG CLOB, 
  APP_LOG_DTS DATE, 
  APP_USER_ID NUMBER
);

--------------------------------------------------------
--  DDL for Table AUDIT_LOG
--------------------------------------------------------
CREATE TABLE FRTHR_FQE.AUDIT_LOG 
(
  AUDIT_LOG_ID NUMBER(19,0), 
  AUTHORIZATION_BODY VARCHAR2(255), 
  AUTHORIZATION_DETAIL VARCHAR2(255), 
  EVENT_DTS TIMESTAMP (6), 
  EVENT_DSC CLOB, 
  EVENT_SOURCE VARCHAR2(255), 
  EVENT_STATUS_CD VARCHAR2(255), 
  EVENT_TYPE_CD VARCHAR2(255), 
  USER_ID VARCHAR2(255)
);

--------------------------------------------------------
--  DDL for Table COM_AUDIT_TRAIL
--------------------------------------------------------
CREATE TABLE FRTHR_FQE.COM_AUDIT_TRAIL 
(
  ID NUMBER(*,0), 
  AUD_USER VARCHAR2(100), 
  AUD_CLIENT_IP VARCHAR2(50), 
  AUD_SERVER_IP VARCHAR2(50), 
  AUD_RESOURCE VARCHAR2(100), 
  AUD_ACTION VARCHAR2(100), 
  APPLIC_CD VARCHAR2(5), 
  AUD_DATE TIMESTAMP (6)
);

--------------------------------------------------------
--  DDL for Table QUERY_ATTR
--------------------------------------------------------
CREATE TABLE FRTHR_FQE.QUERY_ATTR 
(
  QUERY_ATTR_ID NUMBER, 
  QUERY_ID NUMBER, 
  QUERY_ATTR VARCHAR2(100), 
  QUERY_ATTR_VALUE VARCHAR2(100)
);

--------------------------------------------------------
--  DDL for Table QUERY_CONTEXT
--------------------------------------------------------
CREATE TABLE FRTHR_FQE.QUERY_CONTEXT 
(
  QUERY_ID NUMBER(19,0), 
  DATASOURCEID VARCHAR2(255), 
  EXECUTION_ID VARCHAR2(255), 
  IS_STALE NUMBER(1,0), 
  MAXRESPONDINGDATASOURCES NUMBER(10,0), 
  MINRESPONDINGDATASOURCES NUMBER(10,0), 
  ORIGIN_ID NUMBER(19,0), 
  QUEUE_DATE TIMESTAMP (6), 
  STALE_DATE TIMESTAMP (6), 
  STATE VARCHAR2(255), 
  TARGETNAMESPACE NUMBER(19,0), 
  END_DATE TIMESTAMP (6), 
  START_DATE TIMESTAMP (6), 
  USER_ID VARCHAR2(255), 
  ASSOCIATEDRESULT NUMBER(19,0), 
  CURRENTSTATUS NUMBER(19,0), 
  PARENT NUMBER(19,0), 
  RESULTCONTEXT NUMBER(19,0), 
  QUERY_TYPE VARCHAR2(50)
);

--------------------------------------------------------
--  DDL for Table QUERY_DEF
--------------------------------------------------------
CREATE TABLE FRTHR_FQE.QUERY_DEF 
(
  QUERY_ID VARCHAR2(100), 
  QUERY_NM VARCHAR2(200), 
  QUERY_XML SYS.XMLTYPE , 
  CREATE_DTS DATE, 
  CREATED_BY_USER_ID VARCHAR2(100), 
  QUERY_CONTEXT_ID NUMBER
);

--------------------------------------------------------
--  DDL for Table QUERY_NMSPC
--------------------------------------------------------
CREATE TABLE FRTHR_FQE.QUERY_NMSPC 
(
  QUERY_ID VARCHAR2(100), 
  NAMESPACE_ID NUMBER, 
  QUERY_XML SYS.XMLTYPE 
);

--------------------------------------------------------
--  DDL for Table QUERY_TEMP
--------------------------------------------------------
CREATE TABLE FRTHR_FQE.QUERY_TEMP 
(
  QUERY_ID VARCHAR2(100), 
  NAMESPACE_ID NUMBER, 
  QUERY_XML SYS.XMLTYPE 
);

--------------------------------------------------------
--  DDL for Table QUERY_TEMP_ATTR
--------------------------------------------------------
CREATE TABLE FRTHR_FQE.QUERY_TEMP_ATTR 
(
  NAMESPACE_ID NUMBER, 
  QUERY_ID NUMBER, 
  ATTR_NAME VARCHAR2(1000)
);

--------------------------------------------------------
--  DDL for Table QUERY_TEST_ASSERTION
--------------------------------------------------------
CREATE TABLE FRTHR_FQE.QUERY_TEST_ASSERTION 
(
  QUERY_ID NUMBER, 
  NAMESPACE_ID NUMBER, 
  EXPECTED_RESULT_CD VARCHAR2(20), 
  TEST_MSG VARCHAR2(1000)
);

--------------------------------------------------------
--  DDL for Table QUERY_TEST_RESULT
--------------------------------------------------------
CREATE TABLE FRTHR_FQE.QUERY_TEST_RESULT 
(
  QUERY_ID NUMBER, 
  NAMESPACE_ID NUMBER, 
  TEST_CD VARCHAR2(20), 
  ERROR_MSG VARCHAR2(1000), 
  TEST_DTS DATE
);

--------------------------------------------------------
--  DDL for Table QUERY_TEST_SET
--------------------------------------------------------
CREATE TABLE FRTHR_FQE.QUERY_TEST_SET 
(
  QUERY_ID NUMBER, 
  QUERY_XML SYS.XMLTYPE , 
  COMMENTS VARCHAR2(1000)
);

--------------------------------------------------------
--  DDL for Table RESULT_CONTEXT
--------------------------------------------------------
CREATE TABLE FRTHR_FQE.RESULT_CONTEXT 
(
  ID NUMBER(19,0), 
  NUMRECORDS NUMBER(19,0), 
  ROOT_ENTITY_CLASS VARCHAR2(255), 
  TRANSFER_OBJ_CLASS VARCHAR2(255)
);

--------------------------------------------------------
--  DDL for Table RESULT_VIEWS
--------------------------------------------------------
CREATE TABLE FRTHR_FQE.RESULT_VIEWS 
(
  VIEW_ID NUMBER(19,0), 
  INTERSECTIONINDEX NUMBER(10,0), 
  TYPE VARCHAR2(20), 
  VALUE NUMBER(19,0), 
  QUERY_CONTEXT_ID NUMBER(19,0)
);

--------------------------------------------------------
--  DDL for Table SEARCH_QUERY
--------------------------------------------------------
CREATE TABLE FRTHR_FQE.SEARCH_QUERY 
(
  SEARCH_QUERY_ID NUMBER(19,0), 
  QID NUMBER(19,0), 
  QUERYXML CLOB, 
  QUERYCONTEXT NUMBER(19,0), 
  ROOT_OBJECT VARCHAR2(255)
);

--------------------------------------------------------
--  DDL for Table STATUS_META_DATA
--------------------------------------------------------
CREATE TABLE FRTHR_FQE.STATUS_META_DATA 
(
  ID NUMBER(19,0), 
  DATASOURCEID VARCHAR2(255), 
  DURATION NUMBER(19,0), 
  STATUS VARCHAR2(255), 
  STATUS_DATE TIMESTAMP (6), 
  QUERYCONTEXT NUMBER(19,0)
);

--------------------------------------------------------
--  DDL for Table VIRTUAL_OBJ_ID_MAP
--------------------------------------------------------
CREATE TABLE FRTHR_FQE.VIRTUAL_OBJ_ID_MAP 
(
  VIRTUAL_OBJ_ID_MAP_ID NUMBER(19,0), 
  VIRTUAL_OBJ_ATTR VARCHAR2(255), 
  FED_OBJ_ID NUMBER(19,0), 
  CREATE_DTS TIMESTAMP (6), 
  CREATED_BY_CD VARCHAR2(255), 
  DEACTIVATE_DTS TIMESTAMP (6), 
  VIRTUAL_OBJ_NAME VARCHAR2(255), 
  SRC_OBJ_ATTR VARCHAR2(255), 
  SRC_OBJ_ID VARCHAR2(255), 
  SRC_OBJ_NAME VARCHAR2(255), 
  SRC_OBJ_NMSPC_ID NUMBER(19,0), 
  VIRTUAL_OBJ_ID NUMBER(19,0)
);
