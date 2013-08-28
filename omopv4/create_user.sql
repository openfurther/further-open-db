/* Create User */
CREATE USER OMOPV4 IDENTIFIED BY VALUES 'S:8BAE1860862269FFD13B713C8CDD16DE6B9BCAB13E88F4C1E66ACE31B87C;0684E3E8A6DA7377'
  DEFAULT TABLESPACE FRTHR
  TEMPORARY TABLESPACE TEMPGROUP1;

/* Grants */
/* Assuming SCHEMA_OWNER Role is already there */
GRANT CONNECT TO OMOPV4;
GRANT SCHEMA_OWNER TO OMOPV4;

/* Allow User to Create Data & Objects in the FRTHR Tablespace */
ALTER USER OMOPV4 QUOTA unlimited ON FRTHR;