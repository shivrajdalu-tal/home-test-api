Feature: Inventory API - Add Item Success Cases

  Background:
    * url baseUrl
    * configure headers = { 'Content-Type': 'application/json' }
    * def testData = read('classpath:test-data/add-success-test-data.json')

  Scenario: 1. Add item with random id and verify it's retrievable
    * def randomId = Math.floor(Math.random() * 9990) + 10 + ''
    * set testData.newItem.id = randomId
    * def dataToAdd = testData.newItem
    * karate.log('Generated random ID:', randomId)
    * karate.log('Data to add:', dataToAdd)
    
    # Step 1: Add the item
    Given path '/api/inventory/add'
    And request dataToAdd
    When method POST
    Then status 200
    * karate.log('Successfully added item with ID:', dataToAdd.id)

    # Scenario 6 : Verify the item can be retrieved
    Given path '/api/inventory'
    When method GET
    Then status 200
    * karate.log('Retrieved inventory data')

    # Find the added item in the response
    * def foundItems = karate.filter(response.data, function(item){ return item.id == dataToAdd.id })
    * karate.log('Found items with matching ID:', foundItems)
    * assert foundItems.length > 0

    # Validate the data of the found item
    * def foundItem = foundItems[0]
    * match foundItem.name == dataToAdd.name
    * match foundItem.price == dataToAdd.price
    * match foundItem.image == dataToAdd.image
    * karate.log('✓ Successfully validated that the added item is present in the inventory.')
    