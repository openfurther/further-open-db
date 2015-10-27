/* Views for FRTHR_FQE Schema */

--------------------------------------------------------
--  DDL for View QUERY_V
--------------------------------------------------------
CREATE OR REPLACE VIEW FRTHR_FQE.QUERY_V
AS 
select q.query_id,
       q.query_nm,
       qn.namespace_id,
       q.query_xml analytical_query,
       qn.query_xml physical_query,
       q.create_dts exec_dts,
       q.created_by_user_id user_id
  from query_def q, query_nmspc qn
 where q.query_id = qn.query_id
;
