package com.microservice.generation.controller;

import com.microservice.generation.entities.Generator;
import com.microservice.generation.entities.Planta;
import com.microservice.generation.service.GeneratorServiceImpl;
import com.microservice.generation.service.IGeneratorService;
import com.microservice.generation.service.PlantaServiceImpl;
import com.microservice.generation.service.TarifaOperadorServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/api/generator")
public class GeneratorController {

    @Autowired
    private GeneratorServiceImpl generatorService;

    @Autowired
    private TarifaOperadorServiceImpl tarifaOperadorService;

    @Autowired
    private PlantaServiceImpl plantaService;

    @PostMapping("/create")
    @ResponseStatus(HttpStatus.CREATED)
    public void saveGenerator(@RequestBody Generator generator){
        generatorService.save(generator);
    }

    @GetMapping("/calculos")
    public void calculosGeneracion(){
        generatorService.calculate();
    }


}
