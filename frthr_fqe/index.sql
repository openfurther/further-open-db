--------------------------------------------------------
--  DDL for Index QUERY_DEF_INDEX1
--------------------------------------------------------
CREATE INDEX FRTHR_FQE.QUERY_DEF_INDEX1
    ON FRTHR_FQE.QUERY_DEF (QUERY_NM) 
;

--------------------------------------------------------
--  DDL for Index QUERY_DEF_UK1
--------------------------------------------------------
CREATE UNIQUE INDEX FRTHR_FQE.QUERY_DEF_UK1
    ON FRTHR_FQE.QUERY_DEF (QUERY_CONTEXT_ID) 
;

--------------------------------------------------------
--  DDL for Index QUERY_TEMP_ATTR_INDEX1
--------------------------------------------------------
CREATE INDEX FRTHR_FQE.QUERY_TEMP_ATTR_INDEX1
    ON FRTHR_FQE.QUERY_TEMP_ATTR (NAMESPACE_ID) 
;

--------------------------------------------------------
--  DDL for Index QUERY_TEMP_ATTR_INDEX2
--------------------------------------------------------
CREATE INDEX FRTHR_FQE.QUERY_TEMP_ATTR_INDEX2
    ON FRTHR_FQE.QUERY_TEMP_ATTR (QUERY_ID) 
;

--------------------------------------------------------
--  DDL for Index QUERY_TEMP_ATTR_INDEX3
--------------------------------------------------------
CREATE INDEX FRTHR_FQE.QUERY_TEMP_ATTR_INDEX3
    ON FRTHR_FQE.QUERY_TEMP_ATTR (ATTR_NAME) 
;
