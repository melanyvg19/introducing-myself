package com.microservice.generation.service;

import com.microservice.generation.entities.Generator;
import com.microservice.generation.entities.Planta;
import com.microservice.generation.entities.TarifaOperador;
import com.microservice.generation.persistence.GeneratorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class GeneratorServiceImpl implements IGeneratorService {


    @Autowired
    private GeneratorRepository generatorRepository;

    @Autowired
    private  PlantaServiceImpl plantaService;

    @Autowired
    private TarifaOperadorServiceImpl tarifaOperadorService;

    @Override
    public Double findGeneracionAcumuladaByDateAndPlanta(Integer anio, Integer mes, String planta) {
        return generatorRepository.findGeneracionAcumuladaByDateAndPlanta(anio, mes, planta);
    }

    @Override
    public Double findGeneracionActualByDateAndPlanta(Integer anio, Integer mes, String planta) {
        return generatorRepository.findGeneracionActualByDateAndPlanta(anio, mes, planta);
    }

    @Override
    public Double findAhorroCodosAcumuladoByDateAndPlanta(Integer anio, Integer mes, String planta) {
        return generatorRepository.findAhorroCodosAcumuladoByDateAndPlanta(anio, mes, planta);
    }

    @Override
    public Double findAhorroAcumuladoByDateAndPlanta(Integer anio, Integer mes, String planta) {
        return generatorRepository.findAhorroAcumuladoByDateAndPlanta(anio, mes, planta);
    }

    @Override
    public Generator findGeneratorByDateAndPlanta(Integer anio, Integer mes, String planta) {
        return generatorRepository.findGeneratorByDateAndPlanta(anio, mes, planta);
    }

    @Override
    public Generator calculate() {
        List<Planta> plantaList = plantaService.findAll();

        double valorUnidad = 500.2;

        LocalDate currentDate = LocalDate.now();
        int mesActual = currentDate.getMonthValue();
        int anio = currentDate.getYear();

        for (int i = 0; i <= plantaList.size(); i++){

            String idPlanta = plantaList.get(i).getIdPlanta();
            Double tarifaOperador = tarifaOperadorService.findTarifaOperadorByDateAndIdPlanta(mesActual,idPlanta);
            Double diferencia = tarifaOperador - valorUnidad;
            Double generacionActual = generatorRepository.findGeneracionActualByDateAndPlanta(anio, mesActual, idPlanta);
            Double generacionAcumulada = generacionActual + generatorRepository.findGeneracionAcumuladaByDateAndPlanta(anio, mesActual, idPlanta);
            Double valorTotal = generacionAcumulada * valorUnidad;
            Double ahorroActual = diferencia * generacionActual;
            Double ahorroAcumulado = ahorroActual + generatorRepository.findAhorroAcumuladoByDateAndPlanta(anio, mesActual, idPlanta);
            Double ahorroCodosActual = generacionActual * 0.504;
            Double ahorroCodosAcumulado = ahorroCodosActual + generatorRepository.findAhorroCodosAcumuladoByDateAndPlanta(anio, mesActual, idPlanta);
            Generator generator = generatorRepository.findGeneratorByDateAndPlanta(anio, mesActual, idPlanta);
            TarifaOperador idTarifaOperador = tarifaOperadorService.findIdTarifaOperadorByDateAndIdPlanta(mesActual, idPlanta);
            generator.setGeneracionAcumulado(generacionAcumulada);
            generator.setValorUnidad(valorUnidad);
            generator.setValorTotal(valorTotal);
            generator.setDiferenciaTarifa(diferencia);
            generator.setAhorroActual(ahorroActual);
            generator.setAhorroAcumulado(ahorroAcumulado);
            generator.setAhorroCodosActual(ahorroCodosActual);
            generator.setAhorroCodosAcumulado(ahorroCodosAcumulado);
            generator.setAnio(anio);
            generator.setMes(mesActual);
            generator.setTarifaOperador(idTarifaOperador);
            
        }
        return null;
    }

    @Override
    public List<Generator> findAll() {
        return (List<Generator>) generatorRepository.findAll();
    }

    @Override
    public Generator findById(Long id) {
        return generatorRepository.findById(id).orElseThrow();
    }

    @Override
    public void save(Generator generator) {
        generatorRepository.save(generator);
    }

    @Override
    public Generator update(Generator generator) {
        return null;
    }


    @Override
    public List<Generator> findByidGeneracion(Long idGeneracion) {
        return generatorRepository.findAllByGenerator(idGeneracion);
    }
}
