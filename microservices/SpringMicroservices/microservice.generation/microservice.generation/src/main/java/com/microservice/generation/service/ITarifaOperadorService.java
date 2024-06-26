package com.microservice.generation.service;

import com.microservice.generation.entities.TarifaOperador;

public interface ITarifaOperadorService {

    Double findTarifaOperadorByDateAndIdPlanta(Integer mes, String planta);

    TarifaOperador findIdTarifaOperadorByDateAndIdPlanta(Integer mes, String planta);

}
