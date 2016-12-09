--------------------------------------------------------
--  DDL for Function GET_ASSET_LABEL
--------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_ASSET_LABEL (P_ASSET_ID NUMBER) RETURN VARCHAR2 AS

  V_ASSET_LABEL ASSET.ASSET_LABEL%TYPE;

BEGIN

  SELECT ASSET_LABEL INTO V_ASSET_LABEL
  FROM ASSET
  WHERE ASSET_ID = P_ASSET_ID;

  RETURN V_ASSET_LABEL;

END GET_ASSET_LABEL;

/
--------------------------------------------------------
--  DDL for Function GET_ASSET_NAMESPACE_ID
--------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_ASSET_NAMESPACE_ID ( p_asset_id number ) RETURN NUMBER AS

  v_asset_namespace_id number;

BEGIN

  select asset_namespace_asset_id into v_asset_namespace_id
  from asset
  where asset_id = p_asset_id;
  
  return v_asset_namespace_id;

END GET_ASSET_NAMESPACE_ID;

/
--------------------------------------------------------
--  DDL for Function GET_ASSET_NAMESPACE_LABEL
--------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_ASSET_NAMESPACE_LABEL ( p_asset_id number ) RETURN VARCHAR2 AS 

  v_asset_label asset.asset_label%type;

BEGIN

  select get_asset_label(asset_namespace_asset_id) into v_asset_label
  from asset
  where asset_id = p_asset_id;

  return v_asset_label;

END GET_ASSET_NAMESPACE_LABEL;

/
--------------------------------------------------------
--  DDL for Function GET_ASSET_PARENT
--------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_ASSET_PARENT (P_ASSET_ID NUMBER) 
RETURN VARCHAR2 
AS
  V_LS_ASSET_ID ASSET_ASSOC.LS_ASSET_ID%TYPE;
BEGIN

  /* Get Parent Asset ID */
  SELECT LS_ASSET_ID
    INTO V_LS_ASSET_ID 
    FROM ASSET_ASSOC
   WHERE ASSOC_ASSET_ID in (227, 10006)
     AND RS_ASSET_ID = P_ASSET_ID;

  /* Return the Label for Parent */
  RETURN GET_ASSET_LABEL(V_LS_ASSET_ID);

END GET_ASSET_PARENT;

/

--------------------------------------------------------
--  DDL for Function GET_ASSET_TYPE_ID
--------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_ASSET_TYPE_ID ( p_asset_id number ) RETURN NUMBER AS

  v_asset_type_id number;

BEGIN

  select asset_type_asset_id into v_asset_type_id
  from asset
  where asset_id = p_asset_id;
  
  return v_asset_type_id;

END GET_ASSET_type_ID;

/
--------------------------------------------------------
--  DDL for Function GET_ASSET_TYPE_LABEL
--------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_ASSET_TYPE_LABEL ( p_asset_id number ) RETURN VARCHAR2 AS 

  v_asset_label asset.asset_label%type;

BEGIN

  select get_asset_label(asset_type_asset_id) into v_asset_label
  from asset
  where asset_id = p_asset_id;

  return v_asset_label;

END GET_ASSET_type_LABEL;

/
--------------------------------------------------------
--  DDL for Function GET_ASSOC_PROPS_STRING
--------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_ASSOC_PROPS_STRING ( p_asset_assoc_id asset_assoc.asset_assoc_id%type ) RETURN VARCHAR2 AS 

  v_prop_string varchar2(4000);
  v_iter number := 0;

BEGIN

  for crs in (
    select prop_name, prop_val
    from asset_assoc_prop
    where asset_assoc_id = p_asset_assoc_id
    order by prop_name asc)
  loop
  
    v_iter := v_iter+1;

    if v_iter = 1 then
      v_prop_string := crs.prop_name || '=' || crs.prop_val;     
    else
      v_prop_string := v_prop_string || ' | ' || crs.prop_name || '=' || crs.prop_val;     
    end if;
    
  end loop;

  RETURN v_prop_string;
END GET_ASSOC_PROPS_STRING;

/
--------------------------------------------------------
--  DDL for Function GET_ATTR_NM_FROM_TAG
--------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_ATTR_NM_FROM_TAG ( p_resource_id number, p_tag_nm varchar2, p_tag_val varchar2) RETURN VARCHAR2 AS

  v_attr_nm varchar2(100);

BEGIN

  select ar.resource_xml.extract('//attribute[tags/tag/@name="' || p_tag_nm ||'" and tags/tag/@value="'|| p_tag_val ||'"]/@name').getstringval() into v_attr_nm
  from asset_resource ar
  where ar.asset_resource_id = p_resource_id;
  
  return v_attr_nm;
  
  exception 
    when no_data_found 
      then return null;

END GET_ATTR_NM_FROM_TAG;

/
--------------------------------------------------------
--  DDL for Function GET_ATTR_OBJ_ID
--------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_ATTR_OBJ_ID ( p_attr_asset_id asset.asset_id%type ) RETURN asset.asset_id%type AS 

  v_asset_id asset.asset_id%type;
 
BEGIN

select ls_asset_id into v_asset_id
  from asset_assoc
 where rs_asset_id = p_attr_asset_id
   and assoc_asset_id = 227;

  RETURN v_asset_id;
  
END GET_ATTR_OBJ_ID;

/
--------------------------------------------------------
--  DDL for Function GET_DATA_ASSETS
--------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_DATA_ASSETS ( p_obj_nm varchar2 ) RETURN SYS_REFCURSOR AS

    curs SYS_REFCURSOR;

BEGIN

  open curs for
  select distinct asset_id, get_asset_namespace_id(asset_id) namespace_id, asset_resource_id
  from asset_resource ar
  where ar.resource_xml.existsNode('//element/tags/tag[@name="FurtherObjectName" and @value="'|| p_obj_nm ||'"]') = 1
    and is_active_resource( asset_resource_id ) = 1;

  return curs;
  
END GET_DATA_ASSETS;

/
--------------------------------------------------------
--  DDL for Function GET_DTS_NAMESPACE_LABEL
--------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_DTS_NAMESPACE_LABEL (P_NMSPC_ID NUMBER) RETURN VARCHAR2 AS

  V_NMSPC_LABEL VARCHAR2(256);

BEGIN

/*
  SELECT NAME INTO V_NMSC_LABEL
  FROM DTS.DTS_NAMESPACE
  WHERE ID = P_NMSPC_ID;
*/

  if p_nmspc_id = 32777 then
  
    V_NMSPC_LABEL := 'i2b2';
  
  elsif p_nmspc_id = 32769 then
  
    V_NMSPC_LABEL := 'FURTHeR';
  
  elsif p_nmspc_id = 64902 then
  
    V_NMSPC_LABEL := 'Intermountain APO';
  
  else
    null;
    
  end if;

  RETURN V_NMSPC_LABEL;

END GET_DTS_NAMESPACE_LABEL;

/
--------------------------------------------------------
--  DDL for Function GET_LOOKUP_LABEL
--------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_LOOKUP_LABEL (P_LOOKUP_VALUE_ID NUMBER) RETURN VARCHAR2 AS

  V_LABEL LOOKUP_VALUE.LOOKUP_VALUE_LABEL%TYPE;

BEGIN

  SELECT LOOKUP_VALUE_LABEL INTO V_LABEL
  FROM LOOKUP_VALUE
  WHERE LOOKUP_VALUE_ID = P_LOOKUP_VALUE_ID;

  RETURN V_LABEL;

END GET_LOOKUP_LABEL;

/
--------------------------------------------------------
--  DDL for Function GET_NEXT_ASSET_VERSION
--------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_NEXT_ASSET_VERSION ( p_asset_id asset.asset_id%type ) 
RETURN asset_version.asset_version%type AS

  v_version_count number;


BEGIN

  select count(1) into v_version_count
  from asset_version
  where asset_id = p_asset_id;

  if v_version_count = 0 then
  
    return 1;
    
    else
    
      return v_version_count + 1;
  
  end if;

END get_next_asset_version;

/
--------------------------------------------------------
--  DDL for Function GET_RESOURCE_RESOURCE_ID
--------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_RESOURCE_RESOURCE_ID ( p_resource_id number, p_resource_type_id number ) RETURN number AS 

  v_asset_type_id number;
  v_asset_resource_type_id number;
  v_asset_resource_id number;

BEGIN

  select get_asset_type_id( asset_id ), asset_resource_type_id into v_asset_type_id, v_asset_resource_type_id
  from asset_resource ar
  where ar.asset_resource_id = p_resource_id;
  
  select asset_resource_id into v_asset_resource_id
  from asset_resource 
  where asset_id = v_asset_type_id
    and asset_resource_type_id = p_resource_type_id
    and asset_resource_type_id in 
      (select art.asset_resource_type_id from asset_resource_type art
       where art.parent_resource_type_id = v_asset_resource_type_id);

  RETURN v_asset_resource_id;

  exception when no_data_found then return null;


END GET_RESOURCE_RESOURCE_ID;

/
--------------------------------------------------------
--  DDL for Function GET_RESOURCE_TYPE_LABEL
--------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_RESOURCE_TYPE_LABEL (P_RESOURCE_TYPE_ID NUMBER) RETURN VARCHAR2 AS

  V_LABEL ASSET_RESOURCE_TYPE.ASSET_RESOURCE_TYPE_DSC%TYPE;

BEGIN

  SELECT ASSET_RESOURCE_TYPE_DSC INTO V_LABEL
  FROM ASSET_RESOURCE_TYPE
  WHERE ASSET_RESOURCE_TYPE_ID = P_RESOURCE_TYPE_ID;

  RETURN V_LABEL;

END GET_RESOURCE_TYPE_LABEL;
 
 

/
--------------------------------------------------------
--  DDL for Function GET_VALUE_DOMAIN_NAMESPACE
--------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_VALUE_DOMAIN_NAMESPACE ( p_asset_resource_id number, p_value_domain_name varchar2 ) RETURN VARCHAR2 AS

  v_namespace varchar2(255);

BEGIN

  select ar.resource_xml.extract('//element[@name="'
           || p_value_domain_name ||'"]/tags/tag[@name="DTSNamespace"]/@value').getstringval() into v_namespace
  from asset_resource ar
  where asset_resource_id = p_asset_resource_id;
  
  return v_namespace;  

END GET_VALUE_DOMAIN_NAMESPACE;

/
--------------------------------------------------------
--  DDL for Function IS_ACTIVE_RESOURCE
--------------------------------------------------------

CREATE OR REPLACE FUNCTION IS_ACTIVE_RESOURCE ( p_resource_id number ) RETURN NUMBER AS

  v_asset_status_id number;

BEGIN

  select asset_status_id into v_asset_status_id
  from asset_version av, asset_resource ar
  where av.asset_version_seq_id = ar.asset_version_seq_id
    and ar.asset_resource_id = p_resource_id;
    
  if ( v_asset_status_id = 1 ) then 
  
    return 1;
    
  else
  
    return 0;
    
  end if;
  
  exception when no_data_found then return 0;

END IS_ACTIVE_RESOURCE;

/
