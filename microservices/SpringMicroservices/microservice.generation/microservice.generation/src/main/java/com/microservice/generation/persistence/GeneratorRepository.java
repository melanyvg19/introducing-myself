package com.microservice.generation.persistence;

import com.microservice.generation.entities.Generator;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GeneratorRepository extends CrudRepository <Generator, Long> {

    @Query ("SELECT g.generacionAcumulado FROM Generator g WHERE g.anio = :anio AND g.mes = :mes AND g.planta.idPlanta = :planta")
    Double findGeneracionAcumuladaByDateAndPlanta (Integer anio, Integer mes, String planta);

    @Query ("SELECT g.generacionActual FROM Generator g WHERE g.anio = :anio AND g.mes = :mes AND g.planta.idPlanta = :planta")
    Double findGeneracionActualByDateAndPlanta(Integer anio, Integer mes, String planta);

    @Query ("SELECT g.ahorroCodosAcumulado FROM Generator g WHERE g.anio = :anio AND g.mes = :mes AND g.planta.idPlanta = :planta ")
    Double findAhorroCodosAcumuladoByDateAndPlanta(Integer anio, Integer mes, String planta);

    @Query ("SELECT g.ahorroAcumulado FROM Generator g WHERE g.anio = :anio AND g.mes = :mes AND g.planta.idPlanta = :planta ")
    Double findAhorroAcumuladoByDateAndPlanta(Integer anio, Integer mes, String planta);

    @Query ("SELECT g FROM Generator g WHERE g.planta.idPlanta = :planta AND g.mes = :mes AND g.anio = :anio")
    Generator findGeneratorByDateAndPlanta(Integer anio, Integer mes, String planta);

    @Query ("SELECT t.id_tarifa_operador")
    List<Generator> findAllByGenerator(Long idGeneracion);
}
