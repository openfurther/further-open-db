/* Create User in dev-db.further.utah.edu */
CREATE USER OMOPV2 IDENTIFIED BY your_password_here
  DEFAULT TABLESPACE FRTHR
  TEMPORARY TABLESPACE TEMPGROUP1;

/* Grants */
/* Assuming SCHEMA_OWNER Role is already there */
GRANT CONNECT TO OMOPV2;
GRANT SCHEMA_OWNER TO OMOPV2;

/* Allow User to Create Data & Objects in the FRTHR Tablespace */
ALTER USER OMOPV2 QUOTA unlimited ON FRTHR;
