package com.microservice.generation.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table (name = "operador")
@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Operador {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column (name = "id_operador")
    private Integer idOperador;

    @Column (name = "nombre_operador")
    private Integer nombreOperador;

    @OneToMany(targetEntity = Generator.class,fetch = FetchType.LAZY, mappedBy = "planta")
    private List<Planta> plantas;
}
