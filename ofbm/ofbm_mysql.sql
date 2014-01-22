/* MySql DDL for OpenFurther Biospecimen Model (OFBM) */

/*
  Author: University of Utah Biomedical Informatics Core (BMIC) Team
  Data Architect: Peter Mo
  Date: 20140114
  DESCRIPTION:
    The OFBM is a de-normalized biospecimen data mart
    to support ETL data from any single biobanking system.
    It was initially created to provide a simplified data model to connect
    with the OpenFurther data federation framework. 
    However, it can be used for other reporting purpose as well.
*/

/* BEGIN Possible CLEANUP */
/*
Drop schema ofbm;
create schema ofbm;

set foreign_key_checks=off;
DROP TABLE IF EXISTS ofbm.consent;
DROP TABLE IF EXISTS ofbm.person_protocol;
DROP TABLE IF EXISTS ofbm.sample_extid;
DROP TABLE IF EXISTS ofbm.sample_event;
DROP TABLE IF EXISTS ofbm.sample_storage;
DROP TABLE IF EXISTS ofbm.sample;
DROP TABLE IF EXISTS ofbm.person_dx;
DROP TABLE IF EXISTS ofbm.person_race;
DROP TABLE IF EXISTS ofbm.person_extid;
DROP TABLE IF EXISTS ofbm.person;
DROP TABLE IF EXISTS ofbm.protocol_dx;
DROP TABLE IF EXISTS ofbm.protocol;

Truncate TABLE ofbm.consent;
Truncate TABLE ofbm.person_protocol;
Truncate TABLE ofbm.protocol_dx;
Truncate TABLE ofbm.protocol;
Truncate TABLE ofbm.sample_extid;
Truncate TABLE ofbm.sample_event;
Truncate TABLE ofbm.sample;
Truncate TABLE ofbm.sample_storage;
Truncate TABLE ofbm.person_dx;
Truncate TABLE ofbm.person_race;
Truncate TABLE ofbm.person_extid;
Truncate TABLE ofbm.person;

set foreign_key_checks=on;

*/
/* END CLEANUP */

use ofbm;

/* Person or Patient or Participant */
create table ofbm.person (
  p_id int unsigned comment 'Person ID',
  last_name varchar(64) comment 'Last Name',
  first_name varchar(64) comment 'First Name',
  middle_name varchar(64) comment 'Middle Name',
  ssn varchar(16) comment 'Social Security Number',
  admin_gender_nmspc_id int unsigned comment 'Gender Namespace',
  admin_gender_cid varchar(100) comment 'Gender Concept ID',
  ethnicity_nmspc_id int unsigned comment 'Ethnicity Namespace',
  ethnicity_cid varchar(100) comment 'Ethnicity Concept ID',
  birth_dt date comment 'Birth Date',
  birth_yr int unsigned comment 'Birth Year',
  birth_mon int unsigned comment 'Birth Month',
  birth_day int unsigned comment 'Birth Day',
  vital_status_nmspc_id int unsigned comment 'Vital Status Namespace',
  vital_status varchar(100) comment 'Vital Status Concept ID',
  death_dt date comment 'Death Date',
  death_yr int unsigned comment 'Death Year',
  ts timestamp default now() comment 'Auto Timestamp to keep track of ETL process',
  primary key (p_id)
) 
  engine=innodb 
  default charset=utf8 
  comment='Person'
;

/* Person Race */
create table ofbm.person_race (
  p_race_id int unsigned auto_increment comment 'Auto-Increment Surrogate ID',
  p_id int unsigned not null comment 'Person ID',
  race_nmspc_id int unsigned comment 'Race Namespace',
  race_cid varchar(100) comment 'Race Concept ID',
  ts timestamp default now() comment 'Auto Timestamp to keep track of ETL process',
  primary key (p_race_id)
) 
  engine=innodb 
  default charset=utf8 
  comment='Person Race'
;

/* Person External IDs */
create table ofbm.person_extid (
  p_ext_id int unsigned auto_increment comment 'Auto-Increment Surrogate ID',
  p_id int unsigned not null comment 'Person ID',
  ext_source varchar(255) comment 'External System Source such as DNA Lab, etc.',
  ext_type varchar(255) comment 'External ID Type such as Medical Record Number',
  ext_value varchar(255) comment 'External ID Value',
  ts timestamp default now() comment 'Auto Timestamp to keep track of ETL process',
  primary key (p_ext_id)
) 
  engine=innodb 
  default charset=utf8 
  comment='Person MRN or External IDs'
;

/* Person Diagnosis */
create table ofbm.person_dx (
  p_dx_id int unsigned auto_increment comment 'Auto-Increment Surrogate ID',
  p_id int unsigned not null comment 'Person ID',
  code_nmspc varchar(255) comment 'Coding Namespace such as ICD9 or ICD10',
  code_value varchar(255) comment 'ICD Diagnosis Code Value',
  ts timestamp default now() comment 'Auto Timestamp to keep track of ETL process',
  primary key (p_dx_id)
) 
  engine=innodb 
  default charset=utf8 
  comment='Person Diagnosis'
;


/* Sample or Biospecimen */
create table ofbm.sample
( 
  s_id int unsigned comment 'Sample ID',
  parent_s_id int unsigned comment 'Parent Sample ID',
  p_id int unsigned not null comment 'Person ID', 
  protocol_id varchar(255) comment 'Protocol ID from External Biospecimen System',
  label varchar(64) comment 'Sample Label',
  barcode varchar(64) comment 'Sample Barcode',
  lineagetype varchar(32) comment 'Lineage Type such as Aliquot, Derived, etc.',
  category_nmspc_id int unsigned comment 'DTS Category Namespace',
  category_cid varchar(100) comment 'DTS Concept ID for Category',
  type_nmspc_id int unsigned comment 'DTS Sample Type Namespace',
  type_cid varchar(100) comment 'DTS Sample Type Concept ID',
  qualifier_nmspc_id int unsigned comment 'DTS Qualifier Namespace',
  qualifier_cid varchar(100) comment 'DTS Qualifier Concept ID',
  status_nmspc_id int unsigned comment 'DTS Status Namespace',
  status_cid varchar(100) comment 'DTS Status Concept ID',
  amount_uom_nmspc_id int unsigned comment 'DTS Amount Unit of Measure Namespace',
  amount_uom_cid varchar(100) comment 'DTS Amount Unit of Measure Concept ID',
  amount decimal(10,2) comment 'Sample Volume Amount',
  conc_uom_nmspc_id int unsigned comment 'DTS Concentration Unit of Measure Namespace',
  conc_uom_cid varchar(100) comment 'DTS Concentration Unit of Measure Concept ID',
  conc decimal(10,2) comment 'Concentration Measurement Value',
  bodysite_nmspc_id int unsigned comment 'DTS Namespace for Body Site',
  bodysite_cid varchar(100) comment 'Body Site Concept ID for where Sample was extracted',
  path_dx varchar(100) comment 'Pathology Diagnosis',
  path_report varchar(255) comment 'Pathology Report Text',
  sample_gid int unsigned comment 'NCI Global Sample ID',
  ts timestamp default now() comment 'Auto Timestamp to keep track of ETL process',
  constraint sample_pk primary key (s_id)
)
  engine=innodb 
  default charset=utf8 
  comment='Sample or biospecimen'
;

/* Sample External or Alternate IDs */
create table ofbm.sample_extid(
  s_ext_id int unsigned auto_increment comment 'Auto-Increment Surrogate ID',
  s_id int unsigned not null comment 'Sample ID',
  ext_source varchar(255) comment 'External System Source such as Lab or Hospital',
  ext_type varchar(255) comment 'External ID Type such as DNA Extraction or Sequencing',
  ext_value varchar(255) comment 'External ID Value',
  ts timestamp default now() comment 'Auto Timestamp to keep track of ETL process',
  primary key (s_ext_id)
) 
  engine=innodb 
  default charset=utf8 
  comment='Other Sample IDs or Aliases'
;

/* Sample Events */
create table ofbm.sample_event(
  s_event_id int unsigned auto_increment comment 'Auto-Increment Surrogate ID',
  s_id int unsigned not null comment 'Sample ID',
  sample_label varchar(255) comment 'Sample Label',
  sample_barcode varchar(255) comment 'Sample Barcode',
  event_ts datetime comment 'Event TimeStamp',
  event_nmspc_id int unsigned comment 'Event Namespace ID',
  event_cid varchar(100) comment 'Event Concept Code in DTS',
  ts timestamp default now() comment 'Auto Timestamp to keep track of ETL process',
  primary key (s_event_id)
) 
  engine=innodb 
  default charset=utf8 
  comment='Sample events such as freezing, thawing, aliquot, etc.'
;

/* Sample Storage */
create table ofbm.sample_storage (
  s_id int unsigned comment 'Sample ID',
  site varchar(128) comment 'Site or Lab where the sample is located',
  full_path varchar(128) comment 'Full Storage Path Separated by Delimiter',
  ts timestamp default now() comment 'Auto Timestamp to keep track of ETL process',
  primary key (s_id)
) 
  engine=innodb 
  default charset=utf8 
  comment='Sample Storage Location'
;

/* sample Diagnosis */
/*
create table ofbm.sample_dx (
  s_dx_id int unsigned not null auto_increment comment 'Auto-Increment Surrogate ID',
  s_id int unsigned not null comment 'Sample ID',
  collectiongroup varchar(255) comment 'Collection Group Name',
  dx varchar(255) comment 'Clinical Diagnosis',
  dx_status varchar(255) comment 'Clinical Diagnosis Status',
  dx_nmspc_id int unsigned comment 'Diagnosis Namespace ID',
  snomed int unsigned comment 'SNOMED Code',
  ts timestamp default now() comment 'Auto Timestamp to keep track of ETL process',
  primary key (s_dx_id)
) 
  engine=innodb 
  default charset=utf8 
  comment='Sample Medical Conditions or Diagnosis'
;
*/

/* Protocol with Admin Data from a Single Biobanking System */
create table ofbm.protocol (
  protocol_id varchar(255) comment 'Protocol ID from External Biospecimen System',
  protocol_nmspc varchar(255) comment 'Protocol Namespace for Protocol ID to support Federation',
  protocol_type varchar(255) comment 'Protocol Type',
  irb_num varchar(255) comment 'IRB Number',
  pi_name varchar(255) comment 'Principal Investigator Name',
  sample_steward varchar(255) comment 'Administrative Sample Steward or Contact Person',
  ts timestamp default now() comment 'Auto Timestamp to keep track of ETL process',
  primary key (protocol_id)
) 
  engine=innodb 
  default charset=utf8 
  comment='Sample Collection Protocol with Admin Information'
;

/* Protocol Diagnosis */
create table ofbm.protocol_dx (
  protocol_dx_id int unsigned auto_increment comment 'Auto-Increment Surrogate ID',
  protocol_id varchar(255) not null comment 'Protocol ID',
  code_nmspc varchar(255) comment 'Coding Namespace such as ICD9 or ICD10',
  code_value varchar(255) comment 'ICD Diagnosis Code Value',
  ts timestamp default now() comment 'Auto Timestamp to keep track of ETL process',
  primary key (protocol_dx_id)
) 
  engine=innodb 
  default charset=utf8 
  comment='Protocol Diagnosis'
;

/* Person to Protocol Linking Table */
create table ofbm.person_protocol (
  p_id int unsigned comment 'Person ID',
  protocol_id varchar(255) comment 'Protocol ID',
  ts timestamp default now() comment 'Auto Timestamp to keep track of ETL process',
  primary key (p_id,protocol_id)
) 
  engine=innodb 
  default charset=utf8 
  comment='Person to Protocol Linking Table'
;

/* Consent */
create table ofbm.consent (
  consent_id int(11) unsigned auto_increment comment 'Auto-Increment Surrogate ID',
  protocol_id varchar(255) not null comment 'Protocol ID',
  question varchar(255) not null comment 'Consent Question Statement Text',
  answer varchar(255) comment 'Consent answer usually Y or N',
  local_code varchar(255) comment 'Local Consent Statement Code',
  rpms varchar(255) comment 'RPMS Category Code',
  primary key (consent_id)
) 
  engine=innodb 
  default charset=utf8 
  comment='Consent Statements for Protocols'
;

/* END TABLES */


/* BEGIN FK */

/* Optional disable fk check */
set foreign_key_checks=off;

/* person */
alter table ofbm.person_race
  add constraint person_race_fk1
  foreign key ( p_id ) 
  references ofbm.person( p_id );

alter table ofbm.person_extid
  add constraint person_extid_fk1
  foreign key ( p_id ) 
  references ofbm.person( p_id );

alter table ofbm.person_dx
  add constraint person_dx_fk1
  foreign key ( p_id )
  references ofbm.person( p_id );

/* sample */
alter table ofbm.sample
  add constraint sample_fk1
  foreign key ( parent_s_id ) 
  references ofbm.sample( s_id );

alter table ofbm.sample
  add constraint sample_fk2
  foreign key ( protocol_id ) 
  references ofbm.protocol( protocol_id );

alter table ofbm.sample_storage
  add constraint sample_storage_fk1
  foreign key ( s_id ) 
  references ofbm.sample( s_id );

alter table ofbm.sample_extid
  add constraint sample_extid_fk1
  foreign key ( s_id ) 
  references ofbm.sample( s_id );
  
alter table ofbm.sample_event
  add constraint sample_event_fk1
  foreign key ( s_id ) 
  references ofbm.sample( s_id );

/*
alter table ofbm.sample_dx
  add constraint sample_dx_fk1
  foreign key ( s_id ) 
  references ofbm.sample( s_id );
*/

/* person_protocol */
alter table ofbm.person_protocol
  add constraint person_protocol_fk1
  foreign key ( p_id ) 
  references ofbm.person( p_id );

alter table ofbm.person_protocol
  add constraint person_protocol_fk2
  foreign key ( protocol_id ) 
  references ofbm.protocol( protocol_id );

alter table ofbm.protocol_dx
  add constraint protocol_dx_fk1
  foreign key ( protocol_id )
  references ofbm.protocol( protocol_id );

alter table ofbm.consent
  add constraint consent_fk1
  foreign key ( protocol_id ) 
  references ofbm.protocol( protocol_id );


/* BEGIN Drop All FKs */
/* FKs are for Design Purpose ONLY! */
/* Not needed in the ETL */
/*
alter table ofbm.person_race
      drop foreign key person_race_fk1;

alter table ofbm.person_extid
       drop foreign key person_extid_fk1;

alter table ofbm.person_dx
       drop foreign key person_dx_fk1;
*/

/* sample */
/*
alter table ofbm.sample
       drop foreign key sample_fk1;

alter table ofbm.sample_storage
       drop foreign key sample_storage_fk1;

alter table ofbm.sample_extid
       drop foreign key sample_extid_fk1;
  
alter table ofbm.sample_event
       drop foreign key sample_event_fk1;
*/

/*
alter table ofbm.sample_dx
       drop foreign key sample_dx_fk1;
*/

/* person_protocol */
/*
alter table ofbm.person_protocol
       drop foreign key person_protocol_fk1;

alter table ofbm.person_protocol
       drop foreign key person_protocol_fk2;

alter table ofbm.protocol_dx
       drop foreign key protocol_dx_fk1;

alter table ofbm.consent
       drop foreign key consent_fk1;
*/
/* END DROP FK */
