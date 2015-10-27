--------------------------------------------------------
--  Constraints for Table APP_LOG
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.APP_LOG
  ADD PRIMARY KEY (APP_LOG_ID);

--------------------------------------------------------
--  Constraints for Table AUDIT_LOG
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.AUDIT_LOG MODIFY (AUDIT_LOG_ID NOT NULL);
 
ALTER TABLE FRTHR_FQE.AUDIT_LOG
  ADD PRIMARY KEY (AUDIT_LOG_ID);

--------------------------------------------------------
--  Constraints for Table COM_AUDIT_TRAIL
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.COM_AUDIT_TRAIL
  ADD CONSTRAINT CAS_AUDIT_PK PRIMARY KEY (ID);
 
ALTER TABLE FRTHR_FQE.COM_AUDIT_TRAIL MODIFY (ID NOT NULL);
 
ALTER TABLE FRTHR_FQE.COM_AUDIT_TRAIL MODIFY (AUD_USER NOT NULL);
 
ALTER TABLE FRTHR_FQE.COM_AUDIT_TRAIL MODIFY (AUD_ACTION NOT NULL);
 
ALTER TABLE FRTHR_FQE.COM_AUDIT_TRAIL MODIFY (AUD_DATE NOT NULL);

--------------------------------------------------------
--  Constraints for Table QUERY_ATTR
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.QUERY_ATTR
  ADD PRIMARY KEY (QUERY_ATTR_ID);

--------------------------------------------------------
--  Constraints for Table QUERY_CONTEXT
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.QUERY_CONTEXT MODIFY (QUERY_ID NOT NULL);
 
ALTER TABLE FRTHR_FQE.QUERY_CONTEXT MODIFY (EXECUTION_ID NOT NULL);
 
ALTER TABLE FRTHR_FQE.QUERY_CONTEXT MODIFY (IS_STALE NOT NULL);
 
ALTER TABLE FRTHR_FQE.QUERY_CONTEXT MODIFY (MAXRESPONDINGDATASOURCES NOT NULL);
 
ALTER TABLE FRTHR_FQE.QUERY_CONTEXT MODIFY (MINRESPONDINGDATASOURCES NOT NULL);
 
ALTER TABLE FRTHR_FQE.QUERY_CONTEXT MODIFY (STALE_DATE NOT NULL);
 
ALTER TABLE FRTHR_FQE.QUERY_CONTEXT MODIFY (STATE NOT NULL);
 
ALTER TABLE FRTHR_FQE.QUERY_CONTEXT
  ADD PRIMARY KEY (QUERY_ID);

--------------------------------------------------------
--  Constraints for Table QUERY_DEF
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.QUERY_DEF
  ADD CONSTRAINT QUERY_DEF_UK1 UNIQUE (QUERY_CONTEXT_ID);
 
ALTER TABLE FRTHR_FQE.QUERY_DEF
  ADD PRIMARY KEY (QUERY_ID);

--------------------------------------------------------
--  Constraints for Table QUERY_NMSPC
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.QUERY_NMSPC
  ADD PRIMARY KEY (QUERY_ID, NAMESPACE_ID);

--------------------------------------------------------
--  Constraints for Table QUERY_TEST_ASSERTION
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.QUERY_TEST_ASSERTION
  ADD PRIMARY KEY (QUERY_ID, NAMESPACE_ID);

--------------------------------------------------------
--  Constraints for Table QUERY_TEST_SET
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.QUERY_TEST_SET
  ADD PRIMARY KEY (QUERY_ID);

--------------------------------------------------------
--  Constraints for Table RESULT_CONTEXT
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.RESULT_CONTEXT MODIFY (ID NOT NULL);
 
ALTER TABLE FRTHR_FQE.RESULT_CONTEXT
  ADD PRIMARY KEY (ID);

--------------------------------------------------------
--  Constraints for Table RESULT_VIEWS
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.RESULT_VIEWS MODIFY (VIEW_ID NOT NULL);
 
ALTER TABLE FRTHR_FQE.RESULT_VIEWS
  ADD PRIMARY KEY (VIEW_ID);

--------------------------------------------------------
--  Constraints for Table SEARCH_QUERY
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.SEARCH_QUERY MODIFY (SEARCH_QUERY_ID NOT NULL);
 
ALTER TABLE FRTHR_FQE.SEARCH_QUERY
  ADD PRIMARY KEY (SEARCH_QUERY_ID);

--------------------------------------------------------
--  Constraints for Table STATUS_META_DATA
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.STATUS_META_DATA MODIFY (ID NOT NULL);
 
ALTER TABLE FRTHR_FQE.STATUS_META_DATA
  ADD PRIMARY KEY (ID);

--------------------------------------------------------
--  Constraints for Table VIRTUAL_OBJ_ID_MAP
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.VIRTUAL_OBJ_ID_MAP MODIFY (VIRTUAL_OBJ_ID_MAP_ID NOT NULL);
 
ALTER TABLE FRTHR_FQE.VIRTUAL_OBJ_ID_MAP
  ADD PRIMARY KEY (VIRTUAL_OBJ_ID_MAP_ID);

--------------------------------------------------------
--  Ref Constraints for Table QUERY_CONTEXT
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.QUERY_CONTEXT
  ADD CONSTRAINT FK2C94AD3857702D39
  FOREIGN KEY (CURRENTSTATUS)
  REFERENCES FRTHR_FQE.STATUS_META_DATA (ID);
 
ALTER TABLE FRTHR_FQE.QUERY_CONTEXT
  ADD CONSTRAINT FK2C94AD38647CD91D
  FOREIGN KEY (RESULTCONTEXT)
  REFERENCES FRTHR_FQE.RESULT_CONTEXT (ID) ON DELETE CASCADE;
 
ALTER TABLE FRTHR_FQE.QUERY_CONTEXT
  ADD CONSTRAINT FK2C94AD387724A79E
  FOREIGN KEY (PARENT)
  REFERENCES FRTHR_FQE.QUERY_CONTEXT (QUERY_ID) ON DELETE CASCADE;
 
ALTER TABLE FRTHR_FQE.QUERY_CONTEXT
  ADD CONSTRAINT FK2C94AD38A22ADF97
  FOREIGN KEY (ASSOCIATEDRESULT)
  REFERENCES FRTHR_FQE.QUERY_CONTEXT (QUERY_ID) ON DELETE CASCADE;

--------------------------------------------------------
--  Ref Constraints for Table RESULT_VIEWS
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.RESULT_VIEWS
  ADD CONSTRAINT FK1FB8FBCC9C24B876
  FOREIGN KEY (QUERY_CONTEXT_ID)
  REFERENCES FRTHR_FQE.QUERY_CONTEXT (QUERY_ID);
 
ALTER TABLE FRTHR_FQE.RESULT_VIEWS
  ADD CONSTRAINT FK1FB8FBCCCBCEE79C
  FOREIGN KEY (VALUE)
  REFERENCES FRTHR_FQE.RESULT_CONTEXT (ID);

--------------------------------------------------------
--  Ref Constraints for Table SEARCH_QUERY
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.SEARCH_QUERY
  ADD CONSTRAINT FK1B7D0371DE01CADB
  FOREIGN KEY (QUERYCONTEXT)
  REFERENCES FRTHR_FQE.QUERY_CONTEXT (QUERY_ID) ON DELETE CASCADE;

--------------------------------------------------------
--  Ref Constraints for Table STATUS_META_DATA
--------------------------------------------------------
ALTER TABLE FRTHR_FQE.STATUS_META_DATA
  ADD CONSTRAINT FK82C59197DE01CADB
  FOREIGN KEY (QUERYCONTEXT)
  REFERENCES FRTHR_FQE.QUERY_CONTEXT (QUERY_ID) ON DELETE CASCADE;
