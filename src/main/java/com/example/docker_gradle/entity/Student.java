package com.example.docker_gradle.entity;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "TBL_STUDENT")
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
}
