/* pwkm note: 
   Use the frthr oracle tablespace when creating the omopv4 user. */

set DEFINE off
set sqlbl on
ALTER SESSION SET sort_area_size=5000000
;

CREATE TABLE CARE_SITE (
CARE_SITE_ID			INTEGER		NOT NULL,
LOCATION_ID			INTEGER		NULL,
ORGANIZATION_ID			INTEGER		NULL,
PLACE_OF_SERVICE_CONCEPT_ID	INTEGER		NULL,
CARE_SITE_SOURCE_VALUE		VARCHAR2(50)	NOT NULL,
PLACE_OF_SERVICE_SOURCE_VALUE	VARCHAR2(50)	NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE CARE_SITE IS 'Information about the site of care.'
;
COMMENT ON COLUMN CARE_SITE.CARE_SITE_ID IS 'A system-generated unique identifier for each care site. A care site is the place where the provider delivered the healthcare to the person.'
;
COMMENT ON COLUMN CARE_SITE.LOCATION_ID IS 'A foreign key to the geographic location in the location table, where the detailed address information is stored.'
;
COMMENT ON COLUMN CARE_SITE.ORGANIZATION_ID IS 'A foreign key to the organization in the organization table, where the detailed information is stored.'
;
COMMENT ON COLUMN CARE_SITE.PLACE_OF_SERVICE_CONCEPT_ID IS 'A foreign key to the predefined concept identifier in the vocabulary reflecting the place of service.'
;
COMMENT ON COLUMN CARE_SITE.CARE_SITE_SOURCE_VALUE IS 'The identifier for the care site as it appears in the source data, stored here for reference.'
;
COMMENT ON COLUMN CARE_SITE.PLACE_OF_SERVICE_SOURCE_VALUE IS 'The source code for the place of service as it appears in the source data, stored here for reference.'
;
ALTER TABLE CARE_SITE ADD CONSTRAINT CARE_SITE_PK PRIMARY KEY (CARE_SITE_ID)
USING INDEX
NOLOGGING
;
CREATE TABLE COHORT (
COHORT_ID		INTEGER		NOT NULL,
COHORT_CONCEPT_ID	INTEGER		NOT NULL,
COHORT_START_DATE	DATE		NOT NULL,
COHORT_END_DATE		DATE		NULL,
SUBJECT_ID		INTEGER		NOT NULL,
STOP_REASON		VARCHAR2(20)	NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE COHORT IS 'Person, Provider or Visit cohorts.'
;
COMMENT ON COLUMN COHORT.COHORT_ID IS 'A system-generated unique identifier for each cohort record.'
;
COMMENT ON COLUMN COHORT.COHORT_CONCEPT_ID IS 'A foreign key to a standard cohort concept identifier in the vocabulary. Cohort concepts identify the cohorts: whether they are defined through persons, providers or visits, or any combination thereof.'
;
COMMENT ON COLUMN COHORT.COHORT_START_DATE IS 'The date when the cohort definition criteria for the person, provider or visit first match.'
;
COMMENT ON COLUMN COHORT.COHORT_END_DATE IS 'The date when the cohort definition criteria for the person, provider or visit no longer match or the cohort membership was terminated.'
;
COMMENT ON COLUMN COHORT.SUBJECT_ID IS 'A foreign key to the subject in the cohort. These could be referring to records in the Person, Provider, Visit Occurrence table.'
;
COMMENT ON COLUMN COHORT.STOP_REASON IS 'The reason for the end of a cohort membership other than defined by the cohort definition criteria as it appears in the source data.'
;
ALTER TABLE COHORT ADD CONSTRAINT COHORT_PK PRIMARY KEY (COHORT_ID)
USING INDEX
NOLOGGING
;
CREATE TABLE CONDITION_ERA (
CONDITION_ERA_ID		INTEGER	NOT NULL,
PERSON_ID			INTEGER	NOT NULL,
CONDITION_CONCEPT_ID		INTEGER	NOT NULL,
CONDITION_ERA_START_DATE	DATE		NOT NULL,
CONDITION_ERA_END_DATE		DATE		NOT NULL,
CONDITION_TYPE_CONCEPT_ID	INTEGER	NOT NULL,
CONDITION_OCCURRENCE_COUNT	NUMBER(4)	NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE CONDITION_ERA IS 'A diagnoses or conditions that over a period of time.'
;
COMMENT ON COLUMN CONDITION_ERA.CONDITION_ERA_ID IS 'A system-generated unique identifier for each condition era.'
;
COMMENT ON COLUMN CONDITION_ERA.PERSON_ID IS 'A foreign key identifier to the person who is experiencing the condition during the condition era. The demographic details of that person are stored in the person table.'
;
COMMENT ON COLUMN CONDITION_ERA.CONDITION_CONCEPT_ID IS 'A foreign key that refers to a standard condition concept identifier in the vocabulary. '
;
COMMENT ON COLUMN CONDITION_ERA.CONDITION_ERA_START_DATE IS 'The start date for the condition era constructed from the individual instances of condition occurrences. It is the start date of the very first chronologically recorded instance of the condition.'
;
COMMENT ON COLUMN CONDITION_ERA.CONDITION_ERA_END_DATE IS 'The end date for the condition era constructed from the individual instances of condition occurrences. It is the end date of the final continuously recorded instance of the condition.'
;
COMMENT ON COLUMN CONDITION_ERA.CONDITION_TYPE_CONCEPT_ID IS ' A foreign key to the predefined concept identifier in the vocabulary reflecting the parameters used to construct the condition era. For a detailed current listing of condition types see Appendix B: Condition Type Concepts.'
;
COMMENT ON COLUMN CONDITION_ERA.CONDITION_OCCURRENCE_COUNT IS 'The number of individual condition occurrences used to construct the condition era.'
;
ALTER TABLE CONDITION_ERA ADD CONSTRAINT CONDITION_ERA_PK PRIMARY KEY (CONDITION_ERA_ID)
USING INDEX
NOLOGGING
;

CREATE TABLE CONDITION_OCCURRENCE (
CONDITION_OCCURRENCE_ID		INTEGER		NOT NULL,
PERSON_ID			INTEGER		NOT NULL,
CONDITION_CONCEPT_ID		INTEGER		NOT NULL,
CONDITION_START_DATE		DATE			NOT NULL,
CONDITION_END_DATE		DATE			NULL,
CONDITION_TYPE_CONCEPT_ID	INTEGER		NOT NULL,
STOP_REASON			VARCHAR2(20)	NULL,
ASSOCIATED_PROVIDER_ID		INTEGER		NULL,
VISIT_OCCURRENCE_ID		INTEGER		NULL,
CONDITION_SOURCE_VALUE		VARCHAR2(50)	NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE CONDITION_OCCURRENCE IS 'A diagnosis or condition that has been recorded about a person at a certain time.'
;
COMMENT ON COLUMN CONDITION_OCCURRENCE.CONDITION_OCCURRENCE_ID IS 'A system-generated unique identifier for each condition occurrence event.'
;
COMMENT ON COLUMN CONDITION_OCCURRENCE.PERSON_ID IS 'A foreign key identifier to the person who is experiencing the condition. The demographic details of that person are stored in the person table.'
;
COMMENT ON COLUMN CONDITION_OCCURRENCE.CONDITION_CONCEPT_ID IS 'A foreign key that refers to a standard condition concept identifier in the vocabulary.  '
;
COMMENT ON COLUMN CONDITION_OCCURRENCE.CONDITION_START_DATE IS 'The date when the instance of the condition is recorded.'
;
COMMENT ON COLUMN CONDITION_OCCURRENCE.CONDITION_END_DATE IS 'The date when the instance of the Condition is last
recorded.'
;
COMMENT ON COLUMN CONDITION_OCCURRENCE.CONDITION_TYPE_CONCEPT_ID IS 'A foreign key to the predefined concept identifier in the vocabulary reflecting the source data from which the condition was recorded, the level of standardization, and the type of occurrence. Conditions are defined as primary or secondary diagnoses, problem lists and person statuses. For a detailed current listing of condition types see Appendix B: Condition Type Concepts.'
;
COMMENT ON COLUMN CONDITION_OCCURRENCE.STOP_REASON IS 'The reason, if available, that the condition was no longer recorded, as indicated in the source data. Valid values include discharged, resolved, etc.'
;
COMMENT ON COLUMN CONDITION_OCCURRENCE.ASSOCIATED_PROVIDER_ID IS 'A foreign key to the provider in the provider table who was responsible for determining (diagnosing) the condition.'
;
COMMENT ON COLUMN CONDITION_OCCURRENCE.VISIT_OCCURRENCE_ID IS 'A foreign key to the visit in the visit table during which the condition was determined (diagnosed).'
;
COMMENT ON COLUMN CONDITION_OCCURRENCE.CONDITION_SOURCE_VALUE IS 'The source code for the condition as it appears in the source data. This code is mapped to a standard condition concept in the vocabulary and the original code is , stored here for reference. Condition source codes are typically ICD-9-CM diagnosis codes from medical claims or discharge status/disposition codes from EHRs.'
;
ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT CONDITION_OCCURRENCE_PK PRIMARY KEY (CONDITION_OCCURRENCE_ID)
USING INDEX
NOLOGGING
;

CREATE TABLE DEATH (
PERSON_ID			INTEGER		NOT NULL,
DEATH_DATE			DATE			NOT NULL,
DEATH_TYPE_CONCEPT_ID		INTEGER		NOT NULL,
CAUSE_OF_DEATH_CONCEPT_ID	INTEGER		NULL,
CAUSE_OF_DEATH_SOURCE_VALUE	VARCHAR2(50)	NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE DEATH IS 'Time and cause of death of the Person. '
;
COMMENT ON COLUMN DEATH.PERSON_ID IS 'System-generated foreign key identifier to the deceased person. The demographic details of that person are stored in the person table.'
;
COMMENT ON COLUMN DEATH.DEATH_DATE IS 'The date the person deceased. If the precise date including day or month is not known or not allowed, December is used as the default month, and the last day of the month the default day.'
;
COMMENT ON COLUMN DEATH.DEATH_TYPE_CONCEPT_ID IS 'A foreign key referring to the predefined concept identifier in the vocabulary reflecting how the death was represented in the source data.'
;
COMMENT ON COLUMN DEATH.CAUSE_OF_DEATH_CONCEPT_ID IS 'A foreign key referring to a standard concept identifier in the vocabulary for conditions.'
;
COMMENT ON COLUMN DEATH.CAUSE_OF_DEATH_SOURCE_VALUE IS 'The source code for the cause of death as it appears in the source data. This code is mapped to a standard concept in the vocabulary and the original code is , stored here for reference. '
;
ALTER TABLE DEATH ADD CONSTRAINT DEATH_PK PRIMARY KEY (PERSON_ID)
USING INDEX
NOLOGGING
;

CREATE TABLE DRUG_COST (
DRUG_COST_ID			INTEGER	NOT NULL,
DRUG_EXPOSURE_ID		INTEGER	NOT NULL,
PAID_COPAY			NUMBER(8,2)	NULL,
PAID_COINSURANCE		NUMBER(8,2)	NULL,
PAID_TOWARD_DEDUCTIBLE		NUMBER(8,2)	NULL,
PAID_BY_PAYER			NUMBER(8,2)	NULL,
PAID_BY_COORDINATION_BENEFITS	NUMBER(8,2)	NULL,
TOTAL_OUT_OF_POCKET		NUMBER(8,2)	NULL,
TOTAL_PAID			NUMBER(8,2)	NULL,
INGREDIENT_COST			NUMBER(8,2)	NULL,
DISPENSING_FEE			NUMBER(8,2)	NULL,
AVERAGE_WHOLESALE_PRICE		NUMBER(8,2)	NULL,
PAYER_PLAN_PERIOD_ID		INTEGER	NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE DRUG_COST IS 'For each Drug Exposure record additional information about cost and payments.'
;
COMMENT ON COLUMN DRUG_COST.DRUG_COST_ID IS 'A system-generated unique identifier for each drug cost record.'
;
COMMENT ON COLUMN DRUG_COST.DRUG_EXPOSURE_ID IS 'A foreign key identifier to the drug record for which cost data are recorded. '
;
COMMENT ON COLUMN DRUG_COST.PAID_COPAY IS 'The amount paid by the person as a fixed contribution to the expenses. Copay does not contribute to the out_of_pocket expenses.'
;
COMMENT ON COLUMN DRUG_COST.PAID_COINSURANCE IS 'The amount paid by the person as a joint assumption of risk. Typically, this is a percentage of the expenses defined by the payer plan (policy) after the person''s deductible is exceeded.'
;
COMMENT ON COLUMN DRUG_COST.PAID_TOWARD_DEDUCTIBLE IS 'The amount paid by the person that is counted toward the deductible defined by the payer plan (policy).'
;
COMMENT ON COLUMN DRUG_COST.PAID_BY_PAYER IS 'The amount paid by the payer (insurer). If there is more than one payer, several drug_cost records indicate that fact.'
;
COMMENT ON COLUMN DRUG_COST.PAID_BY_COORDINATION_BENEFITS IS 'The amount paid by a secondary payer through the coordination of benefits.'
;
COMMENT ON COLUMN DRUG_COST.TOTAL_OUT_OF_POCKET IS 'The total amount paid by the person as a share of the expenses, excluding the copay.'
;
COMMENT ON COLUMN DRUG_COST.TOTAL_PAID IS 'The total amount paid for the expenses of drug exposure.'
;
COMMENT ON COLUMN DRUG_COST.INGREDIENT_COST IS 'The portion of the drug expenses due to the cost charged by the manufacturer for the drug, typically a percentage of the Average Wholesale Price.'
;
COMMENT ON COLUMN DRUG_COST.DISPENSING_FEE IS 'The portion of the drug expenses due to the dispensing fee charged by the pharmacy, typically a fixed amount.'
;
COMMENT ON COLUMN DRUG_COST.AVERAGE_WHOLESALE_PRICE IS 'List price of a drug set by the manufacturer.'
;
COMMENT ON COLUMN DRUG_COST.PAYER_PLAN_PERIOD_ID IS 'A foreign key to the payer_plan_period table, where the details of the payer, plan and family are stored.'
;
ALTER TABLE DRUG_COST ADD CONSTRAINT DRUG_COST_PK PRIMARY KEY (DRUG_COST_ID)
USING INDEX
NOLOGGING
;

CREATE TABLE DRUG_ERA (
DRUG_ERA_ID		INTEGER	NOT NULL,
PERSON_ID		INTEGER	NOT NULL,
DRUG_CONCEPT_ID		INTEGER	NOT NULL,
DRUG_ERA_START_DATE	DATE	NOT NULL,
DRUG_ERA_END_DATE	DATE	NOT NULL,
DRUG_TYPE_CONCEPT_ID	INTEGER	NOT NULL,
DRUG_EXPOSURE_COUNT	NUMBER(4)	NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE DRUG_ERA IS 'Association between a Person and a Drug over a specific time period.'
;
COMMENT ON COLUMN DRUG_ERA.DRUG_ERA_ID IS 'A system-generated unique identifier for each drug era.'
;
COMMENT ON COLUMN DRUG_ERA.PERSON_ID IS 'A foreign key identifier to the person who is subjected to the drug during the drug era. The demographic details of that person are stored in the person table.'
;
COMMENT ON COLUMN DRUG_ERA.DRUG_CONCEPT_ID IS 'A foreign key that refers to a standard concept identifier in the vocabulary for the drug concept.'
;
COMMENT ON COLUMN DRUG_ERA.DRUG_ERA_START_DATE IS 'The start date for the drug era constructed from the individual instances of drug exposures. It is the start date of the very first chronologically recorded instance of utilization of a drug.'
;
COMMENT ON COLUMN DRUG_ERA.DRUG_ERA_END_DATE IS 'The end date for the drug era constructed from the individual instance of drug exposures. It is the end date of the final continuously recorded instance of utilization of a drug.'
;
COMMENT ON COLUMN DRUG_ERA.DRUG_TYPE_CONCEPT_ID IS ' A foreign key to the predefined concept identifier in the vocabulary reflecting the parameters used to construct the drug era. For a detailed current listing of drug types see Appendix A: Drug Type Codes.'
;
COMMENT ON COLUMN DRUG_ERA.DRUG_EXPOSURE_COUNT IS 'The number of individual drug exposure occurrences used to construct the drug era.'
;
ALTER TABLE DRUG_ERA ADD CONSTRAINT DRUG_ERA_PK PRIMARY KEY (DRUG_ERA_ID)
USING INDEX
NOLOGGING
;

CREATE TABLE DRUG_EXPOSURE (
DRUG_EXPOSURE_ID		INTEGER		NOT NULL,
PERSON_ID			INTEGER		NOT NULL,
DRUG_CONCEPT_ID			INTEGER		NOT NULL,
DRUG_EXPOSURE_START_DATE	DATE		NOT NULL,
DRUG_EXPOSURE_END_DATE		DATE		NULL,
DRUG_TYPE_CONCEPT_ID		INTEGER		NOT NULL,
STOP_REASON			VARCHAR2(20)	NULL,
REFILLS				NUMBER(3)	NULL,
QUANTITY			NUMBER(4)	NULL,
DAYS_SUPPLY			NUMBER(4)	NULL,
SIG				VARCHAR2(500)	NULL,
PRESCRIBING_PROVIDER_ID		INTEGER		NULL,
VISIT_OCCURRENCE_ID		INTEGER		NULL,
RELEVANT_CONDITION_CONCEPT_ID	INTEGER		NULL,
DRUG_SOURCE_VALUE		VARCHAR2(50)	NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE DRUG_EXPOSURE IS 'Association between a Person and a Drug at a specific time.'
;
COMMENT ON COLUMN DRUG_EXPOSURE.DRUG_EXPOSURE_ID IS 'A system-generated unique identifier for each drug utilization event.'
;
COMMENT ON COLUMN DRUG_EXPOSURE.PERSON_ID IS 'System-generated foreign key identifier for the person who is subjected to the drug. The demographic details of that person are stored in the person table.'
;
COMMENT ON COLUMN DRUG_EXPOSURE.DRUG_CONCEPT_ID IS 'A foreign key that refers to a standard concept identifier in the vocabulary for the drug concept.'
;
COMMENT ON COLUMN DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATE IS 'The start date for the current instance of drug utilization. Valid entries include a start date of a prescription, the date a prescription was filled, or the date on which a drug administration procedure was recorded.'
;
COMMENT ON COLUMN DRUG_EXPOSURE.DRUG_EXPOSURE_END_DATE IS 'The end date for the current instance of drug utilization. It is not available from all sources.'
;
COMMENT ON COLUMN DRUG_EXPOSURE.DRUG_TYPE_CONCEPT_ID IS ' A foreign key to the predefined concept identifier in the vocabulary reflecting the type of drug exposure recorded. It indicates how the drug exposure was represented in the source data: as medication history, filled prescriptions, etc. For a detailed current listing of drug types see Appendix A: Drug Type Codes'
;
COMMENT ON COLUMN DRUG_EXPOSURE.STOP_REASON IS 'The reason the medication was stopped, where available. Reasons include regimen completed, changed, removed, etc..'
;
COMMENT ON COLUMN DRUG_EXPOSURE.REFILLS IS 'The number of refills after the initial prescription. The initial prescription is not counted,  Values start with 0.'
;
COMMENT ON COLUMN DRUG_EXPOSURE.QUANTITY IS 'The quantity of drug as recorded in the original prescription or dispensing record.'
;
COMMENT ON COLUMN DRUG_EXPOSURE.DAYS_SUPPLY IS 'The number of days of supply of the medication as recorded in the original prescription or dispensing record.'
;
COMMENT ON COLUMN DRUG_EXPOSURE.SIG IS 'The directions (signetur) on the drug prescription as recorded in the original prescription (and printed on the container) or dispensing record.'
;
COMMENT ON COLUMN DRUG_EXPOSURE.VISIT_OCCURRENCE_ID IS 'A foreign key to the visit in the visit table during which the drug exposure initiated.'
;
COMMENT ON COLUMN DRUG_EXPOSURE.RELEVANT_CONDITION_CONCEPT_ID IS 'A foreign key to the predefined concept identifier in the vocabulary reflecting the condition that was the cause for initiation of the drug exposure. Note that this is not a direct reference to a specific condition record in the condition table, but rather a condition concept in the vocabulary.'
;
COMMENT ON COLUMN DRUG_EXPOSURE.DRUG_SOURCE_VALUE IS 'The source code for the drug as it appears in the source data. This code is mapped to a standard drug concept in the vocabulary and the original code is , stored here for reference.'
;
ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT DRUG_EXPOSURE_PK PRIMARY KEY (DRUG_EXPOSURE_ID)
USING INDEX
NOLOGGING
;

CREATE TABLE LOCATION (
LOCATION_ID			INTEGER		NOT NULL,
ADDRESS_1			VARCHAR2(50)	NULL,
ADDRESS_2			VARCHAR2(50)	NULL,
CITY				VARCHAR2(50)	NULL,
STATE				CHAR(2)		NULL,
ZIP				VARCHAR2(9)	NULL,
COUNTY				VARCHAR2(20)	NULL,
LOCATION_SOURCE_VALUE		VARCHAR2(50)	NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE LOCATION IS 'Physical addresses.'
;
COMMENT ON COLUMN LOCATION.LOCATION_ID IS 'A system-generated unique identifier for each geographic location.'
;
COMMENT ON COLUMN LOCATION.ADDRESS_1 IS 'The address field 1, typically used for the street address, as it appears in the source data.'
;
COMMENT ON COLUMN LOCATION.ADDRESS_2 IS 'The address field 2, typically used for additional detail such as buildings, suites, floors, as it appears in the source data.'
;
COMMENT ON COLUMN LOCATION.CITY IS 'The city field as it appears in the source data.'
;
COMMENT ON COLUMN LOCATION.STATE IS 'The state field as it appears in the source data.'
;
COMMENT ON COLUMN LOCATION.ZIP IS 'The zip code. For US addresses, valid zip codes can be 3, 5 or 9 digits long, depending on the source data.'
;
COMMENT ON COLUMN LOCATION.COUNTY IS 'The county. The county information is necessary because not all zip codes fall into one and the same county.'
;
COMMENT ON COLUMN LOCATION.LOCATION_SOURCE_VALUE IS 'The verbatim information that is used to uniquely identify the location as it appears in the source data.'
;
ALTER TABLE LOCATION ADD CONSTRAINT LOCATION_PK PRIMARY KEY (LOCATION_ID)
USING INDEX
NOLOGGING
;
CREATE TABLE OBSERVATION (
OBSERVATION_ID			INTEGER		NOT NULL,
PERSON_ID			INTEGER		NOT NULL,
OBSERVATION_CONCEPT_ID		INTEGER		NOT NULL,
OBSERVATION_DATE		DATE		NOT NULL,
OBSERVATION_TIME		DATE		NULL,
VALUE_AS_NUMBER			NUMBER(14,3)	NULL,
VALUE_AS_STRING			VARCHAR2(60)	NULL,
VALUE_AS_CONCEPT_ID		INTEGER		NULL,
UNIT_CONCEPT_ID			INTEGER		NULL,
RANGE_LOW			NUMBER(14,3)	NULL,
RANGE_HIGH			NUMBER(14,3)	NULL,
OBSERVATION_TYPE_CONCEPT_ID	INTEGER		NOT NULL,
ASSOCIATED_PROVIDER_ID		INTEGER		NULL,
VISIT_OCCURRENCE_ID		INTEGER		NULL,
RELEVANT_CONDITION_CONCEPT_ID	INTEGER		NULL,
OBSERVATION_SOURCE_VALUE	VARCHAR2(50)	NULL,
UNITS_SOURCE_VALUE		VARCHAR2(50)	NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE OBSERVATION IS 'Symptoms, clinical observations, lab tests etc. about the Person.'
;
COMMENT ON COLUMN OBSERVATION.OBSERVATION_ID IS 'A system-generated unique identifier for each observation.'
;
COMMENT ON COLUMN OBSERVATION.PERSON_ID IS 'A foreign key identifier to the person about whom the observation was recorded. The demographic details of that person are stored in the person table.'
;
COMMENT ON COLUMN OBSERVATION.OBSERVATION_CONCEPT_ID IS 'A foreign key to the standard observation concept identifier in the vocabulary. '
;
COMMENT ON COLUMN OBSERVATION.OBSERVATION_DATE IS 'The date of the observation'
;
COMMENT ON COLUMN OBSERVATION.OBSERVATION_TIME IS 'The time of the observation'
;
COMMENT ON COLUMN OBSERVATION.VALUE_AS_NUMBER IS 'The observation result stored as a number. This is applicable to observations where the result is expressed as a numeric value.'
;
COMMENT ON COLUMN OBSERVATION.VALUE_AS_STRING IS 'The observation result stored as a string. This is applicable to observations where the result is expressed as verbatim text, such as in radiology or pathology report'
;
COMMENT ON COLUMN OBSERVATION.VALUE_AS_CONCEPT_ID IS 'A foreign key to an observation result stored as a concept identifier. This is applicable to observations where the result can be expressed as a standard concept from the vocabulary (e.g., positive/negative, present/absent, low/high, etc.).'
;
COMMENT ON COLUMN OBSERVATION.UNIT_CONCEPT_ID IS 'A foreign key to a standard concept identifier of measurement units in the vocabulary.'
;
COMMENT ON COLUMN OBSERVATION.RANGE_LOW IS 'The lower limit of the normal range of the observation. It is not applicable if the observation results are non-numeric or categorical, and must be in the same units of measure as the observation value.'
;
COMMENT ON COLUMN OBSERVATION.RANGE_HIGH IS 'The upper limit of the normal range of the observation. It is not applicable if the observation results are non-numeric or categorical, and must be in the same units of measure as the observation value.'
;
COMMENT ON COLUMN OBSERVATION.OBSERVATION_TYPE_CONCEPT_ID IS 'A foreign key to the predefined concept identifier in the vocabulary reflecting the type of the observation.'
;
COMMENT ON COLUMN OBSERVATION.ASSOCIATED_PROVIDER_ID IS 'A foreign key to the provider in the provider table who was responsible for making the observation.'
;
COMMENT ON COLUMN OBSERVATION.VISIT_OCCURRENCE_ID IS 'A foreign key to the visit in the visit table during which the observation was recorded.'
;
COMMENT ON COLUMN OBSERVATION.RELEVANT_CONDITION_CONCEPT_ID IS 'A foreign key to the predefined concept identifier in the vocabulary reflecting the condition that was associated with the observation. Note that this is not a direct reference to a specific condition record in the condition table, but rather a condition concept in the vocabulary.'
;
COMMENT ON COLUMN OBSERVATION.OBSERVATION_SOURCE_VALUE IS 'The observation code as it appears in the source data. This code is mapped to a standard concept in the vocabulary and the original code is , stored here for reference.'
;
COMMENT ON COLUMN OBSERVATION.UNITS_SOURCE_VALUE IS 'The source code for the unit as it appears in the source data. This code is mapped to a standard unit concept in the vocabulary and the original code is , stored here for reference. '
;
ALTER TABLE OBSERVATION ADD CONSTRAINT OBSERVATION_PK PRIMARY KEY (OBSERVATION_ID)
USING INDEX
NOLOGGING
;

CREATE TABLE OBSERVATION_PERIOD (
OBSERVATION_PERIOD_ID		INTEGER	NOT NULL,
PERSON_ID			INTEGER	NOT NULL,
OBSERVATION_PERIOD_START_DATE	DATE	NOT NULL,
OBSERVATION_PERIOD_END_DATE	DATE	NOT NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE OBSERVATION_PERIOD IS 'Time intervals at which health care information may be available.'
;
COMMENT ON COLUMN OBSERVATION_PERIOD.OBSERVATION_PERIOD_ID IS 'A system-generated unique identifier for each observation period.'
;
COMMENT ON COLUMN OBSERVATION_PERIOD.PERSON_ID IS 'A foreign key identifier to the person for whom the observation period is defined. The demographic details of that person are stored in the person table.'
;
COMMENT ON COLUMN OBSERVATION_PERIOD.OBSERVATION_PERIOD_START_DATE IS 'The start date of the observation period for which data are available from the data source.'
;
COMMENT ON COLUMN OBSERVATION_PERIOD.OBSERVATION_PERIOD_END_DATE IS 'The end date of the observation period for which data are available from the data source.'
;
ALTER TABLE OBSERVATION_PERIOD ADD CONSTRAINT OBSERVATION_PERIOD_PK PRIMARY KEY (OBSERVATION_PERIOD_ID)
USING INDEX
NOLOGGING
;
CREATE TABLE ORGANIZATION (
ORGANIZATION_ID			INTEGER		NOT NULL,
PLACE_OF_SERVICE_CONCEPT_ID	INTEGER		NULL,
LOCATION_ID			INTEGER		NULL,
ORGANIZATION_SOURCE_VALUE	VARCHAR2(50)	NOT NULL,
PLACE_OF_SERVICE_SOURCE_VALUE	VARCHAR2(50)	NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE ORGANIZATION IS 'Information about health care organizations. '
;
COMMENT ON COLUMN ORGANIZATION.ORGANIZATION_ID IS 'A system-generated unique identifier for each organization. Here, an organization is defined as a collection of one or more care sites that share a single EHR database.'
;
COMMENT ON COLUMN ORGANIZATION.PLACE_OF_SERVICE_CONCEPT_ID IS 'A foreign key that refers to a place of service concept identifier in the vocabulary.'
;
COMMENT ON COLUMN ORGANIZATION.LOCATION_ID IS 'A foreign key to the geographic location of the administrative offices in the location table, where the detailed address information is stored.'
;
COMMENT ON COLUMN ORGANIZATION.ORGANIZATION_SOURCE_VALUE IS 'The identifier for the organization in the source data , stored here for reference.'
;
COMMENT ON COLUMN ORGANIZATION.PLACE_OF_SERVICE_SOURCE_VALUE IS 'The source code for the place of service as it appears in the source data, stored here for reference.'
;
ALTER TABLE ORGANIZATION ADD CONSTRAINT ORGANIZATION_PK PRIMARY KEY (ORGANIZATION_ID)
USING INDEX
NOLOGGING
;

CREATE TABLE PAYER_PLAN_PERIOD (
PAYER_PLAN_PERIOD_ID		INTEGER		NOT NULL,
PERSON_ID			INTEGER		NOT NULL,
PAYER_PLAN_PERIOD_START_DATE	DATE		NOT NULL,
PAYER_PLAN_PERIOD_END_DATE	DATE		NOT NULL,
PAYER_SOURCE_VALUE		VARCHAR2(50)	NULL,
PLAN_SOURCE_VALUE		VARCHAR2(50)	NULL,
FAMILY_SOURCE_VALUE		VARCHAR2(50)	NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE PAYER_PLAN_PERIOD IS 'Information about the coverage plan of the payer.'
;
COMMENT ON COLUMN PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_ID IS 'A system-generated identifier for each unique combination of payer, plan, family code and time span'
;
COMMENT ON COLUMN PAYER_PLAN_PERIOD.PERSON_ID IS 'A foreign key identifier to the person covered by the payer. The demographic details of that person are stored in the person table.'
;
COMMENT ON COLUMN PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_START_DATE IS 'The start date of the payer plan period.'
;
COMMENT ON COLUMN PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_END_DATE IS 'The end date of the payer plan period defined for the person.'
;
COMMENT ON COLUMN PAYER_PLAN_PERIOD.PAYER_SOURCE_VALUE IS 'The source code for the payer as it appears in the source data.'
;
COMMENT ON COLUMN PAYER_PLAN_PERIOD.PLAN_SOURCE_VALUE IS 'The source code for the person''s coverage plan as it appears in the source data.'
;
COMMENT ON COLUMN PAYER_PLAN_PERIOD.FAMILY_SOURCE_VALUE IS 'The source code for the person''s family as it appears in the source data.'
;
ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT PAYER_PLAN_PERIOD_PK PRIMARY KEY (PAYER_PLAN_PERIOD_ID)
USING INDEX
NOLOGGING
;

CREATE TABLE PERSON (
PERSON_ID		INTEGER		NOT NULL,
GENDER_CONCEPT_ID	INTEGER		NOT NULL,
YEAR_OF_BIRTH		NUMBER(4)	NOT NULL,
MONTH_OF_BIRTH		NUMBER(2)	NULL,
DAY_OF_BIRTH		NUMBER(2)	NULL,
RACE_CONCEPT_ID		INTEGER		NULL,
ETHNICITY_CONCEPT_ID	INTEGER		NULL,
LOCATION_ID		INTEGER		NULL,
PROVIDER_ID		INTEGER		NULL,
CARE_SITE_ID		INTEGER		NULL,
PERSON_SOURCE_VALUE	VARCHAR2(50)	NULL,
GENDER_SOURCE_VALUE	VARCHAR2(50)	NULL,
RACE_SOURCE_VALUE	VARCHAR2(50)	NULL,
ETHNICITY_SOURCE_VALUE	VARCHAR2(50)	NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE PERSON IS 'Demographic information about a Person (patient).'
;
COMMENT ON COLUMN PERSON.PERSON_ID IS 'System-generated identifier to uniquely identify each PERSON.'
;
COMMENT ON COLUMN PERSON.GENDER_CONCEPT_ID IS 'Foreign key that refers to the standard Concept Code in the Dictionary for the Gender of the Person.'
;
COMMENT ON COLUMN PERSON.YEAR_OF_BIRTH IS 'The year of birth of the Person. For data sources with date of birth, only the year is extracted. For data sources where the year of birth is not available, the approximate year of birth is derived based on any age group categorization available.'
;
COMMENT ON COLUMN PERSON.MONTH_OF_BIRTH IS 'The month of birth of the person. For data sources that provide the precise date of birth, the month is extracted and stored in this field.'
;
COMMENT ON COLUMN PERSON.DAY_OF_BIRTH IS 'The day of the month of birth of the person. For data sources that provide the precise date of birth, the day is extracted and stored in this field.'
;
COMMENT ON COLUMN PERSON.RACE_CONCEPT_ID IS 'A foreign key that refers to a standard concept identifier in the vocabulary for the race of the person.'
;
COMMENT ON COLUMN PERSON.ETHNICITY_CONCEPT_ID IS 'A foreign key that refers to the standard concept identifier in the vocabulary for the ethnicity of the person.'
;
COMMENT ON COLUMN PERSON.LOCATION_ID IS 'A foreign key to the place of residency for the person in the location table, where the detailed address information is stored.'
;
COMMENT ON COLUMN PERSON.PROVIDER_ID IS 'A foreign key to the primary care provider the person is seeing in the provider table.'
;
COMMENT ON COLUMN PERSON.CARE_SITE_ID IS 'A foreign key to the primary care site in the care site table, where the details of the care site are stored.'
;
COMMENT ON COLUMN PERSON.PERSON_SOURCE_VALUE IS 'An encrypted key derived from the person identifier in the source data. This is necessary when a drug safety issue requires a link back to the person data at the source dataset. No value with any medical or demographic significance must be stored.
'
;
COMMENT ON COLUMN PERSON.GENDER_SOURCE_VALUE IS 'The source code for the gender of the person as it appears in the source data. The person gender is mapped to a standard gender concept in the vocabulary and the corresponding concept identifier is, stored here for reference.'
;
COMMENT ON COLUMN PERSON.RACE_SOURCE_VALUE IS 'The source code for the race of the person as it appears in the source data. The person race is mapped to a standard race concept in the vocabulary and the original code is, stored here for reference.'
;
COMMENT ON COLUMN PERSON.ETHNICITY_SOURCE_VALUE IS 'The source code for the ethnicity of the person as it appears in the source data. The person ethnicity is mapped to a standard ethnicity concept in the vocabulary and the original code is, stored here for reference.'
;
ALTER TABLE PERSON ADD CONSTRAINT PERSON_PK PRIMARY KEY (PERSON_ID)
USING INDEX
NOLOGGING
;

CREATE TABLE PROCEDURE_COST (
PROCEDURE_COST_ID		INTEGER		NOT NULL,
PROCEDURE_OCCURRENCE_ID		INTEGER		NOT NULL,
PAID_COPAY			NUMBER(8,2)	NULL,
PAID_COINSURANCE		NUMBER(8,2)	NULL,
PAID_TOWARD_DEDUCTIBLE		NUMBER(8,2)	NULL,
PAID_BY_PAYER			NUMBER(8,2)	NULL,
PAID_BY_COORDINATION_BENEFITS	NUMBER(8,2)	NULL,
TOTAL_OUT_OF_POCKET		NUMBER(8,2)	NULL,
TOTAL_PAID			NUMBER(8,2)	NULL,
DISEASE_CLASS_CONCEPT_ID	INTEGER		NULL,
REVENUE_CODE_CONCEPT_ID		INTEGER		NULL,
PAYER_PLAN_PERIOD_ID		INTEGER		NULL,
DISEASE_CLASS_SOURCE_VALUE	VARCHAR2(50)	NULL,
REVENUE_CODE_SOURCE_VALUE	VARCHAR2(50)	NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE PROCEDURE_COST IS 'For each Procedure additional information about cost and payments.'
;
COMMENT ON COLUMN PROCEDURE_COST.PROCEDURE_COST_ID IS 'A system-generated unique identifier for each procedure cost record.'
;
COMMENT ON COLUMN PROCEDURE_COST.PROCEDURE_OCCURRENCE_ID IS 'A foreign key identifier to the procedure record for which cost data are recorded. '
;
COMMENT ON COLUMN PROCEDURE_COST.PAID_COPAY IS 'The amount paid by the person as a fixed contribution to the expenses. Copay does not contribute to the out_of_pocket expenses.'
;
COMMENT ON COLUMN PROCEDURE_COST.PAID_COINSURANCE IS 'The amount paid by the person as a joint assumption of risk. Typically, this is a percentage of the expenses defined by the payer plan (policy) after the person''s deductible is exceeded.'
;
COMMENT ON COLUMN PROCEDURE_COST.PAID_TOWARD_DEDUCTIBLE IS 'The amount paid by the person that is counted toward the deductible defined by the payer plan (policy).'
;
COMMENT ON COLUMN PROCEDURE_COST.PAID_BY_PAYER IS 'The amount paid by the payer (insurer). If there is more than one payer, several procedure_cost records indicate that fact.'
;
COMMENT ON COLUMN PROCEDURE_COST.PAID_BY_COORDINATION_BENEFITS IS 'The amount paid by a secondary payer through the coordination of benefits.'
;
COMMENT ON COLUMN PROCEDURE_COST.TOTAL_OUT_OF_POCKET IS 'The total amount paid by the person as a share of the expenses, excluding the copay.'
;
COMMENT ON COLUMN PROCEDURE_COST.TOTAL_PAID IS 'The total amount paid for the expenses of the procedure.'
;
COMMENT ON COLUMN PROCEDURE_COST.DISEASE_CLASS_CONCEPT_ID IS 'A foreign key referring to a standard concept identifier in the vocabulary for disease classes, such as DRGs and APCs.'
;
COMMENT ON COLUMN PROCEDURE_COST.REVENUE_CODE_CONCEPT_ID IS 'A foreign key referring to a standard concept identifier in the vocabulary for revenue codes.'
;
COMMENT ON COLUMN PROCEDURE_COST.PAYER_PLAN_PERIOD_ID IS 'A foreign key to the payer_plan_period table, where the details of the payer, plan and family are stored.'
;
COMMENT ON COLUMN PROCEDURE_COST.DISEASE_CLASS_SOURCE_VALUE IS 'The source code for the disease class as it appears in the source data , stored here for reference.'
;
COMMENT ON COLUMN PROCEDURE_COST.REVENUE_CODE_SOURCE_VALUE IS 'The source code for the revenue code as it appears in the source data , stored here for reference.'
;
ALTER TABLE PROCEDURE_COST ADD CONSTRAINT PROCEDURE_COST_PK PRIMARY KEY (PROCEDURE_COST_ID)
USING INDEX
NOLOGGING
;

CREATE TABLE PROCEDURE_OCCURRENCE (
PROCEDURE_OCCURRENCE_ID		INTEGER		NOT NULL,
PERSON_ID			INTEGER		NOT NULL,
PROCEDURE_CONCEPT_ID		INTEGER		NOT NULL,
PROCEDURE_DATE			DATE		NOT NULL,
PROCEDURE_TYPE_CONCEPT_ID	INTEGER		NOT NULL,
ASSOCIATED_PROVIDER_ID		INTEGER		NULL,
VISIT_OCCURRENCE_ID		INTEGER		NULL,
RELEVANT_CONDITION_CONCEPT_ID	INTEGER		NULL,
PROCEDURE_SOURCE_VALUE		VARCHAR2(50)	NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE PROCEDURE_OCCURRENCE IS 'Procedures carried out on the Person.'
;
COMMENT ON COLUMN PROCEDURE_OCCURRENCE.PROCEDURE_OCCURRENCE_ID IS 'A system-generated unique identifier for each procedure occurrence.'
;
COMMENT ON COLUMN PROCEDURE_OCCURRENCE.PERSON_ID IS 'A foreign key identifier to the person who is subjected to the procedure. The demographic details of that person are stored in the person table.'
;
COMMENT ON COLUMN PROCEDURE_OCCURRENCE.PROCEDURE_CONCEPT_ID IS 'A foreign key that refers to a standard procedure concept identifier in the vocabulary. '
;
COMMENT ON COLUMN PROCEDURE_OCCURRENCE.PROCEDURE_DATE IS 'The date on which the procedure was performed.'
;
COMMENT ON COLUMN PROCEDURE_OCCURRENCE.PROCEDURE_TYPE_CONCEPT_ID IS 'A foreign key to the predefined concept identifier in the vocabulary reflecting the type of the procedure. For a detailed current listing of procedure types see Appendix C: Procedure Type Concepts.'
;
COMMENT ON COLUMN PROCEDURE_OCCURRENCE.ASSOCIATED_PROVIDER_ID IS 'A foreign key to the provider in the provider table who was responsible for carrying out the procedure.'
;
COMMENT ON COLUMN PROCEDURE_OCCURRENCE.VISIT_OCCURRENCE_ID IS 'A foreign key to the visit in the visit table during which the procedure was carried out.'
;
COMMENT ON COLUMN PROCEDURE_OCCURRENCE.RELEVANT_CONDITION_CONCEPT_ID IS 'A foreign key to the predefined concept identifier in the vocabulary reflecting the condition that was the cause for initiation of the procedure. Note that this is not a direct reference to a specific condition record in the condition table, but rather a condition concept in the vocabulary.'
;
COMMENT ON COLUMN PROCEDURE_OCCURRENCE.PROCEDURE_SOURCE_VALUE IS 'The source code for the procedure as it appears in the source data. This code is mapped to a standard procedure concept in the vocabulary and the original code is , stored here for reference. Procedure source codes are typically ICD-9-Proc, CPT-4 or HCPCS codes.'
;
ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT PROCEDURE_OCCURRENCE_PK PRIMARY KEY (PROCEDURE_OCCURRENCE_ID)
USING INDEX
NOLOGGING
;

CREATE TABLE PROVIDER (
PROVIDER_ID		INTEGER		NOT NULL,
NPI			VARCHAR2(20)	NULL,
DEA			VARCHAR2(20)	NULL,
SPECIALTY_CONCEPT_ID	INTEGER		NULL,
CARE_SITE_ID		INTEGER		NULL,
PROVIDER_SOURCE_VALUE	VARCHAR2(50)	NOT NULL,
SPECIALTY_SOURCE_VALUE	VARCHAR2(50)	NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE PROVIDER IS 'Information about health care providers.'
;
COMMENT ON COLUMN PROVIDER.PROVIDER_ID IS 'A system-generated unique identifier for each provider.'
;
COMMENT ON COLUMN PROVIDER.NPI IS 'The National Provider Identifier (NPI) of the provider.'
;
COMMENT ON COLUMN PROVIDER.DEA IS 'The Drug Enforcement Administration (DEA) number of the provider.'
;
COMMENT ON COLUMN PROVIDER.SPECIALTY_CONCEPT_ID IS 'A foreign key to a standard provider''s specialty concept identifier in the vocabulary. '
;
COMMENT ON COLUMN PROVIDER.CARE_SITE_ID IS 'A foreign key to the main care site where the provider is practicing.'
;
COMMENT ON COLUMN PROVIDER.PROVIDER_SOURCE_VALUE IS 'The identifier used for the provider in the source data.rmation that is used to uniquely identify the provider as it appears in the source data , stored here for reference.'
;
COMMENT ON COLUMN PROVIDER.SPECIALTY_SOURCE_VALUE IS 'The source code for the provider specialty as it appears in the source data , stored here for reference.'
;
ALTER TABLE PROVIDER ADD CONSTRAINT PROVIDER_PK PRIMARY KEY (PROVIDER_ID)
USING INDEX
NOLOGGING
;
CREATE TABLE VISIT_OCCURRENCE (
VISIT_OCCURRENCE_ID		INTEGER		NOT NULL,
PERSON_ID			INTEGER		NOT NULL,
VISIT_START_DATE		DATE		NOT NULL,
VISIT_END_DATE			DATE		NOT NULL,
PLACE_OF_SERVICE_CONCEPT_ID	INTEGER		NOT NULL,
CARE_SITE_ID			INTEGER		NULL,
PLACE_OF_SERVICE_SOURCE_VALUE	VARCHAR2(50)	NULL)
NOLOGGING
MONITORING
;

COMMENT ON TABLE VISIT_OCCURRENCE IS 'Visits for health care services of the Person.'
;
COMMENT ON COLUMN VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID IS 'A system-generated unique identifier for each person''s visit or encounter at a healthcare provider.'
;
COMMENT ON COLUMN VISIT_OCCURRENCE.PERSON_ID IS 'A foreign key identifier to the person for whom the visit is recorded. The demographic details of that person are stored in the person table.'
;
COMMENT ON COLUMN VISIT_OCCURRENCE.VISIT_START_DATE IS 'The start date of the visit.'
;
COMMENT ON COLUMN VISIT_OCCURRENCE.VISIT_END_DATE IS 'The end date of the visit. If this is a one-day visit the end date should match the start date.'
;
COMMENT ON COLUMN VISIT_OCCURRENCE.PLACE_OF_SERVICE_CONCEPT_ID IS 'A foreign key that refers to a place of service concept identifier in the vocabulary.'
;
COMMENT ON COLUMN VISIT_OCCURRENCE.CARE_SITE_ID IS 'A foreign key to the care site in the care site table that was visited.'
;
COMMENT ON COLUMN VISIT_OCCURRENCE.PLACE_OF_SERVICE_SOURCE_VALUE IS 'The source code used to reflect the type or source of the visit in the source data. Valid entries include office visits, hospital admissions, etc. These source codes can also be type-of service codes and activity type codes.'
;
ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT VISIT_OCCURRENCE_PK PRIMARY KEY (VISIT_OCCURRENCE_ID)
USING INDEX
NOLOGGING
;


SET HEADING OFF
SELECT '*** EXECUTE COMPLETED ***' FROM DUAL
;
EXIT


/* Do FKs AFTER Tables */

ALTER TABLE CONDITION_ERA ADD CONSTRAINT CONDITION_ERA_PERSON_FK FOREIGN KEY (PERSON_ID) REFERENCES PERSON (PERSON_ID)
;
ALTER TABLE CONDITION_OCCURRENCE ADD CONSTRAINT CONDITION_OCCURRENCE_PERSON_FK FOREIGN KEY (PERSON_ID) REFERENCES PERSON (PERSON_ID)
;
ALTER TABLE DEATH ADD CONSTRAINT DEATH_PERSON_FK FOREIGN KEY (PERSON_ID) REFERENCES PERSON (PERSON_ID)
;
ALTER TABLE DRUG_COST ADD CONSTRAINT DRUG_COST_DRUG_EXPOSURE_FK FOREIGN KEY (DRUG_EXPOSURE_ID) REFERENCES DRUG_EXPOSURE (DRUG_EXPOSURE_ID)
;
ALTER TABLE DRUG_ERA ADD CONSTRAINT DRUG_ERA_PERSON_FK FOREIGN KEY (PERSON_ID) REFERENCES PERSON (PERSON_ID)
;
ALTER TABLE DRUG_EXPOSURE ADD CONSTRAINT DRUG_EXPOSURE_PERSON_FK FOREIGN KEY (PERSON_ID) REFERENCES PERSON (PERSON_ID)
;
ALTER TABLE OBSERVATION ADD CONSTRAINT OBSERVATION_PERSON_FK FOREIGN KEY (PERSON_ID) REFERENCES PERSON (PERSON_ID)
;
ALTER TABLE ORGANIZATION ADD CONSTRAINT ORGANIZATION_LOCATION_FK FOREIGN KEY (LOCATION_ID) REFERENCES LOCATION (LOCATION_ID)
;
ALTER TABLE PAYER_PLAN_PERIOD ADD CONSTRAINT PAYER_PLAN_PERIOD_PERSON_FK FOREIGN KEY (PERSON_ID) REFERENCES PERSON (PERSON_ID)
;
ALTER TABLE PERSON ADD CONSTRAINT PERSON_LOCATION_FK FOREIGN KEY (LOCATION_ID) REFERENCES LOCATION (LOCATION_ID)
;
ALTER TABLE PERSON ADD CONSTRAINT PERSON_PROVIDER_FK FOREIGN KEY (PROVIDER_ID) REFERENCES PROVIDER (PROVIDER_ID)
;
ALTER TABLE PROCEDURE_COST ADD CONSTRAINT PROCEDURE_COST_PROCEDURE_FK FOREIGN KEY (PROCEDURE_OCCURRENCE_ID) REFERENCES PROCEDURE_OCCURRENCE (PROCEDURE_OCCURRENCE_ID)
;
ALTER TABLE PROCEDURE_OCCURRENCE ADD CONSTRAINT PROCEDURE_OCCURRENCE_PERSON_FK FOREIGN KEY (PERSON_ID) REFERENCES PERSON (PERSON_ID)
;
ALTER TABLE VISIT_OCCURRENCE ADD CONSTRAINT VISIT_OCCURRENCE_PERSON_FK FOREIGN KEY (PERSON_ID) REFERENCES PERSON (PERSON_ID)
;

/* Disable FKs Before ETL */
/*
ALTER TABLE CONDITION_ERA DISABLE CONSTRAINT CONDITION_ERA_PERSON_FK;
ALTER TABLE CONDITION_OCCURRENCE DISABLE CONSTRAINT CONDITION_OCCURRENCE_PERSON_FK;
ALTER TABLE DEATH DISABLE CONSTRAINT DEATH_PERSON_FK;
ALTER TABLE DRUG_COST DISABLE CONSTRAINT DRUG_COST_DRUG_EXPOSURE_FK;
ALTER TABLE DRUG_ERA DISABLE CONSTRAINT DRUG_ERA_PERSON_FK;
ALTER TABLE DRUG_EXPOSURE DISABLE CONSTRAINT DRUG_EXPOSURE_PERSON_FK;
ALTER TABLE OBSERVATION DISABLE CONSTRAINT OBSERVATION_PERSON_FK;
ALTER TABLE ORGANIZATION DISABLE CONSTRAINT ORGANIZATION_LOCATION_FK;
ALTER TABLE PAYER_PLAN_PERIOD DISABLE CONSTRAINT PAYER_PLAN_PERIOD_PERSON_FK;
ALTER TABLE PERSON DISABLE CONSTRAINT PERSON_LOCATION_FK;
ALTER TABLE PERSON DISABLE CONSTRAINT PERSON_PROVIDER_FK;
ALTER TABLE PROCEDURE_COST DISABLE CONSTRAINT PROCEDURE_COST_PROCEDURE_FK;
ALTER TABLE PROCEDURE_OCCURRENCE DISABLE CONSTRAINT PROCEDURE_OCCURRENCE_PERSON_FK;
ALTER TABLE VISIT_OCCURRENCE DISABLE CONSTRAINT VISIT_OCCURRENCE_PERSON_FK;
*/

/* Enable FKs AFTER ETL */
/*
ALTER TABLE CONDITION_ERA ENABLE CONSTRAINT CONDITION_ERA_PERSON_FK;
ALTER TABLE CONDITION_OCCURRENCE ENABLE CONSTRAINT CONDITION_OCCURRENCE_PERSON_FK;
ALTER TABLE DEATH ENABLE CONSTRAINT DEATH_PERSON_FK;
ALTER TABLE DRUG_COST ENABLE CONSTRAINT DRUG_COST_DRUG_EXPOSURE_FK;
ALTER TABLE DRUG_ERA ENABLE CONSTRAINT DRUG_ERA_PERSON_FK;
ALTER TABLE DRUG_EXPOSURE ENABLE CONSTRAINT DRUG_EXPOSURE_PERSON_FK;
ALTER TABLE OBSERVATION ENABLE CONSTRAINT OBSERVATION_PERSON_FK;
ALTER TABLE ORGANIZATION ENABLE CONSTRAINT ORGANIZATION_LOCATION_FK;
ALTER TABLE PAYER_PLAN_PERIOD ENABLE CONSTRAINT PAYER_PLAN_PERIOD_PERSON_FK;
ALTER TABLE PERSON ENABLE CONSTRAINT PERSON_LOCATION_FK;
ALTER TABLE PERSON ENABLE CONSTRAINT PERSON_PROVIDER_FK;
ALTER TABLE PROCEDURE_COST ENABLE CONSTRAINT PROCEDURE_COST_PROCEDURE_FK;
ALTER TABLE PROCEDURE_OCCURRENCE ENABLE CONSTRAINT PROCEDURE_OCCURRENCE_PERSON_FK;
ALTER TABLE VISIT_OCCURRENCE ENABLE CONSTRAINT VISIT_OCCURRENCE_PERSON_FK;
*/
