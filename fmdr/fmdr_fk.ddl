/* ***** FURTHER FMDR DDL ***** */

/* FK DDL */
-- ALTER SESSION SET CURRENT_SCHEM = FMDR;

-- ASSET
ALTER TABLE FMDR.ASSET
  ADD CONSTRAINT ASSET_NAMESPACE_ASSET_ID_FK 
  FOREIGN KEY (ASSET_NAMESPACE_ASSET_ID)
  REFERENCES FMDR.ASSET (ASSET_ID)
;

ALTER TABLE FMDR.ASSET
  ADD CONSTRAINT ASSET_TYPE_ASSET_ID_FK 
  FOREIGN KEY (ASSET_TYPE_ASSET_ID)
  REFERENCES FMDR.ASSET (ASSET_ID)
;

ALTER TABLE FMDR.ASSET
  ADD CONSTRAINT ASSET_TYPE_ASSET_ID_FK 
  FOREIGN KEY (ASSET_TYPE_ASSET_ID)
  REFERENCES FMDR.ASSET (ASSET_ID)
;

-- ASSET_PROP
ALTER TABLE FMDR.ASSET_PROP
  ADD CONSTRAINT ASSET_PROP_FK1
  FOREIGN KEY (ASSET_TYPE_PROP_ID)
  REFERENCES FMDR.ASSET (ASSET_ID)
;

ALTER TABLE FMDR.ASSET_PROP
  ADD CONSTRAINT ASSET_PROP_FK2
  FOREIGN KEY (ASSET_ID)
  REFERENCES FMDR.ASSET (ASSET_ID)
;

-- ASSET_ASSOC
ALTER TABLE FMDR.ASSET_ASSOC
  ADD CONSTRAINT LS_ASSET_ID_FK
  FOREIGN KEY (LS_ASSET_ID)
  REFERENCES FMDR.ASSET (ASSET_ID)
;

/* This is the Association Type, which is an Asset. */
ALTER TABLE FMDR.ASSET_ASSOC
  ADD CONSTRAINT ASSOC_ASSET_ID_FK
  FOREIGN KEY (ASSOC_ASSET_ID)
  REFERENCES FMDR.ASSET (ASSET_ID)
;

ALTER TABLE FMDR.ASSET_ASSOC
  ADD CONSTRAINT RS_ASSET_ID_FK
  FOREIGN KEY (RS_ASSET_ID)
  REFERENCES FMDR.ASSET (ASSET_ID)
;

-- ASSET_ASSOC_PROP
ALTER TABLE FMDR.ASSET_ASSOC_PROP
  ADD CONSTRAINT ASSET_ASSOC_ID_FK
  FOREIGN KEY (ASSET_ASSOC_ID)
  REFERENCES FMDR.ASSET_ASSOC (ASSET_ASSOC_ID)
;

-- ASSET_RESOURCE
ALTER TABLE FMDR.ASSET_RESOURCE
  ADD CONSTRAINT ASSET_RESOURCE_FK1
  FOREIGN KEY (ASSET_ID)
  REFERENCES FMDR.ASSET (ASSET_ID)
;

/* Not Needed for simple Diagram or QMDR (Quality MDR)
ALTER TABLE FMDR.ASSET_RESOURCE
  ADD CONSTRAINT ASSET_RESOURCE_FK2
  FOREIGN KEY (ASSET_RESOURCE_TYPE_ID)
  REFERENCES FMDR.ASSET_RESOURCE_TYPE (ASSET_RESOURCE_TYPE_ID)
;
 
ALTER TABLE FMDR.ASSET_RESOURCE
  ADD CONSTRAINT ASSET_RESOURCE_FK3
  FOREIGN KEY (ASSET_VERSION_SEQ_ID)
  REFERENCES FMDR.ASSET_VERSION (ASSET_VERSION_SEQ_ID)
;
*/
