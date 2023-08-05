package com.example.backend;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class CICDTest {
    private String testString;
    @Test
    void contextLoads() {
        assert testString == null;
    }

}
