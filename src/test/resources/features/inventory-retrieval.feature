Feature: Inventory API - Retrieval Operations

  Background:
    * url baseUrl
    * configure headers = { 'Content-Type': 'application/json' }
    * def testData = read('classpath:test-data/retrieval-test-data.json')

  Scenario: Get all menu items
    Given path '/api/inventory'
    When method GET
    Then status 200
    And match response.data == '#array'
    And match each response.data[*] contains { id: '#present', name: '#present', price: '#present', image: '#present' }
    And assert response.data.length >= 9
    * karate.log('Retrieved inventory items, total count:', response.data.length)

  Scenario: Filter by specific ID
    Given path '/api/inventory/filter'
    And param id = testData.filters.byId
    When method GET
    Then status 200
    And match response contains { id: '#present', name: '#present', price: '#present', image: '#present' }
    * karate.log('Retrieved filtered item by ID:', testData.filters.byId, 'Result:', response)

  Scenario: Validate specific expected item exists in inventory
    Given path '/api/inventory'
    When method GET
    Then status 200
    
    # Find the specific expected item
    * def expectedItem = testData.expectedItem
    * def foundItems = karate.filter(response.data, function(item){ return item.id == expectedItem.id })
    * assert foundItems.length > 0
    * karate.log('Found expected item in inventory:', foundItems[0])
    
    # Validate exact match with expected data
    * def foundItem = foundItems[0]
    * match foundItem.id == expectedItem.id
    * match foundItem.name == expectedItem.name
    * match foundItem.image == expectedItem.image
    * match foundItem.price == expectedItem.price
    * karate.log('✓ Validated expected item matches exactly:', expectedItem) 