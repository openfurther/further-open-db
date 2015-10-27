
--------------------------------------------------------
--  DDL for Trigger GET_CAS_LOG_ID
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER FRTHR_FQE.GET_CAS_LOG_ID 
  BEFORE INSERT ON COM_AUDIT_TRAIL
  FOR EACH ROW
BEGIN
  SELECT CAS_LOG_ID_SEQ.nextval
    INTO :new.id
    FROM dual;
END;


/
ALTER TRIGGER FRTHR_FQE.GET_CAS_LOG_ID ENABLE;
--------------------------------------------------------
--  DDL for Function CAN_QUERY
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION FRTHR_FQE.CAN_QUERY ( p_namespace_str varchar2, p_query_context_id number ) RETURN number AS 

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