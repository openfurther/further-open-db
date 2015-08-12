--------------------------------------------------------
--  File created - Wednesday-August-12-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure CREATE_FURTHER_I2B2_USER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "FMDR"."CREATE_FURTHER_I2B2_USER" ( p_app_user_id number ) AS 
BEGIN

declare 

  v_i2b2_user_gsoid varchar2(50);
  v_unid varchar2(20);
  v_firstname varchar2(100);
  v_lastname varchar2(100);
  v_email varchar2(100);
  v_user_id_prop number := 3247;

begin
 
  select firstname, lastname, email, username into v_firstname, v_lastname, v_email, v_unid
  from usernames_v 
  where app_user_id = p_app_user_id;

  v_i2b2_user_gsoid := i2b2user.create_i2b2_user( v_unid, v_firstname || ' ' || v_lastname, v_email, 'University of Utah'  );

  insert into app_user_prop values(asset_id_seq.nextval, p_app_user_id, v_user_id_prop , v_unid );

  commit;


end;


END CREATE_FURTHER_I2B2_USER;

/
--------------------------------------------------------
--  DDL for Procedure DELETE_ASSET
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "FMDR"."DELETE_ASSET" ( P_ASSET_ID IN NUMBER ) AS 

  v_asset_type_id number;

BEGIN

  select get_asset_type_id( asset_id ) into v_asset_type_id from asset where asset_id = p_asset_id;
  
  if ( v_asset_type_id = 1 ) then
  
    raise_application_error(-21000,'Base type asset deletions are not permitted.');
  
  end if;

  delete asset_resource where asset_id = p_asset_id;
  
  delete asset_version where asset_id = p_asset_id;
  
  delete asset where asset_id = p_asset_id;
  
  /* todo - check all links and potential associations and report 
     asset_prop
     asset_assoc
     asset_resource xml links
  */

END DELETE_ASSET;

/
--------------------------------------------------------
--  DDL for Procedure DELETE_I2B2_USER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "FMDR"."DELETE_I2B2_USER" ( p_app_user_id number ) AS 

  v_user_id varchar2(20);

BEGIN

  select app_prop_val into v_user_id
  from app_user_prop
  where app_user_id = p_app_user_id
    and app_prop_id = 3247;

  i2b2user.delete_i2b2_user(v_user_id);

  delete app_user_prop
  where app_user_id = p_app_user_id
    and app_prop_id = 3247;
    
  commit;
  
END DELETE_I2B2_USER;

/
