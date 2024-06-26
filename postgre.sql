INSERT INTO public.generacion (
    id_generacion, generacion_actual, valor_unidad, valor_total, diferencia_tarifa,
    ahorro_actual, ahorro_codos_actual, anio, mes,
    id_tarifa_operador, id_planta
) VALUES (
    DEFAULT, 100, 50, 500, 0, -- Ajustar diferencia_tarifa según sea necesario
    5, 5, -- Ajustar ahorro_codos_actual y ahorro_codos_acumulado según sea necesario
    2023, 4, -- Año y mes extraídos de "fechaIni"
    3, 506 -- Ajustar id_tarifa_operador según sea necesario
);


INSERT INTO public.generacion (
    id_generacion, generacion_actual, valor_unidad, valor_total, diferencia_tarifa,
    ahorro_actual, ahorro_acumulado, ahorro_codos_actual, anio, mes,
    id_tarifa_operador, id_planta
) VALUES (
    DEFAULT, 100, 50, 500, 0, -- Ajustar diferencia_tarifa según sea necesario
    5, 50, 10, -- Ajustar ahorro_codos_actual y ahorro_codos_acumulado según sea necesario
    2023, 3, -- Año y mes extraídos de "fechaIni"
    4, 508 -- Ajustar id_tarifa_operador según sea necesario
);


SELECT * FROM tarifa_operadores

DELETE FROM generacion
SELECT * FROM generacion

CREATE OR REPLACE FUNCTION actualizar_generacion_acumulada()
RETURNS TRIGGER AS $$
BEGIN
    -- Desactivar temporalmente los triggers
    PERFORM pg_catalog.set_config('session_replication_role', 'replica', true);

    -- Realizar la actualización sin disparar el trigger
    UPDATE generacion
    SET generacion_acumulado = (
        SELECT SUM(generacion_actual)
        FROM generacion
        WHERE id_planta = NEW.id_planta
          AND anio = NEW.anio
          AND mes <= NEW.mes
    )
    WHERE id_generacion = NEW.id_generacion;

    -- Reactivar los triggers
    PERFORM pg_catalog.set_config('session_replication_role', 'origin', true);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger
CREATE TRIGGER trigger_actualizar_generacion_acumulada
AFTER INSERT OR UPDATE ON generacion
FOR EACH ROW
EXECUTE FUNCTION actualizar_generacion_acumulada();

SELECT t.tarifa_operador FROM tarifa_operadores AS t INNER JOIN generacion AS g ON t.id_tarifa_operador = g.id_tarifa_operador WHERE g.mes = 1 AND g.id_planta = '506' 

SELECT g.generacion_acumulado FROM generacion AS g WHERE g.anio = 2023 AND g.mes = 1 AND g.id_planta = '506'

--Trigger para ahorro codos
CREATE OR REPLACE FUNCTION actualizar_codos_acumulado()
RETURNS TRIGGER AS $$
BEGIN
    
    PERFORM pg_catalog.set_config('session_replication_role', 'replica', true);

   
    UPDATE generacion
	SET ahorro_codos_acumulado = (
		SELECT SUM (ahorro_codos_actual)
		FROM generacion
		WHERE id_planta = NEW.id_planta
          AND anio = NEW.anio
          AND mes <= NEW.mes
    )
    WHERE id_generacion = NEW.id_generacion;

    PERFORM pg_catalog.set_config('session_replication_role', 'origin', true);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_actualizar_codos_acumulado
AFTER INSERT OR UPDATE ON generacion
FOR EACH ROW
EXECUTE FUNCTION actualizar_codos_acumulado();

--Trigger Ahorro acumulado

CREATE OR REPLACE FUNCTION actualizar_ahorro_acumulado()
RETURNS TRIGGER AS $$
BEGIN
    
    PERFORM pg_catalog.set_config('session_replication_role', 'replica', true);

   
    UPDATE generacion
	SET ahorro_acumulado = (
		SELECT SUM (ahorro_actual)
		FROM generacion
		WHERE id_planta = NEW.id_planta
          AND anio = NEW.anio
          AND mes <= NEW.mes
    )
    WHERE id_generacion = NEW.id_generacion;

    PERFORM pg_catalog.set_config('session_replication_role', 'origin', true);

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_actualizar_ahorro_acumulado
AFTER INSERT OR UPDATE ON generacion
FOR EACH ROW
EXECUTE FUNCTION actualizar_ahorro_acumulado();


	


