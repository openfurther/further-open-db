/* FURTHER MDR DDL */

/* ASSET_ASSOC Table */
CREATE TABLE FMDR.ASSET_ASSOC 
(
  ASSET_ASSOC_ID NUMBER, 
  LS_ASSET_ID NUMBER, 
  ASSOC_ASSET_ID NUMBER, 
  RS_ASSET_ID NUMBER, 
  ENABLED CHAR(1) DEFAULT 'Y', 
  CONSTRAINT ASSET_ASSOC_PK PRIMARY KEY (ASSET_ASSOC_ID)
);
COMMENT ON TABLE FMDR.ASSET_ASSOC IS 'Asset Association';
COMMENT ON COLUMN FMDR.ASSET_ASSOC.ASSET_ASSOC_ID 
        IS 'Asset Association ID';
COMMENT ON COLUMN FMDR.ASSET_ASSOC.LS_ASSET_ID 
        IS 'Left Side Asset ID';
COMMENT ON COLUMN FMDR.ASSET_ASSOC.ASSOC_ASSET_ID 
        IS 'Association Asset ID';
COMMENT ON COLUMN FMDR.ASSET_ASSOC.RS_ASSET_ID 
        IS 'Right Side Asset ID';
COMMENT ON COLUMN FMDR.ASSET_ASSOC.ENABLED
        IS 'Enabled Flag Y or N (Default Y)';


/* BEG Views */

/* FMDR.ASSET_ASSOC_V */
CREATE OR REPLACE VIEW FMDR.ASSET_ASSOC_V 
AS 
SELECT aa.asset_assoc_id,
       get_asset_type_id(ls_asset_id) ls_type_asset_id,
       get_asset_type_label(ls_asset_id) ls_type_label,
       get_asset_namespace_id(ls_asset_id) ls_namespace_asset_id,
       get_asset_namespace_label(ls_asset_id) ls_namespace_label,
       ls_asset_id,
       get_asset_label(ls_asset_id) ls_asset_label,
       assoc_asset_id,
       get_asset_label(assoc_asset_id) assoc_asset_label,
       get_asset_type_id(rs_asset_id) rs_type_asset_id,
       get_asset_type_label(rs_asset_id) rs_type_label,
       get_asset_namespace_id(rs_asset_id) rs_namespace_asset_id,
       get_asset_namespace_label(rs_asset_id) rs_namespace_label,
       rs_asset_id,
       get_asset_label(rs_asset_id) rs_asset_label
  FROM asset_assoc aa
 WHERE aa.enabled = 'Y';

/* FMDR.ASSET_PROP_V */
CREATE OR REPLACE VIEW FMDR.ASSET_PROP_V 
AS 
SELECT av.asset_namespace_asset_id,
       av.asset_namespace_label,
       av.asset_type_asset_id,
       av.asset_type_label,
       av.asset_id,
       av.asset_label,
       av.asset_dsc,
       av.asset_activate_dt,
       av.asset_deactivate_dt,
       ap.asset_prop_id,
       ap.asset_type_prop_id,
       get_asset_label(ap.asset_type_prop_id) as asset_type_prop_label,
       ap.prop_value as asset_prop_value
  FROM asset_v av, asset_prop ap
 WHERE av.asset_id = ap.asset_id;

/* END Views */
