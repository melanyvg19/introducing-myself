package com.microservice.generation.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table(name = "tarifa_operadores")
@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TarifaOperador {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_tarifa_operador")
    private Long idTarifaOperador;

    @Column (name = "tarifa_operador")
    private Double tarifaOperador;

    @Column (name = "mes")
    private Integer mes;

    @Column (name = "anio")
    private Integer anio;

    @OneToMany(targetEntity = Generator.class,fetch = FetchType.LAZY, mappedBy = "tarifaOperador")
    private List<Generator> generators;

}