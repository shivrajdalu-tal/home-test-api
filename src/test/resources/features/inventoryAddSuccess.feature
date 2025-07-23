Feature: Inventory API - Add Item Success Cases

  Background:
    * url baseUrl
    * configure headers = { 'Content-Type': 'application/json' }
    * def itemData = callonce read('classpath:features/shared/new-item-generator.feature')
    * def dataToAdd = itemData.dataToAdd

  Scenario: 3. Add item for non existent id
    # Add the item
    Given path '/api/inventory/add'
    And request dataToAdd
    When method POST
    Then status 200
    * karate.log('✓ Successfully added new item with ID:', dataToAdd.id)

  Scenario: 6. Validate recent added item is present in the inventory
    # Get all inventory items
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
    * match foundItem.id == dataToAdd.id
    * match foundItem.name == dataToAdd.name
    * match foundItem.price == dataToAdd.price
    * match foundItem.image == dataToAdd.image
    * karate.log('✓ Successfully validated that the added item is present in the inventory.', foundItem)
    