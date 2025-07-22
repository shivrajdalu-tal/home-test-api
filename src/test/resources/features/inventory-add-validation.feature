Feature: Inventory API - Add Item Validation Cases

  Background:
    * url baseUrl
    * configure headers = { 'Content-Type': 'application/json' }
    * def testData = read('classpath:test-data/add-validation-test-data.json')

  Scenario: Add duplicate item - should fail
    Given path '/api/inventory/add'
    And request testData.duplicateItem
    When method POST
    Then status 400
    * karate.log('Correctly rejected duplicate item:', testData.duplicateItem)

  Scenario: Add item missing ID - should fail
    Given path '/api/inventory/add'
    And request testData.incompleteItems.missingId
    When method POST
    Then status 400
    * karate.log('Correctly rejected item missing ID:', testData.incompleteItems.missingId)

  Scenario: Add item missing name - should fail
    Given path '/api/inventory/add'
    And request testData.incompleteItems.missingName
    When method POST
    Then status 400
    * karate.log('Correctly rejected item missing name:', testData.incompleteItems.missingName)

  Scenario: Add item missing price - should fail
    Given path '/api/inventory/add'
    And request testData.incompleteItems.missingPrice
    When method POST
    Then status 400
    * karate.log('Correctly rejected item missing price:', testData.incompleteItems.missingPrice)

  Scenario: Add item missing image - should fail
    Given path '/api/inventory/add'
    And request testData.incompleteItems.missingImage
    When method POST
    Then status 400
    * karate.log('Correctly rejected item missing image:', testData.incompleteItems.missingImage) 