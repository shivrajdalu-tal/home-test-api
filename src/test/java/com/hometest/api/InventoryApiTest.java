package com.hometest.api;

import com.intuit.karate.junit5.Karate;

class InventoryApiTest {

    @Karate.Test
    Karate testInventoryApi() {
        return Karate.run("classpath:features")
                .relativeTo(getClass());
    }
} 