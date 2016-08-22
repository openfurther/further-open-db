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
    However, it may be used for other reporting purpose as well.
    Run ONLY the sections that you need below.
*/

/* BEGIN Possible CLEANUP */
/*
Drop schema ofbm;
create schema ofbm;

set foreign_key_checks=off;
DROP TABLE IF EXISTS ofbm.sample_extid;
DROP TABLE IF EXISTS ofbm.sample_event;
DROP TABLE IF EXISTS ofbm.sample;
DROP TABLE IF EXISTS ofbm.person_dx;
DROP TABLE IF EXISTS ofbm.person_race;
DROP TABLE IF EXISTS ofbm.person_extid;
DROP TABLE IF EXISTS ofbm.person;
DROP TABLE IF EXISTS ofbm.protocol_consent;
DROP TABLE IF EXISTS ofbm.protocol_dx;
DROP TABLE IF EXISTS ofbm.protocol;

Truncate TABLE ofbm.protocol_consent;
Truncate TABLE ofbm.protocol_dx;
Truncate TABLE ofbm.protocol;
Truncate TABLE ofbm.sample_extid;
Truncate TABLE ofbm.sample_event;
Truncate TABLE ofbm.sample;
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
  gender varchar(100) comment 'Gender Self Reported',
  ethnicity varchar(100) comment 'Ethnicity Hispanic or Not',
  birth_dt date comment 'Birth Date',
  birth_yr int unsigned comment 'Birth Year',
  birth_mon int unsigned comment 'Birth Month',
  birth_day int unsigned comment 'Birth Day',
  vital_status varchar(100) comment 'Vital Status Dead or Alive',
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
  race varchar(100) comment 'Race',
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
/* Will System use both icd9 and icd10 codes? */
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


/* Sample or Biospecimen FACT Table */
create table ofbm.sample
( 
  s_id int unsigned comment 'Sample ID',
  parent_s_id int unsigned comment 'Parent Sample ID',
  p_id int unsigned not null comment 'Person ID', 
  protocol_id varchar(255) not null comment 'Protocol ID from External Biospecimen System',
  label varchar(64) comment 'Sample Label',
  barcode varchar(64) comment 'Sample Barcode',
  lineagetype varchar(32) comment 'Lineage Type such as Aliquot, Derived, etc.',
  category varchar(100) comment 'Category',
  type varchar(100) comment 'Sample Type such as DNA, etc',
  qualifier varchar(100) comment 'Qualifier',
  status varchar(100) comment 'Status',
  amount_uom varchar(100) comment 'Amount Unit of Measure',
  amount decimal(10,2) comment 'Sample Volume Amount',
  conc_uom varchar(100) comment 'Concentration Unit of Measure',
  conc decimal(10,2) comment 'Concentration Measurement Value',
  bodysite varchar(100) comment 'Body Site for where Sample was extracted',
  path_dx_desc varchar(100) comment 'Pathology Diagnosis Short Text Description',
  path_report varchar(255) comment 'Pathology Report Text',
  sample_gid int unsigned comment 'NCI Global Sample ID',
  storage_path varchar(255) comment 'Full Storage Path Separated by Delimiter',
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
  sample_label varchar(255) comment 'Optional Sample Event Label',
  sample_barcode varchar(255) comment 'Optional Sample Event Barcode',
  event_ts datetime comment 'Event TimeStamp',
  event varchar(100) comment 'Event',
  ts timestamp default now() comment 'Auto Timestamp to keep track of ETL process',
  primary key (s_event_id)
) 
  engine=innodb 
  default charset=utf8 
  comment='Sample events such as freezing, thawing, aliquot, etc.'
;

/* Protocol with Admin Data from a Single Biobanking System */
create table ofbm.protocol (
  protocol_id varchar(255) not null comment 'Protocol ID from External Biospecimen System',
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
/*
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
*/

/* Consent */
create table ofbm.protocol_consent (
  protocol_consent_id int unsigned auto_increment comment 'Auto-Increment Surrogate ID',
  protocol_id varchar(255) not null comment 'Protocol ID',
  question varchar(255) not null comment 'Consent Question Statement Text',
  answer varchar(255) comment 'Consent answer usually Y or N',
  local_code varchar(255) comment 'Local Consent Statement Code',
  rpms_code varchar(255) comment 'RPMS Category Code',
  ts timestamp default now() comment 'Auto Timestamp to keep track of ETL process',
  primary key (protocol_consent_id)
) 
  engine=innodb 
  default charset=utf8 
  comment='Consent Statements with Answers for Protocols'
;


/* SCHEMA_VERSION Table */
create table ofbm.schema_version
( 
  version_id varchar(16) comment 'unique version id or number',
  version_dt timestamp default now() comment 'version datetime defaults to current datetime',
  primary key (version_id)
)
  engine=innodb 
  default charset=utf8 
  comment='Tracks database schema or data model version'
;
/*
insert into ofbm.schema_version(version_id) values ('1.0.0');
*/

/* END TABLES */


/* BEGIN FK */

/* person stuff */
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

/* Protocol_dx */
alter table ofbm.protocol_dx
  add constraint protocol_dx_fk1
  foreign key ( protocol_id )
  references ofbm.protocol( protocol_id );

/* Protocol_Consent */
alter table ofbm.protocol_consent
  add constraint protocol_consent_fk1
  foreign key ( protocol_id ) 
  references ofbm.protocol( protocol_id );

/* sample */
alter table ofbm.sample
  add constraint sample_fk1
  foreign key ( parent_s_id ) 
  references ofbm.sample( s_id );

alter table ofbm.sample
  add constraint sample_fk2
  foreign key ( p_id )
  references ofbm.person( p_id );

alter table ofbm.sample
  add constraint sample_fk3
  foreign key ( protocol_id ) 
  references ofbm.protocol( protocol_id );

/* pwkm note:
   Although we can query across from FSPECIMEN to FPROTOCOL_CONSENT,
   We do not and should not have a physical implementation of a FK.
   Because the FK relationship would have a false impression that each sample can only have one protocol consent.
   So I am taking these two FKs out. */
/* 
alter table ofbm.sample
  add constraint sample_fk4
  foreign key ( protocol_id ) 
  references ofbm.protocol_dx( protocol_id );

alter table ofbm.sample
  add constraint sample_fk5
  foreign key ( protocol_id ) 
  references ofbm.protocol_consent( protocol_id );
*/

/* Sample External ID */
alter table ofbm.sample_extid
  add constraint sample_extid_fk1
  foreign key ( s_id ) 
  references ofbm.sample( s_id );

/* Sample Events */
alter table ofbm.sample_event
  add constraint sample_event_fk1
  foreign key ( s_id ) 
  references ofbm.sample( s_id );



/* Views or SQLs */
/*
select p.p_id as personID,
       p.last_name,
       p.first_name,
       s.s_id as sampleID,
       s.label as sampleLabel,
       s.barcode as sampleBarcode
  from person p,
       sample s
 where p.p_id = s.s_id;
*/

/* Get Consent Statements for Samples */
/*
SELECT * 
  FROM ofbm.sample s, protocol_consent pc
 where s. protocol_id = pc.protocol_id 
 order by s.s_id;
*/
