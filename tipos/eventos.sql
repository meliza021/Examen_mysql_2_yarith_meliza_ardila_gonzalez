DELIMITER $$

CREATE EVENT IF NOT EXISTS ActualizarSaldosPendientes
ON SCHEDULE EVERY 1 MONTH
STARTS '2025-07-31 23:59:00'
DO
BEGIN
  UPDATE clientes
  SET saldo_pendiente = saldo_pendiente + (saldo_pendiente * 0.02)
  WHERE estado = 'activo';
END$$

DELIMITER ;


