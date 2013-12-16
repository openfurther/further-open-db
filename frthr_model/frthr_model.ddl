--------------------------------------------------------
--  File created - Friday-December-13-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table FCONDITION_ERA
--------------------------------------------------------

  CREATE TABLE "FRTHR_MODEL"."FCONDITION_ERA" 
   (	"FCONDITON_ERA_ID" NUMBER(*,0), 
	"DATASET_ID" NUMBER(*,0), 
	"FPERSON_ID" NUMBER(*,0), 
	"FPERSON_COMPOSITE_ID" VARCHAR2(64), 
	"CONDITION_TYPE_CID" VARCHAR2(100), 
	"CONDITION_NMSPC_ID" NUMBER(*,0), 
	"CONDITION_CID" VARCHAR2(100), 
	"CONDITION_ERA_START_DT" DATE, 
	"CONDITION_ERA_END_DT" DATE, 
	"CONDITION_OCCURRENCE_CNT" NUMBER(*,0)
   ) ;
 

   COMMENT ON TABLE "FRTHR_MODEL"."FCONDITION_ERA"  IS 'Condition Era';
--------------------------------------------------------
--  DDL for Table FCONDITION_OCCURRENCE
--------------------------------------------------------

  CREATE TABLE "FRTHR_MODEL"."FCONDITION_OCCURRENCE" 
   (	"FCONDITION_OCCURRENCE_ID" NUMBER(*,0), 
	"DATASET_ID" NUMBER(*,0), 
	"DATASOURCE_NMSPC_ID" NUMBER(*,0), 
	"FPERSON_ID" NUMBER(*,0), 
	"FPERSON_COMPOSITE_ID" VARCHAR2(64), 
	"FPROVIDER_ID" NUMBER(*,0), 
	"FENCOUNTER_ID" NUMBER(*,0), 
	"FCONDITON_ERA_ID" NUMBER(*,0), 
	"CONDITION_TYPE_CID" VARCHAR2(100), 
	"CONDITION_NMSPC_ID" NUMBER(*,0), 
	"CONDITION_CID" VARCHAR2(100), 
	"CONDITION_START_DT" DATE, 
	"CONDITION_END_DT" DATE, 
	"CONDITION_OCCURRENCE_CNT" NUMBER(*,0)
   ) ;
 

   COMMENT ON COLUMN "FRTHR_MODEL"."FCONDITION_OCCURRENCE"."FCONDITION_OCCURRENCE_ID" IS 'CONDITION OCCURRENCE ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FCONDITION_OCCURRENCE"."DATASET_ID" IS 'FURTHER Dataset ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FCONDITION_OCCURRENCE"."DATASOURCE_NMSPC_ID" IS 'Terminology Data Source ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FCONDITION_OCCURRENCE"."FPERSON_ID" IS 'Person ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FCONDITION_OCCURRENCE"."FPROVIDER_ID" IS 'Provider ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FCONDITION_OCCURRENCE"."FENCOUNTER_ID" IS 'Encounter ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FCONDITION_OCCURRENCE"."FCONDITON_ERA_ID" IS 'Condition Era ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FCONDITION_OCCURRENCE"."CONDITION_TYPE_CID" IS 'Condition Type DTS Concept ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FCONDITION_OCCURRENCE"."CONDITION_NMSPC_ID" IS 'Condition DTS Namespace ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FCONDITION_OCCURRENCE"."CONDITION_CID" IS 'Condition DTS Concept ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FCONDITION_OCCURRENCE"."CONDITION_START_DT" IS 'Condition Start Date';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FCONDITION_OCCURRENCE"."CONDITION_END_DT" IS 'Condition End Date';
 
   COMMENT ON TABLE "FRTHR_MODEL"."FCONDITION_OCCURRENCE"  IS 'Condition Occurence';
--------------------------------------------------------
--  DDL for Table FENCOUNTER
--------------------------------------------------------

  CREATE TABLE "FRTHR_MODEL"."FENCOUNTER" 
   (	"FENCOUNTER_ID" NUMBER(*,0), 
	"DATASET_ID" NUMBER(*,0), 
	"DATASOURCE_NMSPC_ID" NUMBER(*,0), 
	"FPERSON_ID" NUMBER(*,0), 
	"FPERSON_COMPOSITE_ID" VARCHAR2(64), 
	"FACILITY_NMSPC_ID" NUMBER(*,0), 
	"FACILITY_CID" VARCHAR2(100), 
	"ADMISSION_DTS" DATE, 
	"ADMISSION_YR" NUMBER(*,0), 
	"ADMISSION_MON" NUMBER(*,0), 
	"ADMISSION_DAY" NUMBER(*,0), 
	"DISCHARGE_DTS" DATE, 
	"DISCHARGE_YR" NUMBER(*,0), 
	"DISCHARGE_MON" NUMBER(*,0), 
	"DISCHARGE_DAY" NUMBER(*,0), 
	"LENGTH_OF_STAY" NUMBER(*,0), 
	"LENGTH_OF_STAY_UNITS_NMSPC_ID" NUMBER(*,0), 
	"LENGTH_OF_STAY_UNITS_CID" VARCHAR2(100), 
	"ADMIT_SOURCE_NMSPC_ID" NUMBER(*,0), 
	"ADMIT_SOURCE_CID" VARCHAR2(100), 
	"ADMIT_TYPE_NMSPC_ID" NUMBER(*,0), 
	"ADMIT_TYPE_CID" VARCHAR2(100), 
	"PATIENT_CLASS_NMSPC_ID" NUMBER(*,0), 
	"PATIENT_CLASS_CID" VARCHAR2(100), 
	"PATIENT_TYPE_NMSPC_ID" NUMBER(*,0), 
	"PATIENT_TYPE_CID" VARCHAR2(100), 
	"HOSPITAL_SERVICE_NMSPC_ID" NUMBER(*,0), 
	"HOSPITAL_SERVICE_CID" VARCHAR2(100)
   ) ;
 

   COMMENT ON COLUMN "FRTHR_MODEL"."FENCOUNTER"."FENCOUNTER_ID" IS 'ENCOUNTER ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FENCOUNTER"."DATASET_ID" IS 'FURTHER Dataset ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FENCOUNTER"."DATASOURCE_NMSPC_ID" IS 'Data Source ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FENCOUNTER"."FPERSON_ID" IS 'Person ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FENCOUNTER"."FPERSON_COMPOSITE_ID" IS 'Composite key of dataset_id:fperson_id to reduce object-relational mapping complexity';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FENCOUNTER"."FACILITY_NMSPC_ID" IS 'Facility Namespace ID, This would be the Organization';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FENCOUNTER"."FACILITY_CID" IS 'Facility Concept ID for a specific Facility';
 
   COMMENT ON TABLE "FRTHR_MODEL"."FENCOUNTER"  IS 'Encounter';
--------------------------------------------------------
--  DDL for Table FLOCATION
--------------------------------------------------------

  CREATE TABLE "FRTHR_MODEL"."FLOCATION" 
   (	"FLOCATION_ID" NUMBER(*,0), 
	"DATASET_ID" NUMBER(*,0), 
	"FLOCATION_COMPOSITE_ID" VARCHAR2(64), 
	"LCTN_GROUP_ID" NUMBER(*,0), 
	"LCTN_GROUP_ORDER" NUMBER(*,0), 
	"LCTN_TYPE_NMSPC_ID" NUMBER(*,0), 
	"LCTN_TYPE_CID" VARCHAR2(100), 
	"LCTN_COMPONENT_NMSPC_ID" NUMBER(*,0), 
	"LCTN_COMPONENT_CID" VARCHAR2(100), 
	"LCTN_COMPONENT_VALUE" VARCHAR2(1000), 
	"START_DT" DATE, 
	"END_DT" DATE
   ) ;
 

   COMMENT ON COLUMN "FRTHR_MODEL"."FLOCATION"."FLOCATION_ID" IS 'Surrogate Key for Location';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FLOCATION"."DATASET_ID" IS 'Data Set or Query ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FLOCATION"."FLOCATION_COMPOSITE_ID" IS 'Composite key of DATASET_ID:FLOCATION_ID to reduce object-relational mapping complexity';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FLOCATION"."LCTN_GROUP_ID" IS 'Groups Entries as a Single Address Component';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FLOCATION"."LCTN_GROUP_ORDER" IS 'Order of Entries within a Group';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FLOCATION"."LCTN_TYPE_NMSPC_ID" IS 'DTS Namespace ID for Location Type';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FLOCATION"."LCTN_TYPE_CID" IS 'DTS Concept ID for Location Type such as HomeAddress, BirthLocation, etc.';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FLOCATION"."LCTN_COMPONENT_NMSPC_ID" IS 'DTS Namespace ID for Location Component';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FLOCATION"."LCTN_COMPONENT_CID" IS 'DTS Concept ID for the Location Component such as Street, City, Hospital, etc.';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FLOCATION"."LCTN_COMPONENT_VALUE" IS 'Location Component Value such as 123 Sesame Street';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FLOCATION"."START_DT" IS 'Location Component Value Start Date';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FLOCATION"."END_DT" IS 'Location Component Value End Date';
 
   COMMENT ON TABLE "FRTHR_MODEL"."FLOCATION"  IS 'Location such as Person Address or Encounter Location';
--------------------------------------------------------
--  DDL for Table FOBSERVATION_FACT
--------------------------------------------------------

  CREATE TABLE "FRTHR_MODEL"."FOBSERVATION_FACT" 
   (	"FOBSERVATION_ID" NUMBER(*,0), 
	"DATASET_ID" NUMBER(*,0), 
	"DATASOURCE_NMSPC_ID" NUMBER(*,0), 
	"FORDER_ID" NUMBER(*,0), 
	"FPERSON_ID" NUMBER(*,0), 
	"FPERSON_COMPOSITE_ID" VARCHAR2(64), 
	"PERSON_AGE_AT_OBS" NUMBER(*,0), 
	"FENCOUNTER_ID" NUMBER(*,0), 
	"FOBSERVATION_PERIOD_ID" NUMBER(*,0), 
	"OBSERVATION_TYPE_CID" VARCHAR2(50), 
	"OBSERVATION_NMSPC_ID" NUMBER(*,0), 
	"OBSERVATION_CID" VARCHAR2(100), 
	"OBSERVATION_MOD_NMSPC_ID" NUMBER(*,0), 
	"OBSERVATION_MOD_CID" VARCHAR2(100), 
	"OBSERVATION_FLAG_NMSPC_ID" NUMBER(*,0), 
	"OBSERVATION_FLAG" VARCHAR2(50), 
	"METHOD_NMSPC_ID" NUMBER(*,0), 
	"METHOD_CID" VARCHAR2(100), 
	"VALUE_NMPSC_ID" NUMBER(*,0), 
	"VALUE_CID" VARCHAR2(100), 
	"VALUE_TYPE_CD" VARCHAR2(20), 
	"VALUE_STRING" VARCHAR2(1000), 
	"VALUE_NUMBER" NUMBER(*,0), 
	"VALUE_UNITS_NMSPC_ID" NUMBER(*,0), 
	"VALUE_UNITS_CID" VARCHAR2(100), 
	"OBSERVATION_SEQ" NUMBER(*,0), 
	"START_DTS" DATE, 
	"END_DTS" DATE
   ) ;
 

   COMMENT ON COLUMN "FRTHR_MODEL"."FOBSERVATION_FACT"."FOBSERVATION_ID" IS 'Observation ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FOBSERVATION_FACT"."DATASET_ID" IS 'FURTHER Dataset ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FOBSERVATION_FACT"."DATASOURCE_NMSPC_ID" IS 'Terminology Data Source ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FOBSERVATION_FACT"."FORDER_ID" IS 'Prescription Order ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FOBSERVATION_FACT"."FPERSON_ID" IS 'Person ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FOBSERVATION_FACT"."PERSON_AGE_AT_OBS" IS 'Person Age at time of Observation';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FOBSERVATION_FACT"."FENCOUNTER_ID" IS 'Encounter ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FOBSERVATION_FACT"."FOBSERVATION_PERIOD_ID" IS 'Observation Period ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FOBSERVATION_FACT"."OBSERVATION_TYPE_CID" IS 'Observation Type Concept ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FOBSERVATION_FACT"."OBSERVATION_FLAG_NMSPC_ID" IS 'Observation Flag Namespace ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FOBSERVATION_FACT"."OBSERVATION_FLAG" IS 'Observation Flag such as High, Low, etc.';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FOBSERVATION_FACT"."START_DTS" IS 'Observation Start Date Timestamp';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FOBSERVATION_FACT"."END_DTS" IS 'Observation End Date Timestamp';
 
   COMMENT ON TABLE "FRTHR_MODEL"."FOBSERVATION_FACT"  IS 'Observation Fact';
--------------------------------------------------------
--  DDL for Table FOBSERVATION_PERIOD
--------------------------------------------------------

  CREATE TABLE "FRTHR_MODEL"."FOBSERVATION_PERIOD" 
   (	"FOBSERVATION_PERIOD_ID" NUMBER(*,0), 
	"DATASET_ID" NUMBER(*,0), 
	"FPERSON_ID" NUMBER(*,0), 
	"FPERSON_COMPOSITE_ID" VARCHAR2(64), 
	"OBS_PERIOD_START_DATE" DATE, 
	"OBS_PERIOD_END_DATE" DATE
   ) ;
 

   COMMENT ON TABLE "FRTHR_MODEL"."FOBSERVATION_PERIOD"  IS 'Observation Period';
--------------------------------------------------------
--  DDL for Table FORDER_FACT
--------------------------------------------------------

  CREATE TABLE "FRTHR_MODEL"."FORDER_FACT" 
   (	"FORDER_ID" NUMBER(*,0), 
	"DATASET_ID" NUMBER(*,0), 
	"DATASOURCE_NMSPC_ID" NUMBER(*,0), 
	"FPERSON_ID" NUMBER(*,0), 
	"FPERSON_COMPOSITE_ID" VARCHAR2(64), 
	"FENCOUNTER_ID" NUMBER(*,0), 
	"FPROVIDER_ID" NUMBER(*,0), 
	"PRIORITY_NMSPC_ID" NUMBER(*,0), 
	"PRIORITY_CID" VARCHAR2(100), 
	"ORDER_DTS" DATE, 
	"DISCONTINUE_DTS" DATE, 
	"ORDER_STATUS_NMSPC_ID" NUMBER(*,0), 
	"ORDER_STATUS_CID" VARCHAR2(100), 
	"ORDER_TYPE_NMSPC_ID" NUMBER(*,0), 
	"ORDER_TYPE_CID" VARCHAR2(100), 
	"START_DTS" DATE, 
	"STOP_DTS" DATE, 
	"ORDER_ITEM_NMSPC_ID" NUMBER(*,0), 
	"ORDER_ITEM_CID" VARCHAR2(100), 
	"ORDER_ITEM_QTY" NUMBER(*,0), 
	"ORDER_ITEM_QTY_UNITS_NMSPC_ID" NUMBER(*,0), 
	"ORDER_ITEM_QTY_UNITS_CID" VARCHAR2(100), 
	"ORDER_ITEM_FORM_NMSPC_ID" NUMBER(*,0), 
	"ORDER_ITEM_FORM_CID" VARCHAR2(100), 
	"ROUTE_NMSPC_ID" NUMBER(*,0), 
	"ROUTE_CID" VARCHAR2(100), 
	"SPECIMEN_TYPE_NMSPC_ID" NUMBER(*,0), 
	"SPECIMEN_TYPE_CID" VARCHAR2(100), 
	"SPECIMEN_SOURCE_NMSPC_ID" NUMBER(*,0), 
	"SPECIMEN_SOURCE_CID" VARCHAR2(100), 
	"FSPECIMEN_ID" NUMBER(*,0), 
	"DURATION" NUMBER(*,0), 
	"DURATION_UNITS_NMSPC_ID" NUMBER(*,0), 
	"DURATION_UNITS_CID" VARCHAR2(100), 
	"DUMMY_NULL" NUMBER(*,0)
   ) ;
 

   COMMENT ON COLUMN "FRTHR_MODEL"."FORDER_FACT"."DATASOURCE_NMSPC_ID" IS 'Terminology Data Source ID';
 
   COMMENT ON TABLE "FRTHR_MODEL"."FORDER_FACT"  IS 'Order Fact or Medication Prescriptions';
--------------------------------------------------------
--  DDL for Table FPERSON
--------------------------------------------------------

  CREATE TABLE "FRTHR_MODEL"."FPERSON" 
   (	"FPERSON_ID" NUMBER(*,0), 
	"DATASET_ID" NUMBER(*,0), 
	"FPERSON_COMPOSITE_ID" VARCHAR2(64), 
	"ADMINISTRATIVE_GENDER_NMSPC_ID" NUMBER(*,0), 
	"ADMINISTRATIVE_GENDER_CID" VARCHAR2(100), 
	"RACE_NMSPC_ID" NUMBER(*,0), 
	"RACE_CID" VARCHAR2(100), 
	"ETHNICITY_NMSPC_ID" NUMBER(*,0), 
	"ETHNICITY_CID" VARCHAR2(100), 
	"BIRTH_DT" DATE, 
	"BIRTH_YR" NUMBER(*,0), 
	"BIRTH_MON" NUMBER(*,0), 
	"BIRTH_DAY" NUMBER(*,0), 
	"EDUCATION_LEVEL" NUMBER(*,0), 
	"PRIMARY_LANGUAGE_NMSPC_ID" NUMBER(*,0), 
	"PRIMARY_LANGUAGE_CID" VARCHAR2(100), 
	"MARITAL_STATUS_NMSPC_ID" NUMBER(*,0), 
	"MARITAL_STATUS_CID" VARCHAR2(100), 
	"RELIGION_NMSPC_ID" NUMBER(*,0), 
	"RELIGION_CID" VARCHAR2(100), 
	"MULTIPLE_BIRTH_INDICATOR" NUMBER(*,0), 
	"MULTIPLE_BIRTH_ORDER_NUMBER" NUMBER(*,0), 
	"VITAL_STATUS_NMSPC_ID" NUMBER(*,0), 
	"VITAL_STATUS" VARCHAR2(100), 
	"CAUSE_OF_DEATH_NMSPC_ID" NUMBER(*,0), 
	"CAUSE_OF_DEATH_CID" VARCHAR2(100), 
	"DEATH_DT" DATE, 
	"DEATH_YR" NUMBER(*,0), 
	"PEDIGREE_QUALITY" NUMBER(*,0)
   ) ;
 

   COMMENT ON COLUMN "FRTHR_MODEL"."FPERSON"."FPERSON_COMPOSITE_ID" IS 'Composite key of dataset_id:fperson_id to reduce object-relational mapping complexity';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FPERSON"."VITAL_STATUS_NMSPC_ID" IS 'D=Dead,A=Alive';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FPERSON"."PEDIGREE_QUALITY" IS 'Kinship Coefficient in UPDB';
 
   COMMENT ON TABLE "FRTHR_MODEL"."FPERSON"  IS 'Person';
--------------------------------------------------------
--  DDL for Table FPERSON_ASSOC
--------------------------------------------------------

  CREATE TABLE "FRTHR_MODEL"."FPERSON_ASSOC" 
   (	"FPERSON_ASSOC_ID" NUMBER(*,0), 
	"DATASET_ID" NUMBER(*,0), 
	"FPERSON_LS_ID" NUMBER(*,0), 
	"ASSOCIATION_CID" VARCHAR2(100), 
	"FPERSON_RS_ID" NUMBER(*,0)
   ) ;
 

   COMMENT ON TABLE "FRTHR_MODEL"."FPERSON_ASSOC"  IS 'Person Association';
--------------------------------------------------------
--  DDL for Table FPERSON_EXTID
--------------------------------------------------------

  CREATE TABLE "FRTHR_MODEL"."FPERSON_EXTID" 
   (	"FPERSON_EXTID_ID" NUMBER(*,0), 
	"FPERSON_ID" NUMBER(*,0), 
	"DATASET_ID" NUMBER(*,0), 
	"FPERSON_COMPOSITE_ID" VARCHAR2(64), 
	"DATASOURCE_NMSPC_ID" NUMBER(*,0), 
	"ID_TYPE_NMSPC_ID" NUMBER(*,0), 
	"ID_TYPE_CID" VARCHAR2(100), 
	"ID_VALUE" VARCHAR2(100)
   ) ;
 

   COMMENT ON COLUMN "FRTHR_MODEL"."FPERSON_EXTID"."FPERSON_EXTID_ID" IS 'Auto ID to support the one(person)-to-many(ExtIDs) relationship';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FPERSON_EXTID"."FPERSON_ID" IS 'FK to FPERSON.FPerson_ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FPERSON_EXTID"."DATASET_ID" IS 'Dataset ID Similar to a FURTHER Query ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FPERSON_EXTID"."FPERSON_COMPOSITE_ID" IS 'Composite key of dataset_id:fperson_id to reduce object-relational mapping complexity';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FPERSON_EXTID"."DATASOURCE_NMSPC_ID" IS 'MDR Data Source Namespace ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FPERSON_EXTID"."ID_TYPE_NMSPC_ID" IS 'DTS Namespace ID for ID Types';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FPERSON_EXTID"."ID_TYPE_CID" IS 'DTS ID Type Concept ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FPERSON_EXTID"."ID_VALUE" IS 'Person External ID Value';
 
   COMMENT ON TABLE "FRTHR_MODEL"."FPERSON_EXTID"  IS 'PERSON External IDs';
--------------------------------------------------------
--  DDL for Table FPERSON_LCTN
--------------------------------------------------------

  CREATE TABLE "FRTHR_MODEL"."FPERSON_LCTN" 
   (	"FPERSON_LCTN_ID" NUMBER(*,0), 
	"DATASET_ID" NUMBER(*,0), 
	"FPERSON_LCTN_COMPOSITE_ID" VARCHAR2(64), 
	"FPERSON_ID" NUMBER(*,0), 
	"FLOCATION_ID" NUMBER(*,0)
   ) ;
 

   COMMENT ON COLUMN "FRTHR_MODEL"."FPERSON_LCTN"."FPERSON_LCTN_ID" IS 'Surrogate ID for FPERSON_LCTN Table';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FPERSON_LCTN"."DATASET_ID" IS 'Data Set or Query ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FPERSON_LCTN"."FPERSON_LCTN_COMPOSITE_ID" IS 'Composite key of dataset_id:fperson_id to reduce object-relational mapping complexity';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FPERSON_LCTN"."FPERSON_ID" IS 'FURTHER (FEDERATED) PERSON ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FPERSON_LCTN"."FLOCATION_ID" IS 'FLOCATION ID';
 
   COMMENT ON TABLE "FRTHR_MODEL"."FPERSON_LCTN"  IS 'Person Location Linking Table';
--------------------------------------------------------
--  DDL for Table FPROCEDURE_OCCURRENCE
--------------------------------------------------------

  CREATE TABLE "FRTHR_MODEL"."FPROCEDURE_OCCURRENCE" 
   (	"FPROCEDURE_ID" NUMBER(*,0), 
	"DATASET_ID" NUMBER(*,0), 
	"DATASOURCE_NMSPC_ID" NUMBER(*,0), 
	"FPERSON_ID" NUMBER(*,0), 
	"FPERSON_COMPOSITE_ID" VARCHAR2(64), 
	"FPROVIDER_ID" NUMBER(*,0), 
	"FENCOUNTER_ID" NUMBER(*,0), 
	"PROCEDURE_TYPE_CID" VARCHAR2(100), 
	"PROCEDURE_NAMESPACE_ID" NUMBER(*,0), 
	"PROCEDURE_CID" VARCHAR2(100), 
	"PROCEDURE_DTS" DATE, 
	"PROCEDURE_YR" NUMBER(*,0), 
	"PROCEDURE_MON" NUMBER(*,0), 
	"PROCEDURE_DAY" NUMBER(*,0), 
	"RELEVANT_COND_NMSPC_ID" NUMBER(*,0), 
	"RELEVANT_CONDITION_CID" VARCHAR2(100)
   ) ;
 

   COMMENT ON COLUMN "FRTHR_MODEL"."FPROCEDURE_OCCURRENCE"."DATASOURCE_NMSPC_ID" IS 'Terminology Data Source ID';
 
   COMMENT ON TABLE "FRTHR_MODEL"."FPROCEDURE_OCCURRENCE"  IS 'Procedure Occurrence';
--------------------------------------------------------
--  DDL for Table FPROVIDER
--------------------------------------------------------

  CREATE TABLE "FRTHR_MODEL"."FPROVIDER" 
   (	"FPROVIDER_ID" NUMBER(*,0), 
	"DATASET_ID" NUMBER(*,0), 
	"FPERSON_ID" NUMBER(*,0), 
	"FPERSON_COMPOSITE_ID" VARCHAR2(64), 
	"PROVIDER_NAME" VARCHAR2(100), 
	"SPECIALTY_NMSPC_ID" NUMBER(*,0), 
	"SPECIALTY_CID" VARCHAR2(100), 
	"SPECIALTY_MOD_NMSPC_ID" NUMBER(*,0), 
	"SPECIALTY_MOD_CID" VARCHAR2(100), 
	"START_DTS" DATE, 
	"END_DTS" DATE
   ) ;
 

   COMMENT ON TABLE "FRTHR_MODEL"."FPROVIDER"  IS 'Provider';
--------------------------------------------------------
--  DDL for Table FSPECIMEN
--------------------------------------------------------

  CREATE TABLE "FRTHR_MODEL"."FSPECIMEN" 
   (	"FSPECIMEN_ID" NUMBER(*,0), 
	"PARENT_FSPECIMEN_ID" NUMBER(*,0), 
	"LINEAGETYPE" CHAR(1), 
	"DATASET_ID" NUMBER(*,0), 
	"DATASOURCE_NMSPC_ID" NUMBER(*,0), 
	"SPECIMEN_NAME" VARCHAR2(32), 
	"FPERSON_ID" NUMBER(*,0), 
	"FPERSON_COMPOSITE_ID" VARCHAR2(64), 
	"CATEGORY_NMSPC_ID" NUMBER(*,0), 
	"CATEGORY_CID" VARCHAR2(100), 
	"TYPE_NMSPC_ID" NUMBER(*,0), 
	"TYPE_CID" VARCHAR2(100), 
	"QUALIFIER_NMSPC_ID" NUMBER(*,0), 
	"QUALIFIER_CID" VARCHAR2(100), 
	"STATUS_NMSPC_ID" NUMBER(*,0), 
	"STATUS_CID" VARCHAR2(100), 
	"AMOUNT_UOM_NMSPC_ID" NUMBER(*,0), 
	"AMOUNT_UOM_CID" VARCHAR2(100), 
	"AMOUNT" NUMBER(*,2), 
	"CONC_UOM_NMSPC_ID" NUMBER(*,0), 
	"CONC_UOM_CID" VARCHAR2(100), 
	"CONC" NUMBER(*,2), 
	"OWNER" VARCHAR2(100), 
	"SPECIMEN_ALIAS" VARCHAR2(32), 
	"SPECIMEN_ALIAS_TYPE" VARCHAR2(32), 
	"FSPECIMEN_GID" NUMBER(*,0), 
	"BODYSITE_NMSPC_ID" NUMBER(*,0), 
	"BODYSITE_CID" VARCHAR2(100), 
	"FSTORAGE_ID" NUMBER(*,0)
   ) ;
 

   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."FSPECIMEN_ID" IS 'Auto Specimen ID for Primary Key';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."PARENT_FSPECIMEN_ID" IS 'Parent Specimen ID if there is a Parent, NULL=Original Sample';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."LINEAGETYPE" IS 'LineageType for Non-Parent Samples: Aliquot, Derived, Collected, Received';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."DATASET_ID" IS 'Dataset or DataSource ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."DATASOURCE_NMSPC_ID" IS 'Terminology Data Source ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."SPECIMEN_NAME" IS 'Specimen Name or Sample ID from Data Source';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."FPERSON_ID" IS 'Person ID such as UUEDW_ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."FPERSON_COMPOSITE_ID" IS 'Person Composite ID = DataSet_ID:FPerson_ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."CATEGORY_NMSPC_ID" IS 'Terminology Namespace ID for Specimen Category';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."CATEGORY_CID" IS 'Terminology Concept ID for Specimen Category such as Blood, DNA, etc.';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."TYPE_NMSPC_ID" IS 'Terminology Namespace ID for Specimen Type';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."TYPE_CID" IS 'Terminology Concept ID for Specimen Type such as Plasma, Serum, etc.';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."QUALIFIER_NMSPC_ID" IS 'Terminology Namespace ID for Qualifier';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."QUALIFIER_CID" IS 'Terminology Concept ID for Qualifier such as Cancerous, etc.';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."STATUS_NMSPC_ID" IS 'Terminology Namespace ID for Specimen Status or Qualifier';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."STATUS_CID" IS 'Terminology Concept ID for Specimen Status such as Available, Unavailable';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."AMOUNT_UOM_NMSPC_ID" IS 'Terminology Namespace ID for Specimen AMOUNT Unit of Measure';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."AMOUNT_UOM_CID" IS 'Terminology Concept ID for Specimen AMOUNT Unit of Measure';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."AMOUNT" IS 'Current Specimen Amount';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."CONC_UOM_NMSPC_ID" IS 'Terminology Namespace ID for Specimen Concentration Unit of Measure';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."CONC_UOM_CID" IS 'Terminology Concept ID for Specimen Concentration Unit of Measure';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."CONC" IS 'Current Specimen Concentration';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."OWNER" IS 'Current steward of sample (administrative or PI)';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."SPECIMEN_ALIAS" IS 'Specimen Alias or resident (local) identifier';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."SPECIMEN_ALIAS_TYPE" IS 'Specimen Alias Type';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."FSPECIMEN_GID" IS 'NCI Global Specimen ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."BODYSITE_NMSPC_ID" IS 'Terminology Namespace ID for Specimen Body Site';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."BODYSITE_CID" IS 'Terminology Concept ID for Specimen Body Site';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN"."FSTORAGE_ID" IS 'Specimen Storage Location ID';
 
   COMMENT ON TABLE "FRTHR_MODEL"."FSPECIMEN"  IS 'Specimens or Samples';
--------------------------------------------------------
--  DDL for Table FSPECIMEN_EVENT
--------------------------------------------------------

  CREATE TABLE "FRTHR_MODEL"."FSPECIMEN_EVENT" 
   (	"FSPECIMEN_EVENT_ID" NUMBER(*,0), 
	"DATASET_ID" NUMBER(*,0), 
	"DATASOURCE_NMSPC_ID" NUMBER(*,0), 
	"FSPECIMEN_ID" NUMBER(*,0), 
	"TYPE_NMSPC_ID" NUMBER(*,0), 
	"TYPE_CID" VARCHAR2(100), 
	"EVENT_DT" DATE
   ) ;
 

   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN_EVENT"."FSPECIMEN_EVENT_ID" IS 'Event ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN_EVENT"."DATASET_ID" IS 'Dataset or DataSource ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN_EVENT"."DATASOURCE_NMSPC_ID" IS 'Terminology Data Source ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN_EVENT"."FSPECIMEN_ID" IS 'SPECIMEN ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN_EVENT"."TYPE_NMSPC_ID" IS 'Terminology Namespace ID for Specimen Event';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN_EVENT"."TYPE_CID" IS 'Terminology Concept ID for Event Type such as freeze, thaw, etc.';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN_EVENT"."EVENT_DT" IS 'Event Date Time';
 
   COMMENT ON TABLE "FRTHR_MODEL"."FSPECIMEN_EVENT"  IS 'Specimen Event';
--------------------------------------------------------
--  DDL for Table FSPECIMEN_NOTE
--------------------------------------------------------

  CREATE TABLE "FRTHR_MODEL"."FSPECIMEN_NOTE" 
   (	"FSPECIMEN_NOTE_ID" NUMBER(*,0), 
	"DATASET_ID" NUMBER(*,0), 
	"DATASOURCE_NMSPC_ID" NUMBER(*,0), 
	"FSPECIMEN_ID" NUMBER(*,0), 
	"ANNOTATOR" VARCHAR2(512), 
	"NOTE" VARCHAR2(512), 
	"NOTE_DT" DATE
   ) ;
 

   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN_NOTE"."FSPECIMEN_NOTE_ID" IS 'Note ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN_NOTE"."DATASET_ID" IS 'Dataset ID Assigned By FURTHER';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN_NOTE"."DATASOURCE_NMSPC_ID" IS 'Terminology Data Source ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN_NOTE"."FSPECIMEN_ID" IS 'SPECIMEN ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN_NOTE"."ANNOTATOR" IS 'Person created the note or quality annotation';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN_NOTE"."NOTE" IS 'Note';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSPECIMEN_NOTE"."NOTE_DT" IS 'Note Creation Date';
 
   COMMENT ON TABLE "FRTHR_MODEL"."FSPECIMEN_NOTE"  IS 'Sample Note';
--------------------------------------------------------
--  DDL for Table FSTORAGE
--------------------------------------------------------

  CREATE TABLE "FRTHR_MODEL"."FSTORAGE" 
   (	"FSTORAGE_ID" NUMBER(*,0), 
	"DATASET_ID" NUMBER(*,0), 
	"DATASOURCE_NMSPC_ID" NUMBER(*,0), 
	"TYPE_NMSPC_ID" NUMBER(*,0), 
	"TYPE_CID" VARCHAR2(100), 
	"STORAGE_PATH" VARCHAR2(512)
   ) ;
 

   COMMENT ON COLUMN "FRTHR_MODEL"."FSTORAGE"."FSTORAGE_ID" IS 'STORAGE ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSTORAGE"."DATASET_ID" IS 'Dataset ID Assigned By FURTHER';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSTORAGE"."DATASOURCE_NMSPC_ID" IS 'Terminology Data Source ID';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSTORAGE"."TYPE_NMSPC_ID" IS 'Terminology Namespace ID for Storage Container Type';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSTORAGE"."TYPE_CID" IS 'Terminology Concept ID for Storage Container Type';
 
   COMMENT ON COLUMN "FRTHR_MODEL"."FSTORAGE"."STORAGE_PATH" IS 'Full Storage Path';
 
   COMMENT ON TABLE "FRTHR_MODEL"."FSTORAGE"  IS 'Sample Storage Location';
--------------------------------------------------------
--  DDL for View PERSON_SPECIMEN_V
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "FRTHR_MODEL"."PERSON_SPECIMEN_V" ("PERSON_PERSONID", "SPECIMEN_ID", "SPECIMEN_PERSONID", "SAMPLE_ALIAS", "SAMPLE_ALIAS_TYPE") AS 
  select p.fperson_id as Person_PersonID,
       s.fspecimen_id as Specimen_ID,
       s.fperson_id as Specimen_PersonID,
       s.specimen_alias as Sample_Alias,
       s.specimen_alias_type as Sample_Alias_Type
  from fperson p left outer join fspecimen s
    on p.fperson_id = s.fperson_id
 ORDER BY p.fperson_id;
--------------------------------------------------------
--  DDL for View SPECIMEN_STORAGE_V
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "FRTHR_MODEL"."SPECIMEN_STORAGE_V" ("FSPECIMEN_ID", "PARENT_FSPECIMEN_ID", "DATASET_ID", "FPERSON_ID", "CATEGORY_NMSPC_ID", "CATEGORY_CID", "TYPE_NMSPC_ID", "TYPE_CID", "STATUS_NMSPC_ID", "STATUS_CID", "AMOUNT_UOM_NMSPC_ID", "AMOUNT_UOM_CID", "AMOUNT", "SPECIMEN_ALIAS", "SPECIMEN_ALIAS_TYPE", "FSTORAGE_ID", "STORAGE_PATH") AS 
  select spe.fspecimen_id,
       spe.parent_fspecimen_id,
       spe.dataset_id,
       spe.fperson_id,
       spe.CATEGORY_NMSPC_ID,
       spe.CATEGORY_CID,
       spe.TYPE_NMSPC_ID,
       spe.TYPE_CID,
       spe.STATUS_NMSPC_ID,
       spe.STATUS_CID,
       spe.AMOUNT_UOM_NMSPC_ID,
       spe.AMOUNT_UOM_CID,
       spe.AMOUNT,
       spe.specimen_alias,
       spe.specimen_alias_type,
       spe.fstorage_id,
       sto.storage_path
  from fspecimen spe join fstorage sto
    on spe.fstorage_id = sto.fstorage_id
 ORDER BY spe.fspecimen_id;
--------------------------------------------------------
--  DDL for Index FCONDITION_ERA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_MODEL"."FCONDITION_ERA_PK" ON "FRTHR_MODEL"."FCONDITION_ERA" ("FCONDITON_ERA_ID", "DATASET_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FCONDITION_OCCURRENCE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_MODEL"."FCONDITION_OCCURRENCE_PK" ON "FRTHR_MODEL"."FCONDITION_OCCURRENCE" ("FCONDITION_OCCURRENCE_ID", "DATASET_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FENCOUNTER_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_MODEL"."FENCOUNTER_PK" ON "FRTHR_MODEL"."FENCOUNTER" ("FENCOUNTER_ID", "DATASET_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FLOCATION_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_MODEL"."FLOCATION_PK" ON "FRTHR_MODEL"."FLOCATION" ("FLOCATION_ID", "DATASET_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FOBSERVATION_FACT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_MODEL"."FOBSERVATION_FACT_PK" ON "FRTHR_MODEL"."FOBSERVATION_FACT" ("FOBSERVATION_ID", "DATASET_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FOBSERVATION_PERIOD_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_MODEL"."FOBSERVATION_PERIOD_PK" ON "FRTHR_MODEL"."FOBSERVATION_PERIOD" ("FOBSERVATION_PERIOD_ID", "DATASET_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FORDER_FACT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_MODEL"."FORDER_FACT_PK" ON "FRTHR_MODEL"."FORDER_FACT" ("FORDER_ID", "DATASET_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FPERSON_ASSOC_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_MODEL"."FPERSON_ASSOC_PK" ON "FRTHR_MODEL"."FPERSON_ASSOC" ("FPERSON_ASSOC_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FPERSON_EXTID_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_MODEL"."FPERSON_EXTID_PK" ON "FRTHR_MODEL"."FPERSON_EXTID" ("FPERSON_EXTID_ID", "DATASET_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FPERSON_LCTN_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_MODEL"."FPERSON_LCTN_PK" ON "FRTHR_MODEL"."FPERSON_LCTN" ("FPERSON_LCTN_ID", "DATASET_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FPERSON_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_MODEL"."FPERSON_PK" ON "FRTHR_MODEL"."FPERSON" ("FPERSON_ID", "DATASET_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FPROCEDURE_OCCURRENCE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_MODEL"."FPROCEDURE_OCCURRENCE_PK" ON "FRTHR_MODEL"."FPROCEDURE_OCCURRENCE" ("FPROCEDURE_ID", "DATASET_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FPROVIDER_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_MODEL"."FPROVIDER_PK" ON "FRTHR_MODEL"."FPROVIDER" ("FPROVIDER_ID", "DATASET_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FSPECIMEN_EVENT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_MODEL"."FSPECIMEN_EVENT_PK" ON "FRTHR_MODEL"."FSPECIMEN_EVENT" ("FSPECIMEN_EVENT_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FSPECIMEN_NOTE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_MODEL"."FSPECIMEN_NOTE_PK" ON "FRTHR_MODEL"."FSPECIMEN_NOTE" ("FSPECIMEN_NOTE_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FSPECIMEN_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_MODEL"."FSPECIMEN_PK" ON "FRTHR_MODEL"."FSPECIMEN" ("FSPECIMEN_ID", "DATASET_ID") 
  ;
--------------------------------------------------------
--  DDL for Index FSTORAGE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FRTHR_MODEL"."FSTORAGE_PK" ON "FRTHR_MODEL"."FSTORAGE" ("FSTORAGE_ID") 
  ;
--------------------------------------------------------
--  Constraints for Table FCONDITION_ERA
--------------------------------------------------------

  ALTER TABLE "FRTHR_MODEL"."FCONDITION_ERA" ADD CONSTRAINT "FCONDITION_ERA_PK" PRIMARY KEY ("FCONDITON_ERA_ID", "DATASET_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table FCONDITION_OCCURRENCE
--------------------------------------------------------

  ALTER TABLE "FRTHR_MODEL"."FCONDITION_OCCURRENCE" ADD CONSTRAINT "FCONDITION_OCCURRENCE_PK" PRIMARY KEY ("FCONDITION_OCCURRENCE_ID", "DATASET_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table FENCOUNTER
--------------------------------------------------------

  ALTER TABLE "FRTHR_MODEL"."FENCOUNTER" ADD CONSTRAINT "FENCOUNTER_PK" PRIMARY KEY ("FENCOUNTER_ID", "DATASET_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table FLOCATION
--------------------------------------------------------

  ALTER TABLE "FRTHR_MODEL"."FLOCATION" ADD CONSTRAINT "FLOCATION_PK" PRIMARY KEY ("FLOCATION_ID", "DATASET_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table FOBSERVATION_FACT
--------------------------------------------------------

  ALTER TABLE "FRTHR_MODEL"."FOBSERVATION_FACT" ADD CONSTRAINT "FOBSERVATION_FACT_PK" PRIMARY KEY ("FOBSERVATION_ID", "DATASET_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table FOBSERVATION_PERIOD
--------------------------------------------------------

  ALTER TABLE "FRTHR_MODEL"."FOBSERVATION_PERIOD" ADD CONSTRAINT "FOBSERVATION_PERIOD_PK" PRIMARY KEY ("FOBSERVATION_PERIOD_ID", "DATASET_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table FORDER_FACT
--------------------------------------------------------

  ALTER TABLE "FRTHR_MODEL"."FORDER_FACT" ADD CONSTRAINT "FORDER_FACT_PK" PRIMARY KEY ("FORDER_ID", "DATASET_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table FPERSON
--------------------------------------------------------

  ALTER TABLE "FRTHR_MODEL"."FPERSON" ADD CONSTRAINT "FPERSON_PK" PRIMARY KEY ("FPERSON_ID", "DATASET_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table FPERSON_ASSOC
--------------------------------------------------------

  ALTER TABLE "FRTHR_MODEL"."FPERSON_ASSOC" ADD CONSTRAINT "FPERSON_ASSOC_PK" PRIMARY KEY ("FPERSON_ASSOC_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table FPERSON_EXTID
--------------------------------------------------------

  ALTER TABLE "FRTHR_MODEL"."FPERSON_EXTID" ADD CONSTRAINT "FPERSON_EXTID_PK" PRIMARY KEY ("FPERSON_EXTID_ID", "DATASET_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table FPERSON_LCTN
--------------------------------------------------------

  ALTER TABLE "FRTHR_MODEL"."FPERSON_LCTN" ADD CONSTRAINT "FPERSON_LCTN_PK" PRIMARY KEY ("FPERSON_LCTN_ID", "DATASET_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table FPROCEDURE_OCCURRENCE
--------------------------------------------------------

  ALTER TABLE "FRTHR_MODEL"."FPROCEDURE_OCCURRENCE" ADD CONSTRAINT "FPROCEDURE_OCCURRENCE_PK" PRIMARY KEY ("FPROCEDURE_ID", "DATASET_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table FPROVIDER
--------------------------------------------------------

  ALTER TABLE "FRTHR_MODEL"."FPROVIDER" ADD CONSTRAINT "FPROVIDER_PK" PRIMARY KEY ("FPROVIDER_ID", "DATASET_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table FSPECIMEN
--------------------------------------------------------

  ALTER TABLE "FRTHR_MODEL"."FSPECIMEN" ADD CONSTRAINT "FSPECIMEN_PK" PRIMARY KEY ("FSPECIMEN_ID", "DATASET_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table FSPECIMEN_EVENT
--------------------------------------------------------

  ALTER TABLE "FRTHR_MODEL"."FSPECIMEN_EVENT" ADD CONSTRAINT "FSPECIMEN_EVENT_PK" PRIMARY KEY ("FSPECIMEN_EVENT_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table FSPECIMEN_NOTE
--------------------------------------------------------

  ALTER TABLE "FRTHR_MODEL"."FSPECIMEN_NOTE" ADD CONSTRAINT "FSPECIMEN_NOTE_PK" PRIMARY KEY ("FSPECIMEN_NOTE_ID") ENABLE;
--------------------------------------------------------
--  Constraints for Table FSTORAGE
--------------------------------------------------------

  ALTER TABLE "FRTHR_MODEL"."FSTORAGE" ADD CONSTRAINT "FSTORAGE_PK" PRIMARY KEY ("FSTORAGE_ID") ENABLE;
