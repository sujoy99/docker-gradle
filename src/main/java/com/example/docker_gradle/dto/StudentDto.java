package com.example.docker_gradle.dto;

import com.example.docker_gradle.entity.Student;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class StudentDto {

    private Long id;
    private String name;

    public Student to(){
        Student s = new Student();
        s.setId(id);
        s.setName(name);
        return s;
    }
}
