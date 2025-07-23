Feature: Inventory API - Retrieval Operations

  Background:
    * url baseUrl
    * configure headers = { 'Content-Type': 'application/json' }
    * def testData = read('classpath:testData/retrievalTestData.json')

  Scenario: 1. Get all menu items
    Given path '/api/inventory'
    When method GET
    Then status 200
    And match response.data == '#array'
    And match each response.data[*] contains { id: '#present', name: '#present', price: '#present', image: '#present' }
    And assert response.data.length >= 9
    * karate.log('Retrieved inventory items, total count:', response.data.length)

  Scenario: 2. Filter by ID - Validate "Baked Rolls x 8"
    Given path '/api/inventory/filter'
    And param id = testData.filters.byId
    When method GET
    Then status 200
    
    # Validate the response contains the expected "Baked Rolls x 8" item
    * def expectedItem = testData.expectedItem
    And match response.id == expectedItem.id
    And match response.name == expectedItem.name
    And match response.price == expectedItem.price
    And match response.image == expectedItem.image
    
    * karate.log('✓ Successfully filtered item by ID:', testData.filters.byId)
    * karate.log('✓ Validated "Baked Rolls x 8" details:', response)
