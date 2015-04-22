/* This Sequence Section is Commented Out

  Sequence Object for ALL User Related (Exclude Assets) Tables
  The purpose of having this second sequence object, is so that when we add users directly into production,
  We will not mess up the Sequence Numbers for the Assets.

  Let's Assign Sequence Value Range 100,000 to 9,999,999

  DROP SEQUENCE FMDR.APP_USER_ID_SEQ;

  CREATE SEQUENCE  FMDR.APP_USER_ID_SEQ
    MINVALUE 100000 MAXVALUE 9999999
    INCREMENT BY 1 START WITH 100000
    NOCACHE ORDER NOCYCLE;

  Get Current Sequence Value without increment:
  select FMDR.APP_USER_ID_SEQ.currval from dual;

  Get Current Sequence Value and increment its value (except for the initial value):
  select FMDR.APP_USER_ID_SEQ.nextval from dual;

  To see the lastest LAST_NUMBER without incrementing the Sequence Object:
  SELECT *
    FROM user_sequences
   where sequence_name = 'APP_USER_ID_SEQ';

End Sequence Comment */


/* Create base tables with NO FKs first, then the Linking Tables with the FKs. */

--------------------------------------------------------
--  DDL for Table APP_PRIV
--------------------------------------------------------
CREATE TABLE FMDR.APP_PRIV
(
  APP_PRIV_ID NUMBER,
  APP_PRIV_DSC VARCHAR2(100),
  CONSTRAINT APP_PRIV_PK PRIMARY KEY (APP_PRIV_ID)
);
COMMENT ON  TABLE FMDR.APP_PRIV IS 'Application Privileges';
COMMENT ON COLUMN FMDR.APP_PRIV.APP_PRIV_ID IS 'Application Privilege ID';
COMMENT ON COLUMN FMDR.APP_PRIV.APP_PRIV_DSC IS 'Application Privilege Description';


--------------------------------------------------------
--  DDL for Table APP_ROLE
--------------------------------------------------------
CREATE TABLE FMDR.APP_ROLE
(
  APP_ROLE_ID NUMBER,
  APP_ROLE_DSC VARCHAR2(255),
  APP_ROLE_NAME VARCHAR2(50),
  CONSTRAINT APP_ROLE_PK PRIMARY KEY (APP_ROLE_ID)
);
COMMENT ON  TABLE FMDR.APP_ROLE IS 'Application End User Roles';
COMMENT ON COLUMN FMDR.APP_ROLE.APP_ROLE_ID IS 'Application Role ID';
COMMENT ON COLUMN FMDR.APP_ROLE.APP_ROLE_DSC IS 'Application Role Description';
COMMENT ON COLUMN FMDR.APP_ROLE.APP_ROLE_NAME IS 'Application Role Name';


--------------------------------------------------------
--  DDL for Table APP_PROP
--------------------------------------------------------
CREATE TABLE FMDR.APP_PROP 
(
  APP_PROP_ID NUMBER, 
  PROP_NMSPC_ID NUMBER, 
  PROP_NAME VARCHAR2(100), 
  PROP_DSC VARCHAR2(255),
  CONSTRAINT APP_PROP_PK PRIMARY KEY (APP_PROP_ID)
);
COMMENT ON  TABLE FMDR.APP_PROP IS 'Application End User Properties';
COMMENT ON COLUMN FMDR.APP_PROP.APP_PROP_ID IS 'Application Property ID';
COMMENT ON COLUMN FMDR.APP_PROP.PROP_NMSPC_ID IS 'Property DTS Namespace ID';
COMMENT ON COLUMN FMDR.APP_PROP.PROP_NAME IS 'Property Name';
COMMENT ON COLUMN FMDR.APP_PROP.PROP_DSC IS 'Property Description';


--------------------------------------------------------
--  DDL for Table APP_USER
--------------------------------------------------------
CREATE TABLE FMDR.APP_USER
(
  APP_USER_ID NUMBER,
  FIRSTNAME VARCHAR2(50),
  LASTNAME VARCHAR2(50),
  EMAIL VARCHAR2(255),
  CREATE_DTS DATE,
  CREATED_BY_USER_ID NUMBER,
  EXPIRE_DT DATE,
  CONSTRAINT APP_USER_PK PRIMARY KEY (APP_USER_ID)
);
COMMENT ON  TABLE FMDR.APP_USER IS 'Application End Users';
COMMENT ON COLUMN FMDR.APP_USER.APP_USER_ID IS 'Application End User ID';
COMMENT ON COLUMN FMDR.APP_USER.FIRSTNAME IS 'First Name';
COMMENT ON COLUMN FMDR.APP_USER.LASTNAME IS 'Last Name';
COMMENT ON COLUMN FMDR.APP_USER.EMAIL IS 'Email Address';
COMMENT ON COLUMN FMDR.APP_USER.CREATE_DTS IS 'Record Creation Date Time';
COMMENT ON COLUMN FMDR.APP_USER.CREATED_BY_USER_ID IS 'Record Created By User ID';
COMMENT ON COLUMN FMDR.APP_USER.EXPIRE_DT IS 'End User Expiration Date Time';


--------------------------------------------------------
--  DDL for Table APP_ROLE_PRIV
--------------------------------------------------------
CREATE TABLE FMDR.APP_ROLE_PRIV
(
  APP_ROLE_PRIV_ID NUMBER,
  APP_ROLE_ID NUMBER,
  APP_PRIV_ID NUMBER,
  OBJ_TYPE_CD VARCHAR2(50),
  OBJ VARCHAR2(1000),
  GRANTED_BY_USER_ID NUMBER,
  CREATED_DTS DATE,
  PARENT_APP_ROLE_PRIV_ID NUMBER,
  CONSTRAINT APP_ROLE_PRIV_PK PRIMARY KEY (APP_ROLE_PRIV_ID),
  CONSTRAINT APP_ROLE_PRIV_UK1 UNIQUE (APP_ROLE_ID, APP_PRIV_ID, OBJ_TYPE_CD, OBJ),
  CONSTRAINT APP_ROLE_PRIV_APP_PRIV_FK1
    FOREIGN KEY (APP_PRIV_ID)
    REFERENCES FMDR.APP_PRIV (APP_PRIV_ID),
  CONSTRAINT APP_ROLE_PRIV_APP_ROLE_FK1
    FOREIGN KEY (APP_ROLE_ID)
	  REFERENCES FMDR.APP_ROLE (APP_ROLE_ID),
  CONSTRAINT APP_ROLE_PRIV_FK1
    FOREIGN KEY (PARENT_APP_ROLE_PRIV_ID)
	  REFERENCES FMDR.APP_ROLE_PRIV (APP_ROLE_PRIV_ID)
);
COMMENT ON  TABLE FMDR.APP_ROLE_PRIV IS 'Application Role Privilege Linking Table';
COMMENT ON COLUMN FMDR.APP_ROLE_PRIV.APP_ROLE_PRIV_ID IS 'Role Linking Privilege ID';
COMMENT ON COLUMN FMDR.APP_ROLE_PRIV.APP_ROLE_ID IS 'Role ID';
COMMENT ON COLUMN FMDR.APP_ROLE_PRIV.APP_PRIV_ID IS 'Privilege ID';
COMMENT ON COLUMN FMDR.APP_ROLE_PRIV.OBJ_TYPE_CD IS 'Object Type Code';
COMMENT ON COLUMN FMDR.APP_ROLE_PRIV.OBJ IS 'Object or Java Class Name';
COMMENT ON COLUMN FMDR.APP_ROLE_PRIV.GRANTED_BY_USER_ID IS 'Granted By User ID';
COMMENT ON COLUMN FMDR.APP_ROLE_PRIV.CREATED_DTS IS 'Record Creation Date Time';
COMMENT ON COLUMN FMDR.APP_ROLE_PRIV.PARENT_APP_ROLE_PRIV_ID IS 'Parent Application Role Privilege ID';


--------------------------------------------------------
--  DDL for Table APP_USER_ROLE
--------------------------------------------------------
CREATE TABLE FMDR.APP_USER_ROLE 
(
  APP_USER_ROLE_ID NUMBER, 
  APP_ROLE_ID NUMBER, 
  APP_USER_ID NUMBER, 
  CREATED_DTS DATE, 
  EXPIRE_DT DATE,
  CONSTRAINT APP_USER_ROLE_PK PRIMARY KEY (APP_USER_ROLE_ID),
  CONSTRAINT APP_USER_ROLE_UK1 UNIQUE (APP_ROLE_ID, APP_USER_ID),
  CONSTRAINT APP_USER_ROLE_APP_ROLE_FK1
    FOREIGN KEY (APP_ROLE_ID)
    REFERENCES FMDR.APP_ROLE (APP_ROLE_ID),
  CONSTRAINT APP_USER_ROLE_APP_USER_FK1
    FOREIGN KEY (APP_USER_ID)
    REFERENCES FMDR.APP_USER (APP_USER_ID)
);
COMMENT ON  TABLE FMDR.APP_USER_ROLE IS 'Application End User Role Assignment';
COMMENT ON COLUMN FMDR.APP_USER_ROLE.APP_USER_ROLE_ID IS 'Application User Role ID';
COMMENT ON COLUMN FMDR.APP_USER_ROLE.APP_ROLE_ID IS 'Role ID';
COMMENT ON COLUMN FMDR.APP_USER_ROLE.APP_USER_ID IS 'User ID';
COMMENT ON COLUMN FMDR.APP_USER_ROLE.CREATED_DTS IS 'Record Creation Date Time';
COMMENT ON COLUMN FMDR.APP_USER_ROLE.EXPIRE_DT IS 'User Role Expiration Date Time';


--------------------------------------------------------
--  DDL for Table APP_USER_PROP
--------------------------------------------------------
CREATE TABLE FMDR.APP_USER_PROP
(
  APP_USER_PROP_ID NUMBER,
  APP_USER_ID NUMBER,
  APP_PROP_ID NUMBER,
  APP_PROP_VAL VARCHAR2(100),
  CONSTRAINT APP_USER_PROP_PK PRIMARY KEY (APP_USER_PROP_ID),
  CONSTRAINT APP_USER_PROP_UK1 UNIQUE (APP_USER_ID, APP_PROP_ID),
  CONSTRAINT APP_USER_PROP_APP_PROP_FK1
    FOREIGN KEY (APP_PROP_ID)
    REFERENCES FMDR.APP_PROP (APP_PROP_ID),
  CONSTRAINT APP_USER_PROP_APP_USER_FK1
    FOREIGN KEY (APP_USER_ID)
    REFERENCES FMDR.APP_USER (APP_USER_ID)
);
COMMENT ON  TABLE FMDR.APP_USER_PROP IS 'Application User Properties';
COMMENT ON COLUMN FMDR.APP_USER_PROP.APP_USER_PROP_ID IS 'Application User Property ID';
COMMENT ON COLUMN FMDR.APP_USER_PROP.APP_USER_ID IS 'User ID';
COMMENT ON COLUMN FMDR.APP_USER_PROP.APP_PROP_ID IS 'Property ID';
COMMENT ON COLUMN FMDR.APP_USER_PROP.APP_PROP_VAL IS 'Property Value';


--------------------------------------------------------
--  DDL for View APP_USER_PROP_V
--------------------------------------------------------
CREATE OR REPLACE VIEW FMDR.APP_USER_PROP_V 
AS 
select aup.app_user_prop_id as APP_USER_PROP_ID,
       au.app_user_id as APP_USER_ID,
       au.firstname || ' ' || au.lastname as USERS_NAME,
       prop_nmspc_id as PROP_NMSPC_ID,
       get_dts_namespace_label(prop_nmspc_id) as PROP_NMSPC_LABEL,
       ap.app_prop_id as APP_PROP_ID,
       ap.prop_name as PROP_NAME,
       aup.app_prop_val as APP_PROP_VAL
  from app_user_prop aup,
       app_prop ap,
       app_user au
 where aup.app_prop_id = ap.app_prop_id
   and aup.app_user_id = au.app_user_id;


/* End of DDL Script */