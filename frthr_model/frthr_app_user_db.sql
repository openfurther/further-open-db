--------------------------------------------------------
--  DDL for Table APP_PRIV
--------------------------------------------------------

  CREATE TABLE APP_PRIV 
   (	APP_PRIV_ID NUMBER, 
	APP_PRIV_DSC VARCHAR2(100 BYTE)
   );
--------------------------------------------------------
--  DDL for Table APP_PROP
--------------------------------------------------------

  CREATE TABLE APP_PROP 
   (	APP_PROP_ID NUMBER, 
	PROP_NMSPC_ID NUMBER, 
	PROP_NAME VARCHAR2(100 BYTE), 
	PROP_DSC VARCHAR2(255 BYTE)
   );
--------------------------------------------------------
--  DDL for Table APP_ROLE
--------------------------------------------------------

  CREATE TABLE APP_ROLE 
   (	APP_ROLE_ID NUMBER, 
	APP_ROLE_DSC VARCHAR2(255 BYTE), 
	APP_ROLE_NAME VARCHAR2(50 BYTE)
   );
--------------------------------------------------------
--  DDL for Table APP_ROLE_PRIV
--------------------------------------------------------

  CREATE TABLE APP_ROLE_PRIV 
   (	APP_ROLE_PRIV_ID NUMBER, 
	APP_ROLE_ID NUMBER, 
	APP_PRIV_ID NUMBER, 
	OBJ_TYPE_CD VARCHAR2(50 BYTE), 
	OBJ VARCHAR2(1000 BYTE), 
	GRANTED_BY_USER_ID NUMBER, 
	CREATED_DTS DATE, 
	PARENT_APP_ROLE_PRIV_ID NUMBER
   );
--------------------------------------------------------
--  DDL for Table APP_USER
--------------------------------------------------------

  CREATE TABLE APP_USER 
   (	APP_USER_ID NUMBER, 
	FIRSTNAME VARCHAR2(50 BYTE), 
	LASTNAME VARCHAR2(50 BYTE), 
	EMAIL VARCHAR2(255 BYTE), 
	CREATE_DTS DATE, 
	CREATED_BY_USER_ID NUMBER, 
	EXPIRE_DT DATE
   );
--------------------------------------------------------
--  DDL for Table APP_USER_PROP
--------------------------------------------------------

  CREATE TABLE APP_USER_PROP 
   (	APP_USER_PROP_ID NUMBER, 
	APP_USER_ID NUMBER, 
	APP_PROP_ID NUMBER, 
	APP_PROP_VAL VARCHAR2(100 BYTE)
   );
--------------------------------------------------------
--  DDL for Table APP_USER_ROLE
--------------------------------------------------------

  CREATE TABLE APP_USER_ROLE 
   (	APP_USER_ROLE_ID NUMBER, 
	APP_ROLE_ID NUMBER, 
	APP_USER_ID NUMBER, 
	CREATED_DTS DATE, 
	EXPIRE_DT DATE
   );
--------------------------------------------------------
--  DDL for Index SYS_C00100617
--------------------------------------------------------

  CREATE UNIQUE INDEX SYS_C00100617 ON APP_PRIV (APP_PRIV_ID);
--------------------------------------------------------
--  DDL for Index SYS_C00145660
--------------------------------------------------------

  CREATE UNIQUE INDEX SYS_C00145660 ON APP_PROP (APP_PROP_ID);
--------------------------------------------------------
--  DDL for Index SYS_C00100612
--------------------------------------------------------

  CREATE UNIQUE INDEX SYS_C00100612 ON APP_ROLE (APP_ROLE_ID);
--------------------------------------------------------
--  DDL for Index APP_ROLE_PRIV_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX APP_ROLE_PRIV_PK ON APP_ROLE_PRIV (APP_ROLE_PRIV_ID);
--------------------------------------------------------
--  DDL for Index APP_ROLE_PRIV_UK1
--------------------------------------------------------

  CREATE UNIQUE INDEX APP_ROLE_PRIV_UK1 ON APP_ROLE_PRIV (APP_ROLE_ID, APP_PRIV_ID, OBJ_TYPE_CD, OBJ);
--------------------------------------------------------
--  DDL for Index SYS_C00100618
--------------------------------------------------------

  CREATE UNIQUE INDEX SYS_C00100618 ON APP_USER (APP_USER_ID);
--------------------------------------------------------
--  DDL for Index SYS_C00145661
--------------------------------------------------------

  CREATE UNIQUE INDEX SYS_C00145661 ON APP_USER_PROP (APP_USER_PROP_ID);
--------------------------------------------------------
--  DDL for Index APP_USER_PROP_UK1
--------------------------------------------------------

  CREATE UNIQUE INDEX APP_USER_PROP_UK1 ON APP_USER_PROP (APP_USER_ID, APP_PROP_ID);
--------------------------------------------------------
--  DDL for Index APP_USER_ROLE_UK1
--------------------------------------------------------

  CREATE UNIQUE INDEX APP_USER_ROLE_UK1 ON APP_USER_ROLE (APP_ROLE_ID, APP_USER_ID);
--------------------------------------------------------
--  DDL for Index SYS_C00100615
--------------------------------------------------------

  CREATE UNIQUE INDEX SYS_C00100615 ON APP_USER_ROLE (APP_USER_ROLE_ID);
--------------------------------------------------------
--  Constraints for Table APP_PRIV
--------------------------------------------------------

  ALTER TABLE APP_PRIV ADD PRIMARY KEY (APP_PRIV_ID);
--------------------------------------------------------
--  Constraints for Table APP_PROP
--------------------------------------------------------

  ALTER TABLE APP_PROP ADD PRIMARY KEY (APP_PROP_ID);
--------------------------------------------------------
--  Constraints for Table APP_ROLE
--------------------------------------------------------

  ALTER TABLE APP_ROLE ADD PRIMARY KEY (APP_ROLE_ID);
--------------------------------------------------------
--  Constraints for Table APP_ROLE_PRIV
--------------------------------------------------------

  ALTER TABLE APP_ROLE_PRIV ADD CONSTRAINT APP_ROLE_PRIV_PK PRIMARY KEY (APP_ROLE_PRIV_ID);
 
  ALTER TABLE APP_ROLE_PRIV ADD CONSTRAINT APP_ROLE_PRIV_UK1 UNIQUE (APP_ROLE_ID, APP_PRIV_ID, OBJ_TYPE_CD, OBJ);
 
  ALTER TABLE APP_ROLE_PRIV MODIFY (APP_ROLE_PRIV_ID NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table APP_USER
--------------------------------------------------------

  ALTER TABLE APP_USER ADD PRIMARY KEY (APP_USER_ID);
--------------------------------------------------------
--  Constraints for Table APP_USER_PROP
--------------------------------------------------------

  ALTER TABLE APP_USER_PROP ADD CONSTRAINT APP_USER_PROP_UK1 UNIQUE (APP_USER_ID, APP_PROP_ID);
 
  ALTER TABLE APP_USER_PROP ADD PRIMARY KEY (APP_USER_PROP_ID);
--------------------------------------------------------
--  Constraints for Table APP_USER_ROLE
--------------------------------------------------------

  ALTER TABLE APP_USER_ROLE ADD CONSTRAINT APP_USER_ROLE_UK1 UNIQUE (APP_ROLE_ID, APP_USER_ID);
 
  ALTER TABLE APP_USER_ROLE ADD PRIMARY KEY (APP_USER_ROLE_ID);



--------------------------------------------------------
--  Ref Constraints for Table APP_ROLE_PRIV
--------------------------------------------------------

  ALTER TABLE APP_ROLE_PRIV ADD CONSTRAINT APP_ROLE_PRIV_APP_PRIV_FK1 FOREIGN KEY (APP_PRIV_ID)
	  REFERENCES APP_PRIV (APP_PRIV_ID) ENABLE;
 
  ALTER TABLE APP_ROLE_PRIV ADD CONSTRAINT APP_ROLE_PRIV_APP_ROLE_FK1 FOREIGN KEY (APP_ROLE_ID)
	  REFERENCES APP_ROLE (APP_ROLE_ID) ENABLE;

--------------------------------------------------------
--  Ref Constraints for Table APP_USER_PROP
--------------------------------------------------------

  ALTER TABLE APP_USER_PROP ADD CONSTRAINT APP_USER_PROP_APP_PROP_FK1 FOREIGN KEY (APP_PROP_ID)
	  REFERENCES APP_PROP (APP_PROP_ID) ENABLE;
 
  ALTER TABLE APP_USER_PROP ADD CONSTRAINT APP_USER_PROP_APP_USER_FK1 FOREIGN KEY (APP_USER_ID)
	  REFERENCES APP_USER (APP_USER_ID) ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table APP_USER_ROLE
--------------------------------------------------------

  ALTER TABLE APP_USER_ROLE ADD CONSTRAINT APP_USER_ROLE_APP_ROLE_FK1 FOREIGN KEY (APP_ROLE_ID)
	  REFERENCES APP_ROLE (APP_ROLE_ID) ENABLE;
 
  ALTER TABLE APP_USER_ROLE ADD CONSTRAINT APP_USER_ROLE_APP_USER_FK1 FOREIGN KEY (APP_USER_ID)
	  REFERENCES APP_USER (APP_USER_ID) ENABLE;
