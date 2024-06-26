package com.microservice.generation.persistence;

import com.microservice.generation.entities.Planta;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PlantaRepository extends CrudRepository <Planta,String > {



}
