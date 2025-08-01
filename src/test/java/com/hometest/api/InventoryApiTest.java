package com.hometest.api;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class InventoryApiTest {

    @Test
    void testInventoryApi() {
        Results results = Runner.path("classpath:features")
                .outputCucumberJson(true)
                .outputHtmlReport(true)
                .parallel(1);
        
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
} 