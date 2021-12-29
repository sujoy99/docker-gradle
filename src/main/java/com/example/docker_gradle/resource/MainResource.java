package com.example.docker_gradle.resource;

import com.example.docker_gradle.dto.StudentDto;
import com.example.docker_gradle.entity.Student;
import com.example.docker_gradle.repository.StudentRepository;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import org.json.simple.JSONObject;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.*;

import static org.springframework.http.ResponseEntity.badRequest;
import static org.springframework.http.ResponseEntity.ok;

@RestController
@RequiredArgsConstructor
@RequestMapping("api/v1/dummy")
@Api(tags = "Dummy data")
public class MainResource {

    private final StudentRepository repository;

    @GetMapping("/hi")
    public String hi() {
        return "hello world";
    }

    @PostMapping("/save")
    @ApiOperation(value = "Save Miscellaneous One", response = String.class)
    public ResponseEntity<?> save(@RequestBody StudentDto dto) {
        Student s = dto.to();
//        repository.save(s);
        return ResponseEntity.ok(repository.save(s));
    }

    @PostMapping("/list")
    @ApiOperation(value = "Save Miscellaneous One", response = String.class)
    public ResponseEntity<?> list() {

        return ResponseEntity.ok(repository.findAll());
    }
}
