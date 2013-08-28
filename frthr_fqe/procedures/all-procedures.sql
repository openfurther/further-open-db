--------------------------------------------------------
--  File created - Friday-February-15-2013   
--------------------------------------------------------
--------------------------------------------------------
--  Ref Constraints for Table QUERY_CONTEXT
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."QUERY_CONTEXT" ADD CONSTRAINT "FK2C94AD3857702D39" FOREIGN KEY ("CURRENTSTATUS")
	  REFERENCES "FRTHR_FQE"."STATUS_META_DATA" ("ID") ENABLE;
 
  ALTER TABLE "FRTHR_FQE"."QUERY_CONTEXT" ADD CONSTRAINT "FK2C94AD38647CD91D" FOREIGN KEY ("RESULTCONTEXT")
	  REFERENCES "FRTHR_FQE"."RESULT_CONTEXT" ("ID") ON DELETE CASCADE ENABLE;
 
  ALTER TABLE "FRTHR_FQE"."QUERY_CONTEXT" ADD CONSTRAINT "FK2C94AD387724A79E" FOREIGN KEY ("PARENT")
	  REFERENCES "FRTHR_FQE"."QUERY_CONTEXT" ("QUERY_ID") ON DELETE CASCADE ENABLE;
 
  ALTER TABLE "FRTHR_FQE"."QUERY_CONTEXT" ADD CONSTRAINT "FK2C94AD38A22ADF97" FOREIGN KEY ("ASSOCIATEDRESULT")
	  REFERENCES "FRTHR_FQE"."QUERY_CONTEXT" ("QUERY_ID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table RESULT_VIEWS
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."RESULT_VIEWS" ADD CONSTRAINT "FK1FB8FBCC9C24B876" FOREIGN KEY ("QUERY_CONTEXT_ID")
	  REFERENCES "FRTHR_FQE"."QUERY_CONTEXT" ("QUERY_ID") ENABLE;
 
  ALTER TABLE "FRTHR_FQE"."RESULT_VIEWS" ADD CONSTRAINT "FK1FB8FBCCCBCEE79C" FOREIGN KEY ("VALUE")
	  REFERENCES "FRTHR_FQE"."RESULT_CONTEXT" ("ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table SEARCH_QUERY
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."SEARCH_QUERY" ADD CONSTRAINT "FK1B7D0371DE01CADB" FOREIGN KEY ("QUERYCONTEXT")
	  REFERENCES "FRTHR_FQE"."QUERY_CONTEXT" ("QUERY_ID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table STATUS_META_DATA
--------------------------------------------------------

  ALTER TABLE "FRTHR_FQE"."STATUS_META_DATA" ADD CONSTRAINT "FK82C59197DE01CADB" FOREIGN KEY ("QUERYCONTEXT")
	  REFERENCES "FRTHR_FQE"."QUERY_CONTEXT" ("QUERY_ID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  DDL for Procedure ADD_QUERY_OBJECT_ALIAS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."ADD_QUERY_OBJECT_ALIAS" ( p_namespace_id number, p_query_id number, p_old_alias varchar2, p_new_alias varchar2, p_new_object varchar2) AS 
   v_new_alias_xml varchar2(1000);
   is_existing_alias number;
BEGIN

  select count(1) into is_existing_alias
  from query_temp q
  where q.query_id = p_query_id
    and q.namespace_id = p_namespace_id
    and q.query_xml.existsNode( '//aliases/alias[key="' || p_new_alias || '"]/key/text()', const.get_query_xml_namespace) = 1;
    
  if ( is_existing_alias = 0 ) then -- does not exist, create 
    
     v_new_alias_xml := 
'<alias>
   <key>' || p_new_alias || '</key>
   <value>' || p_new_object || '</value>
</alias>';

     update query_temp q 
     set query_xml = insertChildXML( q.query_xml
                      , '//aliases[alias/key[text()="' || p_old_alias || '"]]'
                      , 'alias', XMLType( v_new_alias_xml )
                      , const.get_query_xml_namespace ) 
     where q.query_id = p_query_id
       and q.namespace_id = p_namespace_id;

  end if;  
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG','UPDATE ALIAS old=' || p_old_alias || ' new alias=' || p_new_alias || ' exisited=' || is_existing_alias,1);
  
END ADD_QUERY_OBJECT_ALIAS;
 

/
--------------------------------------------------------
--  DDL for Procedure CHECK_TRANSLATED_QUERY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."CHECK_TRANSLATED_QUERY" ( p_namespace_id number, p_query_id number ) AS 

  v_error_msg varchar2(4000); 

BEGIN

  v_error_msg := '';

  for crs in (
    select extract(column_value, '/criteria/searchType/text()', const.get_query_xml_namespace).getstringval() exp_type,
           extract(column_value, '/criteria/parameters/parameter[1]/text()', const.get_query_xml_namespace).getstringval() param1,
           extract(column_value, '/criteria/parameters/parameter[2]/text()', const.get_query_xml_namespace).getstringval() param2,
           extract(column_value, '/criteria/parameters/parameter[3]/text()', const.get_query_xml_namespace).getstringval() param3
    from query_temp q
        ,table(xmlsequence( q.query_xml.extract('//criteria[parameters/untouched]', const.get_query_xml_namespace) ) )
    where query_id = p_query_id 
      and namespace_id = p_namespace_id
  ) loop
  
    v_error_msg := v_error_msg || 'CRITERION NOT SUPPORTED BY ' || const.get_namespace_label( p_namespace_id ) || ': searchType=' || crs.exp_type || ' parameter[1]=' || crs.param1 || ' parameter[2]=' || crs.param2 || ' parameter[3]=' || crs.param3 || ' ';
  
  end loop;
  
  for cr in (
    select extract(column_value, '/alias/key/text()', const.get_query_xml_namespace).getstringval() vkey,
           extract(column_value, '/alias/value/text()', const.get_query_xml_namespace).getstringval() vvalue
    from query_temp q
        ,table(xmlsequence( q.query_xml.extract('//alias[./untouchedAlias]', const.get_query_xml_namespace) ) )
    where query_id = p_query_id 
      and namespace_id = p_namespace_id
  ) loop
  
    v_error_msg := v_error_msg || 'ALIAS NOT UTILIZED IN QUERY for alias key=' || cr.vkey || ' value=' || cr.vvalue || ' ';
  
  end loop;

  
  if length(v_error_msg) > 1  then
    
    v_error_msg := 'QUERY ERRORS - ' || v_error_msg;
    further_pkg.log_msg($$PLSQL_UNIT,'ERROR', 'QUERY(' || p_namespace_id || ':' || p_query_id || ') ' || v_error_msg, 1);
    RAISE_APPLICATION_ERROR(-20000, v_error_msg );
  
  end if;


END CHECK_TRANSLATED_QUERY;
 

/
--------------------------------------------------------
--  DDL for Procedure DELETE_QUERY_ELEMENTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."DELETE_QUERY_ELEMENTS" ( p_namespace_id query_temp.namespace_id%type, p_query_id query_temp.query_id%type, p_xpath varchar2 ) AS 

  v_intro_msg varchar2(50);
  
BEGIN

  v_intro_msg := 'QUERY(' || p_namespace_id || ':' || p_query_id || ') ';

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || ' DELETE XPATH=' || p_xpath ,1);

  update query_temp
  set query_xml = deletexml(
     query_xml
    ,p_xpath
    ,const.get_query_xml_namespace
  )
  where query_id = p_query_id
    and namespace_id = p_namespace_id;
      

END DELETE_QUERY_ELEMENTS;
 

/
--------------------------------------------------------
--  DDL for Procedure GET_PHYSICAL_QUERY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."GET_PHYSICAL_QUERY" 
  (
    p_sys_refcur OUT SYS_REFCURSOR,
    p_namespace_str          VARCHAR2,
    p_query_context_id     NUMBER)
AS

  v_query_id number;
  v_namespace_str varchar2(100);
  v_namespace_id number;
  v_error_msg varchar2(4000);

BEGIN

  v_namespace_id := to_number( p_namespace_str );
  v_query_id := prepare_analytical_query( v_namespace_id, p_query_context_id );
  
  IF ( V_namespace_id = const.get_uuedw_namespace_id ) THEN -- UUEDW
    TRANS_QUERY_UUEDW( v_query_id );
  ELSIF ( V_namespace_id = const.get_updbl_namespace_id ) THEN -- UPDB
    TRANS_QUERY_UPDBL( v_query_id );
  ELSIF ( V_namespace_id = const.get_uuedw_apo_namespace_id ) THEN -- UUEDW_APO
    TRANS_QUERY_UUEDW_APO( v_query_id );
  ELSIF ( V_namespace_id = const.get_ih_apo_namespace_id ) THEN -- IH_APO
    TRANS_QUERY_IH_APO( v_query_id );
  ELSE
  
    v_error_msg := 'QUERY CONTEXT_UUID="' || p_query_context_id || '" NAMESPACE="' ||  v_namespace_str || '" not supported';
    further_pkg.log_msg($$PLSQL_UNIT,'ERROR', v_error_msg, 1);
    RAISE_APPLICATION_ERROR(-20000, v_error_msg );
  
  END IF;
  
  OPEN p_sys_refcur FOR SELECT * FROM query_nmspc WHERE query_id = v_query_id AND namespace_id = v_namespace_id;
  
END GET_PHYSICAL_QUERY;

/
--------------------------------------------------------
--  DDL for Procedure PREPARE_NEW_QUERY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."PREPARE_NEW_QUERY" ( p_namespace_id number, p_query_id number)  AS 
BEGIN

  delete query_temp  where query_id = p_query_id and namespace_id = p_namespace_id;
  delete query_temp_attr  where query_id = p_query_id and namespace_id = p_namespace_id;
  delete query_nmspc where query_id = p_query_id and namespace_id = p_namespace_id;

  /* copy query to query_nmspc to prepare for editting, add untouched */ 
  insert into query_temp   
  select q.query_id
       , p_namespace_id
       , insertChildXML( q.query_xml
                      , '//criteria/parameters[parameter[last()]]'
                      , 'untouched', XMLType('<untouched/>')
                      , const.get_query_xml_namespace ) 
  from query_def q
  where q.query_id = p_query_id;
  
  /* touch all the aliases */
  update query_temp q 
  set query_xml = insertChildXML( q.query_xml
                      , '//alias'
                      , 'untouchedAlias', XMLType('<untouchedAlias/>')
                      , const.get_query_xml_namespace ) 
  where q.query_id = p_query_id
    and q.namespace_id = p_namespace_id;

  /* remove the queryId criteria */
  update query_temp q
  set q.query_xml = deleteXML( q.query_xml, '//criteria[parameters/parameter/text()="id.queryId"]'
                                          , const.get_query_xml_namespace )
  where query_id = p_query_id
    and namespace_id = p_namespace_id;

  /* remove the sortCriteria */
  update query_temp q
  set q.query_xml = deleteXML( q.query_xml, '//sortCriteria'
                                          , const.get_query_xml_namespace )
  where query_id = p_query_id
    and namespace_id = p_namespace_id;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', 'QUERY(' || p_namespace_id || ':' || p_query_id || ') TEMP QUERY PREPARED',1);

END PREPARE_NEW_QUERY;

/
--------------------------------------------------------
--  DDL for Procedure RUN_QUERY_TRANS_TEST_SUITE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."RUN_QUERY_TRANS_TEST_SUITE" as
  v_can_query_uuedw number;
  v_can_query_updbl number;
  v_error_msg varchar2(1000);
  v_error_out varchar2(1000);
  v_test_cd varchar2(20);
  v_test_function varchar2(100);
  v_failures number;

begin

  -- prepare query tables for testing
  -- 1. Remove test queries
  delete query_def where query_id in ( select tst.query_id from query_test_set tst );
  delete query_temp where query_id in ( select tst.query_id from query_test_set tst );
  delete query_nmspc where query_id in ( select tst.query_id from query_test_set tst );
  delete query_temp_attr where query_id in ( select tst.query_id from query_test_set tst );
  delete query_test_result;
  
  -- 2. Re-insert test queries
  insert into query_def (query_id, query_xml, create_dts, created_by_user_id) 
    select query_id, query_xml, sysdate, 'TEST_PROCEDURE' from query_test_set;
  
  commit;

  for c in (
    select q.query_id, q.namespace_id, q.expected_result_cd
    from query_test_assertion q -- where q.query_id in (-679944, -678950, -678943, -676750, -676748, -670242, -670239, -670238)
  ) loop

    v_can_query_uuedw := 0;

    if c.namespace_id = const.get_uuedw_namespace_id then
      begin  
        v_can_query_uuedw := can_query_uuedw( c.query_id );
        exception
        when others then
          v_error_msg := SQLERRM;
          v_can_query_uuedw := 0;
      end;

      if (c.expected_result_cd = 'P' and v_can_query_uuedw = 1) or (c.expected_result_cd = 'F' and v_can_query_uuedw = 0)  then
        insert into query_test_result values( c.query_id, c.namespace_id, 'PASSED', null, sysdate);
      else
        insert into query_test_result values( c.query_id, c.namespace_id, 'FAILED', null, sysdate);    
      end if;

    end if;
    
    v_can_query_updbl := 0;
    if c.namespace_id = const.get_updbl_namespace_id then
      begin  
        v_can_query_updbl := can_query_updbl( c.query_id );
        exception
        when others then
          v_error_msg := SQLERRM;
          v_can_query_updbl := 0;
      end;

      if (c.expected_result_cd = 'P' and v_can_query_updbl = 1) or (c.expected_result_cd = 'F' and v_can_query_updbl = 0)  then
        insert into query_test_result values( c.query_id, c.namespace_id, 'PASSED', null, sysdate);
      else
        insert into query_test_result values( c.query_id, c.namespace_id, 'FAILED', null, sysdate);    
      end if;      
      
    end if;
    commit;    
    --dbms_output.put_line('=========>' || c.query_id || ':' || c.expected_result_cd || ':' || v_test_cd);
  end loop;

  commit;
  
  select count(1) into v_failures
  from query_test_result
  where test_cd = 'FAILED';
  
  if v_failures > 0 then 
  
    RAISE_APPLICATION_ERROR(-20000, v_failures || ' TESTS FAILED: See details in table QUERY_TEST_RESULT' );  
  
  end if;

end run_query_trans_test_suite;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_DEMOG_IH_APO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_DEMOG_IH_APO" ( p_query_id number ) AS

  v_namespace_id number;
  v_ih_apo_person_asset_id number;
  v_is_trans_attr number;
  v_is_trans_attr_value number;
  v_is_valid_attr number;

  v_trgt_attr varchar2(100);
  v_trnsltn_func varchar2(100);
  v_trnsltn_to_type varchar2(100);
  v_nmspc_id number;
  v_prop_name varchar2(100);
  v_trgt_value varchar2(100);
  v_xpath varchar2(4000);
  v_search_type varchar2(50);
  v_oper varchar2(50);
  v_new_oper varchar2(50);
  
  v_error_msg varchar2(4000);
  v_attr_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  i number;
  v_attr_count number;
  
BEGIN

  v_intro_msg := 'QUERY( IH:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  v_namespace_id := const.get_ih_apo_namespace_id ;

  
  for crs in (
    select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() attr_name
    from query_def q
        ,table(xmlsequence( q.query_xml.extract('//parameter[(position()=1 and ../../searchType/text()!="SIMPLE")' ||
                                                        ' or (position()=2 and ../../searchType/text()="SIMPLE")]'
                          , const.get_query_xml_namespace) ) )
    where query_id = p_query_id
  ) loop
  
    select count(1)+1 into v_attr_count -- the nth occurance of this attribute
    from query_temp_attr
    where query_id = p_query_id
      and namespace_id = v_namespace_id
      and attr_name = crs.attr_name;
      
    insert into query_temp_attr values( v_namespace_id, p_query_id, crs.attr_name );
    
    v_is_valid_attr := is_valid_attr( const.get_frthr_person_obj_asset_id, crs.attr_name );
    
    further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '1 CURRENT ATTR: ' || crs.attr_name || '[' || v_attr_count || ']' ,1);
    
    v_ih_apo_person_asset_id := 3138;
   
    if v_is_valid_attr = 1 then
        
      v_is_trans_attr := is_trans_attr( const.get_frthr_person_obj_asset_id, v_ih_apo_person_asset_id , crs.attr_name );
      v_is_trans_attr_value := is_trans_attr_value( p_query_id, const.get_frthr_person_obj_asset_id, v_ih_apo_person_asset_id, crs.attr_name );
      v_trnsltn_to_type := get_trans_assoc_prop( const.get_frthr_person_obj_asset_id, v_ih_apo_person_asset_id, crs.attr_name, 'ATTR_VALUE_TRANS_TO_DATA_TYPE');
  
      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '1.5 TRANSLATION PARAMS: ' || crs.attr_name || '[' || v_attr_count || ']' 
        ||  ' is_trans_attr=' || v_is_trans_attr 
        ||  ' is_trans_attr_value=' || v_is_trans_attr_value 
        ,1);

      v_attr_error_msg := null;
      v_trgt_attr := null;
      v_trgt_value := null;
    
    /* -------------------------
     * Translate Attribute Name
     * -------------------------*/
    if (  v_is_trans_attr = 1 ) then

      v_trgt_attr := get_translated_attribute( const.get_frthr_person_obj_asset_id, v_ih_apo_person_asset_id, crs.attr_name );   
      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '2 TRANSLAING ATTR: ' || crs.attr_name || ' TO: ' || v_trgt_attr || ' NEW TYPE: ' || v_trnsltn_to_type,1);

      update query_temp qn 
         set query_xml = updatexml( 
             qn.query_xml
            ,'(//parameter[text()="' || crs.attr_name || '"])[' || v_attr_count || ']/text()'
            , v_trgt_attr
            , const.get_query_xml_namespace )
      where qn.query_id = p_query_id
        and qn.namespace_id = v_namespace_id;

      if sql%rowcount = 0 then
        v_attr_error_msg := 'ATTR=' || crs.attr_name || ' update failed TRGT_ATTR=' || v_trgt_attr || ' ';
        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '2.1 ' || v_attr_error_msg,1);
      end if;

    end if;
    
    /* -----------------------------
     * Translate Attribute Value(s)
     * ----------------------------- */
    if ( v_is_trans_attr_value  = 1 ) then

      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '3 TRANSLAING ATTR VALUE: ' || crs.attr_name ,1);
      v_trnsltn_func := get_trans_assoc_prop( const.get_frthr_person_obj_asset_id, v_ih_apo_person_asset_id, crs.attr_name, const.get_attr_val_trans_prop_nm);

      i := 0;
      for param in (
        select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() v_value
        from query_def q
            ,table(xmlsequence( q.query_xml.extract('(//criteria[parameters/parameter[text()="' || crs.attr_name || '"]])[' || v_attr_count || ']' ||
                               '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]'
                               , const.get_query_xml_namespace) ) )
        where q.query_id = p_query_id       
      ) loop

          i := i + 1;
          further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '4 TRANSLATE ATTR VALUE[' || i || ']=' || crs.attr_name || ' ATTR_VAL=' || param.v_value ,1);

          if v_trnsltn_func = 'translateCode' then 
          
            v_nmspc_id := get_attr_assoc_prop( const.get_frthr_person_obj_asset_id, crs.attr_name, 'VALUE_SET_NAMESPACE_ID');
            v_prop_name := get_attr_assoc_prop( const.get_frthr_person_obj_asset_id, crs.attr_name, 'VALUE_SET_PROP_NAME');

            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '5 GET_TRANSLATED_CONCEPT_VALUE(' || v_nmspc_id || ', ''' || v_prop_name || ''', ''' || param.v_value || ''', ' || v_namespace_id || ', ''Code'')', 1);

            v_trgt_value := dts.GET_TRANSLATED_CONCEPT_VALUE ( v_nmspc_id, v_prop_name, param.v_value, v_namespace_id, 'Code' );

            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '6 NEW_NMSPC_ID=' || v_namespace_id || ' NEW_CD=' || v_trgt_value,1);
              
          elsif v_trnsltn_func = 'year-from-dateTime' then 

            null; -- v_trgt_value := substr( param.v_value, 1, 4); -- year is the first 4 chars (for the next eight thousand years anyway)         

          end if;
          
          if length(v_trgt_value) > 0 and v_trgt_value is not null then -- trgt_value indicates the value was translated and needs to be updated
  
            v_xpath := '//criteria[parameters//parameter/text()="' || v_trgt_attr || '" and parameters//parameter/text()="' || param.v_value || '"]/parameters/parameter[text()="' || param.v_value || '"]';
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '7 UPDATE QUERY NEW_ATTR=' || v_trgt_attr || ' NEW_ATTR_VALUE=' || v_trgt_value || ' xpath=' || v_xpath,1);
  
            update query_temp qn 
            set query_xml = updatexml( 
              qn.query_xml
              ,v_xpath || '/@xsi:type', 'xs:integer'
              ,v_xpath || '/text()', v_trgt_value
              , const.get_query_xml_namespace)
            where qn.query_id = p_query_id
              and qn.namespace_id = v_namespace_id;
                                                         
          else 
            
            v_attr_error_msg := v_attr_error_msg || 'VALUE TRANSLATION ERROR: attribute=' || crs.attr_name || ' value=' || param.v_value || ' could not be translated. ';

          end if;

      end loop;      
      
    end if; -- is_trans_attr_value
    
    /* -------------------------------
     * Remove untouched from criteria
     * ------------------------------- */
    if ( v_attr_error_msg is null ) then 
                                     
      if ( v_is_trans_attr  = 1) then

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '9 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr || ' VALUE=' || v_trgt_value,1);
        delete_query_elements( v_namespace_id, p_query_id,'//criteria[parameters//parameter/text()="' || v_trgt_attr ||'"]/parameters/untouched');

      elsif ( v_is_trans_attr  = 0 and v_is_trans_attr_value  = 0 and is_valid_attr( const.get_frthr_person_obj_asset_id , crs.attr_name) = 1) then

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '10 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr || ' VALUE=' || v_trgt_value,1);
        delete_query_elements( v_namespace_id, p_query_id,'//criteria[parameters//parameter/text()="' || crs.attr_name || '"]/parameters/untouched');

      end if;
      
    else
      
        further_pkg.log_msg($$PLSQL_UNIT,'ERROR', v_intro_msg || v_attr_error_msg,1);      
     
    end if; -- no error msg
    
    else
    
      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '11 ATTR NOT PROCESSED BY THIS PROC: ' || crs.attr_name ,1);
    
    end if;
    
    v_error_msg := v_error_msg || v_attr_error_msg;
    
  end loop; -- attr loop

  -- delete the female administartive gender crieria when it is female - impled but not supported
  delete_query_elements( v_namespace_id, p_query_id,'//criteria[parameters//parameter/text()="administrativeGender" and parameters//parameter/text()="248153007"]');
  delete query_temp_attr where query_id = p_query_id and namespace_id=v_namespace_id;
  
  /* ----------------------------------------------------------
   * Check for translation errors - throw excpetion when found
   * ----------------------------------------------------------*/
  
  if length( v_error_msg ) > 0 then
    further_pkg.log_msg($$PLSQL_UNIT, v_intro_msg || 'ERROR', v_error_msg, 1);
    RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg );
  end if;

END TRANS_QUERY_DEMOG_IH_APO;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_DEMOG_UPDBL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_DEMOG_UPDBL" ( p_query_id number ) AS

  v_is_trans_attr number;
  v_is_trans_attr_value number;
  v_is_valid_attr number;

  v_trgt_attr varchar2(100);
  v_trnsltn_func varchar2(100);
  v_trnsltn_to_type varchar2(100);
  v_nmspc_id number;
  v_prop_name varchar2(100);
  v_trgt_value varchar2(100);
  v_xpath varchar2(4000);
  v_search_type varchar2(50);
  v_oper varchar2(50);
  v_new_oper varchar2(50);
  
  v_error_msg varchar2(4000);
  v_attr_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  i number;
  v_attr_count number;
  
BEGIN

  v_intro_msg := 'QUERY( UPDB:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  
  for crs in (
    select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() attr_name
    from query_def q
        ,table(xmlsequence( q.query_xml.extract('//parameter[(position()=1 and ../../searchType/text()!="SIMPLE")' ||
                                                        ' or (position()=2 and ../../searchType/text()="SIMPLE")]'
                          , const.get_query_xml_namespace) ) )
    where query_id = p_query_id
  ) loop
  
    select count(1)+1 into v_attr_count -- the nth occurance of this attribute
    from query_temp_attr
    where query_id = p_query_id
      and namespace_id = const.get_updbl_namespace_id
      and attr_name = crs.attr_name;
      
    insert into query_temp_attr values( const.get_updbl_namespace_id, p_query_id, crs.attr_name );
    
    v_is_valid_attr := is_valid_attr( const.get_frthr_person_obj_asset_id, crs.attr_name );
    
    further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '1 CURRENT ATTR: ' || crs.attr_name || '[' || v_attr_count || ']' ,1);
    
    if v_is_valid_attr = 1 then
    
    v_is_trans_attr := is_trans_attr( const.get_frthr_person_obj_asset_id, const.get_updbl_person_obj_asset_id , crs.attr_name );
    v_is_trans_attr_value := is_trans_attr_value( p_query_id, const.get_frthr_person_obj_asset_id, const.get_updbl_person_obj_asset_id, crs.attr_name );
    v_trnsltn_to_type := get_trans_assoc_prop( const.get_frthr_person_obj_asset_id, const.get_updbl_person_obj_asset_id, crs.attr_name, 'ATTR_VALUE_TRANS_TO_DATA_TYPE');

    v_attr_error_msg := null;
    v_trgt_attr := null;
    v_trgt_value := null;
    
    /* -------------------------
     * Translate Attribute Name
     * -------------------------*/
    if (  v_is_trans_attr = 1 ) then

      v_trgt_attr := get_translated_attribute( const.get_frthr_person_obj_asset_id, const.get_updbl_person_obj_asset_id, crs.attr_name );   
      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '2 TRANSLAING ATTR: ' || crs.attr_name || ' TO: ' || v_trgt_attr || ' NEW TYPE: ' || v_trnsltn_to_type,1);

      update query_temp qn 
         set query_xml = updatexml( 
             qn.query_xml
            ,'//parameter[text()="' || crs.attr_name || '"]/text()'
            , v_trgt_attr
            , const.get_query_xml_namespace )
      where qn.query_id = p_query_id
        and qn.namespace_id = const.get_updbl_namespace_id;

      if sql%rowcount = 0 then
        v_attr_error_msg := 'ATTR=' || crs.attr_name || ' update failed TRGT_ATTR=' || v_trgt_attr || ' ';
        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '2.1 ' || v_attr_error_msg,1);
      end if;

    end if;
    
    /* -----------------------------
     * Translate Attribute Value(s)
     * ----------------------------- */
    i := 0;
    if ( v_is_trans_attr_value  = 1 ) then

      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '3 TRANSLAING ATTR VALUE: ' || crs.attr_name ,1);
      v_trnsltn_func := get_trans_assoc_prop( const.get_frthr_person_obj_asset_id, const.get_updbl_person_obj_asset_id, crs.attr_name, const.get_attr_val_trans_prop_nm);

      for param in (
        select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() v_value
        from query_def q
            ,table(xmlsequence( q.query_xml.extract('(//*[parameters/parameter[text()="' || crs.attr_name || '"]])[' || v_attr_count || ']' ||
                               '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]'
                               , const.get_query_xml_namespace) ) )
        where q.query_id = p_query_id       
      ) loop

          i := i + 1;
          further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '4 TRANSLATE ATTR VALUE[' || i || ']=' || crs.attr_name || ' ATTR_VAL=' || param.v_value || ' FUNCTION=' || v_trnsltn_func ,1);

          if v_trnsltn_func = 'translateCode' then 
          
            v_nmspc_id := get_attr_assoc_prop( const.get_frthr_person_obj_asset_id, crs.attr_name, 'VALUE_SET_NAMESPACE_ID');
            v_prop_name := get_attr_assoc_prop( const.get_frthr_person_obj_asset_id, crs.attr_name, 'VALUE_SET_PROP_NAME');

            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '5 GET TRANSLATED CONCEPT VALUE(' || v_nmspc_id || ', ''' || v_prop_name || ''', ''' || param.v_value || ''', ' || const.get_updbl_namespace_id || ', ''Local Code'')', 1);
            v_trgt_value := dts.GET_TRANSLATED_CONCEPT_VALUE ( v_nmspc_id, v_prop_name, param.v_value, const.get_updbl_namespace_id, 'Local Code' );
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '6 NEW_NMSPC_ID=' || const.get_updbl_namespace_id || ' NEW_CD=' || v_trgt_value,1);
              
          elsif v_trnsltn_func = 'year-from-dateTime' then 

            v_trgt_value := substr( param.v_value, 1, 4); -- year is the first 4 chars (for the next eight thousand years)         

          elsif v_trnsltn_func = 'ageToBirthYear' then 

            v_trgt_value := '' || (to_number( to_char( sysdate, 'YYYY' ) ) - to_number( param.v_value));    
            
          end if;
          
          if length(v_trgt_value) > 0 then -- trgt_value indicates the value was translated and needs to be updated
  
            v_xpath := '//*[parameters//parameter/text()="' || v_trgt_attr || '" and parameters//parameter/text()="' || param.v_value || '"]/parameters/parameter[text()="' || param.v_value || '"]';
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '7 UPDATE QUERY NEW_ATTR=' || v_trgt_attr || ' NEW_ATTR_VALUE=' || v_trgt_value || ' xpath=' || v_xpath,1);
        
            if length(v_trnsltn_to_type) > 0 then -- translation type needs to be updated
    
              update query_temp qn 
              set query_xml = updatexml( 
                qn.query_xml
                ,v_xpath || '/@xsi:type', v_trnsltn_to_type
                ,v_xpath || '/text()', v_trgt_value
                , const.get_query_xml_namespace)
              where qn.query_id = p_query_id
                and qn.namespace_id = const.get_updbl_namespace_id;
              
            else -- no type translation required

              update query_temp qn 
              set query_xml = updatexml( 
                qn.query_xml
                ,v_xpath || '/text()'
                ,v_trgt_value
                , const.get_query_xml_namespace)
              where qn.query_id = p_query_id
                and qn.namespace_id = const.get_updbl_namespace_id;
            
            end if;
                                                         
          else 
            
            v_attr_error_msg := v_attr_error_msg || 'VALUE TRANSLATION ERROR: attribute=' || crs.attr_name || ' value=' || param.v_value || ' could not be translated. ';

          end if;

      end loop;      
      
    end if; -- is_trans_attr_value
    
    /* -------------------------------
     * Remove untouched from criteria
     * ------------------------------- */
    if ( v_attr_error_msg is null ) then 
      
      if ( v_is_trans_attr  = 1 and v_is_trans_attr_value  = 0 ) then
      
        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '8 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr,1);
        delete_query_elements( const.get_updbl_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || v_trgt_attr || '"]/parameters/untouched'
                             );
                               
      elsif ( v_is_trans_attr  = 1 and v_is_trans_attr_value  = 1 ) then

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '9 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr || ' VALUE=' || v_trgt_value,1);
        delete_query_elements( const.get_updbl_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || v_trgt_attr || 
                              '" and parameters//parameter/text()="' || v_trgt_value || '"]/parameters/untouched'
                             );

      elsif ( v_is_trans_attr  = 0 and v_is_trans_attr_value  = 0 and is_valid_attr( const.get_updbl_person_obj_asset_id, crs.attr_name) = 1) then

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '10 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr || ' VALUE=' || v_trgt_value,1);
        delete_query_elements( const.get_updbl_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || crs.attr_name || '"]/parameters/untouched'
                             );

      end if;
      
      else
      
        further_pkg.log_msg($$PLSQL_UNIT,'ERROR', v_intro_msg || v_attr_error_msg,1);      
     
    end if; -- no error msg
    
    else
    
      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '11 ATTR NOT PROCESSED BY THIS PROC: ' || crs.attr_name ,1);
    
    end if;
    
    -- if this was an "age BETWEEN" statement the order of the between values needs to be swapped.
    v_search_type := get_attr_search_type(p_query_id, crs.attr_name, v_attr_count );
    further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '12 SEARCH_TYPE for ATTR ' || crs.attr_name || '[' || v_attr_count || ']="' || v_search_type ||'"' ,1);

    if ( crs.attr_name = 'age' and v_search_type = 'BETWEEN' ) then 

      -- duplicate param[2] and add it to end of param list
      update query_temp q 
      set query_xml = insertChildXML( q.query_xml
                      , '(//*[parameters/parameter[text()="' || v_trgt_attr || '"]])[' || v_attr_count || ']/parameters'
                      , 'parameter'
                      , extract( q.query_xml,'(//*[parameters/parameter[text()="' || v_trgt_attr || '"]])[' || v_attr_count || ']' || '//parameter[2]', const.get_query_xml_namespace)
                      , const.get_query_xml_namespace ) 
      where q.query_id = p_query_id
      and q.namespace_id = const.get_updbl_namespace_id;
      
      -- delete param[2] to complete value position swap
      delete_query_elements( const.get_updbl_namespace_id
                             , p_query_id
                             ,'(//*[parameters/parameter[text()="' || v_trgt_attr || '"]])[' || v_attr_count || ']/parameters/parameter[2]'
                             );

    elsif crs.attr_name = 'age' and v_search_type='SIMPLE' then -- need to change operator direction LT becomes GT and vice versa, same with LTE and GTE
    
      v_new_oper := '';
      v_oper := get_attr_simple_operator(p_query_id, crs.attr_name, v_attr_count );

      if v_oper='LT' then 
        v_new_oper:='GT';
      elsif v_oper='GT' then
        v_new_oper:='LT';
      elsif v_oper='LE' then
        v_new_oper:='GE';
      elsif v_oper='GE' then
        v_new_oper:='LE';
      end if;

      if length(v_new_oper) > 0 then -- update the operator

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '13.2 UPDATING QUERY OPERATOR for age[' || v_attr_count || '] FROM ' || v_oper || ' TO ' || v_new_oper,1);
      
        update query_temp q 
        set query_xml = updateXML( q.query_xml
                      , '(//*[parameters/parameter[text()="' || v_trgt_attr || '"]])[' || v_attr_count || ']/parameters/parameter[1]/text()'
                      , v_new_oper
                      , const.get_query_xml_namespace ) 
        where q.query_id = p_query_id
        and q.namespace_id = const.get_updbl_namespace_id;

      end if;

    end if;

    v_error_msg := v_error_msg || v_attr_error_msg;
  end loop; -- attr loop

  delete query_temp_attr where query_id = p_query_id and namespace_id=const.get_uuedw_namespace_id;
  
  /* ----------------------------------------------------------
   * Check for translation errors - throw excpetion when found
   * ----------------------------------------------------------*/
  
  if length( v_error_msg ) > 0 then
    further_pkg.log_msg($$PLSQL_UNIT, v_intro_msg || 'ERROR', v_error_msg, 1);
    RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg );
  end if;

END TRANS_QUERY_DEMOG_UPDBL;
 

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_DEMOG_UUEDW
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_DEMOG_UUEDW" ( p_query_id number ) AS

  v_is_trans_attr number;
  v_is_trans_attr_value number;

  v_trgt_attr varchar2(100);
  v_trnsltn_func varchar2(100);
  v_nmspc_id number;
  v_prop_name varchar2(100);
  v_trgt_value varchar2(100);
  v_xpath varchar2(4000);
  
  v_error_msg varchar2(4000);
  v_attr_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  i number;
  v_attr_count number;
  
BEGIN

  v_intro_msg := 'QUERY( UUEDW:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  
  for crs in (
    select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() attr_name
    from query_def q
        ,table(xmlsequence( q.query_xml.extract('//criteria//parameter[(position()=1 and ../../searchType/text()!="SIMPLE")' ||
                                                                  ' or (position()=2 and ../../searchType/text()="SIMPLE")]'
                          , const.get_query_xml_namespace) ) )
    where query_id = p_query_id
  ) loop
    
    select count(1)+1 into v_attr_count
    from query_temp_attr
    where query_id = p_query_id
      and namespace_id = const.get_uuedw_namespace_id
      and attr_name = crs.attr_name;
      
    insert into query_temp_attr values( const.get_uuedw_namespace_id, p_query_id, crs.attr_name );

    further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '1 CURRENT ATTR: ' || crs.attr_name ,1);
    v_is_trans_attr := is_trans_attr( const.get_frthr_person_obj_asset_id, const.get_uuedw_patient_obj_asset_id, crs.attr_name );
    v_is_trans_attr_value := is_trans_attr_value( p_query_id, const.get_frthr_person_obj_asset_id, const.get_uuedw_patient_obj_asset_id, crs.attr_name );
    v_attr_error_msg := null;
    v_trgt_attr := null;
    v_trgt_value := null;
    
    /* -------------------------
     * Translate Attribute Name
     * -------------------------*/
    if (  v_is_trans_attr = 1 ) then

      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '2 TRANSLAING ATTR: ' || crs.attr_name ,1);
      v_trgt_attr := get_translated_attribute( const.get_frthr_person_obj_asset_id, const.get_uuedw_patient_obj_asset_id, crs.attr_name );   

      update query_temp qn 
         set query_xml = updatexml( 
             qn.query_xml
            ,'//criteria/parameters/parameter[text()="' || crs.attr_name || '"]/text()'
            , v_trgt_attr
            , const.get_query_xml_namespace )
      where qn.query_id = p_query_id
        and qn.namespace_id = const.get_uuedw_namespace_id;

      if sql%rowcount = 0 then
        v_attr_error_msg := 'ATTR=' || crs.attr_name || ' update failed TRGT_ATTR=' || v_trgt_attr;
      end if;

    end if;
    
    /* -----------------------------
     * Translate Attribute Value(s)
     * ----------------------------- */
    if ( v_is_trans_attr_value  = 1 ) then

      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '3 TRANSLAING ATTR VALUE: ' || crs.attr_name ,1);
      v_trnsltn_func := get_trans_assoc_prop( const.get_frthr_person_obj_asset_id, const.get_uuedw_patient_obj_asset_id, crs.attr_name, const.get_attr_val_trans_prop_nm);

      i := 0;
      for param in (
        select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() v_value
        from query_def q
            ,table(xmlsequence( q.query_xml.extract('(//criteria[parameters/parameter[text()="' || crs.attr_name || '"]])[' || v_attr_count || ']' ||
                               '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]'
                               , const.get_query_xml_namespace) ) )
        where q.query_id = p_query_id       
      ) loop

          i := i + 1;
          further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '4 TRANSLATE ATTR VALUE[' || i || ']=' || crs.attr_name || ' ATTR_VAL=' || param.v_value ,1);

          if v_trnsltn_func = 'translateCode' then 
          
            v_nmspc_id := get_attr_assoc_prop( const.get_frthr_person_obj_asset_id, crs.attr_name, 'VALUE_SET_NAMESPACE_ID');
            v_prop_name := get_attr_assoc_prop( const.get_frthr_person_obj_asset_id, crs.attr_name, 'VALUE_SET_PROP_NAME');

            further_pkg.log_msg($$PLSQL_UNIT
              ,'DEBUG'
              , v_intro_msg || '5 GET_TRANSLATED_CONCEPT_VALUE(' || v_nmspc_id || ', ''' || v_prop_name || ''', ''' || param.v_value || ''', ' || const.get_uuedw_namespace_id || ', ''Local Code'')'
              , 1);

            v_trgt_value := dts.GET_TRANSLATED_CONCEPT_VALUE ( v_nmspc_id, v_prop_name, param.v_value, const.get_uuedw_namespace_id, 'Local Code' );

            further_pkg.log_msg($$PLSQL_UNIT
              ,'DEBUG'
              , v_intro_msg || '6 NEW_NMSPC_ID=' || const.get_uuedw_namespace_id || ' NEW_CD=' || v_trgt_value
              ,1);
              
          elsif v_trnsltn_func = 'year-from-dateTime' then 

            v_trgt_value := substr( param.v_value, 1, 4); -- year is the first 4 chars (for the next eight thousand years anyway)         

          end if;
          
          if length(v_trgt_value) > 0 and v_trgt_value is not null then -- trgt_value indicates the value was translated and needs to be updated
  
            v_xpath := '//criteria[parameters//parameter/text()="' || v_trgt_attr || '" and parameters//parameter/text()="' || param.v_value || '"]/parameters/parameter[text()="' || param.v_value || '"]';
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '7 UPDATE QUERY NEW_ATTR=' || v_trgt_attr || ' NEW_ATTR_VALUE=' || v_trgt_value || ' xpath=' || v_xpath,1);
  
            update query_temp qn 
            set query_xml = updatexml( 
              qn.query_xml
              ,v_xpath || '/@xsi:type', 'xs:integer'
              ,v_xpath || '/text()', v_trgt_value
              , const.get_query_xml_namespace)
            where qn.query_id = p_query_id
              and qn.namespace_id = const.get_uuedw_namespace_id;
                                                         
          else 
            
            v_attr_error_msg := v_attr_error_msg || 'VALUE TRANSLATION ERROR: attribute=' || crs.attr_name || ' value=' || param.v_value || ' could not be translated. ';

          end if;

      end loop;      
      
    end if; -- is_trans_attr_value
    
    /* -------------------------------
     * Remove untouched from criteria
     * -------------------------------*/
    if ( v_attr_error_msg is null ) then 
      
      if ( v_is_trans_attr  = 1 and v_is_trans_attr_value  = 0 ) then
      
        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '8 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr,1);
        delete_query_elements( const.get_uuedw_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || v_trgt_attr || '"]/parameters/untouched'
                             );
                               
      elsif ( v_is_trans_attr  = 1 and v_is_trans_attr_value  = 1 ) then

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '9 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr || ' VALUE=' || v_trgt_value,1);
        delete_query_elements( const.get_uuedw_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || v_trgt_attr || 
                              '" and parameters//parameter/text()="' || v_trgt_value || '"]/parameters/untouched'
                             );

      elsif ( v_is_trans_attr  = 0 and v_is_trans_attr_value  = 0 and is_valid_attr( const.get_uuedw_patient_obj_asset_id, crs.attr_name) = 1) then

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '10 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr || ' VALUE=' || v_trgt_value,1);
        delete_query_elements( const.get_uuedw_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || crs.attr_name || '"]/parameters/untouched'
                             );

      end if;
      
      else
      
        further_pkg.log_msg($$PLSQL_UNIT,'ERROR', v_intro_msg || ' 11 ' || v_attr_error_msg,1);      
     
    end if; -- no error msg

    v_error_msg := v_error_msg || v_attr_error_msg;
  end loop; -- attr loop
  

  delete query_temp_attr where query_id = p_query_id and namespace_id=const.get_uuedw_namespace_id;

  /* ----------------------------------------------------------
   * Check for translation errors - throw excpetion when found
   * ----------------------------------------------------------*/
  
    if length( v_error_msg ) > 0 then
      further_pkg.log_msg($$PLSQL_UNIT, v_intro_msg || 'ERROR', '12 ' || v_error_msg, 1);
      RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg );
    end if;

END TRANS_QUERY_DEMOG_UUEDW;
 

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_DEMOG_UUEDW_APO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_DEMOG_UUEDW_APO" ( p_query_id number ) AS

  v_is_trans_attr number;
  v_is_trans_attr_value number;

  v_trgt_attr varchar2(100);
  v_trnsltn_func varchar2(100);
  v_nmspc_id number;
  v_prop_name varchar2(100);
  v_trgt_value varchar2(100);
  v_xpath varchar2(4000);
  
  v_error_msg varchar2(4000);
  v_attr_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  i number;
  v_attr_count number;
  v_namespace_id number;
  
BEGIN

  v_intro_msg := 'QUERY( UUEDW_APO:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  v_namespace_id := const.get_uuedw_apo_namespace_id;
  
  for crs in (
    select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() attr_name
    from query_def q
        ,table(xmlsequence( q.query_xml.extract('//criteria//parameter[(position()=1 and ../../searchType/text()!="SIMPLE")' ||
                                                                  ' or (position()=2 and ../../searchType/text()="SIMPLE")]'
                          , const.get_query_xml_namespace ) ) )
    where query_id = p_query_id
  ) loop
    
    select count(1)+1 into v_attr_count
    from query_temp_attr
    where query_id = p_query_id
      and namespace_id = v_namespace_id
      and attr_name = crs.attr_name;
      
    insert into query_temp_attr values( v_namespace_id, p_query_id, crs.attr_name );

    further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '1 CURRENT ATTR: ' || crs.attr_name ,1);
    
    v_is_trans_attr := is_trans_attr( const.get_frthr_person_obj_asset_id, const.get_uuedw_apo_person_asset_id, crs.attr_name );
    v_is_trans_attr_value := is_trans_attr_value( p_query_id, const.get_frthr_person_obj_asset_id, const.get_uuedw_apo_person_asset_id, crs.attr_name );
    
    v_attr_error_msg := null;
    v_trgt_attr := null;
    v_trgt_value := null;
    
    /* -------------------------
     * Translate Attribute Name
     * -------------------------*/
    if (  v_is_trans_attr = 1 ) then

      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '2 TRANSLAING ATTR: ' || crs.attr_name ,1);
      v_trgt_attr := get_translated_attribute( const.get_frthr_person_obj_asset_id, const.get_uuedw_apo_person_asset_id, crs.attr_name );   

      update query_temp qn 
         set query_xml = updatexml( 
             qn.query_xml
            ,'//criteria/parameters/parameter[text()="' || crs.attr_name || '"]/text()'
            , v_trgt_attr
            , const.get_query_xml_namespace )
      where qn.query_id = p_query_id
        and qn.namespace_id = v_namespace_id;

      if sql%rowcount = 0 then
        v_attr_error_msg := 'ATTR=' || crs.attr_name || ' update failed TRGT_ATTR=' || v_trgt_attr;
      end if;

    end if;
    
    /* -----------------------------
     * Translate Attribute Value(s)
     * ----------------------------- */
    if ( v_is_trans_attr_value  = 1 ) then

      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '3 TRANSLAING ATTR VALUE: ' || crs.attr_name ,1);
      v_trnsltn_func := get_trans_assoc_prop( const.get_frthr_person_obj_asset_id, const.get_uuedw_apo_person_asset_id, crs.attr_name, const.get_attr_val_trans_prop_nm);

      i := 0;
      for param in (
        select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() v_value
        from query_def q
            ,table(xmlsequence( q.query_xml.extract('(//criteria[parameters/parameter[text()="' || crs.attr_name || '"]])[' || v_attr_count || ']' ||
                               '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]'
                               , const.get_query_xml_namespace) ) )
        where q.query_id = p_query_id       
      ) loop

          i := i + 1;
          further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '4 TRANSLATE ATTR VALUE[' || i || ']=' || crs.attr_name || ' ATTR_VAL=' || param.v_value ,1);

          if v_trnsltn_func = 'translateCode' then 
          
            v_nmspc_id := get_attr_assoc_prop( const.get_frthr_person_obj_asset_id, crs.attr_name, 'VALUE_SET_NAMESPACE_ID');
            v_prop_name := get_attr_assoc_prop( const.get_frthr_person_obj_asset_id, crs.attr_name, 'VALUE_SET_PROP_NAME');

            further_pkg.log_msg($$PLSQL_UNIT
              ,'DEBUG'
              , v_intro_msg || '5 GET_TRANSLATED_CONCEPT_VALUE(' || v_nmspc_id || ', ''' || v_prop_name || ''', ''' || param.v_value || ''', ' || v_namespace_id || ', ''Local Code'')'
              , 1);

            v_trgt_value := dts.GET_TRANSLATED_CONCEPT_VALUE ( v_nmspc_id, v_prop_name, param.v_value, v_namespace_id, 'Local Code' );

            further_pkg.log_msg($$PLSQL_UNIT
              ,'DEBUG'
              , v_intro_msg || '6 NEW_NMSPC_ID=' || v_namespace_id || ' NEW_CD=' || v_trgt_value
              ,1);
              
          elsif v_trnsltn_func = 'year-from-dateTime' then 

            v_trgt_value := substr( param.v_value, 1, 4); -- year is the first 4 chars (for the next eight thousand years anyway)         

          end if;
          
          if length(v_trgt_value) > 0 and v_trgt_value is not null then -- trgt_value indicates the value was translated and needs to be updated
  
            v_xpath := '//criteria[parameters//parameter/text()="' || v_trgt_attr || '" and parameters//parameter/text()="' || param.v_value || '"]/parameters/parameter[text()="' || param.v_value || '"]';
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '7 UPDATE QUERY NEW_ATTR=' || v_trgt_attr || ' NEW_ATTR_VALUE=' || v_trgt_value || ' xpath=' || v_xpath,1);
  
            update query_temp qn 
            set query_xml = updatexml( 
              qn.query_xml
              ,v_xpath || '/@xsi:type', 'xs:integer'
              ,v_xpath || '/text()', v_trgt_value
              , v_namespace_id)
            where qn.query_id = p_query_id
              and qn.namespace_id = v_namespace_id;
                                                         
          else 
            
            v_attr_error_msg := v_attr_error_msg || 'VALUE TRANSLATION ERROR: attribute=' || crs.attr_name || ' value=' || param.v_value || ' could not be translated. ';

          end if;

      end loop;      
      
    end if; -- is_trans_attr_value
    
    /* -------------------------------
     * Remove untouched from criteria
     * -------------------------------*/
    if ( v_attr_error_msg is null ) then 
      
      if ( v_is_trans_attr  = 1 and v_is_trans_attr_value  = 0 ) then
      
        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '8 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr,1);
        delete_query_elements( v_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || v_trgt_attr || '"]/parameters/untouched'
                             );
                               
      elsif ( v_is_trans_attr  = 1 and v_is_trans_attr_value  = 1 ) then

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '9 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr || ' VALUE=' || v_trgt_value,1);
        delete_query_elements( v_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || v_trgt_attr || 
                              '" and parameters//parameter/text()="' || v_trgt_value || '"]/parameters/untouched'
                             );

      elsif ( v_is_trans_attr  = 0 and v_is_trans_attr_value  = 0 and is_valid_attr( const.get_uuedw_patient_obj_asset_id, crs.attr_name) = 1) then

        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || '10 UPDATING: REMOVING untouched for ATTR=' || v_trgt_attr || ' VALUE=' || v_trgt_value,1);
        delete_query_elements( v_namespace_id
                             , p_query_id
                             ,'//criteria[parameters//parameter/text()="' || crs.attr_name || '"]/parameters/untouched'
                             );

      end if;
      
      else
      
        further_pkg.log_msg($$PLSQL_UNIT,'ERROR', v_intro_msg || ' 11 ' || v_attr_error_msg,1);      
     
    end if; -- no error msg

    v_error_msg := v_error_msg || v_attr_error_msg;
  end loop; -- attr loop
  

  delete query_temp_attr where query_id = p_query_id and namespace_id=v_namespace_id;

  /* ----------------------------------------------------------
   * Check for translation errors - throw excpetion when found
   * ----------------------------------------------------------*/
  
    if length( v_error_msg ) > 0 then
      further_pkg.log_msg($$PLSQL_UNIT, v_intro_msg || 'ERROR', '12 ' || v_error_msg, 1);
      RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg );
    end if;

END TRANS_QUERY_DEMOG_UUEDW_APO;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_ENCNTR_UUEDW
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_ENCNTR_UUEDW" ( p_query_id number ) AS 

  v_attr varchar2(100);
  v_data_type varchar2(100);
  v_trgt_attr varchar2(100);
  v_attr_count number;
  v_is_valid_attr number;
  v_is_trans_attr number;
  v_is_trans_attr_value number;
  v_is_trans_attr_type number;
  v_new_alias varchar2(100);
  v_translated_attr varchar2(100);
  v_working_aliased_attr varchar2(100);
  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  v_alias_iter number;
  v_length_of_stay_units varchar2(100);
  v_los_units_nmspc_id varchar2(100);

BEGIN

  v_intro_msg := 'QUERY( UUEDW:' || p_query_id || ') ';
  v_alias_iter := 0;

  /* for each encounter alias */
  for c1 in 
    (select extract(column_value, '/alias/key/text()', const.get_query_xml_namespace).getstringval() c_alias,
            extract(column_value, '/alias/value/text()', const.get_query_xml_namespace).getstringval() c_object
     from query_def q
         ,table(xmlsequence( q.query_xml.extract('//aliases/alias[value/text()="encounters"]', const.get_query_xml_namespace) ) )
     where query_id = p_query_id) loop

    further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'START TRANSLATION ALIAS=' || c1.c_alias || ' OBJECT=' || c1.c_object,1);
    v_alias_iter := v_alias_iter + 1;

    -- for each attribute of this alias
    for c2 in (
          select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_aliased_attr
          from query_def q,
            table(xmlsequence
                  (q.query_xml.extract
                    ('//parameter[ora:contains(text(),"' || c1.c_alias || '.")>0]', const.get_query_xml_namespace)
                  )
                )
          where q.query_id = p_query_id
    ) loop 

      v_new_alias := 'nEnc' || v_alias_iter;
      v_attr := get_attr_name_from_obj_attr( c2.c_aliased_attr );
      v_trgt_attr := v_attr;

      v_is_valid_attr := is_valid_attr( const.get_frthr_enc_asset_id, v_attr );
      
      if v_is_valid_attr = 0 then 
        v_error_msg := 'Invalid attribute: ' || c2.c_aliased_attr;
      end if;

      select count(1)+1 into v_attr_count -- the nth occurance of this attribute
      from query_temp_attr
      where query_id = p_query_id
        and namespace_id = const.get_uuedw_namespace_id
        and attr_name = c2.c_aliased_attr;
      
      insert into query_temp_attr values( const.get_uuedw_namespace_id, p_query_id, c2.c_aliased_attr );

      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'PROCESSING ' || c2.c_aliased_attr || '[' || v_attr_count || ']',1);

      v_working_aliased_attr := c2.c_aliased_attr;
              
      v_is_trans_attr := is_trans_attr( const.get_frthr_enc_asset_id, const.get_uuedw_enc_asset_id, v_attr );
      v_is_trans_attr_value := is_trans_attr_value( p_query_id, const.get_frthr_enc_asset_id, const.get_uuedw_enc_asset_id, v_attr );
      v_is_trans_attr_type := is_trans_attr_data_type( const.get_frthr_enc_asset_id, const.get_uuedw_enc_asset_id, v_attr );

      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'TRANSLATION SPECS: ATTR=' || v_attr || ' TRANS ATTR=' 
                || v_is_trans_attr || ' VALUE=' || v_is_trans_attr_value || ' TYPE=' || v_is_trans_attr_type  ,1);

      if v_is_trans_attr = 1 then
      
        v_trgt_attr := get_translated_attribute( const.get_frthr_enc_asset_id, const.get_uuedw_enc_asset_id, v_attr );  
        v_trgt_attr := v_new_alias || '.' || v_trgt_attr;
        v_working_aliased_attr := v_trgt_attr;
        
        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'TRANSLAING ATTR: ' || c2.c_aliased_attr || ' TO: ' || v_trgt_attr, 1);

        update query_temp qn 
           set query_xml = updatexml( 
               qn.query_xml
              ,'//parameter[text()="' || c2.c_aliased_attr || '"][1]/text()'
              , v_trgt_attr
              , const.get_query_xml_namespace )
        where qn.query_id = p_query_id
          and qn.namespace_id = const.get_uuedw_namespace_id;
      
      end if;
      
      if v_is_trans_attr_type = 1 then
      
        v_data_type := get_trans_assoc_prop( const.get_frthr_enc_asset_id, const.get_uuedw_enc_asset_id, v_attr, 'ATTR_VALUE_TRANS_TO_DATA_TYPE' );

        update query_temp q
           set q.query_xml = updatexml( 
                              q.query_xml
                            , '//parameters[parameter/text()="' || v_working_aliased_attr || '"]'
                                       ||' /parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]/@xsi:type'
                            , v_data_type
                            , const.get_query_xml_namespace)
        where q.query_id = p_query_id
          and q.namespace_id = const.get_uuedw_namespace_id;
     
      end if;
      
      -- validation: when there is a length of stay make sure the units are days, otherwise not supported
      if v_attr = 'lengthOfStay' then
      
        v_los_units_nmspc_id := GET_SIMPLE_QUERY_ATTR_VALUE_N(p_query_id, c1.c_alias, 'lengthOfStayUnitsNamespaceId', v_attr_count );
        v_length_of_stay_units := GET_SIMPLE_QUERY_ATTR_VALUE_N(p_query_id, c1.c_alias, 'lengthOfStayUnits', v_attr_count );
        
        -- standard namespace for units is SNOMED, code for days = 258703001
        if v_length_of_stay_units is null or length(v_length_of_stay_units) = 0 then

          v_error_msg := 'Attribute lengthOfStayUnits is a REQUIRED FIELD when querying lengthOfStay';

        elsif v_length_of_stay_units <> '258703001' or v_los_units_nmspc_id <> const.get_snomed_namespace_id  then
        
          v_error_msg := 'UUEDW DOES NOT SUPPORT lengthOfStayUnits namespace=' || v_los_units_nmspc_id || ' value=' || v_length_of_stay_units;
        
        end if;
        
        delete_query_elements( const.get_uuedw_namespace_id
                             , p_query_id
                             ,'(//criteria[parameters/parameter/text()="' || c1.c_alias || '.lengthOfStayUnits"])[' || v_attr_count || ']' );
        
      end if;

      delete_query_elements( const.get_uuedw_namespace_id
                           , p_query_id
                           ,'(//criteria[parameters/parameter[text()="' || v_trgt_attr || '"]])[' || v_attr_count || ']/parameters/untouched' );

      delete_query_elements( const.get_uuedw_namespace_id
                           , p_query_id
                           ,'//alias[key/text()="' || c1.c_alias || '"]/untouchedAlias' );

    
    end loop;
    
    UPDATE_QUERY_OBJECT_ALIAS(const.get_uuedw_namespace_id, p_query_id, c1.c_alias, v_new_alias, c1.c_object);

  end loop;

  if length( v_error_msg ) > 0 then
    RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg);
  end if;
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'END',1);

END TRANS_QUERY_ENCNTR_UUEDW;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_IH_APO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_IH_APO" ( p_query_id number ) AS

  v_intro_msg varchar2(50);
  v_namespace_id number;
  
BEGIN

  v_intro_msg := 'QUERY( IH_APO:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  
  v_namespace_id := const.get_ih_apo_namespace_id ;
  prepare_new_query( v_namespace_id, p_query_id );
  
  /* --------------------------------------------- */
  /* Translate person - root attributes (no alias) */
  /* --------------------------------------------- */
  
  TRANS_QUERY_DEMOG_IH_APO( p_query_id );
  
  TRANS_QUERY_OBS_IH_APO( p_query_id );
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'DELETE *NamespaceId',1);

  update query_temp q
  set q.query_xml = deleteXML( q.query_xml, '//criteria[parameters/parameter[ora:contains(text(),"%NamespaceId")>0]]', const.get_query_xml_namespace )
  where query_id = p_query_id
    and namespace_id = v_namespace_id;

  TRANS_QUERY_SUBQ( v_namespace_id, p_query_id );
  
  check_translated_query( v_namespace_id, p_query_id );
  
  /* --------------------------------------------------------------------- */
  /* Query translation done, add query to query_nmspc for Java interpreter */
  /* --------------------------------------------------------------------- */
  insert into query_nmspc 
    select query_id, v_namespace_id, query_xml 
    from query_temp 
    where query_id = p_query_id
      and namespace_id = v_namespace_id;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END',1);
    
END TRANS_QUERY_IH_APO;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_LCTN_UPDBL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_LCTN_UPDBL" ( p_query_id number ) AS 

  v_iter number;
  v_person_lctn_type varchar2(100);
  v_lctn_val varchar2(255);
  v_lctn_type varchar2(100);
  v_translated_value varchar2(100);
  v_xpath varchar2(1000);
  v_xpath2 varchar2(1000);
  v_attr_update varchar2(100);
  v_val_update varchar2(100);
  v_attr varchar2(100);
  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);


BEGIN

  v_intro_msg := 'QUERY( UPDBL:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'BEGIN',1);
  v_iter := 0;
  /* for each Location alias */
  for cc in 
    (select extract(column_value, '/alias/key/text()', const.get_query_xml_namespace).getstringval() v_alias,
            extract(column_value, '/alias/value/text()', const.get_query_xml_namespace).getstringval() v_object
     from query_def q
         ,table(xmlsequence( q.query_xml.extract('//aliases/alias[value/text()="locations"]', const.get_query_xml_namespace) ) )
     where query_id = p_query_id) loop
     
     v_iter := v_iter + 1;
     v_attr_update := null;
          
     v_person_lctn_type := GET_SIMPLE_QUERY_ATTR_VALUE( p_query_id, cc.v_alias, 'personLocationType');
     v_lctn_type := GET_SIMPLE_QUERY_ATTR_VALUE( p_query_id, cc.v_alias, 'locationType');
     
     further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'PROCESSING ' || cc.v_alias || '.' || cc.v_object || ' TYPE=' || v_person_lctn_type, 1);
     v_attr_update := 'NONE';
     
     if ( v_person_lctn_type = 'CurrentLocation' and v_lctn_type = 'Health District Group' ) then

         v_attr_update := 'current_HDG';

     elsif ( v_person_lctn_type = 'BirthLocation' and v_lctn_type = 'Health District Group' ) then

         v_attr_update := 'birth_HDG';

     -- NOT SUPPORTED 
     --elsif ( v_person_lctn_type = 'DeathLocation' and v_lctn_type = 'Health District Group' ) then

         --v_attr_update := 'death_HDG';

     end if;

     if v_attr_update <> 'NONE' then -- update the attr

       -- update attr 
       update query_temp q
       set q.query_xml = updatexml( 
           q.query_xml
         , '//parameter[text()="' || cc.v_alias || '.location"]/text()'
         , v_attr_update, const.get_query_xml_namespace)
       where q.query_id = p_query_id
         and q.namespace_id = const.get_updbl_namespace_id;       

       if sql%rowcount = 0 then 
         v_error_msg := v_error_msg || 'ATTR UPDATE ERROR: ATTR="' || cc.v_alias || '.location" was NOT updated. ';           
       end if;
       
     else 
         v_error_msg := v_error_msg || 'ATTR TRANSLATION NOT SUPPORTED: personLocationType=' || v_person_lctn_type || ' and locationType=' || v_lctn_type || ' is not supported by UPDBL. ';           
     end if;
     
     /* ------------------------------------- */
     /* Update attr VALUE to UPDBL attr VALUE */
     /* ------------------------------------- */
     -- get and process location value(s) from query
     for attr in (
       SELECT extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() v_value
       FROM query_def q ,
         TABLE(xmlsequence( q.query_xml.extract('//parameters[parameter[text()="' || cc.v_alias || '.location"]] '
                                             || '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]' , const.get_query_xml_namespace) ) )
       WHERE query_id   = p_query_id
     ) loop

         -- get translated location value from DTS
         v_translated_value := dts.GET_TRANSLATED_CONCEPT_VALUE( const.get_further_ontylog_nmspc_id, 'Code in Source', attr.v_value, const.get_updbl_namespace_id , 'Local Code' );
         further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'VALUE TRANSLATION: ATTR="location" OLD_VAL="' || attr.v_value || '" NEW_VAL="' || v_translated_value || '"',1);

         if length(v_translated_value) > 0 then
             
           -- update attr value
           update query_temp q
           set q.query_xml = updatexml( 
               q.query_xml
             , '//parameters[parameter[text()="' || v_attr_update || '"]]/parameter[text()="' || attr.v_value || '"]/text()'
             , v_translated_value, const.get_query_xml_namespace)
           where q.query_id = p_query_id
             and q.namespace_id = const.get_updbl_namespace_id;
             
           if sql%rowcount = 0 then 
             v_error_msg := v_error_msg || 'ATTR VALUE UPDATE ERROR: ATTR="' || v_attr_update || '" VALUE="' || attr.v_value || '" ';           
           end if;

         else
           v_error_msg := v_error_msg || 'VALUE TRANSLATION NOT SUPPORTED: ATTR="' || v_attr_update || '" VALUE="' || attr.v_value || '" ';
         end if;

     end loop;

     delete_query_elements( const.get_updbl_namespace_id
                            , p_query_id, '//criteria/parameters[parameter/text()="' || v_attr_update || '"]/untouched');
            
     -- delete location criteria for this alias - personLocationType and locationType (namespace which is handled later) 
     update query_temp q
       set q.query_xml = deletexml( q.query_xml
                                  , '//criteria[parameters/parameter/text()="' || cc.v_alias || '.personLocationType" ' ||
                                            'or parameters/parameter/text()="' || cc.v_alias || '.locationType"]'
                                  , const.get_query_xml_namespace)
     where q.query_id = p_query_id
         and q.namespace_id = const.get_updbl_namespace_id;
         
     -- delete aliases - the new attrs are root elements ...?
     update query_temp q
       set q.query_xml = deletexml( q.query_xml
                                  , '//alias[key/text()="' || cc.v_alias || '"]'
                                  , const.get_query_xml_namespace)
     where q.query_id = p_query_id
         and q.namespace_id = const.get_updbl_namespace_id;
            
  end loop;      
  
  if length( v_error_msg ) > 0 then
    RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg);
  end if;
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'END',1);

END TRANS_QUERY_LCTN_UPDBL;
 

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_LCTN_UUEDW
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_LCTN_UUEDW" ( p_query_id number ) AS 

  v_iter number;
  v_person_lctn_type varchar2(100);
  v_lctn_val varchar2(255);
  v_lctn_type varchar2(100);
  v_translated_value varchar2(100);
  v_xpath varchar2(1000);
  v_xpath2 varchar2(1000);
  v_attr_update varchar2(100);
  v_val_update varchar2(100);
  v_attr varchar2(100);
  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  v_new_location clob;


BEGIN

  v_intro_msg := 'QUERY( UUEDW:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'BEGIN',1);
  v_iter := 0;
  /* for each locations alias */
  for cc in 
    (select extract(column_value, '/alias/key/text()', const.get_query_xml_namespace).getstringval() v_alias,
            extract(column_value, '/alias/value/text()', const.get_query_xml_namespace).getstringval() v_object
     from query_def q
         ,table(xmlsequence( q.query_xml.extract('//aliases/alias[value/text()="locations"]', const.get_query_xml_namespace) ) )
     where query_id = p_query_id) loop
     
     v_iter := v_iter + 1;
     v_attr_update := null;
          
     v_person_lctn_type := GET_SIMPLE_QUERY_ATTR_VALUE( p_query_id, cc.v_alias, 'personLocationType');
     v_lctn_type := GET_SIMPLE_QUERY_ATTR_VALUE( p_query_id, cc.v_alias, 'locationType');
     
     further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'PROCESSING ' || cc.v_alias || '.' || cc.v_object || ' PERSON LOCATION TYPE=' || v_person_lctn_type || ' LOCATION TYPE=' || v_lctn_type, 1);
     
     /* ------------------------------------------------------ */
     /* Location Type can only be "Current" location for UUEDW */
     /* ------------------------------------------------------ */
     if ( v_person_lctn_type = 'CurrentLocation' ) then

       /* ------------------------- */
       /* Update attr to UUEDW attr */
       /* ------------------------- */
       -- get translated location type from DTS
       -- v_lctn_val := dts.GET_CONCEPT_PROP_VAL( const.get_further_ontylog_nmspc_id , 'Code in Source', attr.v_value, 'Type of Location' );

       v_attr_update := 'NONE';
       
       if v_lctn_type = 'State' then                   
         v_attr_update := 'stateDwid';
       elsif v_lctn_type = 'County' or v_lctn_type = 'Health District Group' then
         v_attr_update := 'countyDwid';       
       end if;
       
       if v_attr_update <> 'NONE' then -- update the attr
       
         if v_lctn_type = 'Health District Group' then -- Build a whole new criteria chunk and update it replaing the old
       
           v_new_location := '<criteria xmlns="http://further.utah.edu/core/query" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><searchType>IN</searchType><parameters><parameter xsi:type="xs:string">' || v_attr_update || '</parameter>';
  
           for param in (
             SELECT extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() val
             FROM query_def q ,
               TABLE(xmlsequence( q.query_xml.extract('//parameters[parameter[text()="' || cc.v_alias || '.location"]] '
                                                || '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]' , const.get_query_xml_namespace) ) )
             WHERE query_id = p_query_id
           ) loop
           
           
             for cparam in (
               select * from table( dts.get_concept_children( 32771, 'Code in Source', param.val , 'HasPart', 0 ) )             
             ) loop

               v_translated_value := dts.GET_TRANSLATED_CONCEPT_VALUE( const.get_further_ontylog_nmspc_id, 'Code in Source', cparam.property_val , const.get_uuedw_namespace_id , 'Local Code' );
               further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'VALUE TRANSLATION: ATTR="location" OLD_VAL="' || cparam.property_val || '" NEW_VAL="' || v_translated_value || '"',1);
                   
               v_new_location := v_new_location || '<parameter xsi:type="xs:integer">' || v_translated_value || '</parameter>';
             
             end loop;
           
           end loop;
  
           v_new_location := v_new_location ||  '</parameters></criteria>';
           
           --further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'UPDATE LOCATION criteria element to: ' || v_new_location,1);

           update query_temp q
           set q.query_xml = updatexml( 
               q.query_xml
             , '//parameter[text()="' || cc.v_alias || '.location"]/../..'
             , xmltype( v_new_location ), const.get_query_xml_namespace)
           where q.query_id = p_query_id
             and q.namespace_id = const.get_uuedw_namespace_id;       
  
         else

           -- update attr 
           update query_temp q
           set q.query_xml = updatexml( 
               q.query_xml
             , '//parameter[text()="' || cc.v_alias || '.location"]/text()'
             , v_attr_update, const.get_query_xml_namespace)
           where q.query_id = p_query_id
             and q.namespace_id = const.get_uuedw_namespace_id;       
  
           if sql%rowcount = 0 then 
             v_error_msg := v_error_msg || 'ATTR UPDATE ERROR: attribute="' || cc.v_alias || '.location" ';           
           end if;
         
         end if;
       
       else 
         v_error_msg := v_error_msg || 'TRANSLATION ERROR: locationType="' || v_lctn_type || '" IS NOT SUPPORTED. ';           
       end if;
     
       /* ------------------------------------- */
       /* Update attr VALUE to UUEDW attr VALUE */
       /* ------------------------------------- */
       -- get and process location value(s) from query
       if v_lctn_type <> 'Health District Group' then
       for attr in (
         SELECT extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() v_value
         FROM query_def q ,
           TABLE(xmlsequence( q.query_xml.extract('//parameters[parameter[text()="' || cc.v_alias || '.location"]] '
                                            || '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]' , const.get_query_xml_namespace) ) )
         WHERE query_id   = p_query_id
       ) loop

         -- get translated location value from DTS
         v_translated_value := dts.GET_TRANSLATED_CONCEPT_VALUE( const.get_further_ontylog_nmspc_id, 'Code in Source', attr.v_value, const.get_uuedw_namespace_id , 'Local Code' );
         further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'VALUE TRANSLATION: ATTR="location" OLD_VAL="' || attr.v_value || '" NEW_VAL="' || v_translated_value || '"',1);

         if length(v_translated_value) > 0 then
             
           -- update attr value
           update query_temp q
           set q.query_xml = updatexml( 
               q.query_xml
             , '//parameters[parameter[text()="' || v_attr_update || '"]]/parameter[text()="' || attr.v_value || '"]/@xsi:type'
             , 'xs:integer'
             , '//parameters[parameter[text()="' || v_attr_update || '"]]/parameter[text()="' || attr.v_value || '"]/text()'
             , v_translated_value, const.get_query_xml_namespace)
           where q.query_id = p_query_id
             and q.namespace_id = const.get_uuedw_namespace_id;
             
           if sql%rowcount = 0 then 
             v_error_msg := v_error_msg || 'ATTR VALUE UPDATE ERROR: attribute="' || v_attr_update || '" value="' || attr.v_value || '" ';           
           end if;

         else
           v_error_msg := v_error_msg || 'VALUE TRANSLATION ERROR: attribute="' || v_attr_update || '" value="' || attr.v_value || '" ';
         end if;

       end loop;
       
       end if;

       -- based on success of updates delete "untouched"
       delete_query_elements( const.get_uuedw_namespace_id
                            , p_query_id, '//criteria[parameters/parameter/text()="' || v_attr_update || '"' ||
                                                ' and ../criteria/parameters/parameter/text()="' || cc.v_alias || '.personLocationType"]/parameters/untouched');
            
       -- delete other location criteria - personLocationType, locationType (except namespace which is handled later) 
         
       update query_temp q
       set q.query_xml = deletexml( q.query_xml
                                  , '//criteria[parameters/parameter/text()="' || cc.v_alias || '.personLocationType" ' ||
                                            'or parameters/parameter/text()="' || cc.v_alias || '.locationType" ' ||
                                            'or parameters/parameter/text()="' || cc.v_alias || '.locationNamespaceId"]'
                                  , const.get_query_xml_namespace)
       where q.query_id = p_query_id
         and q.namespace_id = const.get_uuedw_namespace_id;
         
       -- delete aliases - the attrs are root elements ...?
       update query_temp q
       set q.query_xml = deletexml( q.query_xml
                                  , '//alias[key/text()="' || cc.v_alias || '"]'
                                  , const.get_query_xml_namespace)
       where q.query_id = p_query_id
         and q.namespace_id = const.get_uuedw_namespace_id;
            
     end if;

  end loop;      
  
  if length( v_error_msg ) > 0 then
    RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg);
  end if;
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'END',1);

END TRANS_QUERY_LCTN_UUEDW;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_OBS_IH_APO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_OBS_IH_APO" ( p_query_id number ) AS 

  v_namespace_id number;
  v_iter number;
  v_phrase_index number;
  v_value_index number;
  v_value_type varchar2(20);
  v_trans_value_index number;
  v_chunk_index number;
  v_chunk_xml xmltype;
  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  v_attr_nm varchar2(100);
  v_attr_value varchar2(100);
  v_clob clob;
  v_is_rootCriterion number;

BEGIN

  v_intro_msg := 'QUERY( IH_APO:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'BEGIN',1);
  v_iter := 0;
  v_namespace_id := const.get_ih_apo_namespace_id;
  
  -- for each alias
  for c1 in 
    (select extract(column_value, '/alias/key/text()', const.get_query_xml_namespace).getstringval() c_alias,
            extract(column_value, '/alias/value/text()', const.get_query_xml_namespace).getstringval() c_object
     from query_def q
         ,table(xmlsequence( q.query_xml.extract('//aliases/alias[value/text()="observations"]', const.get_query_xml_namespace) ) )
     where query_id = p_query_id) loop
     
     further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'ALIAS="' || c1.c_alias || '"',1);
          
     v_phrase_index := 0;
     -- for each observation phrase of this alias - extract each observation type for the given alias
     for c2 in (
         select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_obs_type_str
         from query_def q,
           table(xmlsequence
                 (q.query_xml.extract
                   ('//searchType[text()="CONJUNCTION"]/../criteria/parameters/parameter[text()="' || c1.c_alias || '.observationType"]/../parameter[3]', const.get_query_xml_namespace)
                 )
               )
         where q.query_id = p_query_id
     ) loop 

        v_iter := v_iter + 1; -- tracks total number of observation phrases
        v_phrase_index := v_phrase_index + 1;
        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'PROCESSING ' || c1.c_alias || '=' || c2.c_obs_type_str,1);
        
        v_value_index := 0; -- tracks the total number of values in an observation phrase
        v_chunk_index := 0; -- tracks the total number of translated values in an observation phrase - should be GTE v_value_index after translations
        v_clob := null;
        
        -- loop through each observation value in the IN statement and stack the new phrases 
        for c3 in (
          select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_value
          from query_def q
              ,table(xmlsequence( q.query_xml.extract('(//parameters[parameter[text()="' || c1.c_alias || '.observation' ||'"]])[' || v_phrase_index || ']' ||
                                                       '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]'
                                                      ,const.get_query_xml_namespace) ) )
          where query_id = p_query_id
        ) loop
        
          v_value_index := v_value_index + 1;
          v_trans_value_index := 0; -- tracks the number of translations for this value

          further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'PROCESSING value=' || c3.c_value || ' chunk index=' || v_chunk_index || ' value index=' || v_value_index,1);
          
          for c4 in ( -- for each translated value for this logical value
            select rs_attr_label, rs_attr_val
            from fmdr.asset_trans_map_v
            where ls_attr_id = 295
              and ls_attr_val = c3.c_value)
          loop
        
            v_trans_value_index := v_trans_value_index + 1;
            v_chunk_index := v_chunk_index + 1;
            
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'PROCESSING value=' || c3.c_value || ' translation to ' || c4.rs_attr_label || '=' || c4.rs_attr_val || ' DISJUNCTION index=' || v_chunk_index || ' trans value index=' || v_trans_value_index,1);
        
            v_attr_value := null;
            
            if c4.rs_attr_val = '{}' then -- need to fetch the value from the observation phrase
              v_attr_value := get_string_value_by_xpath( v_namespace_id, p_query_id, '(//searchType[text()="CONJUNCTION"]/../../*/criteria/parameters[parameter/text()="' || c1.c_alias || '.valueNumber"])[1]/parameter[3]/text()' ); 
            else
              v_attr_value := c4.rs_attr_val;
            end if;
            
            if is_numeric( v_attr_value ) = 1 then 
              v_value_type := 'xs:long';
            else
              v_value_type := 'xs:string';
            end if;
                    
            v_clob := v_clob ||            
'<criteria xmlns="http://further.utah.edu/core/query" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <searchType>SIMPLE</searchType>
    <parameters>
      <parameter xsi:type="RelationType">EQ</parameter>
			<parameter xsi:type="xs:string">' || c4.rs_attr_label || '</parameter>
			<parameter xsi:type="' || v_value_type || '">' || v_attr_value || '</parameter>
    </parameters>
</criteria>';

          end loop; -- for each translated value
                  
          if v_trans_value_index = 0 then
            v_error_msg := v_error_msg || 'VALUE TRANSLATION ERROR: No translation currently exists for attribute=' || c1.c_alias || '.observation value="' || c3.c_value || '" ';
            --further_pkg.log_msg($$PLSQL_UNIT,'ERROR',v_intro_msg || v_error_msg ,1);       
          end if;
        
       end loop; -- for each observation value

       if v_chunk_index > 1 then 
          
         v_clob := 
'<criteria xmlns="http://further.utah.edu/core/query" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <searchType>DISJUNCTION</searchType>' || v_clob || '</criteria>'; 
  
       end if;
       
       --further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || v_clob ,1);       

       if v_error_msg is null then  

         -- determine if parent node of the observation phase is rootCriterion or criteria
         select count(1) into v_is_rootCriterion
         from query_def q
         where query_id = p_query_id
           and q.query_xml.existsNode('(//searchType[text()="CONJUNCTION"]/../../rootCriterion[criteria/parameters/parameter/text()="' || c1.c_alias || '.observation"])[1]'
                        ,const.get_query_xml_namespace) = 1;

         if v_is_rootCriterion = 1 then

           v_clob := 
  '<rootCriterion xmlns="http://further.utah.edu/core/query" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <searchType>CONJUNCTION</searchType>' || v_clob || '</rootCriterion>'; 

           update query_temp
           set query_xml = 
                updatexml(query_xml
                           ,'(//searchType[text()="CONJUNCTION"]/../../rootCriterion[criteria/parameters/parameter/text()="' || c1.c_alias || '.observation"])[1]'
                           , xmltype(v_clob)
                           , const.get_query_xml_namespace )
           where query_id = p_query_id
             and namespace_id = const.get_ih_apo_namespace_id ;
           
         else
         
           update query_temp
           set query_xml = 
                updatexml(query_xml
                           ,'(//searchType[text()="CONJUNCTION"]/../../*[criteria/parameters/parameter/text()="' || c1.c_alias || '.observation"])[1]'
                           , xmltype(v_clob)
                           , const.get_query_xml_namespace )
           where query_id = p_query_id
             and namespace_id = const.get_ih_apo_namespace_id ;

         end if;

       end if;
       
       --insert into query_temp_chunk values( v_namespace_id, p_query_id, c1.c_alias || '.observation', v_phrase_index, v_value_index, xmltype(v_clob));

     end loop; -- for each alias observation phrase 

     delete_query_elements( v_namespace_id, p_query_id, '//alias[key/text()="' || c1.c_alias || '"]');
     
  end loop; -- for each alias      
  
  if length( v_error_msg ) > 0 then
     RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg);
  end if;
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'END',1);

END TRANS_QUERY_OBS_IH_APO;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_OBS_UPDBL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_OBS_UPDBL" ( p_query_id number ) AS 

  v_iter number;
  v_new_alias varchar2(100);
  v_new_aliased_attr varchar2(100);
  v_xpath varchar2(1000);
  v_xpath2 varchar2(1000);
  v_update varchar2(100);
  v_update2 varchar2(100);
  v_attr varchar2(100);
  v_attr_count number;
  v_icd9_attr_count number;
  v_icd10_attr_count number;
  v_updbl_attr_count number;
  v_time_attr_count number;
  v_is_trans_attr number;
  v_is_trans_attr_value number;
  v_nmspc_id number;
  v_mod_nmspc_id number;
  v_obs_attr varchar2(100);
  v_working_attr varchar2(100);
  v_translated_attr varchar2(100);
  v_translated_mod_attr varchar2(100);
  v_translated_value varchar2(100);
  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  v_obs_type_iter number;
  v_value1 varchar2(4000);
  v_value2 varchar2(4000);

BEGIN

  v_intro_msg := 'QUERY( UPDB:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'BEGIN',1);
  v_iter := 0;
  
  -- for each alias
  for c1 in 
    (select extract(column_value, '/alias/key/text()', const.get_query_xml_namespace).getstringval() c_alias,
            extract(column_value, '/alias/value/text()', const.get_query_xml_namespace).getstringval() c_object
     from query_def q
         ,table(xmlsequence( q.query_xml.extract('//aliases/alias[value/text()="observations"]', const.get_query_xml_namespace) ) )
     where query_id = p_query_id) loop
     
     v_obs_type_iter := 0;
     v_icd9_attr_count := 0;
     v_icd10_attr_count := 0;
     v_updbl_attr_count := 0;
     
     further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'ALIAS="' || c1.c_alias || '"',1);
          
     -- for each observation phrase of this alias - extract each observation type for the given alias
     for c2 in (
         select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_obs_type_str
         from query_def q,
           table(xmlsequence
                 (q.query_xml.extract
                   ('//searchType[text()="CONJUNCTION"]/../criteria/parameters/parameter[text()="' || c1.c_alias || '.observationType"]/../parameter[3]', const.get_query_xml_namespace)
                 )
               )
         where q.query_id = p_query_id
     ) loop 

        v_iter := v_iter + 1; -- tracks total number of observation phrases, not just for this alias 
        v_obs_type_iter := v_obs_type_iter + 1;    
        
        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'PROCESSING ' || c1.c_alias || '=' || c2.c_obs_type_str,1);
     
        /* ---------------------- */
        /* OBSERVATION TYPE = DX  */
        /* ---------------------- */
        if ( c2.c_obs_type_str = const.get_observation_type_dx ) then 
     
           v_nmspc_id := to_number( get_query_obs_phrase_nmspc_id( p_query_id, c1.c_alias || '.observationNamespaceId', c1.c_alias || '.observationType', 'Dx', v_obs_type_iter) ); 
           v_mod_nmspc_id := to_number( get_query_obs_phrase_nmspc_id( p_query_id, c1.c_alias || '.observationModNamespaceId', c1.c_alias || '.observationType', 'Dx', v_obs_type_iter) ); 
           v_translated_mod_attr := '';
       
           if v_nmspc_id = const.get_icd9_namespace_id then 
              v_translated_attr := 'Diagnosis.icd9Code';
              v_icd9_attr_count := v_icd9_attr_count + 1;
           elsif v_nmspc_id = const.get_icd10_namespace_id then
              v_translated_attr := 'Diagnosis.icd10Code';   
              v_icd10_attr_count := v_icd10_attr_count + 1;
           elsif v_nmspc_id = const.get_updbl_namespace_id and v_mod_nmspc_id = const.get_updbl_namespace_id then
              v_translated_attr := 'Diagnosis.icdo_seer';   
              v_translated_mod_attr := 'Diagnosis.cancerBehaviorCode';                 
              v_updbl_attr_count := v_updbl_attr_count + 1;
           else  
              v_error_msg := v_error_msg || 'Invalid namespace id "' || v_nmspc_id || '" declared for UPDB Dx. ';
              v_translated_attr := '';
           end if;
     
           if length( v_translated_attr ) > 0 then
        
              insert into query_temp_attr values ( const.get_updbl_namespace_id, p_query_id, v_translated_attr  );
           
              select count(1) into v_attr_count
              from query_temp_attr q
              where q.query_id = p_query_id 
                and q.namespace_id = const.get_updbl_namespace_id
                and q.attr_name = v_translated_attr;

              further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'ATTR UPDATE FROM ' || c1.c_alias || '.observation TO ' || v_translated_attr ,1);

              /* change <alias>.observation to Diagnosis.<new-attr> */
              update query_temp q
              set q.query_xml = updatexml( 
                q.query_xml
              , '(//parameter[text()="' || c1.c_alias || '.observation"])[1]/text()'
              , v_translated_attr, const.get_query_xml_namespace)
              where q.query_id = p_query_id
                and q.namespace_id = const.get_updbl_namespace_id;

              if length( v_translated_mod_attr ) > 0 then

                update query_temp q
                set q.query_xml = updatexml( 
                  q.query_xml
                , '(//parameter[text()="' || c1.c_alias || '.observationMod"])[1]/text()'
                , v_translated_mod_attr, const.get_query_xml_namespace)
                where q.query_id = p_query_id
                  and q.namespace_id = const.get_updbl_namespace_id;

              end if;
           
              if sql%rowcount = 0 then
                 v_error_msg := v_error_msg || 'UPDATE FROM ' || c1.c_alias || '.observation TO ' || v_translated_attr || ' FAILED. ';
              end if;

              if v_nmspc_id = const.get_icd9_namespace_id then 
                 delete_query_elements( const.get_updbl_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_translated_attr || '"])['|| v_icd9_attr_count ||']/parameters/untouched');
              elsif v_nmspc_id = const.get_icd10_namespace_id then
                 delete_query_elements( const.get_updbl_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_translated_attr || '"])['|| v_icd10_attr_count ||']/parameters/untouched');
              elsif v_nmspc_id = const.get_updbl_namespace_id then
                 delete_query_elements( const.get_updbl_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_translated_attr || '"])['|| v_updbl_attr_count ||']/parameters/untouched');
                 delete_query_elements( const.get_updbl_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_translated_mod_attr || '"])['|| v_updbl_attr_count ||']/parameters/untouched');
              end if;
         
        end if;

        -- get the first (untranslated) time value/range (previous instances are translated already)
        v_value1 := get_string_value_by_xpath( const.get_updbl_namespace_id, p_query_id, '(//parameters[parameter[text()="' || c1.c_alias || '.startDateTime"]])[1]/parameter[(position()=3 and ../../searchType/text()="SIMPLE") or (position()=2 and ../../searchType/text()!="SIMPLE")]/text()');
        v_value2 := get_string_value_by_xpath( const.get_updbl_namespace_id, p_query_id, '(//parameters[parameter[text()="' || c1.c_alias || '.startDateTime"]])[1]/parameter[position()=3 and ../../searchType/text()!="SIMPLE"]/text()');
        
        if length( v_value1 )> 0 then -- implies this observation phrase has time criterion.  
        
           --UPDBL queries do not support multiple observation aliases, they all translate to the same object alias 'Diagnosis' in this case

           insert into query_temp_attr values ( const.get_updbl_namespace_id, p_query_id, 'Diagnosis.diagYr' );
           
           select count(1) into v_time_attr_count
           from query_temp_attr q
           where q.query_id = p_query_id 
             and q.namespace_id = const.get_updbl_namespace_id
             and q.attr_name = 'Diagnosis.diagYr';
                   
           -- update the time attrribute
           update query_temp q
             set q.query_xml = updatexml( 
               q.query_xml
              , '(//parameters[parameter[text()="' || c1.c_alias || '.startDateTime"]])[1]/parameter[(position()=3 and ../../searchType/text()="SIMPLE") or (position()=2 and ../../searchType/text()!="SIMPLE")]/text()'
              , substr( v_value1, 1, 4)
              , '(//parameters[parameter[text()="' || c1.c_alias || '.startDateTime"]])[1]/parameter[position()=3 and ../../searchType/text()!="SIMPLE"]/text()'
              , substr( v_value2, 1, 4)
              , '(//parameters[parameter[text()="' || c1.c_alias || '.startDateTime"]])[1]/parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]/@xsi:type'
              , 'xs:int'
              , '(//parameter[text()="' || c1.c_alias || '.startDateTime"])[1]/text()'
              , 'Diagnosis.diagYr', const.get_query_xml_namespace)
           where q.query_id = p_query_id
             and q.namespace_id = const.get_updbl_namespace_id;
  
           -- delete untouched
           delete_query_elements( const.get_updbl_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="Diagnosis.diagYr"])['|| v_time_attr_count ||']/parameters/untouched');

        end if;
     
        /* --------------------------- */
        /* OBSERVATION TYPE Procedure  */
        /* --------------------------- */
        elsif c2.c_obs_type_str = const.get_observation_type_procedure then
           v_error_msg := v_error_msg || ' FURTHeR does not currently support Procedures for UPDBL.  Coming in a future release.';
        else 
           v_error_msg := v_error_msg || 'Observation type "' || c2.c_obs_type_str || '" is not supported in UPDBL. ';
        end if;

     end loop; -- for each alias observation phrase 

     delete_query_elements( const.get_updbl_namespace_id, p_query_id, '//criteria[parameters//parameter/text()="' || c1.c_alias || '.observationType"]');
     delete_query_elements( const.get_updbl_namespace_id, p_query_id, '//alias[key/text()="' || c1.c_alias || '"]');
     
  end loop; -- for each alias      
  
  if length( v_error_msg ) > 0 then
     RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg);
  end if;
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'END',1);

END TRANS_QUERY_OBS_UPDBL;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_OBS_UUEDW
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_OBS_UUEDW" ( p_query_id number ) AS 

  v_iter number;
  v_obs_type_iter number;
  v_alias_obs_type varchar2(100);
  v_new_alias varchar2(100);
  v_new_alias_obj varchar2(100);
  v_new_dx_alias varchar2(100);
  v_new_dx_alias_obj varchar2(100);
  v_new_lab_alias varchar2(100);
  v_new_lab_alias_obj varchar2(100);
  v_new_aliased_attr varchar2(100);
  v_xpath varchar2(1000);
  v_xpath2 varchar2(1000);
  v_update varchar2(100);
  v_update2 varchar2(100);
  v_attr varchar2(100);
  v_is_trans_attr number;
  v_is_trans_attr_value number;
  v_is_trans_attr_type number;
  v_date_value varchar2(100);
  v_value varchar2(100);
  v_type varchar2(100);
  v_translated_attr varchar2(100);
  v_working_attr varchar2(100);
  v_translated_value varchar2(100);
  v_src_nmspc_id number;
  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  v_from_obj_id number;
  v_to_obj_id number;
  v_dx_nmspc_id number;
  v_alias_lab_iter number;
  v_alias_dx_iter number;
  v_attr_count number;
  v_date_value1 varchar2(50);
  v_new_aliased_time_attr varchar2(100);

BEGIN

   v_intro_msg := 'QUERY( UUEDW:' || p_query_id || ') ';
   further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'BEGIN',1);
   v_iter := 0;
  
   -- for each observation alias
   for c1 in 
    (select extract(column_value, '/alias/key/text()', const.get_query_xml_namespace).getstringval() c_alias,
            extract(column_value, '/alias/value/text()', const.get_query_xml_namespace).getstringval() c_object
     from query_def q
         ,table(xmlsequence( q.query_xml.extract('//aliases/alias[value/text()="observations"]', const.get_query_xml_namespace) ) )
     where query_id = p_query_id) loop
     
      v_obs_type_iter := 0;
      v_alias_dx_iter := 0;
      v_alias_lab_iter := 0;
      v_iter := v_iter + 1;     
      v_new_dx_alias := 'dx' || v_iter;
      v_new_dx_alias_obj := 'diagnoses';
      v_new_lab_alias := 'lb' || v_iter;
      v_new_lab_alias_obj := 'labObservations';
      
      further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'START TRANSLATION ALIAS=' || c1.c_alias || ' OBJECT=' || c1.c_object,1);

      -- for each observation phrase of this alias - extract each observation type for the given alias
      for c2 in (
          select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_obs_type_str
          from query_def q,
            table(xmlsequence
                  (q.query_xml.extract
                    ('//searchType[text()="CONJUNCTION"]/../criteria/parameters/parameter[text()="' || c1.c_alias || '.observationType"]/../parameter[3]', const.get_query_xml_namespace)
                  )
                )
          where q.query_id = p_query_id
      ) loop 
       
         v_xpath := null;
         v_xpath2 := null;
         v_update := null;
         v_update2 := null;
         
         v_obs_type_iter := v_obs_type_iter + 1;
         further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'PROCESSING OBSERVATION PHRASE ' || c1.c_alias || '.observationType[' || v_obs_type_iter || ']=' || c2.c_obs_type_str ,1);

         /* ----------------------------------- */
         /* OBSERVATION TYPE = DX OR PROCEDURE  */
         /* ----------------------------------- */
         if ( c2.c_obs_type_str in (const.get_observation_type_dx, const.get_observation_type_procedure) ) then 
        
            v_new_alias := v_new_dx_alias;
            v_new_alias_obj := v_new_dx_alias_obj;
            v_update := v_new_alias || '.id.codeType';
            v_alias_dx_iter := v_alias_dx_iter + 1;
            v_new_aliased_time_attr := v_new_alias || '.admYear'; 

            select q.query_xml.extract( '(//criteria/parameters[parameter/text()="'|| c1.c_alias ||'.observationNamespaceId"])['|| v_obs_type_iter ||']/parameter[3]/text()'
                                      ,const.get_query_xml_namespace ).getnumberval()
            into v_dx_nmspc_id
            from query_def q
            where q.query_id = p_query_id;

            if ( c2.c_obs_type_str = const.get_observation_type_dx ) then 

               -- check to see that the Dx namespace is ICD9 (namespace_id=10), if not set error message.
               if ( v_dx_nmspc_id <> const.get_icd9_namespace_id) then 
                  v_error_msg := v_error_msg || 'UUEDW does not support diagnosis codes from namespace "' || v_dx_nmspc_id || '" ';
               end if;
             
               v_xpath := '(//criteria[parameters//parameter/text()="' || c1.c_alias || '.observationType" ' ||
                            ' and parameters//parameter/text()="Dx"])[1]' || -- in query_temp the updated index is always 1 (previous instances have been translated) 
                             '/parameters/parameter[text()="' || c1.c_alias || '.observationType"]/text()';
               v_xpath2 := '(//criteria[parameters//parameter/text()="' || v_update || '"' ||
                             ' and parameters//parameter/text()="Dx"])[1]/parameters/parameter[text()="Dx"]/text()';
    
               v_update2 := 'ICD9';
           
            elsif ( c2.c_obs_type_str = const.get_observation_type_procedure ) then

               -- check to see that the Dx namespace is ICD9 (namespace_id=10), if not set error message.
               if ( not v_dx_nmspc_id in ( const.get_icd9_namespace_id, const.get_cpt_namespace_id ) ) then -- not ICD9 or CPT4 
                  v_error_msg := v_error_msg || 'UUEDW does not support procedure codes from namespace ' || v_dx_nmspc_id || ' ';
               end if;

               v_xpath := '(//criteria[parameters//parameter/text()="' || c1.c_alias || '.observationType" ' ||
                          ' and parameters//parameter/text()="Procedure"])[1]' || 
                           '/parameters/parameter[text()="' || c1.c_alias || '.observationType"]/text()';
               v_xpath2 := '(//criteria[parameters//parameter/text()="' || v_update || '"' ||
                           ' and parameters//parameter/text()="Procedure"])[1]/parameters/parameter[text()="Procedure"]/text()';
  
               v_update2 := 'CPT4';

            end if;
        
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || v_new_dx_alias || '.observationNamespaceId['|| v_obs_type_iter ||']=' || v_dx_nmspc_id ,1);
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'XPath update "' || v_xpath || '"=' || v_update, 1);
            further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'XPath2 update "' || v_xpath2 || '"=' || v_update2, 1);

            /* change this observation phrase's observationType=Dx to dianosiscodeType=ICD9 */
            update query_temp q
               set q.query_xml = updatexml( q.query_xml
                                    , v_xpath, v_update
                                    , v_xpath2, v_update2
                                    , const.get_query_xml_namespace)
            where q.query_id = p_query_id
              and q.namespace_id = const.get_uuedw_namespace_id;
           
            delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_update ||'"])['|| v_alias_dx_iter ||']/parameters/untouched');
            delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_update2 ||'"])['|| v_alias_dx_iter ||']/parameters/untouched');
         
            /* change observation to dx code */
            update query_temp q
            set q.query_xml = updatexml( 
              q.query_xml
             , '(//criteria/parameters/parameter[text()="' || c1.c_alias || '.observation"])[1]/text()'
             , v_new_dx_alias || '.id.code', const.get_query_xml_namespace)
            where q.query_id = p_query_id
              and q.namespace_id = const.get_uuedw_namespace_id;
           
            delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_new_dx_alias || '.id.code"])['|| v_alias_dx_iter ||']/parameters/untouched');
           
            /* change observation time */
            update query_temp q
            set q.query_xml = updatexml( 
              q.query_xml
             , '(//criteria/parameters/parameter[text()="' || c1.c_alias || '.startDateTime"])[1]/text()'
             , v_new_dx_alias || '.admYear', const.get_query_xml_namespace)
            where q.query_id = p_query_id
              and q.namespace_id = const.get_uuedw_namespace_id;

            delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_new_dx_alias || '.admYear"])['|| v_alias_dx_iter ||']/parameters/untouched');

         end if;  -- procedure or dx
       
        /* ---------------------------- */
        /* OBSERVATION TYPE = LAB       */
        /* ---------------------------- */
        if ( c2.c_obs_type_str = const.get_observation_type_lab ) then 
        
           v_new_alias := v_new_lab_alias;
           v_new_alias_obj := v_new_lab_alias_obj;
           v_alias_lab_iter := v_alias_lab_iter + 1;
           v_new_aliased_time_attr := v_new_alias || '.observationDtTm'; 
            
           -- loop through all lab-related attributes with this alias
           for c3 in (
              select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_aliased_attr
              from query_def q
                  ,table(xmlsequence( q.query_xml.extract('(//*[searchType="CONJUNCTION" and criteria/parameters/parameter[text()="'|| c1.c_alias ||'.observationType"]/../parameter/text()="Lab"])[' || v_alias_lab_iter || ']/criteria/parameters/parameter[ora:contains(text(),"' || c1.c_alias || '.")>0]', const.get_query_xml_namespace) ) )
              where query_id = p_query_id
           ) loop
       
              v_attr := get_attr_name_from_obj_attr( c3.c_aliased_attr );
              v_working_attr := c3.c_aliased_attr;
              
              v_is_trans_attr := is_trans_attr( const.get_analytical_obs_class_id, const.get_uuedw_lab_obs_class_id, v_attr );
              v_is_trans_attr_value := is_trans_attr_value( p_query_id, const.get_analytical_obs_class_id, const.get_uuedw_lab_obs_class_id, v_attr );
              v_is_trans_attr_type := is_trans_attr_data_type( const.get_analytical_obs_class_id, const.get_uuedw_lab_obs_class_id, v_attr );

              further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'BEGIN TRANSLATION ATTR=' || v_attr || ': TRANSLATE ATTR=' 
                || v_is_trans_attr || ' VALUE=' || v_is_trans_attr_value || ' TYPE=' || v_is_trans_attr_type  ,1);

         
              if v_is_trans_attr = 1 then

                 v_translated_attr := get_translated_attribute( const.get_analytical_obs_class_id, const.get_uuedw_lab_obs_class_id, v_attr );
                 v_new_aliased_attr := v_new_lab_alias || '.' || v_translated_attr;
                 v_working_attr := v_new_aliased_attr;
         
                 v_xpath := '(//*[searchType="CONJUNCTION" and criteria/parameters/parameter[text()="'|| c1.c_alias ||'.observationType"]'
                 || '/../parameter/text()="Lab"])['|| v_alias_lab_iter ||']/criteria/parameters/parameter[text()="' || c3.c_aliased_attr || '"]/text()';

                 -- update attr name
                 update query_temp q
                 set q.query_xml = updatexml( 
                       q.query_xml
                     , v_xpath
                     , v_new_aliased_attr
                     , const.get_query_xml_namespace)
                 where q.query_id = p_query_id
                   and q.namespace_id = const.get_uuedw_namespace_id;
         
                 further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'TRASLATED ATTR "' || c3.c_aliased_attr || '" TO "' || v_new_aliased_attr || '"',1);

               end if;

               if v_is_trans_attr_value = 1 or v_is_trans_attr_type = 1 then
         
                  -- loop through the attribute value codes, translate and update codes and/or data types
                  for c4 in (
                     select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_value
                     from query_temp q
                         ,table(xmlsequence( q.query_xml.extract('(//parameters[parameter[text()="'|| v_working_attr ||'"]])[' || v_alias_lab_iter || ']' ||
                                                           '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]'
                                                          , const.get_query_xml_namespace) ) )
                     where query_id = p_query_id
                       and namespace_id = const.get_uuedw_namespace_id
                  )
                  loop
           
                     v_value := c4.c_value;
                     v_src_nmspc_id := 0;
             
                     if v_is_trans_attr_value = 1 then -- translate value/type 

                        if v_attr in ('observation') then 
                           v_src_nmspc_id := const.get_loinc_namespace_id; -- LOINC
                           v_type := 'xs:integer';
                        elsif v_attr in ('valueType') then 
                           v_src_nmspc_id := const.get_further_namespace_id; -- FURTHER
                           v_type := 'xs:string';
                        else 
                           v_src_nmspc_id := const.get_snomed_namespace_id;  -- SNOMED
                           v_type := 'xs:string';
                        end if;

                        v_translated_value := dts.GET_TRANSLATED_CONCEPT_VALUE( v_src_nmspc_id, 'Code in Source', c4.c_value, const.get_uuedw_namespace_id , 'Local Code' );
                        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'VALUE TRANSLATION: ATTR="' || v_attr || '" FROM VALUE="' || c4.c_value || '" TO VALUE="' || v_translated_value || '"',1);

                        if length(v_translated_value) > 0 then
             
                           -- update attr value and type
                           update query_temp q
                           set q.query_xml = updatexml( 
                                 q.query_xml
                              , '(//parameters[parameter[text()="' || v_working_attr || '"]])[' || v_alias_lab_iter || ']/parameter[text()="' || c4.c_value || '"]/@xsi:type'
                              , v_type
                              , '(//parameters[parameter[text()="' || v_working_attr || '"]])[' || v_alias_lab_iter || ']/parameter[text()="' || c4.c_value || '"]/text()'
                              , v_translated_value, const.get_query_xml_namespace)
                           where q.query_id = p_query_id
                             and q.namespace_id = const.get_uuedw_namespace_id;

                        else
              
                           v_error_msg := v_error_msg || 'VALUE TRANSLATION ERROR: attribute="' || v_attr || '" value="' || c4.c_value || '" ';
             
                        end if;

                     elsif v_is_trans_attr_type = 1 then -- implies only type conversion

                        v_type := get_trans_assoc_prop( const.get_analytical_obs_class_id, const.get_uuedw_lab_obs_class_id, v_attr, 'ATTR_VALUE_TRANS_TO_DATA_TYPE' );

                        further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'VALUE TYPE TRANSLATION: attribute="' || v_attr || '" new type=' || v_type,1);

                        update query_temp q
                        set q.query_xml = updatexml( 
                              q.query_xml
                            , '(//parameters[parameter[text()="' || v_working_attr || '"]])[' || v_alias_lab_iter || ']/parameter[text()="' || c4.c_value || '"]/@xsi:type'
                            , v_type
                            , const.get_query_xml_namespace)
                        where q.query_id = p_query_id
                          and q.namespace_id = const.get_uuedw_namespace_id;

                     else
              
                        v_error_msg := v_error_msg || 'TRANSLATION LOGIC ERROR - should never get here.  Translating attribute="' || v_attr || '" value="' || c4.c_value || '" ';
                 
                     end if;
                  end loop; -- translate value codes loop
           
               end if; -- trans attr value or type

               /* -------------------------------
                * Remove untouched from lab criteria if no errors have been encountered (untouched tags are flags for errors)
                * -------------------------------*/
               if ( v_error_msg is null ) then 
        
                  --if ( v_is_trans_attr  = 1 and v_is_trans_attr_value  = 0 ) then
                  if ( v_is_trans_attr  = 1 ) then
        
                     further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'REMOVING(8) untouched for ATTR=' || v_new_aliased_attr,1);
                     delete_query_elements( const.get_uuedw_namespace_id
                               , p_query_id
                               ,'(//criteria[parameters/parameter[text()="' || v_new_aliased_attr || '"]])[' || v_alias_lab_iter || ']/parameters/untouched'
                               );
                                 
                  elsif ( v_is_trans_attr  = 1 and v_is_trans_attr_value  = 1 ) then
  
                     further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'REMOVING(9) untouched for ATTR=' || v_new_aliased_attr || ' VALUE=' || v_translated_value,1);
                     delete_query_elements( const.get_uuedw_namespace_id
                               , p_query_id
                               ,'(//criteria[parameters//parameter/text()="' || v_new_aliased_attr || 
                                '" and parameters//parameter/text()="' || v_translated_value || '"])['|| v_alias_lab_iter ||']/parameters/untouched'
                               );
  
                  elsif ( v_is_trans_attr  = 0 and v_is_trans_attr_value  = 0 ) then
  
                     further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'REMOVING(10) untouched for ATTR=' || v_attr || ' VALUE=' || v_value,1);
                     delete_query_elements( const.get_uuedw_namespace_id
                               , p_query_id
                               ,'(//criteria[parameters//parameter/text()="' || v_attr || '"])['|| v_alias_lab_iter ||']/parameters/untouched'
                               );
  
                  end if;
                  
                  -- May need this if there are gt 1 time variables (shouldn't happen with i2b2 implementation)
                  delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '//criteria[parameters//parameter/text()="' || v_new_aliased_time_attr ||'"]/parameters/untouched');

               else
        
                  further_pkg.log_msg($$PLSQL_UNIT,'ERROR', v_intro_msg || v_error_msg,1);      
       
               end if; -- no error msg

              further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END TRANSLATION ' || c3.c_aliased_attr,1);
           end loop; -- for each lab attr 
       end if;
       
       v_translated_attr := ''; -- reset
       v_new_aliased_attr := ''; -- reset
        
       add_query_object_alias( const.get_uuedw_namespace_id, p_query_id, c1.c_alias, v_new_alias, v_new_alias_obj );

    end loop; -- for each alias obs type loop   
        
    -- delete observation types for curret alias
    delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '//criteria[parameters/parameter/text()="' || c1.c_alias || '.observationType"]');
    
    -- delete current analytical model observation alias
    delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '//aliases/alias[key/text()="' || c1.c_alias || '"]');

  end loop; -- for each alias loop      
  
  if length( v_error_msg ) > 0 then
    RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg);
  end if;
  
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'END',1);

END TRANS_QUERY_OBS_UUEDW;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_ORDER_UUEDW
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_ORDER_UUEDW" ( p_query_id number ) AS 

  v_iter number;
  v_order_type_iter number;
  v_new_alias varchar2(100);
  v_translated_value varchar2(100);
  v_xpath varchar2(1000);
  v_update varchar2(100);
  
  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);


BEGIN

  v_intro_msg := 'QUERY( UUEDW:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'BEGIN',1);

  v_iter := 0;
  
  /* for each Order alias */
  for c1 in 
    (select extract(column_value, '/alias/key/text()', const.get_query_xml_namespace).getstringval() c_alias,
            extract(column_value, '/alias/value/text()', const.get_query_xml_namespace).getstringval() c_object
     from query_def q
         ,table(xmlsequence( q.query_xml.extract('//aliases/alias[value/text()="orders"]', const.get_query_xml_namespace) ) )
     where query_id = p_query_id) loop
     
     v_iter := v_iter + 1;
     v_order_type_iter := 0;
     
     for c2 in (
         select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_order_type_str
         from query_def q,
           table(xmlsequence
                 (q.query_xml.extract
                   ('//searchType[text()="CONJUNCTION"]/../criteria/parameters/parameter[text()="' || c1.c_alias || '.type"]/../parameter[3]', const.get_query_xml_namespace)
                 )
               )
         where q.query_id = p_query_id
     ) loop 
        
        -- WARNING - v_order_type_iter strategy may NOT be correct in logic below that uses this variable when new order types are added
        v_order_type_iter := v_order_type_iter + 1;
        further_pkg.log_msg($$PLSQL_UNIT, 'DEBUG', v_intro_msg || 'ALIAS: ' || c1.c_alias || '=' || c2.c_order_type_str || ' obj=' || c1.c_object, 1);
     
        /* ------------------- */
        /* ORDER TYPE MED      */
        /* ------------------- */
        if ( c2.c_order_type_str = const.get_order_type_med ) then 
     
           v_new_alias := 'medord' || v_iter;
           
           --update the time parameter for this alias (if there is one)
           update query_temp q
           set q.query_xml = updatexml( 
              q.query_xml
             , '(//criteria/parameters/parameter[text()="' || c1.c_alias || '.orderTime"])[1]/text()'
             , v_new_alias || '.startDate', const.get_query_xml_namespace)
           where q.query_id = p_query_id
             and q.namespace_id = const.get_uuedw_namespace_id;

           delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_new_alias || '.startDate"])['|| v_order_type_iter ||']/parameters/untouched');
           
      
           /* change attr orderItem to multumDCode */
           v_xpath := '(//parameter[text()="' || c1.c_alias || '.orderItem"])[1]/text()';
           v_update := v_new_alias || '.multumDCode';
                         
           further_pkg.log_msg($$PLSQL_UNIT, 'DEBUG','XPATH Update: ' || v_xpath || ' TO ' || v_update, 1);
 
           update query_temp q
           set q.query_xml = updatexml( q.query_xml
                                  , v_xpath
                                  , v_update
                                  , const.get_query_xml_namespace)
           where q.query_id = p_query_id
             and q.namespace_id = const.get_uuedw_namespace_id;
         
           for c3 in (
             select extract(column_value, '/parameter/text()', const.get_query_xml_namespace).getstringval() c_value
             from query_temp q
                 ,table(xmlsequence( q.query_xml.extract('(//parameters[parameter[text()="'|| v_update ||'"]])['|| v_order_type_iter ||']' || -- index may NOT be CORRECT WHEN OTHER ORDER TYPES ARE ADDED
                                                     '//parameter[(position()>2 and ../../searchType/text()="SIMPLE") or (position()>1 and ../../searchType/text()!="SIMPLE")]'
                                                     , const.get_query_xml_namespace) ) )
             where query_id = p_query_id
               and namespace_id = const.get_uuedw_namespace_id
           )
           loop
             
              v_translated_value := substr( c3.c_value, 4, 20 ); -- remove the "GN-" and only send the "d0000" segment

              further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'VALUE TRANSLATION: attribute="' || v_update || '" orig-value="' || c3.c_value || '" new-value="' || v_translated_value || '"',1);
             
              if length(v_translated_value) > 0 then
             
                -- update attr value
                update query_temp q
                set q.query_xml = updatexml( 
                 q.query_xml
                 , '(//parameters[parameter[text()="' || v_update || '"]])['|| v_order_type_iter ||']/parameter[text()="' || c3.c_value || '"]/text()'
                 , v_translated_value, const.get_query_xml_namespace)
                where q.query_id = p_query_id
                  and q.namespace_id = const.get_uuedw_namespace_id;

              else
              
                v_error_msg := v_error_msg || 'VALUE TRANSLATION ERROR: attribute="' || v_update || '" value="' || c3.c_value || '" ';
             
              end if;
             
           end loop; -- value codes loop

           delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '(//criteria[parameters//parameter/text()="' || v_update ||'"])['|| v_order_type_iter ||']/parameters/untouched');
              
        end if; -- is a medication order type
        
        add_query_object_alias( const.get_uuedw_namespace_id, p_query_id, c1.c_alias, v_new_alias, 'medicationOrders' );
             
     end loop; -- for each order type alias loop

      delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '//criteria[parameters//parameter/text()="' || c1.c_alias ||'.type"]');
  
      delete_query_elements( const.get_uuedw_namespace_id, p_query_id, '//aliases/alias[key/text()="' || c1.c_alias || '"]');
   
  end loop; -- for each alias 

  if length( v_error_msg ) > 0 then 
     RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg);
  end if;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'END',1);

END TRANS_QUERY_ORDER_UUEDW;
 

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_SUBQ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_SUBQ" (p_namespace_id number, p_query_id number ) AS 

  i number;
  xml xmltype;
  clob_val clob;
  
begin

  i := 1;

  for crs in (
    select extract( column_value, '/criteria/query/rootCriterion/*', const.get_query_xml_namespace ) subquery_criteria
    from query_temp q ,
      TABLE(xmlsequence( extract( q.query_xml, '//criteria[searchType="IN" and parameters/parameter="udistID"]', const.get_query_xml_namespace ) )) 
    where query_id = p_query_id
      and namespace_id = p_namespace_id)
  loop
      
    clob_val := '<criteria xmlns="http://further.utah.edu/core/query">';
    dbms_lob.append( clob_val, crs.subquery_criteria.getclobval() );
    dbms_lob.append( clob_val, '</criteria>' );
    xml := xmltype( clob_val );
    
    update query_temp q
         set q.query_xml = insertXmlAfter( 
             q.query_xml
           , '//criteria[searchType="IN" and parameters/parameter="udistID"][' || i || ']'
           , xml, const.get_query_xml_namespace)
    where q.query_id = p_query_id
      and q.namespace_id = p_namespace_id;
      
    i := i + 1;
    
  end loop;
  
  update query_temp q
         set q.query_xml = deleteXml( 
             q.query_xml
           , '//criteria[searchType="IN" and parameters/parameter="udistID"]'
           , const.get_query_xml_namespace)
    where q.query_id = p_query_id
      and q.namespace_id = p_namespace_id;
  
END TRANS_QUERY_SUBQ;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_UPDBL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_UPDBL" ( p_query_id number ) AS

  v_trgt_attr varchar2(100);
  v_trnsltn_func varchar2(100);
  v_value_set_nmspc varchar2(100);
  v_nmspc_id number;
  v_trgt_value varchar2(100);
  v_translated_attr varchar2(100);
  v_translated_value varchar2(100);
  v_new_aliased_attr varchar2(100);
  v_xpath varchar2(1000);
  v_xpath2 varchar2(1000);

  v_error_msg varchar2(4000);
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
  set q.query_xml = deleteXML( q.query_xml, '//criteria[parameters/parameter[ora:contains(text(),"%NamespaceId")>0]]', const.get_query_xml_namespace )
  where query_id = p_query_id
    and namespace_id = const.get_updbl_namespace_id;

  
  if length( v_error_msg ) > 0 then
    further_pkg.log_msg($$PLSQL_UNIT, v_intro_msg || 'ERROR', v_error_msg, 1);
    RAISE_APPLICATION_ERROR(-20000, v_intro_msg || v_error_msg );
  end if;
  
  TRANS_QUERY_SUBQ(const.get_updbl_namespace_id, p_query_id );
  
  check_translated_query( const.get_updbl_namespace_id, p_query_id );
  
  /* --------------------------------------------------------------------- */
  /* Query translation done, add query to query_nmspc for Java interpreter */
  /* --------------------------------------------------------------------- */
  insert into query_nmspc 
    select query_id, const.get_updbl_namespace_id, query_xml 
    from query_temp 
    where query_id = p_query_id
      and namespace_id = const.get_updbl_namespace_id;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END',1);
    
END TRANS_QUERY_UPDBL ;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_UUEDW
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_UUEDW" ( p_query_id number ) AS

  v_trgt_attr varchar2(100);
  v_trnsltn_func varchar2(100);
  v_value_set_nmspc varchar2(100);
  v_nmspc_id number;
  v_trgt_value varchar2(100);
  v_translated_attr varchar2(100);
  v_translated_value varchar2(100);
  v_new_aliased_attr varchar2(100);

  v_error_msg varchar2(4000);
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
  /* Translate encounters     */
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
  set q.query_xml = deleteXML( q.query_xml, '//criteria[parameters/parameter[ora:contains(text(),"%NamespaceId")>0]]', const.get_query_xml_namespace )
  where query_id = p_query_id
    and namespace_id = const.get_uuedw_namespace_id;
  
  /* ---------------------------------------------------------------- */
  /* Check for "untouched" attributes - fail and report when detected */
  /* ---------------------------------------------------------------- */
  check_translated_query( const.get_uuedw_namespace_id, p_query_id );
  
  /* --------------------------------------------------------------------- */
  /* Query translation done, add query to query_nmspc for Java interpreter */
  /* --------------------------------------------------------------------- */
  insert into query_nmspc 
    select query_id, const.get_uuedw_namespace_id, query_xml 
    from query_temp 
    where query_id = p_query_id
      and namespace_id = const.get_uuedw_namespace_id;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END',1);
    
END TRANS_QUERY_UUEDW;

/
--------------------------------------------------------
--  DDL for Procedure TRANS_QUERY_UUEDW_APO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."TRANS_QUERY_UUEDW_APO" ( p_query_id number ) AS

  v_trgt_attr varchar2(100);
  v_trnsltn_func varchar2(100);
  v_value_set_nmspc varchar2(100);
  v_nmspc_id number;
  v_trgt_value varchar2(100);
  v_translated_attr varchar2(100);
  v_translated_value varchar2(100);
  v_new_aliased_attr varchar2(100);

  v_error_msg varchar2(4000);
  v_intro_msg varchar2(50);
  v_namespace_id number;
  
BEGIN

  v_intro_msg := 'QUERY( UUEDW_APO:' || p_query_id || ') ';
  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG',v_intro_msg || 'BEGIN',1);
  
  v_namespace_id := const.get_uuedw_apo_namespace_id;
  
  /* ----------------------------------------------------------------------------*/
  /* No translation required - add query to query_nmspc for Java interpreter     */
  /* ----------------------------------------------------------------------------*/
  insert into query_nmspc 
    select query_id, v_namespace_id, query_xml 
    from query_def 
    where query_id = p_query_id;

  further_pkg.log_msg($$PLSQL_UNIT,'DEBUG', v_intro_msg || 'END',1);
    
END TRANS_QUERY_UUEDW_APO;

/
--------------------------------------------------------
--  DDL for Procedure UPDATE_QUERY_OBJECT_ALIAS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "FRTHR_FQE"."UPDATE_QUERY_OBJECT_ALIAS" ( p_namespace_id number, p_query_id number, p_old_alias varchar2, p_new_alias varchar2, p_new_object varchar2) AS 
BEGIN

/*
	<aliases>
		<alias>
			<key>Observation</key>
			<value>observations</value>
		</alias>
	</aliases>
  
 	<aliases>
		<alias>
			<key>dx</key>
			<value>diagnosis</value>
		</alias>
	</aliases>
*/

  update query_temp qn 
     set query_xml = updatexml( 
         query_xml,
         '//aliases/alias[key="'|| p_old_alias || '"]/key/text()', p_new_alias,        
         '//aliases/alias[key="' || p_new_alias || '"]/value/text()', p_new_object, const.get_query_xml_namespace)         
  where qn.query_id = p_query_id;
  
  delete_query_elements( p_namespace_id, p_query_id, '//alias[key/text()="' || p_new_alias || '"]/untouchedAlias');
  
END UPDATE_QUERY_OBJECT_ALIAS;
 

/
