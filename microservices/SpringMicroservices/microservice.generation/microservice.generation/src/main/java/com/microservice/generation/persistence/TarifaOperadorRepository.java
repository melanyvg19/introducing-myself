package com.microservice.generation.persistence;

import com.microservice.generation.entities.TarifaOperador;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface TarifaOperadorRepository {

    @Query("SELECT t.tarifaOperador FROM Generator g INNER JOIN TarifaOperador t ON g.tarifaOperador.idTarifaOperador = t.idTarifaOperador WHERE g.mes = :mes AND  g.planta.idPlanta = :planta")
    Double findTarifaOperadorByDateAndIdPlanta(Integer mes, String planta);

    @Query("SELECT t FROM Generator g INNER JOIN TarifaOperador t ON g.tarifaOperador.idTarifaOperador = t.idTarifaOperador WHERE g.mes = :mes AND  g.planta.idPlanta = :planta ")
    TarifaOperador findIdTarifaOperadorByDateAndIdPlanta(Integer mes, String planta);



}
