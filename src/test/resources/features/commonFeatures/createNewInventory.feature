@ignore 
Feature: New Item Generator

Scenario:
    * def randomId = Math.floor(Math.random() * 9990) + 10 + ''
    * def newItem = read('classpath:testData/addSuccessTestData.json')
    * set newItem.newItem.id = randomId
    * def dataToAdd = newItem.newItem 