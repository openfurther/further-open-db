/* FURTHER MDR DDL */

/* FMDR USER */
/* 
CREATE USER FMDR IDENTIFIED BY fmdr
  DEFAULT TABLESPACE "FRTHR"
  TEMPORARY TABLESPACE "FRTHR_TMP";
*/

/* ***** TABLES ***** */

/* FMDR.ASSET */
CREATE TABLE FMDR.ASSET
(
  ASSET_ID NUMBER,
  ASSET_NAMESPACE_ASSET_ID NUMBER NOT NULL,
  ASSET_TYPE_ASSET_ID NUMBER NOT NULL,
  ASSET_LABEL VARCHAR2(500) NOT NULL,
  ASSET_ACTIVATE_DT DATE NOT NULL,
  ASSET_DEACTIVATE_DT DATE,
  ASSET_DSC VARCHAR2(4000),
  CONSTRAINT ASSET_PK PRIMARY KEY (ASSET_ID),
  CONSTRAINT ASSET_TYPE_ASSET_ID_FK 
             FOREIGN KEY (ASSET_TYPE_ASSET_ID)
             REFERENCES FMDR.ASSET (ASSET_ID),
  CONSTRAINT ASSET_NAMESPACE_ASSET_ID_FK
             FOREIGN KEY (ASSET_NAMESPACE_ASSET_ID)
             REFERENCES FMDR.ASSET (ASSET_ID)
);
COMMENT ON  TABLE FMDR.ASSET IS 'Asset Association';
COMMENT ON COLUMN FMDR.ASSET.ASSET_ID IS 'Asset ID';
COMMENT ON COLUMN FMDR.ASSET.ASSET_NAMESPACE_ASSET_ID IS 'Asset Namespace Asset ID (FK to Asset_ID)';
COMMENT ON COLUMN FMDR.ASSET.ASSET_TYPE_ASSET_ID IS 'Asset Type Asset ID (FK to Asset_ID)';
COMMENT ON COLUMN FMDR.ASSET.ASSET_LABEL IS 'Asset Label';
COMMENT ON COLUMN FMDR.ASSET.ASSET_ACTIVATE_DT IS 'Asset Activation Date';
COMMENT ON COLUMN FMDR.ASSET.ASSET_DEACTIVATE_DT IS 'Asset Deactivation Date';
COMMENT ON COLUMN FMDR.ASSET.ASSET_DSC IS 'Asset Description';


/* ASSET_ASSOC Table */
CREATE TABLE FMDR.ASSET_ASSOC
(
  ASSET_ASSOC_ID NUMBER,
  LS_ASSET_ID NUMBER NOT NULL,
  ASSOC_ASSET_ID NUMBER NOT NULL,
  RS_ASSET_ID NUMBER NOT NULL,
  ENABLED CHAR(1) DEFAULT 'Y',
  CONSTRAINT ASSET_ASSOC_PK PRIMARY KEY (ASSET_ASSOC_ID),
  CONSTRAINT LS_ASSET_ID_FK
             FOREIGN KEY (LS_ASSET_ID)
             REFERENCES FMDR.ASSET (ASSET_ID),
  CONSTRAINT ASSOC_ASSET_ID_FK
             FOREIGN KEY (ASSOC_ASSET_ID)
             REFERENCES FMDR.ASSET (ASSET_ID),
  CONSTRAINT RS_ASSET_ID_FK
             FOREIGN KEY (RS_ASSET_ID)
             REFERENCES FMDR.ASSET (ASSET_ID)
);
COMMENT ON  TABLE FMDR.ASSET_ASSOC IS 'Asset Association';
COMMENT ON COLUMN FMDR.ASSET_ASSOC.ASSET_ASSOC_ID
        IS 'Asset Association ID';
COMMENT ON COLUMN FMDR.ASSET_ASSOC.LS_ASSET_ID
        IS 'Left Side Asset ID (FK to Asset.Asset_ID)';
COMMENT ON COLUMN FMDR.ASSET_ASSOC.ASSOC_ASSET_ID
        IS 'Association Asset ID (FK to Asset.Asset_ID)';
COMMENT ON COLUMN FMDR.ASSET_ASSOC.RS_ASSET_ID
        IS 'Right Side Asset ID (FK to Asset.Asset_ID)';
COMMENT ON COLUMN FMDR.ASSET_ASSOC.ENABLED
        IS 'Enabled Flag Y or N (Default Y)';


/* ASSET_ASSOC_PROP Table */
CREATE TABLE FMDR.ASSET_ASSOC_PROP
(
  ASSET_ASSOC_PROP_ID NUMBER,
	ASSET_ASSOC_ID NUMBER,
	PROP_NAME VARCHAR2(100),
	PROP_VAL VARCHAR2(4000),
  CONSTRAINT ASSET_ASSOC_PROP_PK PRIMARY KEY (ASSET_ASSOC_PROP_ID),
  CONSTRAINT ASSET_ASSOC_ID_FK
             FOREIGN KEY (ASSET_ASSOC_ID)
             REFERENCES FMDR.ASSET_ASSOC (ASSET_ASSOC_ID)
);
COMMENT ON  TABLE FMDR.ASSET_ASSOC_PROP IS 'Asset Association Property';
COMMENT ON COLUMN FMDR.ASSET_ASSOC_PROP.ASSET_ASSOC_PROP_ID IS 'Asset Association Property ID';
COMMENT ON COLUMN FMDR.ASSET_ASSOC_PROP.ASSET_ASSOC_ID IS 'Asset Association ID from Asset_Assoc Table';
COMMENT ON COLUMN FMDR.ASSET_ASSOC_PROP.PROP_NAME IS 'Property Name';
COMMENT ON COLUMN FMDR.ASSET_ASSOC_PROP.PROP_VAL IS 'Property Value';


/* FMDR.LOOKUP_VALUE */
CREATE TABLE FMDR.LOOKUP_VALUE 
(
  LOOKUP_VALUE_ID NUMBER, 
  LOOKUP_VALUE_LABEL VARCHAR2(1000),
  LOOKUP_VALUE_ALT_ID VARCHAR2(1000),
  CODE_NAMESPACE_ID NUMBER, 
  CODE_PROPERTY_NAME VARCHAR2(50),
  CODE_PROPERTY_VALUE VARCHAR2(255),
  LOOKUP_VALUE_ORDER NUMBER,
  CONSTRAINT LOOKUP_VALUE_PK PRIMARY KEY (LOOKUP_VALUE_ID)
);
COMMENT ON  TABLE FMDR.LOOKUP_VALUE IS 'Lookup Values';
COMMENT ON COLUMN FMDR.LOOKUP_VALUE.LOOKUP_VALUE_ID
        IS 'Lookup Value ID';
COMMENT ON COLUMN FMDR.LOOKUP_VALUE.LOOKUP_VALUE_LABEL
        IS 'Lookup Value Label';
COMMENT ON COLUMN FMDR.LOOKUP_VALUE.LOOKUP_VALUE_ALT_ID
        IS 'Lookup Value Alternative ID';
COMMENT ON COLUMN FMDR.LOOKUP_VALUE.CODE_NAMESPACE_ID
        IS 'Optional Code Namespace ID';
COMMENT ON COLUMN FMDR.LOOKUP_VALUE.CODE_PROPERTY_NAME
        IS 'Optional Code Property Name';
COMMENT ON COLUMN FMDR.LOOKUP_VALUE.CODE_PROPERTY_VALUE
        IS 'Optional Code Property Value';
COMMENT ON COLUMN FMDR.LOOKUP_VALUE.LOOKUP_VALUE_ORDER
        IS 'Lookup Value Sort Order';


/* FMDR.ASSET_VERSION */
CREATE TABLE FMDR.ASSET_VERSION
(
  ASSET_VERSION_SEQ_ID NUMBER,
  ASSET_ID NUMBER NOT NULL,
  ASSET_VERSION NUMBER NOT NULL,
  ASSET_STATUS_ID NUMBER NOT NULL,
  ASSET_UPDATED_DTS DATE NOT NULL,
  ASSET_UPDATED_BY_USER_ID VARCHAR2(100),
  ASSET_UPDATE_DSC VARCHAR2(1000),
  ASSET_PROPERTIES_XML SYS.XMLTYPE,
  CONSTRAINT ASSET_VERSION_PK PRIMARY KEY (ASSET_VERSION_SEQ_ID),
  CONSTRAINT ASSET_VERSION_U1 UNIQUE (ASSET_VERSION, ASSET_ID),
  CONSTRAINT ASSET_VERSION_ASSET_ID_FK
             FOREIGN KEY (ASSET_ID)
	           REFERENCES FMDR.ASSET (ASSET_ID),
  CONSTRAINT ASSET_STATUS_ID_FK
             FOREIGN KEY (ASSET_STATUS_ID)
	           REFERENCES FMDR.LOOKUP_VALUE (LOOKUP_VALUE_ID)
);
COMMENT ON  TABLE FMDR.ASSET_VERSION IS 'Asset Version';
COMMENT ON COLUMN FMDR.ASSET_VERSION.ASSET_VERSION_SEQ_ID IS 'Asset Version Sequential ID';
COMMENT ON COLUMN FMDR.ASSET_VERSION.ASSET_ID IS 'Asset ID (FK to Asset.Asset_ID)';
COMMENT ON COLUMN FMDR.ASSET_VERSION.ASSET_VERSION IS 'Asset Version Number';
COMMENT ON COLUMN FMDR.ASSET_VERSION.ASSET_STATUS_ID 
        IS 'Asset Status (1=Active, 0=Inactive) Links to LOOKUP_VALUE.LOOKUP_VALUE_ID';
COMMENT ON COLUMN FMDR.ASSET_VERSION.ASSET_UPDATED_DTS IS 'Asset Last Updated Date and Time Stamp';
COMMENT ON COLUMN FMDR.ASSET_VERSION.ASSET_UPDATED_BY_USER_ID IS 'Asset Last Updated By User ID';
COMMENT ON COLUMN FMDR.ASSET_VERSION.ASSET_UPDATE_DSC IS 'Update Description';
COMMENT ON COLUMN FMDR.ASSET_VERSION.ASSET_PROPERTIES_XML IS 'Asset Properties in XML Format (Not In Use)';


/* FMDR.ASSET_RESOURCE_TYPE */
CREATE TABLE FMDR.ASSET_RESOURCE_TYPE
(
  ASSET_RESOURCE_TYPE_ID NUMBER,
  ASSET_RESOURCE_TYPE_DSC VARCHAR2(100),
  PARENT_RESOURCE_TYPE_ID NUMBER,
  CONSTRAINT ASSET_RESOURCE_TYPE_PK PRIMARY KEY (ASSET_RESOURCE_TYPE_ID),
  CONSTRAINT PARENT_RESOURCE_TYPE_ID_FK
             FOREIGN KEY (PARENT_RESOURCE_TYPE_ID)
	           REFERENCES FMDR.ASSET_RESOURCE_TYPE (ASSET_RESOURCE_TYPE_ID)
);
COMMENT ON  TABLE FMDR.ASSET_RESOURCE_TYPE IS 'Asset Resource Type Lookup Table';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE_TYPE.ASSET_RESOURCE_TYPE_ID
        IS 'Asset Resource Type ID';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE_TYPE.ASSET_RESOURCE_TYPE_DSC
        IS 'Asset Resource Type Description';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE_TYPE.PARENT_RESOURCE_TYPE_ID
        IS 'Self Referencing Parent Asset Resource Type ID';


/* FMDR.ASSET_RESOURCE */
CREATE TABLE FMDR.ASSET_RESOURCE
(
  ASSET_RESOURCE_ID NUMBER,
  ASSET_RESOURCE_TYPE_ID NUMBER NOT NULL,
  ASSET_VERSION_SEQ_ID NUMBER NOT NULL,
  ASSET_ID NUMBER NOT NULL,
  ASSET_VERSION NUMBER NOT NULL,
  RESOURCE_NAME VARCHAR2(255) NOT NULL,
  RESOURCE_DSC VARCHAR2(2000),
  RESOURCE_FILE_NAME VARCHAR2(255),
  STORAGE_CD VARCHAR2(20),
  MIME_TYPE VARCHAR2(100),
  RESOURCE_TEXT VARCHAR2(4000),
  RESOURCE_XML SYS.XMLTYPE ,
  RESOURCE_CLOB CLOB,
  RESOURCE_BLOB BLOB,
  RESOURCE_URL VARCHAR2(1000),
  RESOURCE_ACTIVATE_DT DATE NOT NULL,
  RESOURCE_DEACTIVATE_DT DATE,
  RELATIVE_RESOURCE_URL VARCHAR2(255),
  RESOURCE_INDEX NUMBER,
  ASSET_RESOURCE_VERSION NUMBER,
  UPDATE_DTS DATE,
  UPDATE_USER_ID NUMBER,
  CONSTRAINT ASSET_RESOURCE_PK PRIMARY KEY (ASSET_RESOURCE_ID),
  CONSTRAINT ASSET_RESOURCE_ASSET_RESO_FK1
             FOREIGN KEY (ASSET_RESOURCE_TYPE_ID)
             REFERENCES FMDR.ASSET_RESOURCE_TYPE (ASSET_RESOURCE_TYPE_ID),
  CONSTRAINT ASSET_RESOURCE_ASSET_VERS_FK1
             FOREIGN KEY (ASSET_VERSION_SEQ_ID)
             REFERENCES FMDR.ASSET_VERSION (ASSET_VERSION_SEQ_ID),
  CONSTRAINT ASSET_RESOURCE_ASSET_FK1
             FOREIGN KEY (ASSET_ID)
             REFERENCES FMDR.ASSET (ASSET_ID)
);
COMMENT ON  TABLE FMDR.ASSET_RESOURCE IS 'Asset Resource';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.ASSET_RESOURCE_ID
        IS 'Asset Resource ID';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.ASSET_RESOURCE_TYPE_ID
        IS 'Asset Resource Type ID';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.ASSET_VERSION_SEQ_ID
        IS 'Asset Version Sequence ID';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.ASSET_ID
        IS 'Asset ID';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.ASSET_VERSION
        IS 'Asset Version';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.RESOURCE_NAME
        IS 'Resource Name';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.RESOURCE_DSC
        IS 'Resource Description';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.RESOURCE_FILE_NAME
        IS 'Resource File Name';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.STORAGE_CD
        IS 'Storage Code determines which field the Resource is in.';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.MIME_TYPE
        IS 'Mime Type such as text/plain, text/xml, etc.';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.RESOURCE_TEXT
        IS 'Resource Text File Stored as VARCHAR or TEXT data type';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.RESOURCE_XML
        IS 'Resource XML File Stored as XMLTYPE';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.RESOURCE_CLOB
        IS 'Resource Text File Stored as Character Large Object (CLOB)';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.RESOURCE_BLOB
        IS 'Resource Binary File Stored as Binary Large Object (BLOB)';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.RESOURCE_URL
        IS 'Full Resource URL Stored as URL Path';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.RESOURCE_ACTIVATE_DT
        IS 'Resource Activation Date';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.RESOURCE_DEACTIVATE_DT
        IS 'Resource Deactivation Date';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.RELATIVE_RESOURCE_URL
        IS 'Short Relative Resource URL for REST Services';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.RESOURCE_INDEX
        IS 'Resource Index (Not In Use)';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.ASSET_RESOURCE_VERSION
        IS 'Asset Resource Sequenctial Version Number';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.UPDATE_DTS
        IS 'Last Updated Date Timestamp';
COMMENT ON COLUMN FMDR.ASSET_RESOURCE.UPDATE_USER_ID
        IS 'Last Updated User ID';


/* BEG Views */

/* FMDR.ASSET_ASSOC_V (Enabled Associations ONLY) */
CREATE OR REPLACE VIEW FMDR.ASSET_ASSOC_V 
AS 
SELECT aa.asset_assoc_id,
       get_asset_type_id(ls_asset_id) ls_type_asset_id,
       get_asset_type_label(ls_asset_id) ls_type_label,
       get_asset_namespace_id(ls_asset_id) ls_namespace_asset_id,
       get_asset_namespace_label(ls_asset_id) ls_namespace_label,
       ls_asset_id,
       get_asset_label(ls_asset_id) ls_asset_label,
       assoc_asset_id,
       get_asset_label(assoc_asset_id) assoc_asset_label,
       get_asset_type_id(rs_asset_id) rs_type_asset_id,
       get_asset_type_label(rs_asset_id) rs_type_label,
       get_asset_namespace_id(rs_asset_id) rs_namespace_asset_id,
       get_asset_namespace_label(rs_asset_id) rs_namespace_label,
       rs_asset_id,
       get_asset_label(rs_asset_id) rs_asset_label
  FROM asset_assoc aa
 WHERE aa.enabled = 'Y';

/* FMDR.ASSET_ASSOC_V (Enabled AND Disabled Associations) */
CREATE OR REPLACE VIEW FMDR.ASSET_ASSOC_V_ALL 
AS 
SELECT aa.asset_assoc_id,
       get_asset_type_id(ls_asset_id) ls_type_asset_id,
       get_asset_type_label(ls_asset_id) ls_type_label,
       get_asset_namespace_id(ls_asset_id) ls_namespace_asset_id,
       get_asset_namespace_label(ls_asset_id) ls_namespace_label,
       ls_asset_id,
       get_asset_label(ls_asset_id) ls_asset_label,
       assoc_asset_id,
       get_asset_label(assoc_asset_id) assoc_asset_label,
       get_asset_type_id(rs_asset_id) rs_type_asset_id,
       get_asset_type_label(rs_asset_id) rs_type_label,
       get_asset_namespace_id(rs_asset_id) rs_namespace_asset_id,
       get_asset_namespace_label(rs_asset_id) rs_namespace_label,
       rs_asset_id,
       get_asset_label(rs_asset_id) rs_asset_label,
       enabled
  FROM asset_assoc aa;


/* FMDR.ASSET_PROP_V */
CREATE OR REPLACE VIEW FMDR.ASSET_PROP_V 
AS 
SELECT av.asset_namespace_asset_id,
       av.asset_namespace_label,
       av.asset_type_asset_id,
       av.asset_type_label,
       av.asset_id,
       av.asset_label,
       av.asset_dsc,
       av.asset_activate_dt,
       av.asset_deactivate_dt,
       ap.asset_prop_id,
       ap.asset_type_prop_id,
       get_asset_label(ap.asset_type_prop_id) as asset_type_prop_label,
       ap.prop_value as asset_prop_value
  FROM asset_v av, asset_prop ap
 WHERE av.asset_id = ap.asset_id;

/* END Views */



/* Disable ALL FKs */
/*
alter table ASSET_RESOURCE disable constraint ASSET_RESOURCE_ASSET_VERS_FK1;
alter table ASSET_RESOURCE disable constraint ASSET_RESOURCE_ASSET_RESO_FK1;
alter table ASSET disable constraint ASSET_NAMESPACE_ASSET_ID_FK;
alter table ASSET disable constraint ASSET_TYPE_ASSET_ID_FK;
alter table ASSET_RESOURCE disable constraint ASSET_RESOURCE_ASSET_FK1;
alter table ASSET_VERSION disable constraint ASSET_VERSION_ASSET_ID_FK;
alter table ASSET_RESOURCE_COMMENT disable constraint ASSET_RESOURCE_COMMENT_AS_FK1;
alter table LOOKUP_GROUP_VALUE disable constraint LOOKUP_GROUP_VALUE_LOOKUP_FK2;
alter table APP_PROP disable constraint APP_PROP_LOOKUP_GROUP_FK1;
alter table LOOKUP_GROUP_VALUE disable constraint LOOKUP_GROUP_VALUE_LOOKUP_FK1;
alter table ASSET_RESOURCE_ASSOC disable constraint ASSET_RESOURCE_ASSOC_ASSO_FK1;
alter table ASSET_TYPE_RESOURCE_TYPE disable constraint ASSET_TYPE_RESOURCE_TYPE_FK2;
alter table ASSET_TYPE_RESOURCE_TYPE disable constraint ASSET_TYPE_RESOURCE_TYPE_FK1;
alter table APP_USER_PROP disable constraint APP_USER_PROP_APP_USER_FK1;
alter table APP_USER_ROLE disable constraint APP_USER_ROLE_APP_USER_FK1;
alter table APP_ROLE_PRIV disable constraint APP_ROLE_PRIV_APP_ROLE_FK1;
alter table APP_USER_ROLE disable constraint APP_USER_ROLE_APP_ROLE_FK1;
alter table APP_USER_PROP disable constraint APP_USER_PROP_APP_PROP_FK1;
alter table APP_ROLE_PRIV disable constraint APP_ROLE_PRIV_APP_PRIV_FK1;
*/

/* DROP ALL FKs */
/*
alter table ASSET_RESOURCE drop constraint ASSET_RESOURCE_ASSET_VERS_FK1;
alter table ASSET_RESOURCE_COMMENT drop constraint ASSET_RESOURCE_COMMENT_AS_FK1;
alter table LOOKUP_GROUP_VALUE drop constraint LOOKUP_GROUP_VALUE_LOOKUP_FK2;
alter table APP_PROP drop constraint APP_PROP_LOOKUP_GROUP_FK1;
alter table LOOKUP_GROUP_VALUE drop constraint LOOKUP_GROUP_VALUE_LOOKUP_FK1;
alter table ASSET_RESOURCE_ASSOC drop constraint ASSET_RESOURCE_ASSOC_ASSO_FK1;
alter table ASSET_RESOURCE drop constraint ASSET_RESOURCE_ASSET_RESO_FK1;
alter table ASSET_TYPE_RESOURCE_TYPE drop constraint ASSET_TYPE_RESOURCE_TYPE_FK2;
alter table ASSET drop constraint ASSET_NAMESPACE_ASSET_ID_FK;
alter table ASSET drop constraint ASSET_TYPE_ASSET_ID_FK;
alter table ASSET_RESOURCE drop constraint ASSET_RESOURCE_ASSET_FK1;
alter table ASSET_TYPE_RESOURCE_TYPE drop constraint ASSET_TYPE_RESOURCE_TYPE_FK1;
alter table ASSET_VERSION drop constraint ASSET_VERSION_ASSET_ID_FK;
alter table APP_USER_PROP drop constraint APP_USER_PROP_APP_USER_FK1;
alter table APP_USER_ROLE drop constraint APP_USER_ROLE_APP_USER_FK1;
alter table APP_ROLE_PRIV drop constraint APP_ROLE_PRIV_APP_ROLE_FK1;
alter table APP_USER_ROLE drop constraint APP_USER_ROLE_APP_ROLE_FK1;
alter table APP_USER_PROP drop constraint APP_USER_PROP_APP_PROP_FK1;
alter table APP_ROLE_PRIV drop constraint APP_ROLE_PRIV_APP_PRIV_FK1;
*/

/* DROP ALL TABLES */
/*
drop table APP_LOG CASCADE CONSTRAINTS;
drop table APP_PRIV CASCADE CONSTRAINTS;
drop table APP_PROP CASCADE CONSTRAINTS;
drop table APP_ROLE CASCADE CONSTRAINTS;
drop table APP_ROLE_PRIV CASCADE CONSTRAINTS;
drop table APP_USER CASCADE CONSTRAINTS;
drop table APP_USER_PROP CASCADE CONSTRAINTS;
drop table APP_USER_ROLE CASCADE CONSTRAINTS;
drop table ASSET CASCADE CONSTRAINTS;
drop table ASSET_ASSOC CASCADE CONSTRAINTS;
drop table ASSET_ASSOC_PROP CASCADE CONSTRAINTS;
drop table ASSET_PROP CASCADE CONSTRAINTS;
drop table ASSET_RESOURCE_ASSOC CASCADE CONSTRAINTS;
drop table ASSET_RESOURCE_TYPE CASCADE CONSTRAINTS;
drop table ASSET_STAT CASCADE CONSTRAINTS;
drop table ASSET_TRANS_MAP CASCADE CONSTRAINTS;
drop table ASSET_TYPE_PROP CASCADE CONSTRAINTS;
drop table ASSET_TYPE_RESOURCE_TYPE CASCADE CONSTRAINTS;
drop table ASSOCIATION CASCADE CONSTRAINTS;
drop table LOOKUP_GROUP CASCADE CONSTRAINTS;
drop table LOOKUP_GROUP_VALUE CASCADE CONSTRAINTS;
drop table LOOKUP_VALUE CASCADE CONSTRAINTS;
drop table STATS_TABLE_CELL CASCADE CONSTRAINTS;
drop table ASSET_RESOURCE CASCADE CONSTRAINTS;
drop table ASSET_RESOURCE_VERSION CASCADE CONSTRAINTS;
drop table ASSET_VERSION CASCADE CONSTRAINTS;
drop table ASSET_RESOURCE_COMMENT CASCADE CONSTRAINTS;
drop table STATS_TABLE CASCADE CONSTRAINTS;
*/