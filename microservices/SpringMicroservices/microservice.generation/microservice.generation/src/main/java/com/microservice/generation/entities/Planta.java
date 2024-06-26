package com.microservice.generation.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Table(name = "planta")
@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor

public class Planta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_planta")
    private String idPlanta;

    @Column(name = "nombre_planta")
    private String nombrePlanta;

    @Column (name= "centro_costos")
    private String centroCostos;

    @Column (name= "asunto")
    private String asunto;

    @Column (name= "url_img")
    private String urlImg;

    @OneToMany(targetEntity = Generator.class,fetch = FetchType.LAZY, mappedBy = "planta")
    private List<Generator> generators;

    @ManyToOne
    @JoinColumn(name = "id_operador")
    private Operador operador;


}