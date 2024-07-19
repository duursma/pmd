--
-- BSD-style license; for more info see http://pmd.sourceforge.net/license.html
--

-- See https://github.com/pmd/pmd/issues/1934

BEGIN

  MERGE INTO jhs_translations b
      USING ( SELECT 'PROM_EDIT_PROM_NR' key1,'Edycja promocji nr' text,123123 lce_id FROM dual ) e
      ON (b.key1 = e.key1 and b.lce_id=e.lce_id)
      WHEN MATCHED
        THEN  UPDATE SET b.text = e.text
      WHEN NOT MATCHED
        THEN  INSERT (ID,KEY1, TEXT,LCE_ID) values (JHS_SEQ.NEXTVAL,'PROM_EDIT_PROM_NR','Edycja promocji nr',123123);

-- Plain and simple
  MERGE INTO tbl d
      USING src s
      ON (s.key = d.key)
      WHEN MATCHED
        THEN  UPDATE SET b.value = e.value
      WHEN NOT MATCHED
        THEN  INSERT (ID,VALUE) values (s.key, s.value);

-- You can specify the merge_insert_clause by itself or with the merge_update_clause. If you specify both, then they can be in either order.
-- https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/MERGE.html
  MERGE INTO tbl d
      USING src s
      ON (s.key = d.key)
      WHEN NOT MATCHED
        THEN  INSERT (ID,VALUE) values (s.key, s.value)
      WHEN MATCHED
        THEN  UPDATE SET b.value = e.value;
  
-- Use prefixed columns. Seems bogus but Oracle accepts the syntax.
  MERGE INTO tbl d
      USING src s
      ON (s.key = d.key)
      WHEN NOT MATCHED
        THEN  INSERT (d.ID,d.VALUE) values (s.key, s.value)
      WHEN MATCHED
        THEN  UPDATE SET b.value = e.value;
  
END;
/
