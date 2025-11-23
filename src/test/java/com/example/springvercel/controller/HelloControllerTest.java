package com.example.springvercel.controller;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.hamcrest.Matchers.*;

@WebMvcTest(HelloController.class)
class HelloControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void testHelloEndpoint() throws Exception {
        mockMvc.perform(get("/api/hello"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("Hello from Spring Boot!"))
                .andExpect(jsonPath("$.status").value("success"));
    }

    @Test
    void testRootEndpoint() throws Exception {
        mockMvc.perform(get("/api/"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("Welcome to Spring Boot API"))
                .andExpect(jsonPath("$.version").value("1.0.0"));
    }

    @Test
    void testStatusEndpoint() throws Exception {
        mockMvc.perform(get("/api/status"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("running"))
                .andExpect(jsonPath("$.uptime").value("healthy"));
    }

    @Test
    void testGreetEndpoint() throws Exception {
        mockMvc.perform(get("/api/greet/John"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.greeting").value("Hello, John!"))
                .andExpect(jsonPath("$.message").value("Welcome to our Spring Boot application"));
    }

    @Test
    void testEchoEndpoint() throws Exception {
        String jsonPayload = "{\"test\":\"data\"}";
        
        mockMvc.perform(post("/api/echo")
                .contentType("application/json")
                .content(jsonPayload))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("Echo successful"))
                .andExpect(jsonPath("$.received.test").value("data"));
    }
}

