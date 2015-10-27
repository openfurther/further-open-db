
--------------------------------------------------------
--  DDL for Function CAN_QUERY_IH_APO
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.CAN_QUERY_IH_APO ( p_query_id number ) return number AS

  v_intro_msg varchar2(50);
  
BEGIN

  v_intro_msg := 'QUERY( UPDBL:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  prepare_new_query( const.get_ih_apo_namespace_id, p_query_id );
  
  /* --------------------------------------------- */
  /* Translate person - root attributes (no alias) */
  /* --------------------------------------------- */
  
  TRANS_QUERY_DEMOG_IH_APO( p_query_id );
  
  /* ----------------------- */
  /* Translate observations  */
  /* ----------------------- */
  
  TRANS_QUERY_OBS_IH_APO( p_query_id );
  
  /* ------------------------------ */
  /* Remove namespace attr criteria */
  /* ------------------------------ */
        
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'DELETE *NamespaceId',1);

  update query_temp q
  set q.query_xml = deleteXML( q.query_xml, '//criteria[parameters/parameter[ora:contains(text(),%NamespaceId)>0]]', const.get_query_xml_namespace )
  where query_id = p_query_id
    and namespace_id = const.get_ih_apo_namespace_id;
    
  TRANS_QUERY_SUBQ( const.get_ih_apo_namespace_id, p_query_id );

  check_translated_query( const.get_ih_apo_namespace_id, p_query_id );
  
  delete query_temp where query_id = p_query_id and namespace_id = const.get_ih_apo_namespace_id;
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END',1);
  
  return 1;
  
END CAN_QUERY_IH_APO;

/
--------------------------------------------------------
--  DDL for Function CAN_QUERY_UPDBL
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.CAN_QUERY_UPDBL ( p_query_id number ) return number AS

  v_intro_msg varchar2(50);
  
BEGIN

  v_intro_msg := 'QUERY( UPDBL:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  prepare_new_query( const.get_updbl_namespace_id, p_query_id );
  
  /* --------------------------------------------- */
  /* Translate person - root attributes (no alias) */
  /* --------------------------------------------- */
  
  TRANS_QUERY_DEMOG_UPDBL( p_query_id );
  
  /* ----------------------- */
  /* Translate locations     */
  /* ----------------------- */
  
  TRANS_QUERY_LCTN_UPDBL( p_query_id );
  
  /* ----------------------- */
  /* Translate observations  */
  /* ----------------------- */
  
  TRANS_QUERY_OBS_UPDBL( p_query_id );
  
  /* ------------------------------ */
  /* Remove namespace attr criteria */
  /* ------------------------------ */
        
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'DELETE *NamespaceId',1);

  update query_temp q
  set q.query_xml = deleteXML( q.query_xml, '//criteria[parameters/parameter[ora:contains(text(),%NamespaceId)>0]]', const.get_query_xml_namespace )
  where query_id = p_query_id
    and namespace_id = const.get_updbl_namespace_id;
    
  TRANS_QUERY_SUBQ( const.get_updbl_namespace_id, p_query_id );

  check_translated_query( const.get_updbl_namespace_id, p_query_id );
  
  delete query_temp where query_id = p_query_id and namespace_id = const.get_updbl_namespace_id;
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END',1);
  
  return 1;
  
END CAN_QUERY_UPDBL;

/
--------------------------------------------------------
--  DDL for Function CAN_QUERY_UUEDW
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.CAN_QUERY_UUEDW ( p_query_id number ) RETURN number AS

  v_intro_msg varchar2(50);
  
BEGIN

  v_intro_msg := 'QUERY( UUEDW:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  
  prepare_new_query( const.get_uuedw_namespace_id, p_query_id );

  /* ------------------------------------ */
  /* Translate all the observations first */
  /* ------------------------------------ */
  trans_query_obs_uuedw( p_query_id );      
      
  /* ------------------------ */
  /* Translate all the orders */
  /* ------------------------ */
  trans_query_order_uuedw( p_query_id );      
      
  /* ------------------------ */
  /* Translate locations */
  /* ------------------------ */
  trans_query_lctn_uuedw( p_query_id );      
      
  /* ------------------------ */
  /* Translate encounters */
  /* ------------------------ */
  trans_query_encntr_uuedw( p_query_id );      
      
  /* --------------------------------------------- */
  /* Translate person - root attributes (no alias) */
  /* --------------------------------------------- */
  trans_query_demog_uuedw( p_query_id );      
  
  /* ---------------------- */
  /* Remove namespace attrs */
  /* ---------------------- */
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'DELETE *Namespace',1);

  update query_temp q
  set q.query_xml = deleteXML( q.query_xml, '//criteria[parameters/parameter[ora:contains(text(),%NamespaceId)>0]]', const.get_query_xml_namespace )
  where query_id = p_query_id
    and namespace_id = const.get_uuedw_namespace_id;
  
  check_translated_query( const.get_uuedw_namespace_id, p_query_id );
  
  delete query_temp where query_id = p_query_id and namespace_id = const.get_uuedw_namespace_id;
  
  return 1;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END',1);
    
END CAN_QUERY_UUEDW;

/
--------------------------------------------------------
--  DDL for Function CAN_QUERY_UUEDW_APO
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.CAN_QUERY_UUEDW_APO ( p_query_id number ) RETURN number AS

  v_intro_msg varchar2(50);
  
BEGIN

  v_intro_msg := 'QUERY( UUEDW_APO:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
    
  return 1;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END',1);
    
END CAN_QUERY_UUEDW_APO;

/
--------------------------------------------------------
--  DDL for Function GET_ALIAS_FROM_ATTRIBUTE
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.GET_ALIAS_FROM_ATTRIBUTE ( p_attr_name varchar2) RETURN VARCHAR2 AS 
  v_alias varchar2(100);
BEGIN

  v_alias := substr(p_attr_name, 1, instr(p_attr_name, '.')-1);
  
  if const.get_debug = 1 then dbms_output.put_line( 'GET_ALIAS_FROM_ATTRIBUTE: attribute=' || p_attr_name || ' alias=' || v_alias ); end if;
  
  RETURN v_alias;
  
END GET_ALIAS_FROM_ATTRIBUTE;

/
--------------------------------------------------------
--  DDL for Function GET_ALIAS_LCTN_TYPE
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.GET_ALIAS_LCTN_TYPE ( p_query_id query_def.query_id%type, p_alias varchar2 ) RETURN VARCHAR2 AS 

  v_type_str varchar2(100);
  v_alias varchar2(100);
  v_type varchar2(100);
  
BEGIN

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG','query_id=' || p_query_id || ', alias=' || p_alias || '',1);

  select plctn_type_str, plctn_alias, plctn_type into v_type_str, v_alias, v_type from (
      select distinct
             extract(column_value, '//parameter[ora:contains(text(),personLocationType)>0]/text()', const.get_query_xml_namespace).getstringval() plctn_type_str,
             substr( extract(column_value, '//parameter[ora:contains(text(),personLocationType)>0]/text()', const.get_query_xml_namespace).getstringval()
                    ,1
                    ,instr( extract(column_value, '//parameter[ora:contains(text(),personLocationType)>0]/text()', const.get_query_xml_namespace).getstringval(),'.')-1 ) plctn_alias,
             extract(column_value, '//parameter[3]/text()', const.get_query_xml_namespace).getstringval() plctn_type
      from query_def q
          ,table(xmlsequence( q.query_xml.extract('//criteria[parameters/parameter[ora:contains(text(),personLocationType)>0]]', const.get_query_xml_namespace) ) )
      where query_id = p_query_id
  )
  where plctn_alias = p_alias;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG','RESULT Type=' || v_type_str || ', alias=' || v_alias || ', Type Value=' || v_type || ')',1);
  
  RETURN v_type;
  
END GET_ALIAS_LCTN_TYPE;

/
--------------------------------------------------------
--  DDL for Function GET_ATTR_ASSOC_PROP
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.GET_ATTR_ASSOC_PROP ( p_obj_asset_id number, p_attr_asset_label varchar2, p_prop_name varchar2 ) RETURN VARCHAR2 AS 

  v_prop_val fmdr.asset_assoc_prop.prop_val%type;

BEGIN

  select prop_val into v_prop_val
  from fmdr.asset_assoc_prop ap
  where ap.asset_assoc_id in
  (
    select asset_assoc_id
    from fmdr.asset_assoc_v
    where ls_asset_id = p_obj_asset_id
      and assoc_asset_id = 227
      and rs_asset_label = p_attr_asset_label
  )
  and prop_name = p_prop_name;

  return v_prop_val;

  exception when no_data_found then return null;

END GET_ATTR_ASSOC_PROP;

/
--------------------------------------------------------
--  DDL for Function GET_ATTR_NAME_FROM_OBJ_ATTR
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.GET_ATTR_NAME_FROM_OBJ_ATTR ( p_obj_attr varchar2) RETURN VARCHAR2 AS 
  v_attr varchar2(100);
BEGIN

  v_attr := substr(p_obj_attr, instr(p_obj_attr, '.')+1, length(p_obj_attr));

  RETURN v_attr;
  
END GET_ATTR_NAME_FROM_OBJ_ATTR;

/
--------------------------------------------------------
--  DDL for Function GET_ATTR_SEARCH_TYPE
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.GET_ATTR_SEARCH_TYPE ( p_query_id number, p_attr varchar2, p_attr_index number ) RETURN VARCHAR2 AS 

  v_search_type varchar2(50);
  
BEGIN

  select extract( q.query_xml,'(//*[parameters/parameter[text()=' || p_attr || ']])[' || p_attr_index || ']' || '/searchType/text()', const.get_query_xml_namespace).getstringval()
  into v_search_type
  from query_def q
  where query_id = p_query_id;

  return v_search_type;

END GET_ATTR_SEARCH_TYPE;

/
--------------------------------------------------------
--  DDL for Function GET_ATTR_SIMPLE_OPERATOR
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.GET_ATTR_SIMPLE_OPERATOR ( p_query_id number, p_attr varchar2, p_attr_index number ) RETURN VARCHAR2 AS 

  v_search_type varchar2(50);
  
BEGIN

  select extract( q.query_xml,'(//*[parameters/parameter[text()=' || p_attr || ']])[' || p_attr_index || ']' ||
                              '/searchType[text()=SIMPLE]/../parameters/parameter[1]/text()'
                              , const.get_query_xml_namespace).getstringval() oper
  into v_search_type
  from query_def q
  where query_id = p_query_id;

  return v_search_type;

END GET_ATTR_SIMPLE_OPERATOR;

/
--------------------------------------------------------
--  DDL for Function GET_OBJECT_BY_ALIAS
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.GET_OBJECT_BY_ALIAS ( p_alias varchar2, p_query_id number) RETURN VARCHAR2 AS 
  v_obj_nm varchar2(100);
BEGIN

  select extract( query_xml, '//aliases/alias[key='|| p_alias || ']/value/text()', const.get_query_xml_namespace).getstringval()
  into v_obj_nm
  from query_def
  where query_id = p_query_id;

  if const.get_debug = 1 then dbms_output.put_line( 'GET_OBJECT_BY_ALIAS: alias=' || p_alias || '   object=' || v_obj_nm || '   query_id=' || p_query_id ); end if;

  RETURN v_obj_nm;
  
END GET_OBJECT_BY_ALIAS;

/
--------------------------------------------------------
--  DDL for Function GET_QUERY_OBS_PHRASE_NMSPC_ID
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.GET_QUERY_OBS_PHRASE_NMSPC_ID ( p_query_id query_def.query_id%type, p_nmspc_attr varchar2,  p_attr_name varchar2, p_attr_value varchar2, p_attr_index number) RETURN NUMBER AS

  v_nmspc_id varchar2(100);
  v_intro_msg varchar2(100);
  loop_cnt number;
  v_last_val varchar2(100);
  
BEGIN

  v_intro_msg := 'QUERY( ' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'NMSPC= ' || p_nmspc_attr || ' ATTR= ' || p_attr_name || ' ATTR_VAL=' || p_attr_value, 1);
  
  select q.query_xml.extract('(//criteria[parameters//parameter/text()=' || p_attr_name || '' ||
                  ' and parameters//parameter/text()=' || p_attr_value || '])['|| p_attr_index ||']' ||
                  '/../criteria[parameters/parameter/text()=' || p_nmspc_attr || ']/parameters/parameter[3]/text()'
                  ,const.get_query_xml_namespace).getstringval() into v_nmspc_id
  from query_def q
  where q.query_id = p_query_id;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'ATTR= ' || p_attr_name || ' ATTR_VAL=' || p_attr_value || ' NMPC=' || v_nmspc_id, 1);

  RETURN to_number( v_nmspc_id );

END GET_QUERY_OBS_PHRASE_NMSPC_ID;

/
--------------------------------------------------------
--  DDL for Function GET_SIMPLE_QUERY_ATTR_VALUE
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.GET_SIMPLE_QUERY_ATTR_VALUE ( p_query_id query_def.query_id%type, p_alias varchar2, p_attr_name varchar2 ) RETURN VARCHAR2 AS 

  v_str varchar2(100);
  v_alias varchar2(100);
  v_val varchar2(100);
  
BEGIN

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG','query_id=' || p_query_id || ', ALIAS=' || p_alias || ' ATTR=' || p_attr_name,1);

  select q_str, q_alias, q_val into v_str, v_alias, v_val from (
      select distinct
             extract(column_value, '//parameter[ora:contains(text(),' || p_attr_name || ')>0]/text()', const.get_query_xml_namespace).getstringval() q_str,
             substr( extract(column_value, '//parameter[ora:contains(text(),' || p_attr_name || ')>0]/text()', const.get_query_xml_namespace).getstringval()
                    ,1
                    ,instr( extract(column_value, '//parameter[ora:contains(text(),' || p_attr_name || ')>0]/text()', const.get_query_xml_namespace).getstringval(),'.')-1 ) q_alias,
             extract(column_value, '//parameter[3]/text()', const.get_query_xml_namespace).getstringval() q_val
      from query_def q
          ,table(xmlsequence( q.query_xml.extract('//criteria[parameters/parameter[ora:contains(text(),' || p_attr_name || ')>0]]', const.get_query_xml_namespace) ) )
      where query_id = p_query_id
  )
  where q_alias = p_alias;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG','RESULT ATTR=' || v_str || ', ALIAS=' || v_alias || ', VALUE=' || v_val ,1);
  
  RETURN v_val;
  
END GET_SIMPLE_QUERY_ATTR_VALUE;

/
--------------------------------------------------------
--  DDL for Function GET_SIMPLE_QUERY_ATTR_VALUE_N
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.GET_SIMPLE_QUERY_ATTR_VALUE_N ( p_query_id query_def.query_id%type, p_alias varchar2, p_attr_name varchar2, p_attr_index number ) RETURN VARCHAR2 AS 

  v_str varchar2(100);
  v_alias varchar2(100);
  v_val varchar2(100);
  
BEGIN

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG','query_id=' || p_query_id || ', ALIAS=' || p_alias || ' ATTR=' || p_attr_name,1);

  select q.query_xml.extract('(//criteria[searchType/text()=SIMPLE and parameters/parameter[2]/text()=' || p_alias || '.' || p_attr_name || '])[' || p_attr_index || ']/parameters/parameter[3]/text()', const.get_query_xml_namespace).getstringval() into v_val
  from query_def q
  where query_id = p_query_id;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG','RESULT ATTR=' || v_str || ', ALIAS=' || v_alias || ', VALUE=' || v_val ,1);
  
  RETURN v_val;
  
END GET_SIMPLE_QUERY_ATTR_VALUE_N;

/
--------------------------------------------------------
--  DDL for Function GET_STRING_VALUE_BY_XPATH
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.GET_STRING_VALUE_BY_XPATH ( p_namespace_id number, p_query_id number, p_xpath varchar2) RETURN VARCHAR2 AS 

  v_text_val varchar2(4000);

BEGIN

  begin
    
    select q.query_xml.extract(p_xpath,const.get_query_xml_namespace).getstringval() into v_text_val 
    from query_temp q
    where q.query_id = p_query_id 
      and q.namespace_id = p_namespace_id;

  end;

  RETURN v_text_val;
END GET_STRING_VALUE_BY_XPATH;

/
--------------------------------------------------------
--  DDL for Function GET_TRANSLATED_ATTRIBUTE
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.GET_TRANSLATED_ATTRIBUTE ( p_from_obj_asset_id number, p_to_obj_asset_id number, p_from_attr_nm varchar2) RETURN VARCHAR2 AS 
  v_attr varchar2(100);
BEGIN

  select a1.rs_asset_label into v_attr
  from fmdr.asset_assoc_v a1
  where a1.assoc_asset_id = 363
    and a1.ls_asset_id in (select a2.rs_asset_id from fmdr.asset_assoc_v a2 where a2.ls_asset_id = p_from_obj_asset_id and a2.assoc_asset_id = 227)
    and a1.rs_asset_id in (select a3.rs_asset_id from fmdr.asset_assoc_v a3 where a3.ls_asset_id = p_to_obj_asset_id and a3.assoc_asset_id = 227)
    and a1.ls_asset_label = p_from_attr_nm;

  RETURN v_attr;
END GET_TRANSLATED_ATTRIBUTE;

/
--------------------------------------------------------
--  DDL for Function GET_TRANS_ASSOC_PROP
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.GET_TRANS_ASSOC_PROP ( p_from_obj_asset_id number, p_to_obj_asset_id number, p_from_attr_nm varchar2, p_prop_nm varchar2) RETURN VARCHAR2 AS 
  v_prop_val varchar2(100);
BEGIN

  select p.prop_val into v_prop_val
  from fmdr.asset_assoc_prop p
  where p.asset_assoc_id in (
   select a1.asset_assoc_id
    from fmdr.asset_assoc_v a1
    where a1.assoc_asset_id = 363
      and a1.ls_asset_id in (select a2.rs_asset_id from fmdr.asset_assoc_v a2 where a2.ls_asset_id = p_from_obj_asset_id and a2.assoc_asset_id = 227)
      and a1.rs_asset_id in (select a3.rs_asset_id from fmdr.asset_assoc_v a3 where a3.ls_asset_id = p_to_obj_asset_id   and a3.assoc_asset_id = 227)
      and a1.ls_asset_label = p_from_attr_nm
  )
    and p.prop_name = p_prop_nm;

  RETURN v_prop_val;
  
  exception when no_data_found then return null;
  
END GET_TRANS_ASSOC_PROP;

/
--------------------------------------------------------
--  DDL for Function GET_VALUE_BY_XPATH
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.GET_VALUE_BY_XPATH ( p_namespace_id number, p_query_id number, xpath varchar2) RETURN VARCHAR2 AS 
BEGIN






  RETURN NULL;
END GET_VALUE_BY_XPATH;

/
--------------------------------------------------------
--  DDL for Function IS_NUMERIC
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.IS_NUMERIC ( p_string varchar2 ) RETURN number AS

 v_number number;

BEGIN
  v_number := p_string;
  return 1;
  
  exception
    when others then
      return 0;
      
END IS_NUMERIC;

/
--------------------------------------------------------
--  DDL for Function IS_SUBQUERY
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.IS_SUBQUERY ( p_query_id number, p_attr_name varchar2 ) RETURN number AS 

  v_criteria xmltype;

BEGIN

  select q.query_xml.extract('//criteria[parameters/parameter[text()=' || p_attr_name || '] ' ||
                             'and query/rootCriterion//parameter[string-length(text())>0]]', const.get_query_xml_namespace) into v_criteria
  from query_def q
  where q.query_id = p_query_id;

  if v_criteria is null then 
    return 0;  
  end if;

  return 1;
  
  exception when no_data_found then return 0;
  
END IS_SUBQUERY;

/
--------------------------------------------------------
--  DDL for Function IS_TRANS_ATTR
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.IS_TRANS_ATTR ( p_from_obj_asset_id number, p_to_obj_asset_id number, p_from_attr_name varchar2 ) RETURN number AS 

  v_attr_trans_func fmdr.asset_assoc_prop.prop_val%type;

BEGIN

  v_attr_trans_func := get_trans_assoc_prop( p_from_obj_asset_id, p_to_obj_asset_id, p_from_attr_name, const.get_attr_trans_prop_nm );
  
  if ( v_attr_trans_func is null ) then
  
    return -1;
  
  elsif ( v_attr_trans_func = const.get_attr_trans_func ) then
  
    return 1;
    
  end if;

  return 0;
END IS_TRANS_ATTR;

/
--------------------------------------------------------
--  DDL for Function IS_TRANS_ATTR_DATA_TYPE
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.IS_TRANS_ATTR_DATA_TYPE ( p_from_obj_asset_id number, p_to_obj_asset_id number, p_from_attr_name varchar2 ) RETURN number AS 

  v_val fmdr.asset_assoc_prop.prop_val%type;

BEGIN

  v_val := get_trans_assoc_prop( p_from_obj_asset_id, p_to_obj_asset_id, p_from_attr_name, 'ATTR_VALUE_TRANS_TO_DATA_TYPE' );
  
  if ( v_val is not null ) then
  
    return 1;
  
  end if;

  return 0;
END IS_TRANS_ATTR_DATA_TYPE;

/
--------------------------------------------------------
--  DDL for Function IS_TRANS_ATTR_VALUE
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.IS_TRANS_ATTR_VALUE ( p_query_id number, p_from_obj_asset_id number, p_to_obj_asset_id number, p_from_attr_name varchar2 ) RETURN number AS 

  v_attr_trans_func fmdr.asset_assoc_prop.prop_val%type;

BEGIN

  if is_subquery( p_query_id, p_from_attr_name ) = 1 then
    return 0; 
  end if; 

  v_attr_trans_func := get_trans_assoc_prop( p_from_obj_asset_id, p_to_obj_asset_id, p_from_attr_name, const.get_attr_val_trans_prop_nm );
  
  if ( v_attr_trans_func is not null and v_attr_trans_func <> 'noTranslation' ) then 
  
    return 1;
    
  end if;

  return 0;
END IS_TRANS_ATTR_VALUE;

/
--------------------------------------------------------
--  DDL for Function IS_VALID_ATTR
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.IS_VALID_ATTR ( p_obj_asset_id number, p_attr_name varchar2 ) RETURN number AS 

  v_cnt number;
 
BEGIN

  select count(1) into v_cnt
  from fmdr.asset_assoc_v
  where ls_asset_id = p_obj_asset_id
    and assoc_asset_id = 227
    and rs_asset_label = p_attr_name;
    
  if ( v_cnt = 1 ) then 
  
    return 1;
    
  end if;

  return 0;
END IS_VALID_ATTR;

/
--------------------------------------------------------
--  DDL for Function PREPARE_ANALYTICAL_QUERY
--------------------------------------------------------

CREATE OR REPLACE FUNCTION FRTHR_FQE.PREPARE_ANALYTICAL_QUERY ( p_namespace_id number, p_query_context_id number )  RETURN number AS 

  v_query_count number;
  v_query_id number;
  v_analytical_query_uuid varchar2(255);
  v_query_context_id varchar2(255);
  v_namespace_str varchar2(100);
  v_user_id varchar2(100);
  v_query_xml_clob clob;
  v_query_xml xmltype;
  v_intro_msg varchar2(100);
  
BEGIN

  v_intro_msg := 'QUERY( ' || p_namespace_id || ':' || p_query_context_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);

  -- get the query namespace and parent id that contains analytical query data
  select qc.user_id into v_user_id
  from query_context qc
  where qc.query_id = p_query_context_id;
  --where qc.execution_id = p_query_context_uuid;

  -- get the query
  select sq.queryxml into v_query_xml_clob
  from search_query sq
  where sq.querycontext = p_query_context_id;

  v_query_id := query_id_seq.nextval;
  insert into query_def values( v_query_id, null, xmltype( v_query_xml_clob), sysdate, v_user_id, p_query_context_id );
  commit;
    
  return v_query_id;

  exception 
    when DUP_VAL_ON_INDEX then 
    select query_id into v_query_id
    from query_def qd
    where qd.query_context_id = p_query_context_id;
    
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'END',1);
    
  return v_query_id;

END PREPARE_ANALYTICAL_QUERY;

/