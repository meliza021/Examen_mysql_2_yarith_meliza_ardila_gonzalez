DELIMITER $$

CREATE EVENT IF NOT EXISTS ev_actualizar_emails_nulos
ON SCHEDULE
  EVERY 1 DAY
  STARTS TIMESTAMP(CURRENT_DATE, '02:00:00')
DO
  UPDATE tu_tabla
  SET email = 'holasoymeliza@gmail.com'
  WHERE email IS NULL OR email = '';
$$

DELIMITER ;

DELIMITER $$
