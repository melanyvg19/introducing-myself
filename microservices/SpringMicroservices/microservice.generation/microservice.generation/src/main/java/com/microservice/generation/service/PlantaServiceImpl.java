package com.microservice.generation.service;

import com.microservice.generation.entities.Planta;
import com.microservice.generation.persistence.PlantaRepository;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class PlantaServiceImpl implements IPlantaService {

    @Autowired
    private PlantaRepository plantaRepository;

    @Override
    public List<Planta> findAll() {
        return (List<Planta>) plantaRepository.findAll();
    }
}
