--Define un evento llamado `ev_actualizar_emails_nulos` que actualiza registros con email NULL o vacío por defecto: correo_desconocido@dominio.com, cada día a las 02:00 am.
DELIMITER $$

DROP EVENT IF EXISTS evt_alerta_pagos_pendientes $$

CREATE EVENT evt_alerta_pagos_pendientes
ON SCHEDULE EVERY 1 DAY
ENABLE
DO
BEGIN
    INSERT INTO alerta_pago (cliente_id, pago_id, fecha_pago, fecha_creacion)
    SELECT
        pa.cliente_id,
        pa.id,
        pa.total
        pa.fecha,
    FROM pago AS pa
    WHERE pa.estado = 'Pendiente'
    AND pa.fecha <= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
    AND NOT EXISTS (
        SELECT 1 FROM alerta_pago ap WHERE ap.pago_id = pa.id
    );

END $$

DELIMITER ;

-- 2. Define un evento llamado `ev_reporte_clientes_mensual` Cuenta clientes registrados el mes anterior y guarda en `reporte_clientes`, el primer día de cada mes.
DELIMITER $$

DROP EVENT IF EXISTS evt_insertar_historial_pago $$

CREATE EVENT evt_insertar_historial_pago
ON SCHEDULE EVERY 1 HOUR
ENABLE
DO
BEGIN
    INSERT INTO historial_pagos (pago_id, total, fecha_pago)
    SELECT pa.id, pa.total, NOW()
    FROM pago pa
    JOIN historial_pagos hpa ON hpa.pago_id = pa.id
    WHERE pa.estado = 'Pagado'
    AND pa.id NOT IN (
        SELECT pago_id
        FROM historial_pagos
    );

END $$

DELIMITER ;

-- 3.Define un evento llamado `ev_cierre_empleados_inactivos` que actualiza estado de empleados con salario 0 como inactivos, semanal.
DELIMITER $$

DROP EVENT IF EXISTS evt_bloquear_tarjetas_por_cuenta $$

CREATE EVENT evt_bloquear_tarjetas_por_cuenta
ON SCHEDULE EVERY 1 DAY
ENABLE
DO
BEGIN

    UPDATE tarjeta ta
    JOIN cuenta_bancaria cb ON ta.cuenta_bancaria_id = cb.id
    SET ta.estado = 'Bloqueada'
    WHERE cb.estado = 'Bloqueada' AND ta.estado IN ('Activa','Inactiva, Cerrada');

END $$

DELIMITER ;

-- 4. Define un evento llamado `ev_actualizar_fecha_contratacion_futura` que corrige empleados con `fecha_contratacion` mayor a `CURDATE()`, diariamente.
DELIMITER $$

DROP EVENT IF EXISTS evt_limpiar_historial_pagos $$

CREATE EVENT evt_limpiar_historial_pagos
ON SCHEDULE EVERY 1 MONTH
ENABLE
DO
BEGIN
    DELETE FROM historial_pagos WHERE fecha_creacion < NOW() - INTERVAL 2 YEAR;

END $$

DELIMITER ;

-- 5.Define un evento llamado `ev_backup_clientes_antiguos` que aInserta clientes con `fecha_registro` mayor a 3 años en `clientes_historico`, trimestral.
DELIMITER $$

DROP EVENT IF EXISTS evt_limpiar_historial_cuotas $$

CREATE EVENT evt_limpiar_historial_cuotas
ON SCHEDULE EVERY 1 MONTH
ENABLE
DO
BEGIN
    DELETE FROM historial_cuotas WHERE fecha_creacion < NOW() - INTERVAL 2 YEAR;

END $$

DELIMITER ;