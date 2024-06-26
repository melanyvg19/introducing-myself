package com.microservice.generation.service;

import com.microservice.generation.entities.TarifaOperador;
import com.microservice.generation.persistence.TarifaOperadorRepository;
import org.springframework.beans.factory.annotation.Autowired;

public class TarifaOperadorServiceImpl implements ITarifaOperadorService{

    @Autowired
    private TarifaOperadorRepository tarifaOperadorRepository;

    @Override
    public Double findTarifaOperadorByDateAndIdPlanta(Integer mes, String planta) {
        return tarifaOperadorRepository.findTarifaOperadorByDateAndIdPlanta(mes, planta);
    }

    @Override
    public TarifaOperador findIdTarifaOperadorByDateAndIdPlanta(Integer mes, String planta) {
        return tarifaOperadorRepository.findIdTarifaOperadorByDateAndIdPlanta(mes, planta);
    }
}
