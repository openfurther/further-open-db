/* FURTHER OMOP INTERFACE DB VIEWS */

/* CONDITION_ERA */
CREATE OR REPLACE VIEW FRTHR_OMOP_I.CONDITION_ERA 
AS 
SELECT fconditon_era_id condition_era_id,
       fperson_id person_id,
       condition_cid condition_concept_id,
       condition_era_start_dt condition_era_start_date,
       condition_era_end_dt condition_era_end_date,
       condition_type_cid condition_type_concept_id,
       condition_occurrence_cnt condition_occurrence_count
  FROM frthr_model.fcondition_era
 WHERE dataset_id = 1;

/* CONDITION_OCCURRENCE */
CREATE OR REPLACE VIEW FRTHR_OMOP_I.CONDITION_OCCURRENCE 
AS 
SELECT fcondition_occurrence_id condition_occurrence_id,
       fperson_id person_id,
       condition_cid condition_concept_id,
       condition_start_dt condition_start_date,
       condition_end_dt condition_end_date,
       condition_type_cid condition_type_concept_id,
       (SELECT NULL FROM dual) stop_reason,
       fprovider_id associated_provider_id,
       fencounter_id visit_occurrence_id,
       (SELECT NULL FROM dual) condition_source_value
  FROM frthr_model.fcondition_occurrence
 WHERE dataset_id = 1;

/* DRUG_EXPOSURE */
CREATE OR REPLACE VIEW FRTHR_OMOP_I.DRUG_EXPOSURE 
AS 
SELECT forder_id drug_exposure_id,
       fperson_id person_id,
       order_item_cid drug_concept_id,
       start_dts drug_exposrue_start_date,
       stop_dts drug_exposure_end_date,
       (SELECT NULL FROM dual) drug_type_concept_id,
       (SELECT NULL FROM dual) stop_reason,
       (SELECT NULL FROM dual) refills,
       (SELECT NULL FROM dual) quantity,
       (SELECT NULL FROM dual) days_supply,
       (SELECT NULL FROM dual) sig,
       (SELECT NULL FROM dual) prescribing_provider,
       fencounter_id visit_occurrence,
       (SELECT NULL FROM dual) relevant_condition_concept_id,
       (SELECT NULL FROM dual) drug_source_value
  FROM frthr_model.forder_fact ord
 WHERE ord.dataset_id=1;

/* OBSERVATION */
CREATE OR REPLACE VIEW FRTHR_OMOP_I.OBSERVATION 
AS 
SELECT obs.fobservation_id observation_id,
       obs.fperson_id person_id,
       obs.observation_cid observation_concept_id,
       obs.start_dts observation_date,
       obs.start_dts observation_time,
       obs.value_number value_as_number,
       obs.value_string value_as_string,
       obs.value_cid value_as_concept_id,
       obs.value_units_cid unit_concept_id,
       (SELECT NULL FROM dual) range_low,
       (SELECT NULL FROM dual) range_high,
       obs.observation_type_cid observation_type_concept_id,
       (SELECT NULL FROM dual) associated_provider_id,
       obs.fencounter_id visit_occurrence_id,
       (SELECT NULL FROM dual) relevant_condition_concept_id,
       (SELECT NULL FROM dual) observation_source_value,
       (SELECT NULL FROM dual) unit_source_value
  FROM frthr_model.fobservation_fact obs
 WHERE obs.dataset_id=1;

/* PERSON */
CREATE OR REPLACE VIEW FRTHR_OMOP_I.PERSON 
AS 
SELECT p.FPERSON_ID person_id ,
       p.ADMINISTRATIVE_GENDER_CID gender_concept_id ,
       p.RACE_CID race_concept_id ,
       p.ETHNICITY_CID ethnicity_concept_id ,
       p.BIRTH_YR year_of_birth ,
       p.BIRTH_MON month_of_birth ,
       p.BIRTH_DAY day_of_birth ,
       lctn.lctn_cid person_location_id ,
       (SELECT NULL FROM dual) provider_id ,
       (SELECT NULL FROM dual) care_site_id ,
       (SELECT NULL FROM dual) person_source_value ,
       (SELECT NULL FROM dual) gender_source_value ,
       (SELECT NULL FROM dual) race_source_value ,
       (SELECT NULL FROM dual) ethnicity_source_value
  FROM frthr_model.fperson p, frthr_model.fperson_lctn lctn
 WHERE p.dataset_id = 1
   AND p.fperson_id = lctn.fperson_id (+)
   AND lctn.person_lctn_type_cd (+) = 'CurrentLocation'
   AND lctn.dataset_id (+) = 1
   AND (p.administrative_gender_nmspc_id = 30 OR administrative_gender_nmspc_id IS NULL)
   AND (p.race_nmspc_id = 30 OR p.race_nmspc_id IS NULL)
   AND (p.ethnicity_nmspc_id = 30 OR p.ethnicity_nmspc_id IS NULL);

/* PROCEDURE_OCCURRENCE */
CREATE OR REPLACE VIEW FRTHR_OMOP_I.PROCEDURE_OCCURRENCE 
AS 
SELECT fprocedure_id procedure_occurrence_id,
       fperson_id person_id,
       procedure_cid procedure_concept_id,
       procedure_dts procedure_date,
       procedure_type_cid procedure_type_concept_id,
       (SELECT NULL FROM dual) associated_provider_id,
       fencounter_id visit_occurrence_id,
       relevant_condition_cid relevant_condition_concept_id,
       (SELECT NULL FROM dual) procedure_source_value
  FROM frthr_model.fprocedure_occurrence
 WHERE dataset_id=1;

/* VISIT_OCCURRENCE */
CREATE OR REPLACE VIEW FRTHR_OMOP_I.VISIT_OCCURRENCE 
AS 
SELECT fencounter_id visit_occurrence_id,
       fperson_id person_id,
       CASE WHEN admission_yr IS NULL THEN NULL ELSE to_date( '01-JAN-' || admission_yr, 'dd-mon-yyyy') END as visit_start_date,
       CASE WHEN discharge_yr IS NULL THEN NULL ELSE to_date( '01-JAN-' || discharge_yr, 'dd-mon-yyyy') END as visit_end_date,
       (SELECT NULL FROM dual) place_of_service_concept_id,
       (SELECT NULL FROM dual) care_site_id,
       (SELECT NULL FROM dual) visit_source_value
  FROM frthr_model.fencounter
 WHERE dataset_id = 1;

