Feature: Inventory API Testing

  Background:
    * url baseUrl
    * configure headers = { 'Content-Type': 'application/json' }
    * def testData = read('classpath:test-data.json')

  Scenario: 1. Get all menu items
    Given path '/api/inventory'
    When method GET
    Then status 200
    And assert response.data.length >= 9
    And match each response.data[*] contains { id: '#present', name: '#present', price: '#present', image: '#present' }
    * karate.log('Total items in inventory:', response.data.length)

  Scenario: 2. Filter by id - Get Baked Rolls x 8
    Given path '/api/inventory/filter'
    And param id = testData.expectedItems.bakedRolls.id
    When method GET
    Then status 200
    And match response.id == testData.expectedItems.bakedRolls.id
    And match response.name == testData.expectedItems.bakedRolls.name
    And match response.price == testData.expectedItems.bakedRolls.price
    And match response.image == testData.expectedItems.bakedRolls.image
    And match response contains { id: '#present', name: '#present', price: '#present', image: '#present' }
    * karate.log('Filtered item:', response)

  Scenario: 3. Add item for non-existent id
    Given path '/api/inventory/add'
    And request testData.newItem
    When method POST
    Then status 200
    * karate.log('Item added successfully for nonexistent id')

  Scenario: 4. Add item for existing id - should fail
    Given path '/api/inventory/add'
    And request testData.duplicateItem
    When method POST
    Then status 400
    * karate.log('Correctly rejected duplicate item with id', testData.duplicateItem.id)

  Scenario: 5a. Try to add item with missing information - missing id
    Given path '/api/inventory/add'
    And request testData.incompleteItems.missingId
    When method POST
    Then status 400
    And match response contains 'Not all requirements are met'
    * karate.log('Correctly rejected incomplete item:', response)

  Scenario: 5b. Try to add item with missing information - missing name
    Given path '/api/inventory/add'
    And request testData.incompleteItems.missingName
    When method POST
    Then status 400
    And match response contains 'Not all requirements are met'
    * karate.log('Correctly rejected item without name:', response)

  Scenario: 5c. Try to add item with missing information - missing price
    Given path '/api/inventory/add'
    And request testData.incompleteItems.missingPrice
    When method POST
    Then status 400
    And match response contains 'Not all requirements are met'
    * karate.log('Correctly rejected item without price:', response)

  Scenario: 5d. Try to add item with missing information - missing image
    Given path '/api/inventory/add'
    And request testData.incompleteItems.missingImage
    When method POST
    Then status 400
    And match response contains 'Not all requirements are met'
    * karate.log('Correctly rejected item without image:', response)

  Scenario: 6. Validate recent added item is present in the inventory
    Given path '/api/inventory'
    When method GET
    Then status 200
    And match response.data[*].id contains testData.newItem.id
    * def fiteredItem = karate.filter(response.data, function(x){ return x.id == testData.newItem.id })[0]
    And match fiteredItem.name == testData.newItem.name
    And match fiteredItem.price == testData.newItem.price
    And match fiteredItem.image == testData.newItem.image
    * karate.log('Verified existing fitered item in inventory:', fiteredItem)