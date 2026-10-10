@ignore
Feature: Reusable - get an auth token

  Scenario:
    Given url baseUrl
    And path 'auth'
    And request { username: '#(username)', password: '#(password)' }
    When method post
    Then status 200
    And match response.token == '#string'
    * def token = response.token
