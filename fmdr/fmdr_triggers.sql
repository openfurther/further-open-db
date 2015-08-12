--------------------------------------------------------
--  File created - Wednesday-August-12-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger INSERT_APP_LOG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "FMDR"."INSERT_APP_LOG" 
BEFORE INSERT ON APP_LOG
FOR EACH ROW
DECLARE

  LOG_ID NUMBER;

BEGIN

  SELECT APP_LOG_ID_SEQ.NEXTVAL INTO LOG_ID FROM DUAL;
  
  :NEW.APP_LOG_ID := LOG_ID;
  :NEW.APP_LOG_DTS := SYSDATE;

END;





/
ALTER TRIGGER "FMDR"."INSERT_APP_LOG" ENABLE;
