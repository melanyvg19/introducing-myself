package com.microservice.generation.service;

import com.microservice.generation.entities.Generator;

import java.util.List;

public interface IGeneratorService {

    Double findGeneracionAcumuladaByDateAndPlanta (Integer anio, Integer mes, String planta);

    Double findGeneracionActualByDateAndPlanta(Integer anio, Integer mes, String planta);

    Double findAhorroCodosAcumuladoByDateAndPlanta(Integer anio, Integer mes, String planta);

    Double findAhorroAcumuladoByDateAndPlanta(Integer anio, Integer mes, String planta);

    Generator findGeneratorByDateAndPlanta(Integer anio, Integer mes, String planta);

    Generator calculate();

    List<Generator> findAll();

    Generator findById (Long id);

    void save(Generator generator);

    Generator update(Generator generator);

    List<Generator> findByidGeneracion(Long idGeneracion);
}
