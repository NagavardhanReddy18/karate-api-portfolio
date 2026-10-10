@smoke
Feature: Health check

  Scenario: the API is up
    Given url baseUrl
    And path 'ping'
    When method get
    Then status 201
